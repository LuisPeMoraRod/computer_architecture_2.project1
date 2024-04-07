
module aludec
(
	input logic [5:0] funct,
	input logic [1:0] aluop,
	output logic [2:0] alucontrol
);

	always_comb
		case(aluop)
			2'b00: alucontrol = 3'b010; // addi
			2'b01: alucontrol = 3'b111; // vset
			default: case(funct) // RTYPE
							6'b000000: alucontrol = 3'b010; // add
							6'b000001: alucontrol = 3'b110; // sub
							6'b000100: alucontrol = 3'b010; // add.fp
							6'b000110: alucontrol = 3'b000; // mul.fp
							6'b100100: alucontrol = 3'b010; // vadd.fp
							6'b100110: alucontrol = 3'b000; // vmul.fp
							6'b110000: alucontrol = 3'b011; // vsum.fp
							
							default: alucontrol = 3'bxxx; // ???
						endcase
		endcase

endmodule
