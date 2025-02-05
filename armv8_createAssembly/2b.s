/*
	X3 -> sum
 	x0 -> puntero a memoria
	x9 -> delimitador (N)
	
	
	seteo x3 en 0
	seteo x9 en N = 29
	en cada iteracion: 
		- cargo en X2 el valor de memoria de X0
		- X3 += X2
		- X0 + 8
		- X9 --
		- si X9 != 0 -> branch loop
		- guardo en la pos X0 de memoria el valor de X3
*/
	ADD		X2, XZR, XZR		// X2 = 0
	ADD  	X9, X30, XZR
loop1: 
	STUR 	X2, [X0, #0]		// WRITE X2 IN X0 ADDR 
	ADD		X2, X2, X1			// X2 ++
	ADD 	X0, X0, X8			// X0 += 8
	SUB 	X9, X9, X1			// X9 --
	CBZ 	X9, end1			
	CBZ 	XZR, loop1				

end1:
	ADD 	X3, XZR, XZR
	ADD 	X9, X30, XZR
	ADD		X0, XZR, XZR

loop2: 	
	LDUR 	X2, [X0, #0]		// X2 = M[X0]
	ADD 	X3, X3, X2			// X3 += X2
	ADD 	X0, X0, X8			// X0 += 8b
	SUB 	X9, X9, X1			// X9 --
	CBZ 	X9, end2			
	CBZ 	XZR, loop2	

end2:
	STUR 	X3, [X0, #0]		// M[X0] = X3
	
infloop:
	CBZ XZR, infloop
	