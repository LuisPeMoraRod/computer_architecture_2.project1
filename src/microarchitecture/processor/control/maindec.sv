
module maindec
(
	input logic [5:0] op,
	output logic memtoreg, memwrite,
	output logic branch, alusrc,
	output logic regdst, regwrite,
	output logic jump,
	output logic [1:0] aluop
);

	logic [9:0] controls;
	assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = controls;
	
	always_comb
		case(op)
			6'b000000: controls <= 9'b1100_000_10; //Rtyp
			6'b100011: controls <= 9'b1010_010_00; //LW
			6'b101011: controls <= 9'b0010_100_00; //SW
			6'b000100: controls <= 9'b0001_000_01; //BEQ
			6'b001000: controls <= 9'b1010_000_00; //ADDI
			6'b000010: controls <= 9'b0000_001_00; //J
			default: controls <= 9'bxxxxxxxxx; //???
		endcase
	
endmodule
