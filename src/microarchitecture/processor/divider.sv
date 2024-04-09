module divider (
    input logic [31:0] numerator,  // Numerador de 32 bits
    input logic [31:0] denominator,  // Denominador de 32 bits
	 output logic [15:0] result_q78
    
);

    logic [39:0] dividend;
    logic [31:0] div_result; // Cociente de la división
	 logic [6:0] truncated_quotient;  // Cociente truncado a 7 bits
    logic [7:0] remainder;  // Resto de 8 bits

    // Concatenamos el numerador con 8 bits más para realizar la división
    assign dividend = {8'b0, numerator};

    // Realizamos la división
    always @* begin
        if (denominator == 0) begin
            truncated_quotient = 8'b0; // Si el denominador es 0, el cociente truncado es 0
            remainder = 8'b0; // El resto también es 0
        end else begin
            div_result = dividend / denominator;
            remainder = dividend % denominator;
            truncated_quotient = div_result[6:0]; // Truncamos el cociente a 7 bits
            result_q78 = {1'b0, truncated_quotient, remainder};
				
        end
    end

endmodule
