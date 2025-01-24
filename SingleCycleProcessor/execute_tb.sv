module execute_tb;
	logic AluSrc;
	logic [3:0] AluControl;
	logic [63:0] PC_E, signImm_E, readData1_E, readData2_E;
	logic [63:0] PCBranch_E, aluResult_E, writeData_E;
	logic zero_E;

	execute uut (
		.AluSrc(AluSrc),
		.AluControl(AluControl),
		.PC_E(PC_E),
		.signImm_E(signImm_E),
		.readData1_E(readData1_E),
		.readData2_E(readData2_E),
		.PCBranch_E(PCBranch_E),
		.aluResult_E(aluResult_E),
		.writeData_E(writeData_E),
		.zero_E(zero_E)
  );
  
  // Estímulos de prueba
  initial begin
    $display("Iniciando Testbench para el módulo execute...");
    
    // Caso 1: Prueba de suma con registros (AluControl = 4'b0010, AluSrc = 0)
    AluSrc = 0;
    AluControl = 4'b0010; // Operación de suma
    PC_E = 64'h0000_0000_0000_0004;
    signImm_E = 64'h0000_0000_0000_0008; // Valor inmediato
    readData1_E = 64'h0000_0000_0000_0002;
    readData2_E = 64'h0000_0000_0000_0003;
    #10; // Esperar 10 ns
    $display("Caso 1: aluResult_E = %h, zero_E = %b", aluResult_E, zero_E);

    // Caso 2: Prueba de AND lógico (AluControl = 4'b0000)
    AluControl = 4'b0000; // Operación AND
    readData1_E = 64'hFFFF_FFFF_FFFF_FFFF;
    readData2_E = 64'h0000_0000_0000_FFFF;
    #10;
    $display("Caso 2: aluResult_E = %h, zero_E = %b", aluResult_E, zero_E);

    // Caso 3: Prueba de salto con PCBranch_E
    PC_E = 64'h0000_0000_0000_0010;
    signImm_E = 64'h0000_0000_0000_0004; // Inmediato desplazado a la izquierda
    #10;
    $display("Caso 3: PCBranch_E = %h", PCBranch_E);

    // Caso 4: Prueba de comparación igual (AluControl = 4'b0110, salida zero_E = 1)
    AluControl = 4'b0110; // Operación de resta
    readData1_E = 64'h0000_0000_0000_000A;
    readData2_E = 64'h0000_0000_0000_000A; // Igual que el registro 1
    #10;
    $display("Caso 4: aluResult_E = %h, zero_E = %b", aluResult_E, zero_E);

    // Fin del test
    $stop;
  end

endmodule
 