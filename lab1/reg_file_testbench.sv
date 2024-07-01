module reg_file_testbench();
	logic 			clk, wr_en;
	logic [31:0] 	write_data;
	logic [3:0] 	write_addr, read_addr1, read_addr2;
	logic [31:0] 	read_data1, read_data2;

	reg_file dut (.*);
	
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
		$stop;
	end
endmodule