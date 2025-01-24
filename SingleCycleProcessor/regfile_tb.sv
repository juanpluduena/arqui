module regfile_tb;
	logic clk, we3;
	logic [4:0] ra1, ra2, wa3;
	logic [63:0] wd3;
	logic [63:0] rd1, rd2;
	
	regfile uut(
		.clk(clk),
		.we3(we3),
		.ra1(ra1),
		.ra2(ra2),
		.wa3(wa3),
		.wd3(wd3),
		.rd1(rd1),
		.rd2(rd2)
	);
	
	// we3: permiso para escribir
	// wa3: direccion de memoria a escribir (32b)
	// wd3: contenido a guardar (64b)
	// ra1: direccion para lectura de datos en memoria que sale por rd1
	// ra2: direccion para lectura de datos en memoria que sale por rd2
	
	initial clk = 0;
	always #5 clk = ~clk;
	
	initial begin
		we3 = 0;
		
		for (int i = 0; i < 32; i++) begin
			ra1 = i;
			ra2 = i;
			#10;
		end
		
		we3 = 1;
		wa3 = 5;
		wd3 = {64{1'b1}};
		ra1 = 5;
		ra2 = 4;
		#10;
		
		we3 = 0;
		wa3 = 1;
		wd3 = 64'hfe32;
		ra2 = 1;
		#10;
		
		we3 = 1;
		wa3 = 31;
		wd3 = 64'h6e6e6e;
		ra1 = 31;
		#10;
		
		$stop;
	end
endmodule
