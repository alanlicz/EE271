module winning (clk, reset, leftest, rightest, L, R, numbers);
   input logic clk, reset, leftest, rightest, L, R;
	output logic [6:0] numbers;
	
	logic [1:0] ps, ns;
	
	parameter one = 2'b01, two = 2'b10, none = 2'b00;
	
	logic [6:0] ONE, TWO, NONE;
	
	assign ONE = 7'b1111001;
	assign TWO = 7'b0100100;
	assign NONE = 7'b1111111;

	always_comb
	   case (ps)
		   none:  if (leftest & L & ~R) 
						begin 
							ns = two; 
							numbers = TWO;
						end
			       else if (rightest & R & ~L) 
						begin 
							ns = one; 
							numbers = ONE;
						end
					 else begin 
						ns = none; 
						numbers = NONE; 
					 end
			one:   begin 
						ns = one; 
						numbers = ONE; 
					end
			two:   begin 
						ns = two; 
						numbers = TWO; 
					end
			default: begin ns = none; numbers = NONE; end
			
		endcase
		
	always @(posedge clk)
	   if (reset)
		   ps <= none;
		else
		   ps <= ns;
			
endmodule

module winning_testbench();
   logic clk, reset, leftest, rightest, L, R;
	logic numbers;
	
	winning dut3 (.clk, .reset, .leftest, .rightest, .L, .R);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin   
                                                        	 @(posedge clk);
	   reset <= 1;                                         @(posedge clk);
	   reset <= 0; 
		
		L <= 0; R <= 0; leftest <= 1;  rightest <= 0;       @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 1;       @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0;       @(posedge clk);	
		L <= 0; R <= 1; leftest <= 1;  rightest <= 0;       @(posedge clk);
		L <= 0; R <= 1; leftest <= 0;  rightest <= 1;       @(posedge clk);
		L <= 0; R <= 1; leftest <= 0;  rightest <= 0;       @(posedge clk);	
		L <= 1; R <= 0; leftest <= 1;  rightest <= 0;       @(posedge clk);
		L <= 1; R <= 0; leftest <= 0;  rightest <= 1;       @(posedge clk);
		L <= 1; R <= 0; leftest <= 0;  rightest <= 0;       @(posedge clk)		
		L <= 1; R <= 1; leftest <= 1;  rightest <= 0;       @(posedge clk);
		L <= 1; R <= 1; leftest <= 0;  rightest <= 1;       @(posedge clk);
		L <= 1; R <= 1; leftest <= 0;  rightest <= 0;       @(posedge clk);
		$stop;
	end
endmodule

	
	
	
	
	
	