module flopr_tb;

    // Parámetros
    parameter N = 32;

    // Señales
    logic clk;
    logic reset;
    logic [N-1:0] d;
    logic [N-1:0] q;
    
    // Instancia del módulo flopr
    flopr #(.N(N)) dut (
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q)
    );

    // Generación de la señal de reloj (100 MHz -> periodo = 10 ns)
    always begin
        #5 clk = ~clk;  // 10 ns total (5 ns high, 5 ns low)
    end

    // Proceso principal
    initial begin
        // Inicializar señales
        clk = 0;
        reset = 1;
        d = 0;

        // Generar reset activo durante los primeros 5 ciclos de reloj
        repeat(5) begin
            d = $random;  // Generar números aleatorios de 64 bits
            #10;  // Esperar 1 ciclo de reloj (10 ns)
        end

        // Desactivar reset y continuar ingresando números
        reset = 0;
        repeat(5) begin
            d = $random;  // Generar números aleatorios de 64 bits
            #10;  // Esperar 1 ciclo de reloj (10 ns)
        end

        // Finalizar la simulación
        $finish;
    end

    // Monitor para verificar los resultados
    initial begin
        $monitor("Time: %0t | clk = %b | reset = %b | d = %h | q = %h", $time, clk, reset, d, q);
    end

endmodule
