
// Top level module

module top
(
	input logic clk, reset,
	output logic [31:0] writedata, dataadr,
	output logic memwrite
);

	logic [31:0] pc, instr, readdata;
	

	simd_processor processor (clk, reset, pc, instr, memwrite, dataadr, writedata, readdata);
	
	imem imem (pc[7:2], instr);
	
	// wires for memory module
	logic w_enable, src_sel;
	logic [31:0] addr;
	logic [15:0] w_data_a;
	logic [255:0] w_data_b;
	logic [15:0] q_a;
	logic [255:0] q_b;
	dmem ram_mem (clk, w_enable, src_sel, addr, w_data_a, w_data_b, q_a, q_b);

endmodule
