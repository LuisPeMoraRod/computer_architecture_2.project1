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
		a = 256'h1234_5678_90AB_CDEF_1234_5678_90AB_CDEF_1234_5678_90AB_CDEF_1234_5678_90AB_CDEF; // Valor de entrada a
		b = 256'h9876_5432_10FE_DCBA_9876_5432_10FE_DCBA_9876_5432_10FE_DCBA_9876_5432_10FE_DCBA; // Valor de entrada b
		opcode = 3'b010; // Operacion de multiplicacion
		flag_scalar = 1'b0;

		#100;

		// Mostrar los resultados
		$display("Resultado: %h", result);
		$display("Flags: %h", flags);

		flag_scalar = 1'b1;
		#100;

		// Mostrar los resultados
		$display("Resultado: %h", result);
		$display("Flags: %h", flags);
				
	end

endmodule
