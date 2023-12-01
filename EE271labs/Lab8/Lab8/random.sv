module random(rand_num, rst, clk);
	input logic rst, clk;
	output logic [7:0] rand_num;
	logic feedback;
	assign feedback = rand_num[0] ~^ rand_num[2] ~^ rand_num[3] ~^ rand_num[4];
	always_ff @(posedge clk) begin
		if (rst) begin
      rand_num <= 0;
    end
    else begin
      rand_num <= rand_num >> 1;
      rand_num[7] <= feedback;
    end
	end
endmodule

module random_testbench();
  logic clk, reset;
  logic [7:0] rand_num;
  random dut(rand_num, reset, clk);
  // Set up a simulated clock.
  parameter CLOCK_PERIOD=100;
  initial begin
    clk <= 0;
    forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
  end
  // Set up the inputs to the design. Each line is a clock cycle.
  initial begin
    @(posedge clk);
    reset <= 1; @(posedge clk); // Always reset FSMs at start
    reset <= 0; repeat(515) @(posedge clk);
    $stop; // End the simulation.
  end
endmodule
