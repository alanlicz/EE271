module centerLight (Clk, reset, L, R, NL, NR, lightOn);
	input logic clk, reset;
 
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, NL, NR;
	
	// when lightOn is true, the center light should be on.
	output logic lightOn;
	
	// State variables
	enum {on, off} ps, ns;
	
	// Next state logic
	always_comb begin
		case(ps)
			on: 
				if (R & ~L | ~R & L)
					ns = off;
				else
					ns = on;
			
		   off:
				if (NL & R & ~L | NR & ~R & L)	
					ns = on;
				else
					ns = off;
		endcase
	end
		
	// Output logic
	always_comb begin
		case(ps)
			on:
				lightOn = 1;
			off:
				lightOn = 0;
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin  
		if (reset)  
			ps <= on;  
		else  
			ps <= ns;  
	end 	
endmodule


