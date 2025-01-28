module maindec_tb;
	logic [10:0] Op;
	logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
	logic [1:0] ALUOp;
	
	maindec uut(
		.Op(Op),
		.Reg2Loc(Reg2Loc), 
		.ALUSrc(ALUSrc), 
		.MemtoReg(MemtoReg), 
		.RegWrite(RegWrite), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.Branch(Branch),
		.ALUOp(ALUOp)
	);
	
	initial begin
		Op = 11'b111_1100_0010; // LDUR
		#1;
		Op = 11'b111_1100_0000; // STUR
		#1;
		Op = 11'b101_1010_0101; // CBZ
		#1;
		Op = 11'b100_0101_1000; // ADD
		#1;
		Op = 11'b110_0101_1000; // SUB
		#1;
		Op = 11'b100_0101_0000; // AND
		#1;
		Op = 11'b101_0101_0000; // ORR
		#1;
		Op = 11'b111_1111_0000; // no existente
		#1;
		
		$stop;
	end
endmodule
