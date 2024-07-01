// Christopher Andrade
// 04/05/2024
// EE/CSE 469
// Lab #1, Task 2

// reg_file takes a clock, 3 4-bit addresses (2 of which concern reading data and the other writing data), a write enable,
// and write data which is 32-bits. Data will only be written to a register corresponding to the 4-bit write address (write_addr)
// if write enable is true (1) at the posedge of the clock, making the write synchronous. The reg_file also contains 2 
// 32-bit outputs which correspond to the inputted read addresses, these outputs are updated asynchronously and will change 
// the outputted data immediately if the corresponding read address is changed. 
module reg_file(input logic clk, wr_en,
    input logic [31:0] write_data,
    input logic [3:0] write_addr, input logic [3:0]
    read_addr1, read_addr2, output logic [31:0]
    read_data1, read_data2);
	
	// Internal memory array of depth 16 and width of 32 bits which is the register file.
	logic [15:0][31:0] memory;
	
	assign read_data1 = memory[read_addr1];
	assign read_data2 = memory[read_addr2];
	
	// Always block which is updated at the clock edge to write data, or when either read address is changed to allow for
	// asynchronous reading from the register file.
	always_ff @ (posedge clk) begin
		// Writing of data at appropriate address within register file when writes are enabled.
		if ( wr_en )
			memory[write_addr] <= write_data;		
	end
endmodule

// reg_file_testbench tests multiple scenarios to ensure that the register file is updated with correct data at correct address
// one clock cycle after writes are enabled. Testbench also checks if data is read as soon as the read address changes, ensures
// an asynchronous read. The testbench also ensures that read data is updated one clock cycle after data is written at the same
// address. The tests concerning reading data are additionally testing both read data addresses/outputs.
module reg_file_testbench();
	// logic to represent the inputs and outputs of reg_file are created.
	logic 			clk, wr_en;
	logic [31:0] 	write_data;
	logic [3:0] 	write_addr, read_addr1, read_addr2;
	logic [31:0] 	read_data1, read_data2;
	
	// Creation of an instance of the reg_file using the created logic above.
	reg_file dut (.*);
	
	// Creation of clock and initialization of certain variables to ensure no
	// unintended behavior, most importantly write enable is turned off.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk 			<= 0;
		wr_en 		<= 0;
		write_data 	<= 0;
		write_addr 	<= 0;
		read_addr1 	<= 0;
		read_addr2	<= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Creation of multiple combinations of inputs to thoroughly test the register file instance behavior.
	initial begin
		write_data <= '1; write_addr <= 4'b0001;									@(posedge clk);
																								@(posedge clk);
																								@(posedge clk);
		wr_en <= 1;																			@(posedge clk);
																								@(posedge clk);
		write_addr <= 4'b0010; write_data <= 16'b1111111111111111;			@(posedge clk);
																								@(posedge clk);
																								@(posedge clk);
																								@(posedge clk);
		read_addr1 <= 4'b0001; read_addr2 <= 4'b0010;							@(posedge clk);
																								@(posedge clk);
																								@(posedge clk);
		write_addr <= 4'b0011; read_addr1 <= 4'b0011;							@(posedge clk);
																								@(posedge clk);
																								@(posedge clk);
																								@(posedge clk);
		write_addr <= 4'b0100; read_addr2 <= 4'b0100; write_data <= 0;		@(posedge clk);
																								@(posedge clk);
																								@(posedge clk);
		$stop;
	end
endmodule