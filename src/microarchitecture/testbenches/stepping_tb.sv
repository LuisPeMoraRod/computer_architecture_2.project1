`timescale 1 ps / 1 ps
module stepping_tb();
	logic clk_c;
	logic reset;
	logic clk_b;
	logic debug;
	logic [31:0] readdata2;
		
	// instantiate device to be tested
	top dut(clk_c, reset, clk_b, debug, readdata2);
	
	// initialize test
	initial
	begin
		reset <= 0;
	end
	
	// generate clock to sequence tests
	always
	begin
		clk_c <= 1; # 5; clk_c <= 0; # 5;
		clk_b <= 0; # 5; clk_b <= 1; # 5;
		debug <= 1; # 100; debug <= 0; # 100;
	end
	
	
endmodule
