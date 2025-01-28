module execute #(parameter N = 64) (
	input logic AluSrc,
	input logic [3:0] AluControl,
	input logic [63:0] PC_E, signImm_E, readData1_E, readData2_E,
	output logic [63:0] PCBranch_E, aluResult_E, writeData_E,
	output logic zero_E
);
	logic [63:0] sl2_result, mux_result;
	
	mux2 mux_inst (
		.d0(readData2_E),
		.d1(signImm_E),
		.s(AluSrc),
		.y(mux_result)
	);
	 
	adder adder_inst (
		.a(PC_E),
		.b(sl2_result),
		.y(PCBranch_E)
	);
	 
	sl2 sl2_inst (
		.a(signImm_E),
		.y(sl2_result)
	);
	 
	alu alu_inst(
		.a(readData1_E),
		.b(mux_result),
		.ALUControl(AluControl),
		.result(aluResult_E),
		.zero(zero_E)
	);
	
	assign writeData_E = readData2_E;
endmodule
	