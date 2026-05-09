module dff #(parameter WIDTH = 32)
(input logic clk, rst_n, en,
input logic [WIDTH-1:0] d,
output logic [WIDTH-1:0] q);
always_ff @(posedge clk, negedge rst_n)
if (!rst_n) q <= 0;
else if (en) q <= d;
endmodule
