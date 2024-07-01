module CarDetection_tb();
	logic clk, outer, inner, enter, exit;

	CarDetection dut (.*);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;.
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		inner<=0; outer<=0;	@(posedge clk);
									@(posedge clk);
		inner<=1; outer<=0;	@(posedge clk);
									@(posedge clk);
		inner<=1; outer<=1;	@(posedge clk);
									@(posedge clk);
		inner<=0; outer<=1;	@(posedge clk);
									@(posedge clk);	
		inner<=0; outer<=0;	@(posedge clk);
									@(posedge clk);
		$stop;
	end
endmodule