/* Top-level module for LandsLand hardware connections to implement the parking lot system.*/

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, V_GPIO);

	input  logic		 CLOCK_50;	// 50MHz clock
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	output logic [9:0] LEDR;
	inout  logic [35:0] V_GPIO;	// expansion header 0 (LabsLand board)
	
    // Turn off all 7-seg displays (active low: 1 = off, 0 = on)
	assign HEX0 = 7'b1111111;	
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	logic [31:0] clocks;
	logic enter, exit;
	
		
	
	clock_divider clock	 (CLOCK_50, clocks);
	
	CarDetection detector (CLOCK_50, outer, inner, enter, exit);
	
	occupancy current		 (CLOCK_50, enter, exit, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

endmodule  // DE1_SoC
