`timescale 1 ps / 1 ps
module general_tb();
	logic clk;
	logic reset;
	logic [31:0] readdata2;
	
	// instantiate device to be tested
	top dut(clk, reset, readdata2);
	
	// initialize test
	initial
	begin
		reset <= 1; # 22; reset <= 0;
	end
	
	// generate clock to sequence tests
	always
	begin
		clk <= 1; # 5; clk <= 0; # 5;
	end
	
	
endmodule
