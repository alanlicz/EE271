module pipe_generator #(parameter SHIFT_THRESHOLD)(column ,clk, rst);
	input logic clk, rst;
	output logic [15:0] column;
  logic [15:0] pipe0, pipe1;
	logic [7:0] random_number;
	int count;
	random lfsr(random_number, rst, clk);
	
  pipe_filler #(0, 5) pipe0_filler(pipe0, random_number[1:0], random_number[5:4]);
  pipe_filler #(5, 5) pipe1_filler(pipe1, random_number[3:2], random_number[7:6]);

	always_ff @(posedge clk) begin
		if (rst) begin
			count <= 0;
		end
		else begin
			if (count >= SHIFT_THRESHOLD) begin
        column <= pipe0 & pipe1;
        count <= 0;
			end
			else begin
				column <= 0;
				count += 1; 
			end
		end
	end
endmodule

module pipe_generator_testbench();
  logic clk, rst;
	logic [15:0] column;
  pipe_generator #(3) dut (column, clk, rst);
  // Set up a simulated clock.
  parameter CLOCK_PERIOD=100;
  initial begin
    clk <= 0;
    forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
  end
  initial begin
    rst <= 1; @(posedge clk);
    rst <= 0; @(posedge clk);
    repeat(256) @(posedge clk);
    $stop;
  end
endmodule