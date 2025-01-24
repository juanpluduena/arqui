module alu_tb;
	logic [63:0] a, b, result;
	logic [3:0] ALUControl;
	logic zero;
	
	alu uut (
        .a(a),
        .b(b),
		  .ALUControl(ALUControl),
		  .result(result),
		  .zero(zero)
	);
	
	task check_output(input [63:0] in1, in2, expected);
        begin
            a = in1;
				b = in2;
            #10;  // Espera 10 unidades de tiempo para que la salida se actualice	
            if (result === expected)
                $display("PASSED: a = %b, b = %b, result = %b", a, b, result);
            else
                $display("FAILED: a = %b, b = %b, result = %b (expected %b)", a, b, result, expected);
        end
	endtask
	 
	logic [63:0] pos1, pos2, neg1, neg2;
	 
	initial begin
		pos1 = {{60{1'b0}}, 4'b1010}; // 10
		pos2 = {{60{1'b0}}, 4'b0111}; // 7
		neg1 = {{60{1'b1}}, 4'b0110}; // -10
		neg2 = {{60{1'b1}}, 4'b1110}; // -2
	
		// AND
		ALUControl = 4'b0000;
		
		// 10 & 7 = 000...1010 & 000...0111 = 000...0010
		check_output(pos1, pos2, 64'b0010);
		
		// -10 & -2 = 111...0110 & 111...1110 = 111...0110
		check_output(neg1, neg2, {{60{1'b1}}, 4'b0110});
		
		// 7 & -2 = 000...0111 & 111...1110 = 000...0110
		check_output(pos2, neg2, {{60{1'b0}}, 4'b0110});
		
		// OR
		ALUControl = 4'b0001;
		
		// 10 | 7 = 000...1010 | 000...0111 = 000...1111
		check_output(pos1, pos2, 64'b1111);
		
		// -10 | -2 = 111...0110 | 111...1110 = 111...1110
		check_output(neg1, neg2, {{60{1'b1}}, 4'b1110});
		
		// 7 | -2 = 000...0111 | 111...1110 = 111...1111
		check_output(pos2, neg2, {{60{1'b1}}, 4'b1111});
		
		// ADD
		ALUControl = 4'b0010;
		
		// 10 + 7 = 000...1010 + 000...0111 = 000...10001
		check_output(pos1, pos2, 64'b10001);
		
		// -10 + -2 = 111...0110 + 111...1110 = 111...0100
		check_output(neg1, neg2, {{60{1'b1}}, 4'b0100});
		
		// 7 + -2 = 000...0111 + 111...1110 = 000...0101
		check_output(pos2, neg2, {{60{1'b0}}, 4'b0101});
		
		// SUB
		ALUControl = 4'b0110;
		
		// 10 - 7 = 000...1010 - 000...0111 = 000...0011
		check_output(pos1, pos2, 64'b0011);
		
		// -10 - (-2) = 111...0110 - 111...1110 = 111...1000
		check_output(neg1, neg2, {{60{1'b1}}, 4'b1000});
		
		// 7 - (-2) = 000...0111 - 111...1110 = 000...1001
		check_output(pos2, neg2, {{60{1'b0}}, 4'b1001});
		
		// pass input b
		ALUControl = 4'b0111;
		
		// a = 1111, b = 0101 , result = 0101
		check_output(64'b1111, 64'b0101, 64'b0101);
		
		// ADD
		ALUControl = 4'b0010;
		
		// overflow
		// -1 + 1
		check_output({64{1'b1}}, 64'b1, 64'b0);
		
		// result == 0, zero == 1
		// 10 + (-10) = 000...1010 + 111...0110 = 0
		check_output(pos1, neg1, 64'b0);
		
		$stop;
	end
endmodule
