module ALU_vec_aux (
	input [15:0] data_a,
	input [15:0] data_b,
	input [2:0] opcode,
	input flag_scalar,
	input int instance_num,
	output reg [15:0] result,
	output reg [3:0] flags
);

	// Variables internas para los calculos
	reg [15:0] high, mid, low, a, b, a_comp, b_comp, result_temp, result_comp;

	// complemento a dos de los operandos
	two_complement #(.N(16)) tc_a (
		.data_in(data_a),
		.data_out(a_comp)
	);

	two_complement #(.N(16)) tc_b (
		.data_in(data_b),
		.data_out(b_comp)
	);

	reg [13:0] mult_int_result;    // 14 bits para el resultado entero de la multiplicacion
	reg [15:0] mult_frac_result;   // 15 bits para el resultado fraccionario de la multiplicacion

	// Seleccion de la operacion
	always @* begin
		high = 15'b0;
		mid = 15'b0;
		low = 15'b0;

		a = data_a[15] ? a_comp : data_a;
		b = data_b[15] ? b_comp : data_b;

		if ( (flag_scalar == 1'b1 && instance_num == 0) || (flag_scalar == 1'b0) ) begin
			case (opcode)
				3'b000: // Suma 
					result = a + b;

				3'b001: // Resta
					result = a - b;

				3'b010: // Multiplicacion
					begin
						high = a[14:8] * b[14:8];
						mid = (a[14:8] * b[7:0]) + (b[14:8] * a[7:0]);
						low = a[7:0] * b[7:0];
						result_temp = (high << 8) + mid + (low >> 8);
						result_comp = ~result_temp + 1'b1; //complemento a 2 
						result = (data_a[15] ^ data_b[15]) ? result_comp : result_temp;

					end
					
				default: // Operacion no valida
					result = 16'b0;  
			
			endcase
		end 
		else begin
			result = 16'bx;
		end
	end


	// Flags
	always @* begin
		flags[0] = (a[15] == 1'b0) && (b[15] == 1'b0) && (result[15] == 1'b1);	// Carry
		flags[1] = (result == 16'b0);		// Cero
		flags[2] = (result[15] == 1'b1);	// Negativo
		flags[3] = (result > 16'h7FFF);	// Overflow
	end

	endmodule

module two_complement #(parameter N = 16)(
	input [N-1:0] data_in,
	output [N-1:0] data_out
);
	assign data_out = ~data_in + 1'b1;
endmodule