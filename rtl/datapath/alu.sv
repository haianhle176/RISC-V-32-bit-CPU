module alu #(parameter SIZE = 32)(
    input logic [SIZE-1:0] a, b,
    input logic [2:0] alucontrol,
    output logic [SIZE-1:0] aluresult,
    output logic zero
);
    always_comb begin 
        case (alucontrol)
            3'b000 : aluresult = a + b;
            3'b001 : aluresult = a - b;
            3'b101 : aluresult = $signed(a) < $signed(b) ? 32'd1 : 32'd0;
            3'b011 : aluresult = a | b;
            3'b010 : aluresult = a & b;
            default: aluresult = 32'bx;
        endcase
    end
    assign zero = (aluresult == 32'b0);
endmodule