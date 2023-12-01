module victory (playAgain, HEX0, HEX5, clk, reset, LED9, LED1, L, R);
   input logic clk, reset, LED9, LED1, L, R;
	output logic [6:0] HEX0, HEX5;
	output logic  playAgain;
	
	logic [2:0] Lcount;
	logic [2:0] Rcount;

	enum {off, P1, P2} ps, ns;
	
	always_comb begin
		case(ps)
			off:   if(LED9 & ~L & R) ns = P1;
							
					 else if(LED9 & ~R & L) ns = P2;
					
					 else ns = off;
							
			P1: ns = P1;  //You win
				
			P2: ns = P2;  //Computer win
			
		endcase

	end
		
			
	always_ff @(posedge clk) begin
		if(ps == off & ns == P1) begin

			Rcount <= Rcount + 1;

		end
		
		else if(ps == off & ns == P2) begin

			Lcount <= Lcount + 1;
		end
		
		if(reset) begin
			Lcount <= 3'b000;
			Rcount <= 3'b000;
			ps <= off;
			playAgain <= 0;
		end
		else if(playAgain) begin
			ps <= off;
			playAgain <= 0;
		end
		else
			ps <= ns;
			
		if(ps == P1 | ps == P2)
			playAgain <= 1;
		else
			playAgain <= 0;
	end
	
	always_comb begin
	
													//You win
													
			if(Rcount == 3'b000) 		//0
				HEX0 = 7'b0111111;
			else if(Rcount == 3'b001)	//1
				HEX0 = 7'b0000110;
			else if(Rcount == 3'b010)	//2
				HEX0 = 7'b1011011;
			else if(Rcount == 3'b011)	//3
				HEX0 = 7'b1001111;
			else if(Rcount == 3'b100)	//4
				HEX0 = 7'b1100110;
			else if(Rcount == 3'b101)	//5
				HEX0 = 7'b1101101;
			else if(Rcount == 3'b110)	//6
				HEX0 = 7'b1111101;
			else 									
				HEX0 = 7'b0000111;			//7
		
													//Computer wins
													
			if(Lcount == 3'b000) 		//0
				HEX5 = 7'b0111111;
			else if(Lcount == 3'b001)	//1
				HEX5 = 7'b0000110;
			else if(Lcount == 3'b010)	//2
				HEX5 = 7'b1011011;
			else if(Lcount == 3'b011)	//3
				HEX5 = 7'b1001111;
			else if(Lcount == 3'b100)	//4
				HEX5 = 7'b1100110;
			else if(Lcount == 3'b101)	//5
				HEX5 = 7'b1101101;
			else if(Lcount == 3'b110)	//6
				HEX5 = 7'b1111101;
			else 									
				HEX5 = 7'b0000111;			//7
	 
		
	end
			
endmodule

module victory_testbench();
   logic clk, reset, LED9, LED1, L, R;
	logic [6:0] HEX0, HEX5;
	logic playAgain;
	
	victory dut3 (.clk, .reset, .LED9, .LED1, .L, .R, .playAgain, .HEX0, .HEX5);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin   
                                                        	 @(posedge clk);
	   reset <= 1;                                         @(posedge clk);
	   reset <= 0; 													 @(posedge clk);		
		L <= 0; R <= 0; LED9 <= 1;  LED1 <= 0;     @(posedge clk);
		L <= 0; R <= 0; LED9 <= 0;  LED1 <= 1;     @(posedge clk);
		L <= 0; R <= 0; LED9 <= 0;  LED1 <= 0;     @(posedge clk);
		
		                                                  	 @(posedge clk);
	   reset <= 1;                                         @(posedge clk);
	   reset <= 0; 													 @(posedge clk);		
		L <= 0; R <= 1; LED9 <= 1;  LED1 <= 0;     @(posedge clk);
		L <= 0; R <= 1; LED9 <= 0;  LED1 <= 1;     @(posedge clk);
		L <= 0; R <= 1; LED9 <= 0;  LED1 <= 0;     @(posedge clk);

		                                                  	 @(posedge clk);
	   reset <= 1;                                         @(posedge clk);
	   reset <= 0; 													 @(posedge clk);		
		L <= 1; R <= 0; LED9 <= 1;  LED1 <= 0;     @(posedge clk);
		L <= 1; R <= 0; LED9 <= 0;  LED1 <= 1;     @(posedge clk);
		L <= 1; R <= 0; LED9 <= 0;  LED1 <= 0;     @(posedge clk);

		                                                  	 @(posedge clk);
	   reset <= 1;                                         @(posedge clk);
	   reset <= 0; 													 @(posedge clk);		
		L <= 1; R <= 1; LED9 <= 1;  LED1 <= 0;     @(posedge clk);
		L <= 1; R <= 1; LED9 <= 0;  LED1 <= 1;     @(posedge clk);
		L <= 1; R <= 1; LED9 <= 0;  LED1 <= 0;     @(posedge clk);
		$stop;
	end
endmodule

	
	
	
	
	
	