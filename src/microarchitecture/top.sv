
// Top level module

module top
(
	input logic clk, reset
	
);
	logic [31:0] writedata, dataadr;
	logic memwrite;
	logic [31:0] pcF, instr, readdata;
	logic src_sel;
	logic [255:0] w_data_b;
	logic [15:0] q_a;
	logic [255:0] q_b;
	

	simd_processor processor (clk, reset, pcF, instr, memwrite, src_sel, dataadr, writedata, readdata);
	
	imem imem (pcF[7:2], instr);
	
	
	dmem ram_mem (clk, memwrite, src_sel, dataadr, writedata[15:0], w_data_b, q_a, q_b);
	
	assign readdata = {16'b0, q_a};

endmodule
