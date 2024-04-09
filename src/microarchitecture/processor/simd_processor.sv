

// Top level Verilog code for 32-bit 5-stage Pipelined MIPS Processor
	
	
module simd_processor
(
	input logic clk, reset,
	output logic [31:0] pcF,
	input logic [31:0] instrF,

	output logic [13:0] address_RAM,
	output logic [31:0] byteena_RAM,
	input logic [255:0] readData_RAM,
	output logic [255:0] writeData_RAM,
	output logic rden_RAM, wren_RAM
);

	logic [5:0] opD, functD;
	logic regdstE, alusrcE, scalarE,
			pcsrcD, memdataM,
			memtoregE, memtoregM, memtoregW,
			regwriteE, regwriteM, VregwriteM, regwriteW, VregwriteW;
	logic [2:0] alucontrolE;
	logic flushE;
	logic jumpD; 
	logic [1:0] branchD;
	logic [31:0] srca2D, srcb2D;
	logic memwriteM, memsrcM;
	
	control c
	(
		clk, reset, opD, functD, 
		srca2D, srcb2D,
		flushE,
		jumpD,
		branchD,
		pcsrcD, alusrcE, scalarE,
		alucontrolE,
		regdstE, 
		memwriteM, memdataM, memsrcM,
		regwriteE, regwriteM, VregwriteM, regwriteW, VregwriteW,
		memtoregE, memtoregM, memtoregW
	);
	
	datapath dp
	(
		clk, reset, 
		memtoregE, memdataM, memsrcM, memtoregM, memtoregW, memwriteM,
		pcsrcD, branchD,
		alusrcE, regdstE, scalarE,
		regwriteE, regwriteM, VregwriteM, regwriteW, VregwriteW,
		jumpD, alucontrolE,
		pcF, instrF,
		opD, functD, flushE,
		srca2D, srcb2D,

		address_RAM,
		byteena_RAM,
		readData_RAM,
		writeData_RAM,
		rden_RAM, wren_RAM
	);

endmodule
