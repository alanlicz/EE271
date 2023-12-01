module collision_detector(gameover, bird_position, green_column0, green_column1);
	input int bird_position;
	input logic [15:0] green_column0, green_column1;
	output logic gameover;
  assign gameover = green_column0[bird_position]
      | green_column0[bird_position + 1]
      | green_column1[bird_position]
      | green_column1[bird_position + 1];
endmodule

module collision_detector_testbench();
  logic gameover;
  int bird_position;
  logic [15:0] green_column0, green_column1;
  collision_detector dut(gameover, bird_position, green_column0, green_column1);
  initial begin
    green_column0 <= 0;
    green_column1 <= 0; #10;
    bird_position <= 0; #10;
    bird_position <= 14; #10;
    bird_position <= 8; #10;
    green_column0 <= 16'b1111110000001111;
    green_column1 <= 0; #10;
    bird_position <= 0; #10;
    bird_position <= 14; #10;
    bird_position <= 8; #10;
    green_column0 <= 0;
    green_column1 <= 16'b1111110000001111; #10;
    bird_position <= 0; #10;
    bird_position <= 14; #10;
    bird_position <= 8; #10;
    green_column0 <= 0;
    green_column1 <= 0; #10;
    bird_position <= 0; #10;
    bird_position <= 14; #10;
    bird_position <= 8; #10;
    green_column0 <= 16'b1111110000001111;
    green_column1 <= 16'b1111110000001111; #10;
    bird_position <= 0; #10;
    bird_position <= 14; #10;
    bird_position <= 8; #10;
  end
endmodule