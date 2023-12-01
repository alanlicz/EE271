module userInput (clk, reset, key, out);
   input logic clk, reset, key;
	output logic out;
	
	
	enum {on, off, meta} ps, ns;
	
	
	always_comb begin
		case (ps)
			on:	if (key)		ns = meta;
			 else   				ns = off;
			 
			off:	if (key)		ns = on;
			 else					ns = off;
			
			meta:if (key)		ns = meta;
			 else					ns = off;
		endcase
	end

	assign out = (ps == on);
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= off;
		else
			ps <= ns;
	end
	
		
endmodule

module userInput_testbench();
   logic clk, reset, key;
	logic out;
   
	button dut5 (.clk, .reset, .key, .out);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin
	                                     @(posedge clk);
	   reset <= 1;                       @(posedge clk);
	   reset <= 0;    
		key <= 0;          @(posedge clk);
	   key <= 1;          @(posedge clk);
				   			                
	   key <= 0;          @(posedge clk);	                                   
	   key <= 1;          @(posedge clk);
				   			               								            			   		
		$stop;
   end	
endmodule