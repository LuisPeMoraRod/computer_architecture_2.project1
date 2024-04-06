module PMC_unit (
    input logic clk,     // Señal de reloj
    input logic reset,   // Señal de reset
    input logic memWrite_in, memToReg_in, //Senales de control
	 input logic [2:0] aluControl_in,
    input logic stall_enable, //Habilitar contador de stalls
	 output logic [31:0] stall_count, // Out stall_count
    output logic [31:0] instr_cycle_count, // Out instr_cycle_count
    output logic [31:0] arith_count, // Out arith_count
	 output logic [31:0] mem_access_count  // Out mem_access_Count
);
	
	logic arith_enable, memory_enable; //Habilitar contadores de aritmetica y memoria 
	logic [2:0] aluReg;
	
	always_comb begin //Evaluar señales de control
		memory_enable <= (memWrite_in | memToReg_in) ? 1'b1 : 1'b0;
	end
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
        arith_enable <= 1'b0;
        aluReg <= 3'b0; // Asegurarse de reiniciar aluReg en el reset
		end else begin
				if ((aluControl_in != 3'b100) && (aluReg != aluControl_in)) begin
                arith_enable <= 1'b1;
            end else begin
                arith_enable <= 1'b0;
            end
            aluReg <= aluControl_in;
		end
	end
		

    // Contador de Stalls:
    contador stall_counter (clk, reset, stall_enable, stall_count);
	 
    // Contadores de Ciclos de Instruccion
	 //contador contador_2 (clk, reset, enable, instr_cycle_count);
    
	 //Contador de Operaciones Aritmeticas
	 contador arithmetic_counter (clk, reset, arith_enable, arith_count);

	 //Contador de Accesos a Memoria
	 contador memory_counter (clk, reset, memory_enable, mem_access_count);
	 
endmodule
