 module ALU_vec (
	input [255:0] a,
	input [255:0] b,
	input [2:0] opcode,
	input flag_scalar,
	output reg [255:0] result,
	output reg [63:0] flags
);

	localparam NUM_INSTANCES = 16;	// Numero de instancias
	localparam bits_index = 16;		// Indice para acceder a los bits requeridos de a y b
	localparam flags_index = 4; 		// Indice para acceder a los bits requeridos de flags

	// Generacion de instancias de ALU_vec_aux
	genvar i;
	generate
		for (i = 0; i < NUM_INSTANCES; i = i + 1) begin : alu_instance

			ALU_vec_aux alu (
				.data_a(a[15 + bits_index*i : 0 + bits_index*i]),
				.data_b(b[15 + bits_index*i : 0 + bits_index*i]),
				.opcode(opcode), 
				.flag_scalar(flag_scalar),
				.instance_num(i),
				.result(result[15 + bits_index*i : 0 + bits_index*i]),
				.flags(flags[3 + flags_index*i : 0 + flags_index*i])
			);
		end
	endgenerate

endmodule
