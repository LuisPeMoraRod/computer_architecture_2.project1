// Register file

module regfile_vec
(
	input logic clk,
	input logic rst,
	input logic vwe3,
	input logic [4:0] vra1, vra2, vwa3,
	input logic [255:0] vwd3,
	output logic [255:0] vrd1, vrd2
);

	logic [255:0] vrf[23:16];
	
	// Writing on falling edge
	always_ff @(negedge clk) begin
		if(rst) begin  
			vrf[23:16] <= '{8{255'd0}};
		end
		if (vwe3) vrf[vwa3] <= vwd3;
	end
	assign vrd1 = (vra1 != 0) ? vrf[vra1] : 0;
	assign vrd2 = (vra2 != 0) ? vrf[vra2] : 0;
	
endmodule
