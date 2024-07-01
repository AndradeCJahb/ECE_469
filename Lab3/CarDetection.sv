module CarDetection (clk, outer, inner, enter, exit);
	input logic clk, outer, inner;
	output logic enter, exit;
	
	enum {NONE, outerDetect, in, innerDetect} ps, ns;
	
	assign exit = (ns == NONE & ps == outerDetect);
	assign enter = (ns == NONE & ps == innerDetect);
	
	always_comb
		case ( ps )
			NONE			: ns = (outer & !inner) ? outerDetect : (!outer & inner) ? innerDetect : NONE;
			outerDetect	: ns = (outer & inner) ? in : (outer & !inner) ? outerDetect : NONE;
			in				: ns = (outer & !inner) ? outerDetect : (!outer & inner) ? innerDetect : (outer & inner) ? in : NONE;
			innerDetect : ns = (outer & inner) ? in : (!outer & inner) ? innerDetect : NONE;
		endcase
	
	always_ff @ (posedge clk)
		ps <= ns;
endmodule
