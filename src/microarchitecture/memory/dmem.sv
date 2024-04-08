
module dmem
(
	clk, // clock signal
	w_enable, //write enable
	src_sel, // source selector (0=scalar, 1=vectorial)
	addr, // memory address
	w_data_a, // input data to be written (scalar)
	w_data_b, // input data to be written (vectorial)
	q_a, // output signal with data read (16 bits)
	q_b // output signal with data read (256 bits)
);
	input clk, w_enable, src_sel;
	input [31:0] addr;
	input [15:0] w_data_a;
	input [255:0] w_data_b;
	output [15:0] q_a;
	output [255:0] q_b;

	logic [17:0]  address_a; //address input for port A (scalar)
	logic [13:0]  address_b; //address input for port B (vectorial)
	
	logic wren_a, wren_b;

	assign address_a = addr[17:0]; // resize address for port A (scalar)
	assign address_b = addr[13:0]; // resize address for port B (vectorial)

	assign wren_a = (w_enable && ~src_sel); // write to port A when src_sel = 0
	assign wren_b = (w_enable && src_sel); // write to port B when src_sel = 1

endmodule
