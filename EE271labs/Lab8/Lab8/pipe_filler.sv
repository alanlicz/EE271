module pipe_filler #(parameter GAP_BASE, parameter GAP_BASE_WIDTH)(dest, gap_width, gap_offset);
	input logic [1:0] gap_width, gap_offset;
	output logic [15:0] dest;
	always_comb begin
		dest = 0;
    // Acutal Gap Width is gap_width + GAP_BASE_WIDTH
		for (int i=0; i<gap_width + GAP_BASE_WIDTH; i++) begin
      dest[i + gap_offset + GAP_BASE] = 1;
    end
    dest = ~dest;
	end
endmodule

module pipe_filler_testbench();
  logic [1:0] gap_width, gap_offset;
	logic [15:0] column;
  pipe_filler #(3, 2) dut (column, gap_width, gap_offset);
  initial begin
    for (int i=0; i<4; i++) begin
      gap_width = i;
      for (int j=0; j<4; j++) begin
        gap_offset = j; #10;
      end
    end
  end
endmodule