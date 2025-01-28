module fetch #(parameter N = 64) (
	input logic PCSrc_F, clk, reset,
	input logic [63:0] PCBranch_F,
	output logic [63:0] imem_addr_F
);
	logic [63:0] mux_result, adder_result, flop_result;
	
	mux2 mux_inst (
		.d0(adder_result),
		.d1(PCBranch_F),
		.s(PCSrc_F),
		.y(mux_result)
	);
	
	flopr flopr_inst (
	  .clk(clk),
	  .reset(reset),
	  .d(mux_result),
	  .q(flop_result)
    );
	 
	 adder adder_inst (
		.a(flop_result),
		.b(64'd4),
		.y(adder_result)
	 );
	 
	 assign imem_addr_F = flop_result;
endmodule
