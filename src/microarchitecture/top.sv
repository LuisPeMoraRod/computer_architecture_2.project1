
// Top level module

module top
(
	input logic clk, reset,
	output logic [31:0] readdata2
);

	logic [31:0] writedata, dataadr;
	logic memwrite;
	logic [31:0] pcF, instr, readdata;
	logic src_sel;
	logic [255:0] w_data_b;
	logic [15:0] q_a;
	logic [255:0] q_b;
	

	simd_processor processor
	(
		clk, 
		reset, 
		pcF, 
		instr, 
		memwrite, 
		src_sel, 
		dataadr, 
		writedata, 
		readdata, 
		w_data_b, 
		q_b
	);

	
	imem imem (pcF[7:2], instr);
	
	
	//dmem ram_mem (clk, memwrite, src_sel, dataadr, writedata[15:0], {223'd0, writedata}, q_a, q_b);
	
	logic memWriteM, memSrcM;
    logic [31:0] address;
    logic [15:0] scalarDataIn; 
    logic [255:0] vectorDataIn;
    logic busy;
    logic [15:0] scalarDataOut;
    logic [255:0] vectorDataOut;
    
    // ip_ram signals
    logic [255:0] readData;
    logic wren;
    logic [13:0] ip_address;
    logic [31:0] byteena;
    logic [255:0] writeData;
		
	// instantiate device to be tested
	vector_load_store_unit vlsu
    (
        clk, reset,
        memWriteM, memSrcM,
        address,
        scalarDataIn, 
        vectorDataIn,
        busy,
        scalarDataOut,
        vectorDataOut,
    
        readData,
        wren,
        ip_address,
        byteena,
        writeData
    );
	
	// instantiate device to be tested
	dmem data_mem
	(
		ip_address,
		byteena,
		clk,
		writeData,
		wren,
		readData
	);
	
	
	assign readdata = {16'b0, q_a};
	assign readdata2 = q_b[31:0];

endmodule
