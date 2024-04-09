module regfile_vec_tb;

    // Parametros
    reg clk;
    reg vwe3;
    reg [2:0] vra1, vra2, vwa3;
    reg [255:0] vwd3;
    wire [255:0] vrd1, vrd2;

    // Instancia del modulo regfile_vec
    regfile_vec uut (
        .clk(clk),
        .vwe3(vwe3),
        .vra1(vra1),
        .vra2(vra2),
        .vwa3(vwa3),
        .vwd3(vwd3),
        .vrd1(vrd1),
        .vrd2(vrd2)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        vwe3 = 1;
        vra1 = 1;
        vra2 = 2;
        vwa3 = 2;
        vwd3 = 256'h123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;
        
        #10;
        vwe3 = 0;
        #10;
    end

    // Monitoreo de las salidas
    always @(vrd1 or vrd2) begin
        $display("vrd1 = %h, vrd2 = %h", vrd1, vrd2);
    end

endmodule
