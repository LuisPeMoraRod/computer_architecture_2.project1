

// Write Back Forwarding for when the register file is being written and read at the same time

module WB_forward  #(parameter N = 32)
(
	input logic [31:0] read_data_1, read_data_2, write_data,
	input logic [4:0] rs_ID, rt_ID, write_addr,
	input logic regfile_write_en,
	output logic [31:0] read_data_1_ID, read_data_2_ID
);
		
		logic source_rs, source_rt;
		
		always_comb
		begin
			if ((regfile_write_en == 1) && (write_addr != 0) && (write_addr == rs_ID))
				source_rs = 1'b1;
			else 
				source_rs = 1'b0;
				
			if ((regfile_write_en == 1) && (write_addr != 0) && (write_addr == rt_ID))
				source_rt = 1'b1;
			else 
				source_rt = 1'b0;
		end
		

		mux2 #(N) mux_read_data_1(read_data_1, write_data, source_rs, read_data_1_ID);
		mux2 #(N) mux_read_data_2(read_data_2, write_data, source_rt, read_data_2_ID);
		
endmodule
