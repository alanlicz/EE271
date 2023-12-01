module score_counter(hex0, hex1, gameover, green_column, clk, rst);
	input logic gameover, clk, rst;
  input logic [15:0] green_column;
  output logic [6:0] hex0, hex1;
  logic over, previous;
  logic [7:0] count_bcd;
  seg7 digit1(count_bcd[7:4], hex1);
  seg7 digit0(count_bcd[3:0], hex0);

  always_ff @(posedge clk) begin
    if (rst) begin
      count_bcd <= 0;
      over <= 0;
      previous <= 0;
    end
    else begin
      if (gameover || over) begin
        count_bcd <= count_bcd;
        over <= 1;
      end
      else begin
        if (|green_column) begin
          if (~previous) begin
            if (count_bcd[3:0] == 9) begin
              count_bcd[7:4] += 1'b1;
              count_bcd[3:0] <= 0;
            end
            else begin
              count_bcd += 1'b1;
            end
          end
          previous <= |green_column;
        end
        else begin
          previous <= 0;
        end
      end
    end
  end
endmodule

module score_counter_testbench();
  logic clk, rst, gameover;
  logic [6:0] hex0, hex1;
  logic [15:0] green_column;
  score_counter dut(hex0, hex1, gameover, green_column, clk, rst);
  // Set up a simulated clock.
  parameter CLOCK_PERIOD=100;
  initial begin
    clk <= 0;
    forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
  end
  initial begin
    rst <= 1; @(posedge clk);
    rst <= 0; gameover <= 0; @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    repeat(21) begin
      green_column <= 1; @(posedge clk);
      green_column <= 0; @(posedge clk);
      @(posedge clk);
    end
    gameover <= 1; @(posedge clk);
    @(posedge clk);
    repeat(3) begin
      green_column <= 1; @(posedge clk);
      green_column <= 0; @(posedge clk);
      @(posedge clk);
    end
    gameover <= 0; @(posedge clk);
    @(posedge clk);
    repeat(3) begin
      green_column <= 1; @(posedge clk);
      green_column <= 0; @(posedge clk);
      @(posedge clk);
    end
    $stop;
  end
endmodule