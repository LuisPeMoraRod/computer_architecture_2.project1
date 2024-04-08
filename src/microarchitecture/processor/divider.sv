module divider(
    input logic signed [31:0] dividend,
    input logic signed [31:0] divisor,
    output logic signed [15:0] result // Q7.8 format reduced to 16 bits
);

	logic signed [7:0] quotient;
	logic signed [31:0] remainder;
	logic signed [31:0] dividend_reg;
	logic signed [31:0] divisor_reg;

	always @* begin
		 // Copiar dividend y divisor a registros
		 dividend_reg = dividend;
		 divisor_reg = divisor;

		 // Realizar la división
		 if (divisor_reg == 0) begin
			  // Divisor es cero, resultado especial
			  result = 16'b0; // Todos los bits a cero
		 end else begin
			  // Inicializar el cociente y el residuo
			  quotient = 0;
			  remainder = dividend_reg;

			  // Realizar la división mediante resta repetida
			  for (int i = 0; i < 8; i++) begin
					remainder = remainder - divisor_reg;
					if (remainder[31] == 0) 
						 quotient[7 - i] = 1; // Bit del cociente en posición adecuada
					else
						 remainder = remainder + divisor_reg; // Restaurar el residuo
			  end

			  // Ajustar el resultado a Q7.8 format
			  result = {quotient[7:0], remainder[30:23]}; // Parte entera en bits [15:8], parte fraccionaria en bits [7:0]
		 end
	end

endmodule