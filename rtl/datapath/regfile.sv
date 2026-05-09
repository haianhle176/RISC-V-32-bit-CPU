module regfile(
    input  logic        clk, rst_n,
    input  logic        we3,
    input  logic [4:0]  a1, a2, a3,
    input  logic [31:0] wd3,
    output logic [31:0] rd1, rd2
);
    logic [31:0] rf[31:0];
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            rf[3] <= 32'd640; 
            rf[2] <= 32'd1020; 
        end
        else if (we3 && (a3 != 5'd0)) begin
            rf[a3] <= wd3;
        end
    end
    assign rd1 = (a1 == 5'd0) ? 32'd0 : rf[a1];
    assign rd2 = (a2 == 5'd0) ? 32'd0 : rf[a2];

endmodule