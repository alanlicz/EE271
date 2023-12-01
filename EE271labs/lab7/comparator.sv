module comparator(clk, reset, A, B, value_final);
	output logic value_final;
	input logic clk, reset;
	input logic [9:0] A, B;
	
	always_ff @(posedge clk) begin
		if (reset) value_final <= 0;
		else value_final <= (A > B);
	end
	
endmodule 

module comparator_testbench();
	logic clk, reset;
	logic [9:0] A, B;
	logic value_final;
   
	comparator dut (.clk, .reset, .A, .B, .value_final);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin
		reset <= 1; 							@(posedge clk);
													@(posedge clk);
		reset <= 0;								@(posedge clk);
													@(posedge clk);
		A <= 8'b1011011; B<= 8'b1100110;	@(posedge clk);
		B <= 8'b1011011; A<= 8'b1100110;	@(posedge clk);
													@(posedge clk);
		$stop;
	end
endmodule 