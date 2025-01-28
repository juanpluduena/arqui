module maindec(
	input logic [10:0] Op,
	output logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch,
	output logic [1:0] ALUOp
);
	always_comb begin
		case (Op)
			11'b111_1100_0010: begin // LDUR
				Reg2Loc = 0;
				ALUSrc = 1;
				MemtoReg = 1;
				RegWrite = 1;
				MemRead = 1;
				MemWrite = 0;
				Branch = 0;
				ALUOp = 2'b00;
			end
			
			11'b111_1100_0000: begin // STUR
				Reg2Loc = 1;
				ALUSrc = 1;
				MemtoReg = 0;
				RegWrite = 0;
				MemRead = 0;
				MemWrite = 1;
				Branch = 0;
				ALUOp = 2'b00;
			end
			
			11'b101_1010_0000,
			11'b101_1010_0001,
			11'b101_1010_0010,
			11'b101_1010_0011,
			11'b101_1010_0100,
			11'b101_1010_0101,
			11'b101_1010_0110,
			11'b101_1010_0111: begin // CBZ
				Reg2Loc = 1;
				ALUSrc = 0;
				MemtoReg = 0;
				RegWrite = 0;
				MemRead = 0;
				MemWrite = 0;
				Branch = 1;
				ALUOp = 2'b01;
			end
			
			11'b100_0101_1000,
			11'b110_0101_1000,
			11'b100_0101_0000,
			11'b101_0101_0000: begin // ADD, SUB, AND, ORR
				Reg2Loc = 0;
				ALUSrc = 0;
				MemtoReg = 0;
				RegWrite = 1;
				MemRead = 0;
				MemWrite = 0;
				Branch = 0;
				ALUOp = 2'b10;
			end
			
			default: begin // default
				Reg2Loc = 0;
				ALUSrc = 0;
				MemtoReg = 0;
				RegWrite = 0;
				MemRead = 0;
				MemWrite = 0;
				Branch = 0;
				ALUOp = 2'b00;
			end
		endcase
	end
endmodule
			