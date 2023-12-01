module LFSR(clk, reset, Q);
	output logic [9:0] Q;
	input logic clk, reset; 
	
	logic xnor_out;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			Q[9:0] <= 10'b0000000000;
			xnor_out = 1;
		end
		else begin
			xnor_out <= (Q[0] ~^ Q[3]); 
			Q[9] <= xnor_out;
			Q[8:0] <= Q[9:1];
		end
	end
endmodule 

module LFSR_testbench();
	logic [9:0] Q;
	logic clk, reset;
	
	LFSR dut(.clk, .reset, .Q);
	
	parameter CLOCK_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2)
		clk <= ~clk;
	end
	
	initial begin
		reset <= 1; 						@(posedge clk);
												@(posedge clk);
		reset <= 0;							@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		$stop;
	end
endmodule
