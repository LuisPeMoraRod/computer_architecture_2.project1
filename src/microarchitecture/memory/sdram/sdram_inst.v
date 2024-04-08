	sdram u0 (
		.clk_clk                 (<connected-to-clk_clk>),                 //       clk.clk
		.reset_reset             (<connected-to-reset_reset>),             //     reset.reset
		.sdr_slave_address       (<connected-to-sdr_slave_address>),       // sdr_slave.address
		.sdr_slave_byteenable_n  (<connected-to-sdr_slave_byteenable_n>),  //          .byteenable_n
		.sdr_slave_chipselect    (<connected-to-sdr_slave_chipselect>),    //          .chipselect
		.sdr_slave_writedata     (<connected-to-sdr_slave_writedata>),     //          .writedata
		.sdr_slave_read_n        (<connected-to-sdr_slave_read_n>),        //          .read_n
		.sdr_slave_write_n       (<connected-to-sdr_slave_write_n>),       //          .write_n
		.sdr_slave_readdata      (<connected-to-sdr_slave_readdata>),      //          .readdata
		.sdr_slave_readdatavalid (<connected-to-sdr_slave_readdatavalid>), //          .readdatavalid
		.sdr_slave_waitrequest   (<connected-to-sdr_slave_waitrequest>),   //          .waitrequest
		.sdr_wire_addr           (<connected-to-sdr_wire_addr>),           //  sdr_wire.addr
		.sdr_wire_ba             (<connected-to-sdr_wire_ba>),             //          .ba
		.sdr_wire_cas_n          (<connected-to-sdr_wire_cas_n>),          //          .cas_n
		.sdr_wire_cke            (<connected-to-sdr_wire_cke>),            //          .cke
		.sdr_wire_cs_n           (<connected-to-sdr_wire_cs_n>),           //          .cs_n
		.sdr_wire_dq             (<connected-to-sdr_wire_dq>),             //          .dq
		.sdr_wire_dqm            (<connected-to-sdr_wire_dqm>),            //          .dqm
		.sdr_wire_ras_n          (<connected-to-sdr_wire_ras_n>),          //          .ras_n
		.sdr_wire_we_n           (<connected-to-sdr_wire_we_n>),           //          .we_n
		.sdr_clk_clk             (<connected-to-sdr_clk_clk>)              //   sdr_clk.clk
	);

