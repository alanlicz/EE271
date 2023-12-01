module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	// Default values, turns off the HEX displays
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	logic[6:0] A, B;
	
	
	seg7 SW0To3 (.bcd(SW[3:0]), .leds(A));
	seg7 sw4To7 (.bcd(SW[7:4]), .leds(B));
	
	assign HEX0 = ~A;
	assign HEX1 = ~B;
	
	
	
endmodule

module seg7 (bcd, leds);
	input logic [3:0] bcd;
	output logic [6:0] leds;
	always_comb begin
		case (bcd)
		// Light:             6543210
			4'b0000: leds = 7'b0111111; // 0
			4'b0001: leds = 7'b0000110; // 1
			4'b0010: leds = 7'b1011011; // 2
			4'b0011: leds = 7'b1001111; // 3
			4'b0100: leds = 7'b1100110; // 4
			4'b0101: leds = 7'b1101101; // 5
			4'b0110: leds = 7'b1111101; // 6
			4'b0111: leds = 7'b0000111; // 7
			4'b1000: leds = 7'b1111111; // 8
			4'b1001: leds = 7'b1101111; // 9
			default: leds = 7'bX;
		endcase
	end
endmodule

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i <256; i++) begin
			SW[7:0] = i; #10;
		end
	end
endmodule

