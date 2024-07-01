// Christopher Andrade
// 04/05/2024
// EE/CSE 469
// Lab #1, Task 3

// alu takes 2 32-bit inputs and a 2 bit instruction selector (ALU_Control) to perform either an addition, subtraction, OR-ing or AND-ing
// of the 32-bit inputs. The 32-bit output will be the result of manipulating the two inputs according to which instruction is selected, while
// the 4-bit output represents 4 different flags that may occur as a result of whatever operation was performed, in all the ALUFlags detect if
// the result is negative, 0, resulted in an adder overflow or adder carryout.
module alu(input logic [31:0] a, b,
	input logic [1:0] ALUControl,
	output logic [31:0] Result,
	output logic [3:0] ALUFlags);
	
	// Assignment of 0 and negative flag, bit 3 and 4 respectively.
	assign ALUFlags[2] = !Result;
	assign ALUFlags[3] = Result[31];
	
	// Selects which operation to perform on the two 32 bits based on the 2bit ALU_Control, 00==add, 01==subtract, 10=AND, 11=OR.
	always_comb begin
		case (ALUControl)
        2'b00: begin
						// Assigns Result based on addition of 32-bit inputs, also assigns carryout and overflow flag.
						Result = a + b;
						ALUFlags[0] = (a[31] == ~Result[31]) & (b[31] == a[31]);
						ALUFlags[1] = ~Result[31] & (a[31] | b[31]);
					end
        2'b01: begin	
						// Assigns Result based on addition of one 32-bit number, the bitwise NOT of the other and addition of 1, subtraction using 2's complement
						// of one of the two 32-bit inputs. Also assigns carryout and overflow flag.
						Result = a + ~b + 1;
						ALUFlags[0] = (a[31] == ~Result[31]) & (b[31] != a[31]);
						ALUFlags[1] = (b == 0) | (~Result[31] & (a[31] | ((~b)+ 1) >> 31));
					end
        2'b10:	begin
						// Assigns Result based on bitwise AND-ing of the two 32-bit inputs. Since no adding/subtracting is occuring carryout and overflow are set
						// to 0.
						Result = a & b;
						ALUFlags[0] = 0;
						ALUFlags[1] = 0;
					end
        2'b11: begin
						// Assigns Result based on bitwise OR-ing of the two 32-bit inputs. Since no adding/subtracting is occuring carryout and overflow are set
						// to 0.
						Result = a | b;
						ALUFlags[0] = 0;
						ALUFlags[1] = 0;
					end
		endcase
	end
endmodule

// alu testbench sources a previously created alu.tv file which contains rows of vectors that are assigned to the 32-bit inputs and 2-bit ALU control.
// This allows for multiple different inputs to be tested on the ALU and its outputs (Result and ALUFlags) to be seen within modelsim.
module alu_testbench();
	// logic to represent the inputs and outputs of the alu are created.
	logic [31:0] a, b;
	logic [1:0] ALUControl;
	logic [31:0] Result;
	logic [3:0] ALUFlags;
	logic clk;
	logic [67:0] testvectors [1000:0];
	
	// Creation of an instance of the alu using the created logic above.
	alu dut (.*);
	
	// Creation of clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk 			<= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Reads rows of vectors from alu.tv to set the inputs of the alu testbench to different values.
	initial begin
		$readmemh ("C:/Users/andra/OneDrive/Desktop/ECE_469/labs/lab1a/simulation/modelsim/alu.tv", testvectors);
		
		for (int i = 0; i < 40; i = i+1) begin
			{ALUControl, a, b} = testvectors[i];	@(posedge clk);
		end
	end
endmodule
