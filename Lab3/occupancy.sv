module occupancy (clk, enter, exit, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input logic clk, enter, exit;
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	
	logic [4:0] count;
	
	assign incr = enter;
	assign decr = exit;
		
	always_ff @ (posedge clk) begin
		if ( incr & count < 16 )
			count <= count + 1'b1;
		if ( decr & count > 0 )
			count <= count - 1'b1;
	end
	
	always_comb begin 
		case ( count )
			5'b00000:	begin
								HEX5 = 7'b0110001;
								HEX4 = 7'b1110001;
								HEX3 = 7'b0110000;
								HEX2 = 7'b0001000;
								HEX1 = 7'b0011001;
								HEX0 = 7'b0000001;
							end
			5'b00001:	begin	
								HEX0 = 7'b1001111;
								HEX1 = 7'b1111111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b00010:	begin	
								HEX0 = 7'b0010010;
								HEX1 = 7'b1111111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b00011:	begin	
								HEX0 = 7'b0000110;
								HEX1 = 7'b1111111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b00100:	begin	
								HEX0 = 7'b1001100;
								HEX1 = 7'b1111111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b00101:	begin	
								HEX0 = 7'b0100100;
								HEX1 = 7'b1111111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b00110:	begin	
								HEX0 = 7'b0100000;
								HEX1 = 7'b1111111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b00111:	begin	
								HEX0 = 7'b0001111;
								HEX1 = 7'b1111111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b01000:	begin	
								HEX0 = 7'b0000000;
								HEX1 = 7'b1111111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b01001:	begin
								HEX0 = 7'b0001100;
								HEX1 = 7'b1111111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b01010:	begin	
								HEX0 = 7'b0000000;
								HEX1 = 7'b1001111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b01011:	begin	
								HEX0 = 7'b1001111;
								HEX1 = 7'b1001111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b01100:	begin	
								HEX0 = 7'b0010010;
								HEX1 = 7'b1001111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b01101:	begin	
								HEX0 = 7'b0000110;
								HEX1 = 7'b1001111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b01110:	begin	
								HEX0 = 7'b1001100;
								HEX1 = 7'b1001111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b01111:	begin	
								HEX0 = 7'b0100100;
								HEX1 = 7'b1001111;
								HEX2 = 7'b1111111;
								HEX3 = 7'b1111111;
								HEX4 = 7'b1111111;
								HEX5 = 7'b1111111;
							end
			5'b10000:	begin	
								HEX0 = 7'b0100000;
								HEX1 = 7'b1001111;
								HEX2 = 7'b1110001;
								HEX3 = 7'b1110001;
								HEX4 = 7'b1000001;
								HEX5 = 7'b0111000;
							end
		endcase
	end
endmodule
