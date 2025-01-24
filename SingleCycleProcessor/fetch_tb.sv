module fetch_tb;
	logic PCSrc_F, clk, reset;
	logic [63:0] PCBranch_F;
	logic [63:0] imem_addr_F;
	
	fetch uut(
		.PCSrc_F(PCSrc_F),
		.clk(clk),
		.reset(reset),
		.PCBranch_F(PCBranch_F),
		.imem_addr_F(imem_addr_F)
	);
	
	initial clk = 0;
	always #5 clk = ~clk;
	
	initial begin
		reset = 1;
		PCSrc_F = 0;
		PCBranch_F = 64'h16e10b5ef5732a68;
		
		repeat(5) @(posedge clk);
		
		reset = 0;
		
		repeat(5) @(posedge clk);
		
		PCSrc_F = 1;
		
		repeat(5) @(posedge clk);
		
		$stop;
	end
endmodule
	