`timescale 1 ps / 1 ps
module general_tb();
	logic clk;
	logic reset;
	logic [31:0] readdata2;
	
	// instantiate device to be tested
	top dut(clk, reset, readdata2);

	// Clock generation
    initial begin
        clk = 0;
        forever #5 clk = !clk; // 100MHz clock
    end
	
	// initialize test
	initial
	begin
		reset <= 1; # 22; reset <= 0;
		# 1000;
		$finish;
	end
	
	
	
endmodule
