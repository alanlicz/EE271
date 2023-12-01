
module bird #(parameter FLY_THRESHOLD = 100, // default 100 cycle/pixel
    parameter GRAV_THRESHOLD = 150) // default 150 cycle/pixel
    (clk, rst, button, gameover, position);
  input logic clk, rst, button, gameover;
  output int position; // from 0 (top) to 14 (bottom)
  int gravity, fly; // internal timing counters
  // clk is 1526 Hz
  always_ff @ (posedge clk) begin
    if (rst) begin
      position <= 5; // slightly above halfway up the board
      gravity <= 0;
      fly <= 0;
    end
    else begin
      if (gameover) begin
        position <= position;
      end
      else if (position >= 14 && !button) begin
        position <= position;
      end
      else if (position == 0 && button) begin
        position <= position;
      end
      else if (button) begin
        fly += 1;
        if (fly > FLY_THRESHOLD) begin
          fly <= 0;
          position -= 1;
        end
      end
      else begin
        gravity += 1;
        if (gravity > GRAV_THRESHOLD) begin
          gravity <= 0;
          position += 1;
        end
      end
    end
  end
endmodule

module bird_testbench();
  logic clk, rst, button, gameover;
  int position;
  bird #(.FLY_THRESHOLD(3), .GRAV_THRESHOLD(4))
      dut (.clk, .rst, .button, .position, .gameover);
  // Set up a simulated clock.
  parameter CLOCK_PERIOD=100;
  initial begin
    clk <= 0;
    forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
  end
  initial begin
    rst <= 1; @(posedge clk);
    button <= 0; gameover <= 0; @(posedge clk);
    rst <= 0; @(posedge clk);
    repeat(48) @(posedge clk);
    button <= 1; repeat(32) @(posedge clk);
    rst <= 1; @(posedge clk);
    rst <= 0; @(posedge clk);
    button <= 1; repeat(32) @(posedge clk);
    button <= 0; repeat(32) @(posedge clk);
    @(posedge clk);
    rst <= 1; button <= 0; @(posedge clk);
    rst <= 0; repeat(16) @(posedge clk);
    gameover <= 1; repeat(16) @(posedge clk);
    button <= 1; repeat(16) @(posedge clk);
    $stop;
  end
endmodule