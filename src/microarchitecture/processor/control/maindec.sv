
module maindec
(
	input logic [5:0] op,
	output logic memtoReg, VmemtoReg, memWrite, memData, memSrc,
	output logic ALUSrc,
	output logic regDst, regWrite, VregWrite,
	output logic jump,
	output logic [1:0] branch
);

	logic [11:0] controls;
	assign {regWrite, VregWrite, memtoReg, VmemtoReg, memWrite, memData, memSrc, ALUSrc, regDst, branch, jump} = controls;
	
	always_comb
		case(op)
			6'b000000: controls = 12'b100x_0xx_01_00_0; // add, sub
			6'b010000: controls = 12'b100x_0xx_10_00_0; // addi
			6'b000100: controls = 12'b01x0_0xx_01_00_0; // add.fp, mul.fp
			6'b001100: controls = 12'b01x1_0xx_01_00_0; // vadd.fp, vmul.fp, vsum.fp
			6'b010001: controls = 12'b000x_1xx_10_00_0; // sw
			6'b010010: controls = 12'b101x_0xx_10_00_0; // lw
			6'b010101: controls = 12'b00x0_1xx_10_00_0; // sw.fp
			6'b010110: controls = 12'b01x1_0xx_10_00_0; // lw.fp
			6'b011101: controls = 12'b00x0_1xx_10_00_0; // vst
			6'b011110: controls = 12'b01x1_0xx_10_00_0; // vld
			6'b100000: controls = 12'b00xx_0xx_00_01_0; // beq
			6'b100000: controls = 12'b00xx_0xx_00_10_0; // blt
			6'b100010: controls = 12'b00xx_0xx_00_00_1; // j
			6'b111111: controls = 12'b01x0_0xx_10_00_0; // vset.fp
			  default: controls = 12'b00xx_0xx_xx_00_0; //???
			  
		endcase
	
endmodule
