module winning (newGame, HEX0, HEX5, clk, reset, leftmost, rightmost, L, R);
   input logic clk, reset, leftmost, rightmost, L, R;
	output logic [6:0] HEX0, HEX5;
	output logic  newGame;
	
	logic [2:0] leftCount;
	logic [2:0] rightCount;

	enum {off, P1, P2} ps, ns;
	
	always_comb begin
		case(ps)
			off:   if(leftmost & ~L & R) ns = P1;
							
					 else if(leftmost & ~R & L) ns = P2;
					
					 else ns = off;
							
			P1: ns = P1;  //You win
				
			P2: ns = P2;  //Computer win
			
		endcase

	end
		
			
	always_ff @(posedge clk) begin
		if(ps == off & ns == P1) begin

			rightCount <= rightCount + 1;

		end
		
		else if(ps == off & ns == P2) begin

			leftCount <= leftCount + 1;
		end
		
		if(reset) begin
			leftCount <= 3'b000;
			rightCount <= 3'b000;
			ps <= off;
			newGame <= 0;
		end
		else if(newGame) begin
			ps <= off;
			newGame <= 0;
		end
		else
			ps <= ns;
			
		if(ps == P1 | ps == P2)
			newGame <= 1;
		else
			newGame <= 0;
	end
	
	always_comb begin
	
													//You win
													
			if(rightCount == 3'b000) 		//0
				HEX0 = 7'b0111111;
			else if(rightCount == 3'b001)	//1
				HEX0 = 7'b0000110;
			else if(rightCount == 3'b010)	//2
				HEX0 = 7'b1011011;
			else if(rightCount == 3'b011)	//3
				HEX0 = 7'b1001111;
			else if(rightCount == 3'b100)	//4
				HEX0 = 7'b1100110;
			else if(rightCount == 3'b101)	//5
				HEX0 = 7'b1101101;
			else if(rightCount == 3'b110)	//6
				HEX0 = 7'b1111101;
			else 									
				HEX0 = 7'b0000111;			//7
		
													//Computer wins
													
			if(leftCount == 3'b000) 		//0
				HEX5 = 7'b0111111;
			else if(leftCount == 3'b001)	//1
				HEX5 = 7'b0000110;
			else if(leftCount == 3'b010)	//2
				HEX5 = 7'b1011011;
			else if(leftCount == 3'b011)	//3
				HEX5 = 7'b1001111;
			else if(leftCount == 3'b100)	//4
				HEX5 = 7'b1100110;
			else if(leftCount == 3'b101)	//5
				HEX5 = 7'b1101101;
			else if(leftCount == 3'b110)	//6
				HEX5 = 7'b1111101;
			else 									
				HEX5 = 7'b0000111;			//7
	 
		
	end
			
endmodule

module winning_testbench();
   logic clk, reset, leftmost, rightmost, L, R;
	logic [6:0] HEX0, HEX5;
	logic newGame;
	
	winning dut3 (.clk, .reset, .leftmost, .rightmost, .L, .R, .newGame, .HEX0, .HEX5);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin   
                                                        	 @(posedge clk);
	   reset <= 1;                                         @(posedge clk);
	   reset <= 0; 													 @(posedge clk);		
		L <= 0; R <= 0; leftmost <= 1;  rightmost <= 0;     @(posedge clk);
		L <= 0; R <= 0; leftmost <= 0;  rightmost <= 1;     @(posedge clk);
		L <= 0; R <= 0; leftmost <= 0;  rightmost <= 0;     @(posedge clk);
		
		                                                  	 @(posedge clk);
	   reset <= 1;                                         @(posedge clk);
	   reset <= 0; 													 @(posedge clk);		
		L <= 0; R <= 1; leftmost <= 1;  rightmost <= 0;     @(posedge clk);
		L <= 0; R <= 1; leftmost <= 0;  rightmost <= 1;     @(posedge clk);
		L <= 0; R <= 1; leftmost <= 0;  rightmost <= 0;     @(posedge clk);

		                                                  	 @(posedge clk);
	   reset <= 1;                                         @(posedge clk);
	   reset <= 0; 													 @(posedge clk);		
		L <= 1; R <= 0; leftmost <= 1;  rightmost <= 0;     @(posedge clk);
		L <= 1; R <= 0; leftmost <= 0;  rightmost <= 1;     @(posedge clk);
		L <= 1; R <= 0; leftmost <= 0;  rightmost <= 0;     @(posedge clk);

		                                                  	 @(posedge clk);
	   reset <= 1;                                         @(posedge clk);
	   reset <= 0; 													 @(posedge clk);		
		L <= 1; R <= 1; leftmost <= 1;  rightmost <= 0;     @(posedge clk);
		L <= 1; R <= 1; leftmost <= 0;  rightmost <= 1;     @(posedge clk);
		L <= 1; R <= 1; leftmost <= 0;  rightmost <= 0;     @(posedge clk);
		$stop;
	end
endmodule

	
	
	
	
	
	