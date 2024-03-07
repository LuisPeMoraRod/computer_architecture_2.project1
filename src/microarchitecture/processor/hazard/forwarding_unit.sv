
module forwarding_unit
(
	input logic regfile_en_MEM, regfile_en_WB,
	input logic [4:0] write_addr_MEM, write_addr_WB, rs_EX, rt_EX,
	output logic [1:0] forward_A, forward_B
);
	/*
	always_comb begin
		if (Match_1E_M & RegWriteM) ForwardAE = 2'b10;
		else if (Match_1E_W & RegWriteW) ForwardAE = 2'b01;
		else ForwardAE = 2'b00;
		
		if (Match_2E_M & RegWriteM) ForwardBE = 2'b10;
		else if (Match_2E_W & RegWriteW) ForwardBE = 2'b01;
		else ForwardBE = 2'b00;
	end
	*/
	
endmodule
