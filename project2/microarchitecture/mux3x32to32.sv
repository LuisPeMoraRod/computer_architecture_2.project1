`timescale 1 ps / 100 fs
module mux3x32to32(DataOut,A,B,C,Select);
	output [31:0] DataOut;
	input [1:0] Select;
	input [31:0] A,B,C;

	always @(*) begin
		 case (Select)
			2'b00: DataOut = A;
			2'b01: DataOut = B;
			2'b10: DataOut = C;
			default: DataOut = 32'b0;
		 endcase
	  end

endmodule