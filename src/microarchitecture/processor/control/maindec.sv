
module maindec
(
	input logic [5:0] op,
	output logic regWrite, VregWrite,
	output logic memtoReg, VmemtoReg, memWrite, memData, memSrc,
	output logic ALUSrc, scalar, regDst, 
	output logic [1:0] branch, 
	output logic jump,
	output logic [1:0] aluop
);

	logic [13:0] controls;
	assign {regWrite, VregWrite,   memtoReg, memWrite, memData, memSrc,   ALUSrc, scalar, regDst,   branch, jump, aluop} = controls;
	
	always_comb
		case(op)
			6'b000000: controls = 14'b_10_0000_001_00_0_10; // add, sub
			6'b010000: controls = 14'b_10_0000_100_00_0_00; // addi
			6'b000100: controls = 14'b_01_0000_011_00_0_10; // add.fp, mul.fp
			6'b001100: controls = 14'b_01_0000_001_00_0_10; // vadd.fp, vmul.fp, vsum.fp
			6'b010001: controls = 14'b_00_0100_100_00_0_00; // sw
			6'b010010: controls = 14'b_10_1000_100_00_0_00; // lw
			6'b010101: controls = 14'b_00_0110_100_00_0_00; // sw.fp
			6'b010110: controls = 14'b_01_1010_100_00_0_00; // lw.fp
			6'b011101: controls = 14'b_00_0101_100_00_0_00; // vst
			6'b011110: controls = 14'b_01_1001_100_00_0_00; // vld
			6'b100000: controls = 14'b_00_0000_000_01_0_00; // beq
			6'b100000: controls = 14'b_00_0000_000_10_0_00; // blt
			6'b100010: controls = 14'b_00_0000_000_00_1_00; // j
			6'b111111: controls = 14'b_01_0000_100_00_0_10; // vset.fp
			6'b110010: controls = 14'b_00_0000_000_00_0_00; // start
			6'b110001: controls = 14'b_00_0000_000_00_0_00; // close
			  default: controls = 14'b_00_0000_000_00_0_00; // ???
			  
		endcase
	
endmodule
