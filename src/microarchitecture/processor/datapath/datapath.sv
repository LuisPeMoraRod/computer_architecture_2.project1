// Processor's Datapath

module datapath
(
	input logic clk, reset,
	input logic memtoregE, memdataM, memsrcM, memtoregM, memtoregW,
	input logic pcsrcD, 
	input logic [1:0] branchD,
	input logic alusrcE, regdstE, scalarE,
	input logic regwriteE, regwriteM, regwriteW, VregwriteW,
	input logic jumpD,
	input logic [2:0] alucontrolE,
	output logic [31:0] pcF,
	input logic [31:0] instrF,
	output logic [31:0] aluoutM,
	output logic [31:0] writedataM,
	input logic [31:0] readdataM,
	output logic [5:0] opD, functD,
	output logic flushE,
	output logic [31:0] srca2D, srcb2D,
	output logic [255:0] ValuoutM,
	input logic [255:0] Vmemout
);


	logic forwardaD, forwardbD;
	logic [1:0] forwardaE, forwardbE;
	logic stallF, stallD;
	logic [4:0] rsD, rtD, rdD, rsE, rtE, rdE;
	logic [4:0] writeregE, writeregM, writeregW;
	logic flushD;
	logic [31:0] pcnextFD, pcnextbrFD, pcplus4F, pcbranchD;
	logic [31:0] signimmD, signimmE, signimmshD;
	logic [31:0] srcaD, srcaE, srca2E;
	logic [31:0] srcbD, srcbE, srcb2E, srcb3E;
	logic [15:0] srcmem;
	logic [31:0] pcplus4D, instrD;
	logic [31:0] aluoutE, aluoutW;
	logic [31:0] readdataW, resultW;
	logic [3:0] flags;
	logic [255:0] VsrcaD, VsrcaE, Vsrca2E;
	logic [255:0] VsrcbD, VsrcbE, Vsrcb2E;
	logic [255:0] VresultW, ValuoutE, extVector, ValuoutW, VreadDataM, VreadDataW;
	logic [1:0] VforwardaE, VforwardbE;
	logic [63:0] Vflags;
	
	
	// hazard detection
	hazard h
	(
		rsD, rtD, rsE, rtE, writeregE, writeregM,
		writeregW,regwriteE, regwriteM, regwriteW,
		memtoregE, memtoregM, branchD,
		forwardaD, forwardbD, forwardaE,
		forwardbE,
		stallF, stallD, flushE
	);
	
	// next PC logic
	mux2 #(32) pcbrmux (pcplus4F, pcbranchD, pcsrcD, pcnextbrFD);
	mux2 #(32) pcmux (pcnextbrFD,{pcplus4D[31:28], instrD[25:0], 2'b00}, jumpD, pcnextFD);
	
	
	// register file
	regfile rf(clk, reset, regwriteW, rsD, rtD, writeregW, resultW, srcaD, srcbD);
	
	// Vector register file 
	regfile_vec rf_v(clk, reset, VregwriteW, rsD, rtD, writeregW, VresultW, VsrcaD, VsrcbD);
	
	
	// Fetch stage
	reg_ren #(32) pcreg(clk, reset, ~stallF, pcnextFD, pcF);
	adder #(32) pcadd1(pcF, 32'b100, pcplus4F);

	
	// Decode stage
	reg_ren #(32) r1D(clk, reset, ~stallD, pcplus4F, pcplus4D);
	reg_rcen #(32) r2D(clk, reset, ~stallD, flushD, instrF, instrD);
	
	signext se(instrD[15:0], signimmD);
	sl2 immsh(signimmD, signimmshD);
	
	adder pcadd2(pcplus4D, signimmshD, pcbranchD);
	mux2 #(32) forwardadmux(srcaD, aluoutM, forwardaD, srca2D);
	mux2 #(32) forwardbdmux(srcbD, aluoutM, forwardbD, srcb2D);
	
	assign opD = instrD[31:26];
	assign functD = instrD[5:0];
	assign rsD = instrD[25:21];
	assign rtD = instrD[20:16];
	assign rdD = instrD[15:11];
	assign flushD = (pcsrcD | jumpD) & ~stallD;
	
	
	// Execute stage
	reg_rc #(32) r1E (clk, reset, flushE, srcaD, srcaE);
	reg_rc #(32) r2E (clk, reset, flushE, srcbD, srcbE);
	reg_rc #(32) r3E (clk, reset, flushE, signimmD, signimmE);
	reg_rc #(5) r4E (clk, reset, flushE, rsD, rsE);
	reg_rc #(5) r5E (clk, reset, flushE, rtD, rtE);
	reg_rc #(5) r6E (clk, reset, flushE, rdD, rdE);
	reg_rc #(256) r7E (clk, reset, flushE, VsrcaD, VsrcaE);
	reg_rc #(256) r8E (clk, reset, flushE, VsrcbD, VsrcbE);
	
	
	mux3 #(32) forwardaemux (srcaE, resultW, aluoutM, forwardaE, srca2E);
	mux3 #(32) forwardbemux (srcbE, resultW, aluoutM, forwardbE, srcb2E);
	mux2 #(32) srcbmux (srcb2E, signimmE, alusrcE, srcb3E);
	
	ALU alu(srca2E, srcb3E, alucontrolE, aluoutE, flags);
	mux2 #(5) wrmux (rtE, rdE, regdstE, writeregE);
	
	
	mux3 #(256) Vforwardaemux (VsrcaE, VresultW, ValuoutM, VforwardaE, Vsrca2E);
	mux3 #(256) Vforwardbemux (VsrcbE, VresultW, ValuoutM, VforwardbE, Vsrcb2E);
	
	ALU_vec alu_vec(Vsrca2E, Vsrcb2E, alucontrolE, scalarE, ValuoutE, Vflags);
	
	
	// Memory stage
	reg_r #(32) r1M(clk, reset, srcb2E, writedataM);
	reg_r #(32) r2M(clk, reset, aluoutE, aluoutM);
	reg_r #(5) r3M(clk, reset, writeregE, writeregM);
	reg_r #(256) r4M(clk, reset, ValuoutE, ValuoutM);
	
	mux2 #(16) memDatamux (writedataM[15:0], ValuoutM[15:0], memdataM, srcmem);
	mux2 #(256) memSrcmux (extVector, Vmemout, memsrcM, VreadDataM);
	
	// Writeback stage
	reg_r #(32) r1W (clk, reset, aluoutM, aluoutW);
	reg_r #(32) r2W (clk, reset, readdataM, readdataW);
	reg_r #(5) r3W (clk, reset, writeregM, writeregW);
	reg_r #(256) r4W (clk, reset, ValuoutM, ValuoutW);
	reg_r #(256) r5W (clk, reset, VreadDataM, VreadDataW);
	
	mux2 #(32) resmux (aluoutW, readdataW, memtoregW, resultW);
	mux2 #(256) regWmux (ValuoutW, VreadDataW, memtoregW, VresultW);
	
endmodule
