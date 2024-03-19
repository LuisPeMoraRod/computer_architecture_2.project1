module ALU_vec_aux (
    input [15:0] a,
    input [15:0] b,
    input [2:0] opcode,
    output reg [15:0] result,
    output reg [3:0] flags
);
    
	// Variables internas para los calculos
   reg [13:0] mult_int_result;    // 14 bits para el resultado entero de la multiplicacion
   reg [15:0] mult_frac_result;   // 15 bits para el resultado fraccionario de la multiplicacion

   // Seleccion de la operacion
   always @* begin
		mult_int_result = 14'b0;    
		mult_frac_result = 16'b0;
		
		case (opcode)
			3'b000: // Suma 
				result = a + b;

			3'b001: // Resta
				result = a - b;

			3'b010: // Multiplicacion
				begin
					mult_int_result = a[14:8] * b[14:8];	// Multiplicacion parte entera
					mult_frac_result = a[7:0] * b[7:0];  	// Multiplicacion parte fraccionaria
				 
					result = {mult_int_result[6:0], mult_frac_result[15:8]};
				end
				
			default: // Operacion no valida
				result = 16'b0;  
		
		endcase
	end

	
   // Flags
   always @* begin
		flags[0] = (a[15] == 1'b0) && (b[15] == 1'b0) && (result[15] == 1'b1);	// Carry
      flags[1] = (result == 16'b0);		// Cero
		flags[2] = (result[15] == 1'b1);	// Negativo
      flags[3] = (result > 16'h7FFF);	// Overflow
   end

endmodule
