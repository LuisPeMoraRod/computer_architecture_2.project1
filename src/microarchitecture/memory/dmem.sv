
module dmem
(
	input logic clk, we,
	input logic [31:0] a, wd,
	output logic [31:0] rd
);

	reg [31:0] RAM[63:0];
	
	initial
	begin
		$readmemh("memdata.dat",RAM);
	end
	
	assign rd = RAM[a[31:2]]; // word aligned
	
	always @(posedge clk)
		if (we)
			RAM[a[31:2]] <= wd;
	
endmodule
