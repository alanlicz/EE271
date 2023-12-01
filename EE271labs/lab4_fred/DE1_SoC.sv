// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	assign LEDR[0] = SW[8] | (SW[7] & SW[9]);
	// LED 0 is for discontinued product
	assign LEDR[1] = ~SW[0] & ~SW[8] & (SW[7] | ~SW[9]);
	// LED 1 is for stolen item
	
	logic[6:0] A, B, C, D, E, F;
	
	seg7 fred (.UPC(SW[9:7]), .hex0(A), .hex1(B), .hex2(C), .hex3(D), .hex4(E), .hex5(F));
	
	assign HEX0 = ~A;
	assign HEX1 = ~B;
	assign HEX2 = ~C;
	assign HEX3 = ~D;
	assign HEX4 = ~E;
	assign HEX5 = ~F;
	
endmodule

module seg7 (UPC, hex0, hex1, hex2, hex3, hex4, hex5);
	input logic [3:0] UPC;
	output logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5;
	always_comb begin
		case (UPC)
			// Light:         6543210
			3'b000: hex0 = 7'b1111001; // E
			3'b001: hex0 = 7'b1110111; // A
			3'b011: hex0 = 7'b1111001; // E
			3'b100: hex0 = 7'b1100110; // 4
			3'b101: hex0 = 7'b1111001; // E
			3'b110: hex0 = 7'b1101101; // S
			default: hex0 = 7'bX;
		endcase
		
		case (UPC)
			// Light:         6543210
			3'b000: hex1 = 7'b0110111; // N
			3'b001: hex1 = 7'b0110111; // N
			3'b011: hex1 = 7'b0111111; // O
			3'b100: hex1 = 7'b1101101; // S
			3'b101: hex1 = 7'b0110111; // N
			3'b110: hex1 = 7'b0110111; // N
			default: hex1 = 7'bX;
		endcase
		
		case (UPC)
			// Light:         6543210
			3'b000: hex2 = 7'b0111111; // O
			3'b001: hex2 = 7'b1110111; // A
			3'b011: hex2 = 7'b0111000; // L
			3'b100: hex2 = 7'b1110011; // P
			3'b101: hex2 = 7'b0111111; // O
			3'b110: hex2 = 7'b1110111; // A
			default: hex2 = 7'bX;
		endcase
		
		case (UPC)
			// Light:         6543210
			3'b000: hex3 = 7'b1110110; // H
			3'b001: hex3 = 7'b0110111; // N
			3'b011: hex3 = 7'b1110111; // A
			3'b100: hex3 = 7'b1111111; // off
			3'b101: hex3 = 7'b0111000; // L
			3'b110: hex3 = 7'b1111001; // E
			default: hex3 = 7'bX;
		endcase
		
		case (UPC)
			// Light:         6543210
			3'b000: hex4 = 7'b1110011; // P
			3'b001: hex4 = 7'b1110111; // A
			3'b011: hex4 = 7'b1111111; // off
			3'b100: hex4 = 7'b1111111; // off
			3'b101: hex4 = 7'b0111001; // C
			3'b110: hex4 = 7'b0011110; // J
			default: hex4 = 7'bX;
		endcase
		
		case (UPC)
			// Light:         6543210
			3'b000: hex5 = 7'b0110000; // I
			3'b001: hex5 = 7'b1111100; // B
			3'b011: hex5 = 7'b1111111; // off
			3'b100: hex5 = 7'b1111111; // off
			3'b101: hex5 = 7'b1111111; // off
			3'b110: hex5 = 7'b1111111; // off
			default: hex5 = 7'bX;
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
		SW[6] = 1'b0;
		SW[5] = 1'b0;
		SW[4] = 1'b0;
		SW[3] = 1'b0;
		SW[2] = 1'b0;
		SW[1] = 1'b0;
		for(i = 0; i <16; i++) begin
			SW[9:7] = i; #10;
			SW[0] = i; #10;
		end
	end
endmodule
