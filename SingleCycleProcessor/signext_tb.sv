module signext_tb;
    logic [31:0] a;   // Entrada: Instrucción de 32 bits
    logic [63:0] y;   // Salida: Valor extendido a 64 bits

    // Instancia del módulo signext
    signext uut (
        .a(a),
        .y(y)
    );

    // Tarea para mostrar resultados en cada ciclo
    task check_output(input [31:0] instr, input [63:0] expected);
        begin
            a = instr;
            #10;  // Espera 10 unidades de tiempo para que la salida se actualice
            if (y === expected)
                $display("PASSED: Instr = %b, y = %b", a, y);
            else
                $display("FAILED: Instr = %b, y = %b (expected %b)", a, y, expected);
        end
    endtask

    initial begin
        // Caso 1: LDUR X1, [X2, #0x400]
        // Opcode = 111_1100_0010, inmediato = 100000000 (-256 en decimal)
        check_output(32'b111_1100_0010_100000000_00_00010_00001, 
                     {{55{1'b1}}, 9'b100000000});

        // Caso 2: STUR X3, [X4, #0x44]
        // Opcode = 111_1100_0000, inmediato = 000101100 (44 en decimal)
        check_output(32'b111_1100_0010_000101100_00_00100_00011, 
                     {{55{1'b0}}, 9'b000101100});

        // Caso 3: CBZ X1, #-0x10
        // Opcode = 101_1010_0000, inmediato = 1111111111111110110 (-10 en decimal)
        check_output(32'b101_1010_0_1111111111111110110_00001, 
                     {{45{1'b1}}, 19'b1111111111111110110});

        // Caso 4: Instrucción no reconocida
        check_output(32'b0, 
                     64'b0);

        // Caso 5: Otra instrucción no reconocida
        check_output(32'b1110_0010_0000_0000_0000_0000_0000_0000, 
                     64'b0);

        $stop;  // Finaliza la simulación
    end
endmodule
