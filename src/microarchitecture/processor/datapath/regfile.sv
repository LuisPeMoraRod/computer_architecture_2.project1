// Register file

module regfile
(
	input logic clk,
	input logic rst,
	input logic we3,
	input logic [4:0] ra1, ra2, wa3,
	input logic [31:0] wd3,
	output logic [31:0] rd1, rd2
);


	logic [31:0] rf[31:0];
	
	// Writing on falling edge
	always_ff @(negedge clk) begin
		if(rst) begin  
			//rf[0] <=  32'h00000;  // $zero
			rf[31:0] <= '{32{32'd0}};
		end
		
		if (we3) rf[wa3] <= wd3;
	end
	
	assign rd1 = rf[ra1];
	assign rd2 = rf[ra2];
	
endmodule
 