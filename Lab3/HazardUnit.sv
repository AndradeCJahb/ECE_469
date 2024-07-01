module HazardUnit (ForwardBE, ForwardAE, FlushE, FlushD, StallD, StallF, MemtoRegE, RegWriteW, 
						RegWriteM, Match1EM, Match2EM, Match1EW, Match2EW, Match12DE);
						
	input logic MemtoRegE, RegWriteW, RegWriteM, Match1EM, Match2EM, Match1EW, Match2EW, Match12DE;
	output logic FlushE, FlushD, StallD, StallF;
	output logic [1:0] ForwardAE, ForwardBE;
	
	logic LDRStall;
	assign LDRStall = Match12DE & MemtoRegE;
	assign FlushF = LDRStall;
	assign StallD = FlushE;
	assign StallF = StallD;
	
	always_comb begin
		if ( Match1EM & RegWriteM )
			ForwardAE = 2'b10;
		else if ( Match1EW & RegWriteW )
			ForwardAE = 2'b01;
		else
			ForwardAE = 2'b00;
		
		
		if ( Match2EM & RegWriteM)
			ForwardBE = 2'b10;
		else if ( Match2EW & RegWriteW )
			ForwardBE = 2'b01;
		else
			ForwardBE = 2'b00;
	end
endmodule
