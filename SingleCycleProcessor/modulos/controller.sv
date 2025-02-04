// CONTROLLER

module controller(input logic [10:0] instr,
						input logic ExtIRQ, ExcAck, reset,
						output logic [3:0] AluControl, EStatus,
						output logic [1:0] AluSrc,
						output logic reg2loc, regWrite, Branch,
											memtoReg, memRead, memWrite, Exc, ERet, ExtIAck);
											
	logic [1:0] AluOp_s;
	logic NotAnInstr = 1'b0;
	logic [3:0] alu_control_res;
											
	maindec 	decPpal 	(.Op(instr), 
							.reset(reset),
							.Reg2Loc(reg2loc), 
							.ALUSrc(AluSrc), 
							.MemtoReg(memtoReg), 
							.RegWrite(regWrite), 
							.MemRead(memRead), 
							.MemWrite(memWrite), 
							.Branch(Branch), 
							.ALUOp(AluOp_s),
							.ERet(ERet),
							.NotAnInstr(NotAnInstr));	
					
								
	aludec 	decAlu 	(.funct(instr), 
							.aluop(AluOp_s), 
							.alucontrol(alu_control_res));
							
	assign Exc = ExtIRQ | NotAnInstr;
	
	assign AluControl = reset ? 4'b0 : alu_control_res; 
	
	assign EStatus = NotAnInstr ? 4'b0010 : (ExtIRQ ? 4'b0001 : 4'b0);
	
	assign ExtIAck = ExcAck & ExtIRQ;
			
endmodule
