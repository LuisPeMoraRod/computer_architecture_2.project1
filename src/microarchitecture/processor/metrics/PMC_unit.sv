module PMC_unit (
    input logic clk,     // Señal de reloj
    input logic reset,   // Señal de reset
    input logic memWrite_in, memToReg_in, //Senales de control de mem y WB
	 input logic [2:0] aluControl_in,
    input logic [1:0 ]stall_in, //Habilitar contador de stalls
	 input logic [5:0] opcode_in, funct_in, // señales desde al menos execute en adelante
	 input logic jmp_in, // señal desde unidad de control
	 input logic [1:0] branch_in, // señal desde unidad de control
	 output logic [31:0] stall_count, CPI_numerator, CPI_denominator, // Out stall_count
    output logic [15:0] cycles_per_instruction, // Out instr_cycle_count
    output logic [31:0] arith_count, // Out arith_count
	 output logic [31:0] mem_access_count,  // Out mem_access_Count
	 output logic [31:0] mem_read_count, mem_write_count,
	 output logic [31:0] ADD_count, SUB_count, ADDI_count, ADD_FP_count, MUL_FP_count, VADD_FP_count, VMUL_FP_count,
			VSUM_FP_count, VSET_FP_count, SW_count, LW_count, SW_FP_count, LW_FP_count, VST_count, VLD_count,
			BEQ_count, BLT_count, J_count
);
	
	logic arith_enable; //Habilitar contadores de aritmetica y memoria 
	//logic [31:0] CPI_numerator, CPI_denominator;
	
	
	
	parameter ARITH_INSTRUCTION_CYCLES = 5; 
	parameter MEM_LD_INSTRUCTION_CYCLES = 5;   
	parameter MEM_STR_INSTRUCTION_CYCLES = 4;
	parameter BRANCH_INSTRUCTION_CYCLES = 2;
	
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
        arith_enable <= 1'b0;

		end else begin
		
				// Logica para ignorar operaciones no aritmeticas y conter una vez por instruccion
				if (aluControl_in != 3'b100) begin
                arith_enable <= 1'b1;
            end else begin
                arith_enable <= 1'b0;
            end
		end
	end
		

   // Contador de Stalls:
   counter stall_counter (clk, reset, (stall_in[0] || stall_in[1]), stall_count);
	//======================================================================
	 
	//Contador de Operaciones Aritmeticas
	counter arithmetic_counter (clk, reset, arith_enable, arith_count);
	//======================================================================
	 
	//Contador de Accesos a Memoria
	counter memory_read_counter (clk, reset, memToReg_in, mem_read_count);
	counter memory_write_counter (clk, reset, memWrite_in, mem_write_count);
	assign mem_access_count = mem_read_count + mem_write_count;
	//======================================================================
	 
   // Contadores de Ciclos de Instruccion
	instr_counter instruction_counters(clk, reset, opcode_in, funct_in, jmp_in, branch_in,
		ADD_count, SUB_count, ADDI_count, ADD_FP_count, MUL_FP_count, VADD_FP_count, VMUL_FP_count,
		VSUM_FP_count, VSET_FP_count, SW_count, LW_count, SW_FP_count, LW_FP_count, VST_count, VLD_count,
		BEQ_count, BLT_count, J_count);
			
	 
	assign CPI_numerator = ((ADD_count + SUB_count + ADDI_count + ADD_FP_count + MUL_FP_count + VADD_FP_count + VMUL_FP_count +	VSUM_FP_count + VSET_FP_count) * ARITH_INSTRUCTION_CYCLES + 
		(LW_count + LW_FP_count + VLD_count) * MEM_LD_INSTRUCTION_CYCLES + (SW_count + SW_FP_count + VST_count) * MEM_STR_INSTRUCTION_CYCLES +
		(BEQ_count + BLT_count + J_count) * BRANCH_INSTRUCTION_CYCLES);
	assign CPI_denominator = (ADD_count + SUB_count + ADDI_count + ADD_FP_count + MUL_FP_count + VADD_FP_count + VMUL_FP_count +	VSUM_FP_count + VSET_FP_count + 
		LW_count + LW_FP_count + VLD_count + SW_count + SW_FP_count + VST_count +
		BEQ_count + BLT_count + J_count);
		
	divider division (CPI_numerator, CPI_denominator, cycles_per_instruction);
    

	 
endmodule
