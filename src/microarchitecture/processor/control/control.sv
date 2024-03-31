// Processor's Controller

module control
(
	input logic clk, reset,
	input logic [5:0] opD, functD,
	input logic [31:0] srca2D, srcb2D,
	input logic flushE,

	output logic jumpD,
	output logic [1:0] branchD,
	output logic pcsrcD, alusrcE, scalarE,
	output logic [2:0] alucontrolE,
	output logic regdstE,
	output logic memwriteM, memdataM, memsrcM,
	output logic regwriteE, regwriteM, regwriteW, VregwriteW,
	output logic memtoregE, memtoregM, memtoregW
);


	logic [1:0] aluopD;
	logic memtoregD, memwriteD, alusrcD, scalarD, 
			regdstD, regwriteD, VregwriteD, memdataD;
	logic [2:0] alucontrolD;
	logic memwriteE, memdataE, memsrcD, memsrcE;
	logic VregwriteE, VmemtoregM, VregwriteM;
	
	
	maindec md
	(
		opD,
		regwriteD, VregwriteD, 
		memtoregD, memwriteD, memdataD, memsrcD,
		alusrcD, scalarD, regdstD, 
		branchD,
		jumpD,	
		aluopD
	);
	
	aludec ad(functD, aluopD, alucontrolD);
	
	branch_control _bc (srca2D, srcb2D, branchD, pcsrcD);
	
	
	
	// pipeline registers
	reg_rc #(12) regE
	(
		clk, reset, flushE,
		{memtoregD, memwriteD, memdataD, memsrcD, alusrcD, scalarD, regdstD, regwriteD, VregwriteD, alucontrolD},
		{memtoregE, memwriteE, memdataE, memsrcE, alusrcE, scalarE, regdstE, regwriteE, VregwriteE, alucontrolE}
	);
	reg_r #(6) regM (clk, reset, 
		{memtoregE, memwriteE, memdataE, memsrcE, regwriteE, VregwriteE}, 
		{memtoregM, memwriteM, memdataM, memsrcM, regwriteM, VregwriteM});
	reg_r #(3) regW (clk, reset, 
		{memtoregM, regwriteM, VregwriteM}, 
		{memtoregW, regwriteW, VregwriteW});
	
endmodule
