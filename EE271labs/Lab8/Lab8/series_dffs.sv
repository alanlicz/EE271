module series_dffs (clean, raw, rst, clk);
	input logic raw, rst, clk;
	output logic clean;
	logic s;
	always_ff @(posedge clk) begin
		if (rst) begin
			s <= 0;
		end
		else begin
			s <= raw;
			clean <= s;
		end
	end
endmodule

module series_dffs_testbench();
  logic clk, reset, w;
  logic out;
  series_dffs dut (.clean(out), .raw(w), .rst(reset), .clk(clk));
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
	reset <= 0; w <= 0; @(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
	w <= 1; @(posedge clk);
	w <= 0; @(posedge clk);
	w <= 1; @(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
	w <= 0; @(posedge clk);
			@(posedge clk);
	$stop; // End the simulation.
  end
endmodule