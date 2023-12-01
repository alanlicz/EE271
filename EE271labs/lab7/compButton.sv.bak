module LFSR_SW(clk, reset, random, SW, out);
	output logic out;
	input logic clk, reset;
	input logic [9:0] random;
	input logic [8:0] SW;
	
	logic [9:0] SW_extend;
	
	assign SW_extend[9] = 1'b0;
	assign SW_extend[8:0] = SW[8:0];
	
	comparator computer(.clk, .reset, .A(SW_extend), .B(random), .A_larger(out));
endmodule

module LFSR_SW_testbench();
	logic out;
	logic clk, reset;
	logic [9:0] random;
	logic [8:0] SW;
	
	LFSR_SW dut(.clk, .reset, .random, .SW, .out);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) 
		clk <= ~clk;
	end
	
	initial begin
		reset <= 1;													@(posedge clk);
																		@(posedge clk);
		reset <= 0;													@(posedge clk);
																		@(posedge clk);
		random = 10'b0000000001;	SW = 9'b000000010;	@(posedge clk);
																		@(posedge clk);
		random = 10'b0000000011;	SW = 9'b000000010;	@(posedge clk);
																		@(posedge clk);
		$stop;
	end
endmodule