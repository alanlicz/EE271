module normalLight (clk, reset, L, R, NL, NR, lighton);
   input logic clk, reset, L, R, NL, NR;
	output logic lighton;
	logic ns;
	
	parameter on = 1'b1, off = 1'b0;
	
	always_comb
	   case (lighton)
		   on:  if ((R & L) | (~R & ~L)) ns = on;
			     else ns = off;
			off: if ((NR & L & ~R) | (NL & R & ~L)) ns = on;
			     else ns = off;
			default: ns = off;
		 endcase
		 
	always @(posedge clk)
	    if (reset)
		    lighton <= off;
		 else 
		    lighton <= ns;		 
endmodule

module normalLight_testbench();
   logic clk, reset, L, R, NL, NR;
	logic lighton;
   
	normalLight dut2 (.clk, .reset, .L, .R, .NL, .NR, .lighton);
	
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
		
		L <= 0; R <= 1; NL <= 1;  NR <= 0;       			@(posedge clk);
		L <= 0; R <= 1; NL <= 0;  NR <= 1;       			@(posedge clk);
		L <= 0; R <= 1; NL <= 0;  NR <= 0;       			@(posedge clk);
		
		L <= 1; R <= 1; NL <= 1;  NR <= 0;       			@(posedge clk);
		L <= 1; R <= 1; NL <= 0;  NR <= 1;       			@(posedge clk);
		L <= 1; R <= 1; NL <= 0;  NR <= 0;       			@(posedge clk);
		$stop;
   end	
endmodule
	