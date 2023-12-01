// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
  output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]  LEDR;
  input  logic [3:0]  KEY;
  input  logic [9:0]  SW;
  output logic [35:0] GPIO_1; // Used for LED board
  input logic CLOCK_50;

  // Turn off HEX displays
  assign HEX2 = '1;
  assign HEX3 = '1;
  assign HEX4 = '1;
  assign HEX5 = '1;

  // Reset
  logic rst;                   // reset - toggle this on startup
  assign rst = SW[9];


  /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
    ===========================================================*/
  logic [31:0] div_clk;
  clock_divider cdiv (.clk(CLOCK_50),
              .rst,
              .divided_clocks(div_clk));

  // Clock selection; allows for easy switching between simulation and board clocks
  logic clkSelect;

  // Uncomment ONE of the following two lines depending on intention
  // assign clkSelect = CLOCK_50;  // for simulation
  assign clkSelect = div_clk[14]; // 1526 Hz clock for board


  /* Set up LED board driver
    ================================================================== */
  logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs (row x col)
  logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs (row x col)

  /* Standard LED Driver instantiation - set once and 'forget it'. See LEDDriver.sv for more info. 
  DO NOT MODIFY this line or the LEDDriver file */
  LEDDriver Driver (.clk(clkSelect), .rst, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
  
  logic button;
  series_dffs s_dffs(button, ~KEY[0], rst, clkSelect);
  
  logic [15:0] generated_pipe, pipe_holder;
  logic gameover;
  int position;
  bird b(clkSelect, rst, button, gameover, position);
  pipe_generator #(218*8) pipe_gen(generated_pipe, clkSelect, rst); // Generate Interval: 218 * 8 Cycle
  
  logic [15:0] green_column_12, green_column_13, green_column_14;  // Transposed Columns
  score_counter score_count(HEX0, HEX1, gameover, green_column_14, clkSelect, rst);
  collision_detector collision(gameover, position, green_column_12, green_column_13);
  
  always_comb begin
    RedPixels = 0;
    green_column_12 = 0;
    green_column_13 = 0;
    green_column_14 = 0;
    RedPixels[position][13:12] = 2'b11; // set bird bottom pixels on
    RedPixels[position + 1][13:12] = 2'b11; // set bird bottom pixels on
    // Transpose of columns
    for (int i=0; i<16; i++) begin
      green_column_12[i] = GrnPixels[i][12];
      green_column_13[i] = GrnPixels[i][13];
      green_column_14[i] = GrnPixels[i][14];
    end
  end

  int green_refresh_counter;
  always_ff @(posedge clkSelect) begin
    if (rst) begin
      GrnPixels <= 'b0;
      green_refresh_counter <= 0;
      pipe_holder <= 0;
    end
    else begin
      if (|generated_pipe) begin
        pipe_holder <= generated_pipe;
      end
      if (green_refresh_counter >= 218 && ~gameover) begin
        green_refresh_counter <= 0;
        for (int i=0; i<16; i++) begin
          GrnPixels[i] <<= 1;
          GrnPixels[i][0] <= pipe_holder[i];
        end
        pipe_holder <= 0;
      end
      else begin
        green_refresh_counter += 1;
      end
    end
  end
	 
endmodule

module DE1_SoC_testbench();
  logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0]  LEDR, SW;
  logic [3:0]  KEY;
  logic [35:0] GPIO_1; // Used for LED board
  logic CLOCK_50;
  DE1_SoC dut (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
  // Set up a simulated clock.
  parameter CLOCK_PERIOD=100;
  initial begin
    CLOCK_50 <= 0;
    forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
  end
    // Test the design.
  initial begin
    repeat(1) @(posedge CLOCK_50);
    SW[9] <= 1; repeat(1) @(posedge CLOCK_50); // Always reset FSMs at start
    SW[9] <= 0; repeat(1) @(posedge CLOCK_50);
    repeat(20) begin
      KEY[0] <= 1; repeat(450) @(posedge CLOCK_50);
      KEY[0] <= 0; repeat(300) @(posedge CLOCK_50);
    end    
    $stop; // End the simulation.
  end
endmodule