
// Top level module

module top
(
	input logic clk, reset
);

	logic [31:0] writedata, dataadr;
	logic memwrite;
	logic [31:0] pcF, instr;
	
	logic [31:0] address_RAM;
	logic [31:0] byteena_RAM;
	logic [255:0] readData_RAM;
	logic [255:0] writeData_RAM;
	logic rden_RAM, wren_RAM;
	

	simd_processor processor
	(
		clk, 
		reset, 
		pcF, 
		instr, 

		address_RAM,
		byteena_RAM,
		readData_RAM,
		writeData_RAM,
		rden_RAM, wren_RAM
	);

	
	imem imem 
	(
		pcF[7:2], 
		instr
	);
	

	dmem data_mem
	(
		address_RAM,
		byteena_RAM,
		clk,
		writeData_RAM,
		rden_RAM, wren_RAM,
		readData_RAM
	);
	
endmodule
