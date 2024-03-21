

// Top level Verilog code for 32-bit 5-stage Pipelined MIPS Processor
	
	
module simd_processor
(
	input logic clk, reset,
	output logic [31:0] pcF,
	input logic [31:0] instrF,
	output logic memwriteM, src_sel,
	output logic [31:0] aluoutM, writedataM,
	input logic [31:0] readdataM
);

	logic [5:0] opD, functD;
	logic regdstE, alusrcE, scalarE,
			pcsrcD, memdataM,
			memtoregE, memtoregM, memtoregW,
			regwriteE, regwriteM, regwriteW, VregwriteW;
	logic [2:0] alucontrolE;
	logic flushE;
	logic jumpD; 
	logic [1:0] branchD;
	logic [31:0] srca2D, srcb2D;
	
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
		memwriteM, memdataM, src_sel,
		regwriteE, regwriteM, regwriteW, VregwriteW,
		memtoregE, memtoregM, memtoregW
	);
	
	datapath dp
	(
		clk, reset, 
		memtoregE, memdataM, memtoregM, memtoregW, 
		pcsrcD, branchD,
		alusrcE, regdstE, scalarE,
		regwriteE, regwriteM, regwriteW, VregwriteW,
		jumpD, alucontrolE,
		pcF, instrF,
		aluoutM, writedataM, readdataM,
		opD, functD, flushE,
		srca2D, srcb2D
	);

endmodule
