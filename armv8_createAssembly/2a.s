/*
	X2 -> i 
	x0 -> puntero a memoria
	x9 -> delimitador (N)
	seteo x2 en 0
	en cada iteracion: 
	- guardo en x0 el valor de x2
	- le sumo 1 a x2
	- le sumo 8 a x0
	- le resto X1 a x9
		+ si x9 es 0 branch fin
		+ si x9 no es 0 branch loop
*/

	ADD  	X9, X30, XZR
	ADD		X2, XZR, XZR		// X2 = 0
loop: 
	STUR 	X2, [X0, #0]		// WRITE X2 IN X0 ADDR 
	ADD		X2, X2, X1			// X2 ++
	ADD 	X0, X0, X8			// X0 += 8
	SUB 	X9, X9, X1			// X9 --
	CBZ 	X9, end				
	CBZ 	XZR, loop				

end:

infloop:
	CBZ XZR, infloop
	