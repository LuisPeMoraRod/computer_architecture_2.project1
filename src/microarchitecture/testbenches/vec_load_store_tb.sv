
`timescale 1 ps / 1 ps

module vec_load_store_tb();
	
	logic	clk, reset;
	
	logic [15:0] 		result;
	logic [31:0] 		address;
	logic 				memWriteM, memtoRegW, memSrcM;
	logic [15:0] 		data_in;
	logic [15:0] 		data_in_vec [16];
	logic [15:0] 		data_out;
	logic [15:0] 		data_out_vec [16];
	logic 				busy;
	logic				data_ready;
	logic [3:0] 		debug;
	
	logic button;
	
	
	logic [24:0] sdr_slave_address;      
	logic [1:0]  sdr_slave_byteenable_n;
	logic        sdr_slave_chipselect;   
	logic [15:0] sdr_slave_writedata;    
	logic        sdr_slave_read_n;       
	logic        sdr_slave_write_n;      
	logic [15:0] sdr_slave_readdata;     
	logic        sdr_slave_readdatavalid;
	logic        sdr_slave_waitrequest;  
	
	
	logic [15:0] mem [64];
	
	int delay;
	
	
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
		busy,
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
		busy,
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
	
	
	// writing side
	initial
	begin
		reset <= 1'b1;
		# 40;
		reset <= 1'b0;
		button <= 1'b1;
		
		
		# 50;
		
		button <= 1'b0;
		# 12;
		button <= 1'b1;
		
		# 1100;
		
		button <= 1'b0;
		# 12;
		button <= 1'b1;

		# 100;
		
		button <= 1'b0;
		# 12;
		button <= 1'b1;

		# 1100;
		
		button <= 1'b0;
		# 12;
		button <= 1'b1;

		# 100;
		
		button <= 1'b0;
		# 12;
		button <= 1'b1;
		
	end
	
	
	// sdram slave logic
	always_ff @ (posedge clk)
	begin
		
		if (sdr_slave_chipselect & ~sdr_slave_write_n)  // write logic
		begin
			delay <= delay + 1;
			sdr_slave_readdatavalid <= 1'b0;
			
			if (delay < 1) 
				sdr_slave_waitrequest <= 1'b1;
			else begin
				sdr_slave_waitrequest <= 1'b0;
				mem[sdr_slave_address] <= sdr_slave_writedata;
			end
			
		end
		
		else if (sdr_slave_chipselect & ~sdr_slave_read_n)  // read logic
		begin
			delay <= delay + 1;
			
			if (delay < 1) 
				sdr_slave_waitrequest <= 1'b1;
			else begin
				sdr_slave_waitrequest <= 1'b0;
			end
			
			if (delay < 2) 
				sdr_slave_readdatavalid <= 1'b0;
			else begin
				sdr_slave_readdatavalid <= 1'b1;
				sdr_slave_readdata <= mem[sdr_slave_address];
			end
				
		end
		
		else begin
			delay <= 0;
			sdr_slave_waitrequest <= 1'b1;
			sdr_slave_readdatavalid <= 1'b0;
			sdr_slave_readdata <= 16'd0;
		end
		
	end
	
	// clock
	always
	begin
		clk <= 0; # 5; clk <= 1; # 5;
	end
	
	
endmodule
