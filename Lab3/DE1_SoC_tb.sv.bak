/* testbench for the DE1_SoC */
module DE1_SoC_tb();

	// define signals
	logic	CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [35:0] V_GPIO;
	
	// define parameters
	parameter T = 20;
	
	// instantiate module
	DE1_SoC dut (.*);
	
	// define simulated clock
	initial begin
		CLOCK_50 <= 0;
		forever	#(T/2)	CLOCK_50 <= ~CLOCK_50;
	end  // initial clock
	
endmodule  // DE1_SoC_tb
