module signext(
    input  logic [24:0] a,
    input  logic [1:0]  s,
    output logic [31:0] y
);
    logic [31:0] imm_i, imm_s, imm_b, imm_j;

    assign imm_i = {{20{a[24]}}, a[24:13]};
    assign imm_s = {{20{a[24]}}, a[24:18], a[4:0]};
    assign imm_b = {{20{a[24]}}, a[0], a[23:18], a[4:1], 1'b0};
    assign imm_j = {{12{a[24]}}, a[12:5], a[13], a[23:14], 1'b0};

    always_comb begin
        case (s)
            2'b00:   y = imm_i;
            2'b01:   y = imm_s;
            2'b10:   y = imm_b;
            2'b11:   y = imm_j;
            default: y = 32'bx;
        endcase
    end

endmodule