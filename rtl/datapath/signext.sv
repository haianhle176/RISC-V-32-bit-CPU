module signext(
    input logic [24:0] a,
    input logic [1:0] s,
    output logic [31:0] y
);
    always_comb begin 
        case (s)
            2'b00 : y = {{20{a[24]}}, a[24:13]} ;
            2'b01 : y = {{20{a[24]}}, a[24:18], a[4:0]};
            2'b10 : y = {{20{a[24]}}, a[0], a[23:18], a[4:1], 1'b0};
            2'b11 : y = {{12{a[24]}}, a[12:5], a[13], a[23:14], 1'b0};
            default: y = 32'bx;
        endcase
    end
endmodule