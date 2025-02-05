.text
.org 0x0000  // Inicio del programa en dirección 0x0000

main:
    // Inicialización de registros
    ADD X1, XZR, X10      // X1 = 10 (valor arbitrario)
    ADD X2, XZR, X20      // X2 = 20 (valor arbitrario)
    ORR X3, X1, X2       // X3 = X1 | X2 (prueba de ORR)
    AND X4, X1, X2       // X4 = X1 & X2 (prueba de AND)
    ADD X5, X1, X2       // X5 = X1 + X2 (prueba de ADD)
    SUB X6, X2, X1       // X6 = X2 - X1 (prueba de SUB)

    // Instrucción inválida para provocar excepción
    .word 0xFFFFFFFF     // Opcode inválido

    BR main  // Bucle infinito para seguir ejecutando

.org 0xD8  // Dirección del vector de interrupciones

ISR:  
    MRS X7, ESR         // Leer ESR (razón de la excepción)
    MRS X8, ELR         // Leer ELR (dirección de la instrucción fallida)

    // Determinar tipo de excepción
    AND X9, X7, 0x1     // Si ESR & 1 != 0, es una instrucción inválida
    CBZ X9, ext_irq     // Si X9 es 0, es una interrupción externa

    // Manejo de instrucción inválida
    ADD X8, X8, 4       // Saltar la instrucción inválida (ELR + 4)
    ADD X29, X29, 1     // Contar interrupciones de instrucción inválida
    BR X8               // Retornar a la siguiente instrucción válida

ext_irq:
    ADD X30, X30, 1     // Contar interrupciones externas
    ERET                // Retornar al programa principal
