module alu (
    input logic [31:0] a,b,
    input logic [2:0] alucontrol,
    output logic [31:0] aluresult,
    output logic zero
);
    always_comb begin 
        case (alucontrol)
            3'b000 : aluresult = a + b;
            3'b001 : aluresult = a - b;
            3'b010 : aluresult = a & b;
            3'b011 : aluresult = a | b;
            3'b100 : aluresult = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            3'b101 : aluresult = a << b[4:0];
            3'b110 : aluresult = a >> b[4:0];
            3'b111 : aluresult = a >>> b[4:0];
            default: aluresult = 32'bx;
        endcase
    end
    assign zero = (aluresult==32'b0);
endmodule