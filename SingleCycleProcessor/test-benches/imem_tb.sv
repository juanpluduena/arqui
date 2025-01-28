module imem_tb;
	logic [5:0] addr;
	logic [31:0] q;
	
	imem uut (
		.addr(addr),
		.q(q)
   );
	 
	initial begin
		integer i;
		
		for (i = 0; i < 50; i = i + 1) begin
			addr = 6'h0 + i;
			#10;
		end
		
		$stop;
	end
endmodule
