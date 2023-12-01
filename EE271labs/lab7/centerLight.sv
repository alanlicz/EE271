module centerLight (clk, reset, L, R, NL, NR, lightOn, playAgain);
   input logic clk, reset, L, R, NL, NR, playAgain;
	output logic lightOn;
	logic ns;
	
	parameter on = 1'b1, off = 1'b0;
	
	always_comb
		case (lightOn)
			on:  if ((R & L) | (~R & ~L)) ns = on;
				else ns = off;
			off: if ((NR & L & ~R) | (NL & R & ~L)) ns = on;
				else ns = off;
			default ns = on;
		endcase
		  
	always @(posedge clk)
	    if (reset | playAgain)
		    lightOn <= on;
		 else 
		    lightOn <= ns;		 
endmodule

module centerLight_testbench();
   logic clk, reset, L, R, NL, NR, playAgain;
	logic lightOn;
   
	centerLight dut1 (.clk, .reset, .L, .R, .NL, .NR, .lightOn, .playAgain);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin
	                                                   @(posedge clk);
	   reset <= 1;                                     @(posedge clk);
	   reset <= 0; 												@(posedge clk);
		L <= 0; R <= 0; NL <= 1;  NR <= 0;       			@(posedge clk);
		L <= 0; R <= 0; NL <= 0;  NR <= 1;       			@(posedge clk);
		L <= 0; R <= 0; NL <= 0;  NR <= 0;       			@(posedge clk);
		
		L <= 1; R <= 0; NL <= 1;  NR <= 0;       			@(posedge clk);
		L <= 1; R <= 0; NL <= 0;  NR <= 1;       			@(posedge clk);
		L <= 1; R <= 0; NL <= 0;  NR <= 0;       			@(posedge clk);
		
		playAgain <= 1;												@(posedge clk);
		                                                @(posedge clk);
		playAgain <= 0;												@(posedge clk);
		                                                @(posedge clk);
																		
		
		L <= 0; R <= 1; NL <= 1;  NR <= 0;       			@(posedge clk);
		L <= 0; R <= 1; NL <= 0;  NR <= 1;       			@(posedge clk);
		L <= 0; R <= 1; NL <= 0;  NR <= 0;       			@(posedge clk);
		
		L <= 1; R <= 1; NL <= 1;  NR <= 0;       			@(posedge clk);
		L <= 1; R <= 1; NL <= 0;  NR <= 1;       			@(posedge clk);
		L <= 1; R <= 1; NL <= 0;  NR <= 0;       			@(posedge clk);
		$stop;
   end	
endmodule	
	
	
	
	
	
	
	
	