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
		if(rst)  
			vrf[23:16] <= '{8{255'd0}};	//set all registers in zero
		if (vwe3)
			vrf[vwa3] <= vwd3;	// write register
	end
	assign vrd1 = vrf[vra1]; 	// read vector register 1
	assign vrd2 = vrf[vra2];	// read vector register 2
	
endmodule
