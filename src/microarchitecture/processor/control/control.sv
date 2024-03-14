// Processor's Controller

module control
(
	input logic clk, reset,
	input logic [5:0] opD, functD,
	input logic flushE, equalD,
	output logic memtoregE, memtoregM,
	output logic memtoregW, memwriteM,
	output logic pcsrcD, branchD, alusrcE,
	output logic regdstE, regwriteE,
	output logic regwriteM, regwriteW,
	output logic jumpD,
	output logic [2:0] alucontrolE
);


	logic [1:0] aluopD;
	logic memtoregD, memwriteD, alusrcD,
			regdstD, regwriteD;
	logic [2:0] alucontrolD;
	logic memwriteE;
	
	maindec md
	(
		opD, memtoregD, memwriteD, branchD,
		alusrcD, regdstD, regwriteD, jumpD,
		aluopD
	);
	
	aludec ad(functD, aluopD, alucontrolD);
	
	assign pcsrcD = branchD & equalD;
	
	// pipeline registers
	reg_rc #(8) regE
	(
		clk, reset, flushE,
		{memtoregD, memwriteD, alusrcD, regdstD, regwriteD, alucontrolD},
		{memtoregE, memwriteE, alusrcE, regdstE, regwriteE, alucontrolE}
	);
	reg_r #(3) regM (clk, reset, {memtoregE, memwriteE, regwriteE}, {memtoregM, memwriteM, regwriteM});
	reg_r #(2) regW (clk, reset, {memtoregM, regwriteM}, {memtoregW, regwriteW});
	
endmodule
