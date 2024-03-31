
module PMC_tb();
	 logic clk;     // Señal de reloj
    logic reset;   // Señal de reset
    logic memWrite_in, memToReg_in; //Senales de control
	 logic [2:0] aluControl_in;
    logic stall_enable; //Habilitar contador de stalls
	 logic [31:0] stall_count; // Out stall_count
    logic [31:0] instr_cycle_count; // Out instr_cycle_count
    logic [31:0] arith_count; // Out arith_count
	 logic [31:0] mem_access_count;  // Out mem_access_Count
	
	// instantiate device to be tested
	PMC_unit dut(
	 clk, reset,
    memWrite_in, memToReg_in, 
	 aluControl_in,
    stall_enable, //Habilitar contador de stalls
	 stall_count, // Out stall_count
    instr_cycle_count, // Out instr_cycle_count
    arith_count, // Out arith_count
	 mem_access_count  // Out mem_access_Count
	);
	// initialize test
	initial
	begin
		reset <= 1;
		memWrite_in<=0; 
		memToReg_in<=0;
		stall_enable<=0;
		aluControl_in <=3'b100;
		# 12; reset <= 0;
		#10
		memWrite_in<=1;
		#25
		memWrite_in<=0;
		#10
		memToReg_in<=1;
		stall_enable<=1;
		
		aluControl_in <=3'b110;
		#15
		memToReg_in<=0;
		#10
		stall_enable<=0;
		
		aluControl_in <=3'b010;
		#20
		
		aluControl_in <=3'b011;
		#10
		aluControl_in <=3'b100;
				
		
		
		
		
	end
	
	// generate clock to sequence tests
	always
	begin
		clk <= 1; # 5; clk <= 0; # 5;
	end

	
endmodule
