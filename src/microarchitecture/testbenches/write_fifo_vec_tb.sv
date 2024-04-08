`timescale 1 ps / 1 ps

module write_fifo_vec_tb();
	
	logic aclr;
	logic	[255:0] data;
	logic	rdclk;
	logic	rdreq;
	logic	wrclk;
	logic	wrreq;
	logic	[15:0] q;
	logic	rdempty;
	logic	wrfull;
	
	
	write_fifo_vec wfv
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
		data <= 256'h1234_5678_90AB_CDEF_1234_5678_90AB_CDEF_1234_5678_90AB_CDEF_1234_5678_90AB_CDEF;
		wrreq <= 0;
		
		wait (wrfull == 0)
			wait (wrclk == 1)
				wrreq <= 1;
		
		
		wait (wrclk == 0)
			# 2;
		
		wait (wrclk == 1) 
		begin
			data = 256'h9876_5432_10FE_DCBA_9876_5432_10FE_DCBA_9876_5432_10FE_DCBA_9876_5432_10FE_DCBA;
			if (wrfull == 1)
			begin
				wrreq <= 0;
				wait (wrfull == 0)
					wrreq <= 1;
			end
			else
				wrreq <= 1;
		end
		
		wait (wrclk == 0)
			# 2;
		
		wait (wrclk == 1)
			wrreq <= 0;
		
		# 500
		
		wait (wrclk == 1) 
		begin
			data = 256'hAAAA_5432_10FE_DCBA_9876_5432_10FE_DCBA_9876_5432_10FE_DCBA_9876_5432_10FE_FFFF;
			if (wrfull == 1)
			begin
				wrreq <= 0;
				wait (wrfull == 0)
					wrreq <= 1;
			end
			else
				wrreq <= 1;
		end
		
		wait (wrclk == 0)
			# 2;
		
		wait (wrclk == 1)
			wrreq <= 0;
		
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
