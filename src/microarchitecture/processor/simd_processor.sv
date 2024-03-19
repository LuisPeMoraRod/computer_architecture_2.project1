

// Top level Verilog code for 32-bit 5-stage Pipelined MIPS Processor
	
	
module simd_processor
(
	input logic clk, reset,
	output logic [31:0] pcF,
	input logic [31:0] instrF,
	output logic memwriteM,
	output logic [31:0] aluoutM, writedataM,
	input logic [31:0] readdataM
);

	logic [5:0] opD, functD;
	logic regdstE, alusrcE,
			pcsrcD,
			memtoregE, memtoregM, memtoregW,
			regwriteE, regwriteM, regwriteW;
	logic [2:0] alucontrolE;
	logic flushE;
	logic jumpD; 
	logic [1:0] branchD;
	logic [31:0] srca2D, srcb2D;
	
	control c
	(
		clk, reset, opD, functD, flushE,
		memtoregE, memtoregM,
		memtoregW, memwriteM, 
		pcsrcD, alusrcE, 
		branchD, 
		regdstE, regwriteE,
		regwriteM, regwriteW, jumpD,
		alucontrolE,
		srca2D, srcb2D
	);
	
	datapath dp
	(
		clk, reset, memtoregE, memtoregM,
		memtoregW, pcsrcD, branchD,
		alusrcE, regdstE, regwriteE,
		regwriteM, regwriteW, jumpD,
		alucontrolE,
		pcF, instrF,
		aluoutM, writedataM, readdataM,
		opD, functD, flushE,
		srca2D, srcb2D
	);

endmodule
