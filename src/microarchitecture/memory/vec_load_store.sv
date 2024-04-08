
module vec_load_store
(
	input  logic 				clk, reset,
	input  logic [31:0] 		address,
	input  logic 				memWriteM, memtoRegW, memSrcM,
	input  logic [15:0] 		data_in,
	input  logic [15:0] 		data_in_vec [16],
	output logic [15:0] 		data_out,
	output logic [15:0] 		data_out_vec [16],
	output logic 				write_done,
	output logic 				data_ready,
	
	// sdram signals
	output logic [24:0] 		sdr_slave_address,
	output logic [1:0]  		sdr_slave_byteenable_n,
	output logic        		sdr_slave_chipselect,
	output logic [15:0] 		sdr_slave_writedata,
	output logic        		sdr_slave_read_n,
	output logic        		sdr_slave_write_n,
	input  logic [15:0]			sdr_slave_readdata,
	input  logic        		sdr_slave_readdatavalid,
	input  logic        		sdr_slave_waitrequest
);
	
	typedef enum logic [3:0]
	{
		IDLE = 4'b0000,
		WRITE = 4'b0001,
		WAIT_WRITE = 4'b0010,
		LOOP_WRITE = 4'b0011,
		DONE_WRITE = 4'b0100,
		READ = 4'b0101,
		DATA_VALID = 4'b0110,
		LOOP_READ = 4'b0111,
		OUTPUT_READY = 4'b1000
	} state_t;

	state_t state, next_state;
	
	logic [15:0] reg_data_in;
	logic [15:0] reg_data_in_vec [16];
	logic reg_memSrcM;
	logic reg_memtoRegW;
	logic reg_memWriteM;
	logic [24:0] reg_address, next_address, count, next_count;
	

	// current state logic
	always_ff @ (posedge clk) 
	begin
		if (reset) begin

			reg_data_in <= 16'd0;
			reg_data_in_vec <= '{ 16{16'd0} };

			data_out <= 16'd0;
			data_out_vec <= '{ 16{16'd0} };

			reg_memtoRegW <= 1'b0;
			reg_memWriteM <= 1'b0;
			reg_memSrcM <= 1'b0;

			state <= IDLE;
		end
		else begin
			reg_address <= (state == IDLE) ? address[24:0] : next_address;
			
			reg_data_in <= (state == IDLE) ? data_in : reg_data_in;
			reg_data_in_vec <= (state == IDLE) ? data_in_vec : reg_data_in_vec;

			data_out <= (state == DATA_VALID) ? sdr_slave_readdata : data_out;
			data_out_vec[count] <= (state == DATA_VALID) ? sdr_slave_readdata : data_out_vec[count];

			reg_memSrcM <= (state == IDLE) ? memSrcM : reg_memSrcM;
			reg_memtoRegW <= (state == IDLE) ? memtoRegW : reg_memtoRegW;
			reg_memWriteM <= (state == IDLE) ? memWriteM : reg_memWriteM;
			
			count <= (state == IDLE) ? 25'd0 : next_count;

			state <= next_state;
		end
	end
	
	
	// next stage logic
	always_comb 
	begin
	
		case (state)
				
			IDLE:
			begin
				if (memWriteM) next_state = WRITE;
				else if (memtoRegW) next_state = READ;
				else next_state = IDLE;
			end
			

			WRITE:
			begin
				if (sdr_slave_waitrequest) next_state = WRITE;
				else next_state = WAIT_WRITE;
			end

			WAIT_WRITE:
			begin
				if (reg_memSrcM) next_state = LOOP_WRITE;
				else next_state = DONE_WRITE;
			end

			LOOP_WRITE: 
			begin
				if (count < 25'd15) next_state = WRITE;
				else next_state = DONE_WRITE;
			end
			
			DONE_WRITE:
			begin
				next_state = IDLE;
			end


			READ:
			begin
				if (sdr_slave_waitrequest) next_state = READ;
				else next_state = DATA_VALID;
			end

			DATA_VALID: 
			begin
				if (~sdr_slave_readdatavalid) next_state = DATA_VALID;
				else if (reg_memSrcM) next_state = LOOP_READ;
				else next_state = OUTPUT_READY;
			end

			LOOP_READ:
			begin
				if (count < 25'd15) next_state = READ;
				else next_state = OUTPUT_READY;
			end
			

			OUTPUT_READY:
			begin
				next_state = IDLE;
			end


			default: 
			begin
				next_state = IDLE;
			end
				
		endcase
		
	end

	// address and counter logic
	always_comb
	begin
		if (state == LOOP_WRITE || state == LOOP_READ) begin
			next_count = count + 25'd1;
			next_address = reg_address + 25'd1;
		end
		else begin 
			next_count = count;
			next_address = reg_address;
		end
	end

	assign sdr_slave_byteenable_n = 2'b00;
	assign sdr_slave_address = reg_address;
	assign sdr_slave_chipselect = ~sdr_slave_write_n | ~sdr_slave_read_n;
	assign sdr_slave_writedata = (reg_memSrcM) ? reg_data_in_vec[count] : reg_data_in;
	assign sdr_slave_write_n = (state == WRITE || state == WAIT_WRITE) ? 1'b0 : 1'b1;
	assign sdr_slave_read_n = (state == READ) ? 1'b0 : 1'b1;
	
	assign write_done = (state == DONE_WRITE) ? 1'b1 : 1'b0;
	assign data_ready = (state == OUTPUT_READY) ? 1'b1 : 1'b0;

endmodule
