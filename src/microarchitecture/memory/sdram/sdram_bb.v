
module sdram (
	clk_clk,
	reset_reset,
	sdr_slave_address,
	sdr_slave_byteenable_n,
	sdr_slave_chipselect,
	sdr_slave_writedata,
	sdr_slave_read_n,
	sdr_slave_write_n,
	sdr_slave_readdata,
	sdr_slave_readdatavalid,
	sdr_slave_waitrequest,
	sdr_wire_addr,
	sdr_wire_ba,
	sdr_wire_cas_n,
	sdr_wire_cke,
	sdr_wire_cs_n,
	sdr_wire_dq,
	sdr_wire_dqm,
	sdr_wire_ras_n,
	sdr_wire_we_n,
	sdr_clk_clk);	

	input		clk_clk;
	input		reset_reset;
	input	[24:0]	sdr_slave_address;
	input	[1:0]	sdr_slave_byteenable_n;
	input		sdr_slave_chipselect;
	input	[15:0]	sdr_slave_writedata;
	input		sdr_slave_read_n;
	input		sdr_slave_write_n;
	output	[15:0]	sdr_slave_readdata;
	output		sdr_slave_readdatavalid;
	output		sdr_slave_waitrequest;
	output	[12:0]	sdr_wire_addr;
	output	[1:0]	sdr_wire_ba;
	output		sdr_wire_cas_n;
	output		sdr_wire_cke;
	output		sdr_wire_cs_n;
	inout	[15:0]	sdr_wire_dq;
	output	[1:0]	sdr_wire_dqm;
	output		sdr_wire_ras_n;
	output		sdr_wire_we_n;
	output		sdr_clk_clk;
endmodule
