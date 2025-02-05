// Testbench ProcessorPatterson
// Top-level Entity: processor_arm

module processor_tb();
    localparam N = 64;  // Tamaño de registros
    logic CLOCK_50, reset;
    logic DM_writeEnable;
    logic [N-1:0] DM_writeData, DM_addr;
    logic dump;
    logic ExtIRQ, ExtIAck;

    // Instancia del procesador
    processor_arm dut (
        .CLOCK_50(CLOCK_50), 
        .reset(reset), 
        .ExtIRQ(ExtIRQ), 
        .DM_writeData(DM_writeData), 
        .DM_addr(DM_addr), 
        .DM_writeEnable(DM_writeEnable), 
        .ExtIAck(ExtIAck), 
        .dump(dump)
    );

    // Generación del clock (50MHz)
    always begin
        #5 CLOCK_50 = ~CLOCK_50;  // Cada 5ns cambia el estado
    end

    initial begin
        // Inicialización de señales
        CLOCK_50 = 0; 
        reset = 1;
        dump = 0;
        ExtIRQ = 0;

        // Espera inicial con reset activo
        #20 reset = 0;  // Desactiva reset después de 20ns

        // Genera una interrupción externa en cierto momento
        #100 ExtIRQ = 1;  // Activa interrupción externa
        #10  ExtIRQ = 0;  // Desactiva interrupción después de 10ns

        // Verifica que el procesador reconozca la interrupción
        #50 assert(ExtIAck) 
            else $error("ERROR: ExtIAck no se activó tras la interrupción.");

        // Ejecuta la simulación por un tiempo y luego detiene
        #15000 dump = 1;  // Activa volcado de datos al final
        #20 $stop;  // Detiene la simulación
    end
endmodule
