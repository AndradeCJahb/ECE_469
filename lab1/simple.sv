module simple (clk, reset, w, out);
input logic clk, reset, w;
output logic out;
// State variables
enum { none, got_one, got_two } ps, ns;
// Next State logic
always_comb begin
case (ps)
none: if (w) ns = got_one;
else ns = none;
got_one: if (w) ns = got_two;
else ns = none;
got_two: if (w) ns = got_two;
else ns = none;
endcase
end
// Output logic - could also be another always_comb block.
assign out = (ps == got_two);
// DFFs
always_ff @(posedge clk) begin
if (reset)
ps <= none;
else
ps <= ns;
end
endmodule

module simple_testbench();
logic clk, reset, w;
logic out;
simple dut (clk, reset, w, out);
// Set up a simulated clock.
parameter CLOCK_PERIOD=100;
initial begin
clk <= 0;
forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
end
// Set up the inputs to the design. Each line is a clock cycle.
initial begin
@(posedge clk);
reset <= 1; @(posedge clk); // Always reset FSMs at start
reset <= 0; w <= 0; @(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
w <= 1; @(posedge clk);
w <= 0; @(posedge clk);
w <= 1; @(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
w <= 0; @(posedge clk);
@(posedge clk);
$stop; // End the simulation.
end
endmodule