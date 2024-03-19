module ALU_vec_aux_tb;

    reg [15:0] a, b;
    reg [2:0] opcode;
    wire [15:0] result;
    wire [3:0] flags;

    // Instancia del modulo ALU_vec
    ALU_vec_aux dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .flags(flags)
    );

    initial begin
        // Prueba de suma
        a = 16'h1234;
        b = 16'h5678;
        opcode = 3'b000;
        #10;
        $display("Suma: %h + %h = %h", a, b, result);

        // Prueba de resta
        a = 16'h5678;
        b = 16'h1234;
        opcode = 3'b001;
        #10;
        $display("Resta: %h - %h = %h", a, b, result);

        // Prueba de multiplicacion
		  a = 16'h1234;
        b = 16'h5678;
        opcode = 3'b010;
        #10;
        $display("Multiplicacion: %h * %h = %h", a, b, result);
        
    end
endmodule
