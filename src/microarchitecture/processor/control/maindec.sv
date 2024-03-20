
module maindec
(
	input logic [5:0] op,
	output logic memtoreg, memwrite,
	output logic alusrc,
	output logic regdst, regwrite,
	output logic jump,
	output logic [1:0] aluop, branch
);

	logic [9:0] controls;
	assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = controls;
	
	always_comb
		case(op)
			6'b000000: controls = 10'b110_00_000_10; //Rtyp
			6'b100011: controls = 10'b101_00_010_00; //LW
			6'b101011: controls = 10'b001_00_100_00; //SW
			6'b000100: controls = 10'b000_01_000_00; //BEQ
			6'b000101: controls = 10'b000_10_000_00; //BLT
			6'b001000: controls = 10'b101_00_000_00; //ADDI
			6'b000010: controls = 10'b000_00_001_00; //J
			default: controls = 10'bxxxxxxxxxx; //???
		endcase
	
endmodule
