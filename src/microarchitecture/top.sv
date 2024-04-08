
// Top level module

module top
(
	input logic clk_c, reset,
	input logic clk_b, debug,
	output logic [31:0] readdata2
	
);

	logic [31:0] writedata, dataadr;
	logic memwrite;
	logic clk;
	logic [31:0] pcF, instr, readdata;
	logic src_sel;
	logic [255:0] w_data_b;
	logic [15:0] q_a;
	logic [255:0] q_b;
	
	
	muxClock mux_clock (clk_c, clk_b, debug, clk);

	simd_processor processor (clk, reset, pcF, instr, memwrite, src_sel, dataadr, writedata, readdata, w_data_b, q_b);

	
	imem imem (pcF[7:2], instr);
	
	
	dmem ram_mem (clk, memwrite, src_sel, dataadr, writedata[15:0], {223'd0, writedata}, q_a, q_b);
	
	assign readdata = {16'b0, q_a};
	assign readdata2 = q_b[31:0];

endmodule
