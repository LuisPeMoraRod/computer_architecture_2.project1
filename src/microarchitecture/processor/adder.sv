// Simple N bit adder

module adder #(parameter N = 32)(
	input logic [N-1:0] a, b,
	output logic [N-1:0] result);
					
	assign result = a + b;
	
endmodule
