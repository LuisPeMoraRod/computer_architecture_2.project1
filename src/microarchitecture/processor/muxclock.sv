
module muxclock
(
	input logic clk_c, clk_b,
	input logic debug,
	output logic clk
);
												
	assign clk = debug ? clk_b : clk_c;
	
endmodule