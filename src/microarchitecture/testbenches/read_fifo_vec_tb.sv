`timescale 1 ps / 1 ps

module read_fifo_vec_tb();
	
	logic aclr;
	logic	[15:0] data;

	logic	rdclk;
	logic	rdreq;
	logic	wrclk;
	logic	wrreq;
	logic	[255:0] q;
	logic	rdempty;
	logic	wrfull;
	
	
	read_fifo_vec rfv
	(
		aclr,
		data,
		rdclk,
		rdreq,
		wrclk,
		wrreq,
		q,
		rdempty,
		wrfull
	);
	
	assign aclr = 1'b0;
	
	
	// reading side
	assign rdreq = ~rdempty;
	
	// writing side
	initial
	begin
		data <= 16'd0;
		wrreq <= 0;
		
		for(int i = 0; i<16; i++)
		begin
			data = data + 16'd1;
			
			wait (wrclk == 1)
				wait (wrfull == 0)	
					wrreq <= 1;
			
			wait (wrclk == 0)
			# 2;
			
			wait (wrclk == 1) 
				if (wrfull == 1)
					wrreq <= 0;
		end
		
		# 40;
		wrreq <= 0;
		
		for(int i = 0; i<16; i++)
		begin
			data = data + 16'd1;
			
			wait (wrclk == 1)
				wait (wrfull == 0)	
					wrreq <= 1;
			
			wait (wrclk == 0)
			# 2;
			
			wait (wrclk == 1) 
				if (wrfull == 1)
					wrreq <= 0;
		end
		
		
	end
	
	
	// write clock
	always
	begin
		wrclk <= 0; # 10; wrclk <= 1; # 10;
	end
	
	
	// read clock
	always
	begin
		rdclk <= 0; # 5; rdclk <= 1; # 5;
	end
	
endmodule
