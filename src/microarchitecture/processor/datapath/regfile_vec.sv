// Register file

module regfile_vec
(
	input logic clk,
	input logic vwe3,
	input logic [2:0] vra1, vra2, vwa3,
	input logic [255:0] vwd3,
	output logic [255:0] vrd1, vrd2
);


	logic [255:0] vrf[7:0];
	
	// Writing on falling edge
	always_ff @(negedge clk)
		if (vwe3) vrf[vwa3] <= vwd3;
	
	assign vrd1 = (vra1 != 0) ? vrf[vra1] : 0;
	assign vrd2 = (vra2 != 0) ? vrf[vra2] : 0;
	
endmodule
