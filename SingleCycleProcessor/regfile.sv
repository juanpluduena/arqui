module regfile(
	input logic clk, we3,
	input logic [4:0] ra1, ra2, wa3,
	input logic [63:0] wd3,
	output logic [63:0] rd1, rd2
);
	logic [63:0] REGS [0:31];
	
	initial begin
		$readmemh("progs/regfile.txt", REGS);
	end
	
	always_comb begin
		rd1 = (ra1 == 5'd31) ? 64'b0 : REGS[ra1];
		rd2 = (ra2 == 5'd31) ? 64'b0 : REGS[ra2];
	end
	
	always_ff @(posedge clk) begin
		if (we3 && (wa3 != 31)) begin
			REGS[wa3] <= wd3;
		end
	end
	
endmodule
