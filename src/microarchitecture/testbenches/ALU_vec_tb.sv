module ALU_vec_tb;

	// Senales de entrada
	reg [255:0] a;
	reg [255:0] b;
	reg [2:0] opcode;
	reg flag_scalar;

	// Senales de salida
	wire [255:0] result;
	wire [63:0] flags;

	// Instancia del modulo ALU_vec
	ALU_vec uut (
		.a(a),
		.b(b),
		.opcode(opcode),
		.flag_scalar(flag_scalar),
		.result(result),
		.flags(flags)
	);

	initial begin
		// a = [1.5,   1.25, 3.5, 1.5,  0.5,  3.0,  1.25]
		// b = [-1.75, 1.5,  2.0, 3,25, 5.75, -0.5, -1.5]
		a = 256'h0180_0140_0380_0180_0080_0300_0140_0000_0000_0000_0000_0000_0000_0000_0000_0140; // Valor de entrada a
		b = 256'hFE40_0180_0200_0340_05c0_FF80_FE80_0000_0000_0000_0000_0000_0000_0000_0000_FE80; // Valor de entrada b
		opcode = 3'b000; // multiplication code
		flag_scalar = 1'b0;

		#100;

		$display("a = %h\nb = %h\n", a, b);

		// Show fp vector mult
		$display("Result fp mult vector: %h", result);
		$display("Flags: %b", flags);

		flag_scalar = 1'b1;
		#100;

		// Show fp scalar mult
		$display("Result fp mult scalar: %h", result);
		$display("Flags: %b", flags);

		flag_scalar = 1'b0;	//vector
		opcode = 3'b010;	// add code
		#100;

		// Show fp vector add
		$display("Result fp add vector: %h", result);
		$display("Flags: %b", flags);

		flag_scalar = 1'b1;
		#100;

		// Show fp scalar add
		$display("Result fp add scalar: %h", result);
		$display("Flags: %b", flags);
				
	end

endmodule
