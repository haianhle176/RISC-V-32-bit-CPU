module branchdecoder (
    input logic [2:0] funct3,
    output logic tzero,nzero
);
    logic [1:0] tnzero;
    assign {tzero,nzero} = tnzero;
    always_comb begin 
        case (funct3)
            3'b000,3'b101: tnzero = 2'b10;
            3'b001,3'b100: tnzero = 2'b01;
            default: tnzero = 2'b00;
        endcase
    end
endmodule