`timescale 1ns / 1ps

module dmem_tb;

    // Testbench signals
    reg clk;
    reg w_enable;
    reg src_sel;
    reg [31:0] addr;
    reg [15:0] w_data_a;
    reg [255:0] w_data_b;
    wire [15:0] q_a;
    wire [255:0] q_b;

    dmem dut (
        .clk(clk),
        .w_enable(w_enable),
        .src_sel(src_sel),
        .addr(addr),
        .w_data_a(w_data_a),
        .w_data_b(w_data_b),
        .q_a(q_a),
        .q_b(q_b)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = !clk; // 100MHz clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        w_enable = 0;
        src_sel = 0;
        addr = 0;
        w_data_a = 0;
        w_data_b = 0;

        // Reset sequence
        #100;
        
        // Example write operation
        w_enable = 1;
        src_sel = 0; // Writing scalar value
        addr = 32'h00000010; // Example address
        w_data_a = 16'hFFFF; // Example data
        #10;
        
        // Switch to vectorial write
        src_sel = 1;
        addr = 32'h00000020;
        w_data_b = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA; // Example data
        #10;

        w_enable = 0;
        #10;
        addr = 32'h00000010;
        src_sel = 0;
        // End simulation
        #100;
        $finish;
    end
endmodule
