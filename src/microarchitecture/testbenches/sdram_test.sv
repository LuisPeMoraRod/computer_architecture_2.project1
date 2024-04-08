
module sdram_test
(
	input logic clk, reset,
	input logic button,
	output logic [15:0] result,
	output logic [3:0] debug,
	
	
	// vector load/store unit signals
	output  logic [31:0] 		address,
	output  logic 				memWriteM, memtoRegW, memSrcM,
	output  logic [15:0] 		data_in,
	output  logic [15:0] 		data_in_vec [16],
	input 	logic [15:0] 		data_out,
	input 	logic [15:0] 		data_out_vec [16],
	input 	logic 				write_done,
	input 	logic 				data_ready
);
	
	typedef enum logic [2:0]
	{
		INIT = 3'b000,
		WRITE = 3'b001,
		WRITE2 = 3'b010,
		READ = 3'b011,
		SHOW = 3'b100
	} state_t;

	state_t state, next_state;
	
	
	logic button_prev;
	logic [15:0] result_next;
	logic [3:0] debug_next;
	
	
	always_ff @ (posedge clk) begin

		if (reset) begin
			state <= INIT;
			debug <= 4'b0;
		end
		else begin
			button_prev <= button;
			state <= next_state;
			result <= result_next;
			debug <= debug_next;
		end
	end
	
	assign debug_next = (state == WRITE2) ? debug + 4'd1 : debug;
	
	
	always_comb 
	begin
	
		case (state)
				
			INIT: begin
				
				address = 32'd0;
				memWriteM = 1'd0;
				memtoRegW = 1'd0;
				memSrcM = 1'd0;

				data_in = 16'd0;
				data_in_vec = '{ 16{16'd0} };
				
				
				result_next = 16'h8888;
				
				if (~button & button_prev) next_state = WRITE;
				else next_state = INIT;
			end
			
			
			WRITE: begin
				
				address = 32'd0;
				memWriteM = 1'd1;
				memtoRegW = 1'd0;
				memSrcM = 1'd1;

				data_in = 16'h1001;
				data_in_vec = '{ 16{16'h0004} };
				
				
				result_next = 16'h7777;
				
				if (write_done) next_state = WRITE2;
				else next_state = WRITE;
				
			end

			WRITE2: begin
				
				address = 32'd5;
				memWriteM = 1'd1;
				memtoRegW = 1'd0;
				memSrcM = 1'd1;

				data_in = 16'h2222;
				data_in_vec = '{ 16{16'h0003} };
				
				
				result_next = 16'h9999;
				
				if (write_done) next_state = READ;
				else next_state = WRITE2;
				
			end
			
			READ: begin
				
				address = 32'd0;
				memWriteM = 1'd0;
				memtoRegW = 1'd1;
				memSrcM = 1'd1;

				data_in = 16'd0;
				data_in_vec = '{ 16{16'd0} };
				
				
				/*
				result_next = data_out_vec[15:0] + 
							  data_out_vec[31:16] + 
							  data_out_vec[47:32] + 
							  data_out_vec[63:48] + 
							  data_out_vec[79:64] + 
							  data_out_vec[95:80] + 
							  data_out_vec[111:96] + 
							  data_out_vec[127:112] + 
							  data_out_vec[143:128] +

							  data_out_vec[159:144] + 
							  data_out_vec[175:160] + 
							  data_out_vec[191:176] + 
							  data_out_vec[206:192] + 
							  data_out_vec[223:207] + 
							  data_out_vec[239:224] + 
							  data_out_vec[255:240];
				
				result_next = 	data_out[3:0] + 
									data_out[7:4] +
									data_out[11:8] + 
									data_out[15:12];
				*/
				result_next = 	data_out_vec[1];
				
				if (data_ready) next_state = SHOW;
				else next_state = READ;
				
			end
			
			SHOW: begin
				address = 32'd0;
				memWriteM = 1'd0;
				memtoRegW = 1'd0;
				memSrcM = 1'd0;

				data_in = 16'd0;
				data_in_vec = '{ 16{16'd0} };
				
				
				
				result_next = result;
							  
				
				if (~button & button_prev) next_state = INIT;
				else next_state = SHOW;
				
			end
			
			default: begin
				
				address = 32'd0;
				memWriteM = 1'd0;
				memtoRegW = 1'd0;
				memSrcM = 1'd0;
				data_in = 16'd0;
				data_in_vec = '{ 16{16'd0} };
				
				result_next = result;
				next_state = INIT;
			end
				
		endcase
		
	end

	
endmodule
