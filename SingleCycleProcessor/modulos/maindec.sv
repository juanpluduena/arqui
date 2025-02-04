module maindec(
	input logic [10:0] Op,
	input logic reset,
	output logic Reg2Loc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ERet, NotAnInstr,
	output logic [1:0] ALUOp, ALUSrc
);
	always_comb begin
	
		if (reset) begin
			Reg2Loc = 1'b0;
			ALUSrc = 2'b00;
			MemtoReg = 1'b0;
			RegWrite = 1'b0;
			MemRead = 1'b0;
			MemWrite = 1'b0;
			Branch = 1'b0;
			ALUOp = 2'b00;
			ERet = 1'b0;
			NotAnInstr = 1'b0;
		end
		
		else begin
		
			case (Op)
				11'b111_1100_0010: begin // LDUR
					Reg2Loc = 1'bx;
					ALUSrc = 2'b01;
					MemtoReg = 1'b1;
					RegWrite = 1'b1;
					MemRead = 1'b1;
					MemWrite = 1'b0;
					Branch = 1'b0;
					ALUOp = 2'b00;
					ERet = 1'b0;
					NotAnInstr = 1'b0;
				end
				
				11'b111_1100_0000: begin // STUR
					Reg2Loc = 1'b1;
					ALUSrc = 2'b01;
					MemtoReg = 1'bx;
					RegWrite = 1'b0;
					MemRead = 1'b0;
					MemWrite = 1'b1;
					Branch = 1'b0;
					ALUOp = 2'b00;
					ERet = 1'b0;
					NotAnInstr = 1'b0;
				end
				
				11'b101_1010_0000,
				11'b101_1010_0001,
				11'b101_1010_0010,
				11'b101_1010_0011,
				11'b101_1010_0100,
				11'b101_1010_0101,
				11'b101_1010_0110,
				11'b101_1010_0111: begin // CBZ
					Reg2Loc = 1'b1;
					ALUSrc = 2'b00;
					MemtoReg = 1'bx;
					RegWrite = 1'b0;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					Branch = 1'b1;
					ALUOp = 2'b01;
					ERet = 1'b0;
					NotAnInstr = 1'b0;
				end
				
				11'b100_0101_1000,
				11'b110_0101_1000,
				11'b100_0101_0000,
				11'b101_0101_0000: begin // ADD, SUB, AND, ORR
					Reg2Loc = 1'b0;
					ALUSrc = 2'b00;
					MemtoReg = 1'b0;
					RegWrite = 1'b1;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					Branch = 1'b0;
					ALUOp = 2'b10;
					ERet = 1'b0;
					NotAnInstr = 1'b0;
				end
				
				11'b110_1011_0100: begin // ERET
					Reg2Loc = 1'b0;
					ALUSrc = 2'b00;
					MemtoReg = 1'bx;
					RegWrite = 1'b0;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					Branch = 1'b1;
					ALUOp = 2'b01;
					ERet = 1'b1;
					NotAnInstr = 1'b0;
				end
				
				11'b110_1010_1001: begin // MRS
					Reg2Loc = 1'b1;
					ALUSrc = 2'b1x;
					MemtoReg = 1'b0;
					RegWrite = 1'b1;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					Branch = 1'b0;
					ALUOp = 2'b01;
					ERet = 1'b0;
					NotAnInstr = 1'b0;
				end
				
				default: begin // INVALID OPCODE
					Reg2Loc = 1'bx;
					ALUSrc = 2'bxx;
					MemtoReg = 1'b0;
					RegWrite = 1'b0;
					MemRead = 1'b0;
					MemWrite = 1'b0;
					Branch = 1'b0;
					ALUOp = 2'bxx;
					ERet = 1'b0;
					NotAnInstr = 1'b1;
				end
				
			endcase
			
		end
		
	end
	
endmodule
			