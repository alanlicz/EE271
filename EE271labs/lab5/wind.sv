module wind(clk, reset, SW, out);   
	input logic clk, reset;
	input logic [1:0] SW;
   output logic [2:0] out;   
 
	// State variables 
	enum {C0, C1, LR0, LR1, LR2, RL0, RL1, RL2} ps, ns;  
  
	// Next State logic  
	always_comb begin  
		case(ps)  
			C0: if (SW[1])          ns = LR0;
				 else if (SW[0])     ns = RL0;
				 else                ns = C1;
				 
			C1: if (SW[1])          ns = LR0;
				 else if (SW[0])     ns = RL0;
				 else                ns = C0;
				  
			
			LR0: if (SW[1])         ns = LR1;
				  else               ns = C0;
			
			LR1: if (SW[1])         ns = LR2;
				  else               ns = C0;
				  
		   LR2: if (SW[1])         ns = LR0;
				  else               ns = C0;
				  
				  
			RL0: if (SW[0])         ns = RL1;
				  else               ns = C0;
			
			RL1: if (SW[0])         ns = RL2;
				  else               ns = C0;
				  
		   RL2: if (SW[0])         ns = RL0;
				  else               ns = C0;
		endcase   
	end  
   
	// Output logic  
	always_comb begin
		case(ps)
			C0:  out[2] = 1;
			C1:  out[2] = 0;
			LR0: out[2] = 0;
			LR1: out[2] = 0;
			LR2: out[2] = 1;
			RL0: out[2] = 1;
			RL1: out[2] = 0;
			RL2: out[2] = 0;
		endcase
		
		case(ps)
			C0:  out[1] = 0;
			C1:  out[1] = 1;
			LR0: out[1] = 0;
			LR1: out[1] = 1;
			LR2: out[1] = 0;
			RL0: out[1] = 0;
			RL1: out[1] = 1;
			RL2: out[1] = 0;
		endcase
		
		case(ps)
			C0:  out[0] = 1;
			C1:  out[0] = 0;
			LR0: out[0] = 1;
			LR1: out[0] = 0;
			LR2: out[0] = 0;
			RL0: out[0] = 0;
			RL1: out[0] = 0;
			RL2: out[0] = 1;
		endcase
	end
	
	// DFFs  
	always_ff @(posedge clk) begin  
		if (reset)  
			ps <= C0;  
		else  
			ps <= ns;  
	end  
endmodule

			