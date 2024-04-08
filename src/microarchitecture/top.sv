
// Top level module

module top
(
	input logic clk, reset,
	input logic button,
	
	output logic        sdr_clk_clk,             //   sdr_clk.clk
	output logic [12:0] sdr_wire_addr,           //  sdr_wire.addr
	output logic [1:0]  sdr_wire_ba,             //          .ba
	output logic        sdr_wire_cas_n,          //          .cas_n
	output logic        sdr_wire_cke,            //          .cke
	output logic        sdr_wire_cs_n,           //          .cs_n
	inout  wire  [15:0] sdr_wire_dq,             //          .dq
	output logic [1:0]  sdr_wire_dqm,            //          .dqm
	output logic        sdr_wire_ras_n,          //          .ras_n
	output logic        sdr_wire_we_n,           //          .we_n
	
	output [6:0] s0, s1, s2, s3, s4
);
	
	/*
	logic [31:0] writedata, dataadr;
	logic memwrite;
	logic [31:0] pcF, instr, readdata;
	logic src_sel;
	logic [255:0] w_data_b;
	logic [15:0] q_a;
	logic [255:0] q_b;
	

	simd_processor processor (clk, reset, pcF, instr, memwrite, src_sel, dataadr, writedata, readdata, w_data_b, q_b);

	
	imem imem (pcF[7:2], instr);
	
	
	
	logic	[15:0] rd_data;
	logic	rd_rdreq;
	logic	rd_wrreq;
	logic	[255:0] rd_q;
	logic	rd_rdempty;
	logic	rd_wrfull;
	
	
	read_fifo_vec wfv
	(
		.aclr		(reset),
		.data		(rd_data),
		.rdclk	(clk),
		.rdreq	(rd_rdreq),
		.wrclk	(clk),
		.wrreq	(rd_wrreq),
		.q			(rd_q),
		.rdempty	(rd_rdempty),
		.wrfull	(rd_wrfull)
	);
	
	logic	[255:0] wr_data;
	logic	wr_rdreq;
	logic	wr_wrreq;
	logic	[15:0] wr_q;
	logic	wr_rdempty;
	logic	wr_wrfull;
	
	
	write_fifo_vec wfv
	(
		.aclr		(reset),
		.data		(wr_data),
		.rdclk	(clk),
		.rdreq	(wr_rdreq),
		.wrclk	(clk),
		.wrreq	(wr_wrreq),
		.q			(wr_q),
		.rdempty	(wr_rdempty),
		.wrfull	(wr_wrfull)
	);
	*/
	
	logic [24:0] sdr_slave_address;       // sdr_slave.address
	logic [1:0]  sdr_slave_byteenable_n;  //          .byteenable_n
	logic        sdr_slave_chipselect;    //          .chipselect
	logic [15:0] sdr_slave_writedata;     //          .writedata
	logic        sdr_slave_read_n;        //          .read_n
	logic        sdr_slave_write_n;       //          .write_n
	logic [15:0] sdr_slave_readdata;      //          .readdata
	logic        sdr_slave_readdatavalid; //          .readdatavalid
	logic        sdr_slave_waitrequest;   //          .waitrequest
	
	
	logic [15:0] result;
	
	
	logic [31:0] 		address;
	logic 				memWriteM, memtoRegW, memSrcM;
	logic [15:0] 		data_in;
	logic [15:0] 		data_in_vec [16];
	logic [15:0] 		data_out;
	logic [15:0] 		data_out_vec [16];
	logic 				write_done;
	logic 				data_ready;
	logic [3:0] 		debug;
	
	
	

	logic	[4:0]			buff_address;
	logic	[255:0]		buff_data;
	logic	  				buff_wren;
	logic	[255:0]		buff_q;
	
	
	file_buffer asd
	(
		buff_address,
		clk,
		buff_data,
		buff_wren,
		buff_q
	);
	
	
	sdram sdr 
	(
		clk,                 	 //       clk.clk
		reset,             		 //     reset.reset
		sdr_clk_clk,             //   sdr_clk.clk
		sdr_slave_address,       // sdr_slave.address
		sdr_slave_byteenable_n,  //          .byteenable_n
		sdr_slave_chipselect,    //          .chipselect
		sdr_slave_writedata,     //          .writedata
		sdr_slave_read_n,        //          .read_n
		sdr_slave_write_n,       //          .write_n
		sdr_slave_readdata,      //          .readdata
		sdr_slave_readdatavalid, //          .readdatavalid
		sdr_slave_waitrequest,   //          .waitrequest
		sdr_wire_addr,           //  sdr_wire.addr
		sdr_wire_ba,             //          .ba
		sdr_wire_cas_n,          //          .cas_n
		sdr_wire_cke,            //          .cke
		sdr_wire_cs_n,           //          .cs_n
		sdr_wire_dq,             //          .dq
		sdr_wire_dqm,            //          .dqm
		sdr_wire_ras_n,          //          .ras_n
		sdr_wire_we_n            //          .we_n
	);
	
	
	

	
	sdram_test sr_test
	(
		clk, reset,
		button,
		result,
		debug,
		
		
		address,
		memWriteM, memtoRegW, memSrcM,
		data_in,
		data_in_vec,
		data_out,
		data_out_vec,
		write_done,
		data_ready
	);
	

	
	vec_load_store vls
	(
		clk, reset,
		address,
		memWriteM, memtoRegW, memSrcM,
		data_in,
		data_in_vec,
		data_out,
		data_out_vec,
		write_done,
		data_ready,
		sdr_slave_address,
		sdr_slave_byteenable_n,
		sdr_slave_chipselect,
		sdr_slave_writedata,
		sdr_slave_read_n,
		sdr_slave_write_n,
		sdr_slave_readdata,
		sdr_slave_readdatavalid,
		sdr_slave_waitrequest
	);
	
	
	
	display7 d1(result[3:0], s0);
	display7 d2(result[7:4], s1);
	display7 d3(result[11:8], s2);
	display7 d4(result[15:12], s3);
	display7 d5(debug, s4);
	
	
	assign buff_address = 5'd0;
	
	assign buff_data[15:0] = data_out_vec [0];
	assign buff_data[31:16] = data_out_vec [1];
	assign buff_data[47:32] = data_out_vec [2];
	assign buff_data[63:48] = data_out_vec [3];
	assign buff_data[79:64] = data_out_vec [4];
	assign buff_data[95:80] = data_out_vec [5];
	assign buff_data[111:96] = data_out_vec [6]; 
	assign buff_data[127:112] = data_out_vec [7];
	assign buff_data[143:128] = data_out_vec [8];
	assign buff_data[159:144] = data_out_vec [9];
	assign buff_data[175:160] = data_out_vec [10];
	assign buff_data[191:176] = data_out_vec [11];
	assign buff_data[207:192] = data_out_vec [12];
	assign buff_data[223:208] = data_out_vec [13];
	assign buff_data[239:224] = data_out_vec [14];
	assign buff_data[255:240] = data_out_vec [15];
	
	assign buff_wren = data_ready;

	

	
endmodule
