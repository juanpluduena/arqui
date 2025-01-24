module imem #(parameter N = 32) (
	input logic [5:0] addr,
	output logic [N-1:0] q
);
	logic [N-1:0] ROM [0:63];
	
	initial begin
		ROM = '{default:'0};
		$readmemh("progs/imem.txt", ROM);
	end
	
	assign q = ROM[addr];
endmodule
