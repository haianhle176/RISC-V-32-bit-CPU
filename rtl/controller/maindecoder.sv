module maindecoder (
    input logic [6:0] op,
    output logic branch,jump,memwrite,alusrc,regwrite,
    output logic [1:0] resultsrc,immsrc,
    output logic [1:0] aluop
 );
    logic [10:0] controls ;
    assign {regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump} = controls;
    always_comb begin 
        case (op)
            7'b0000011 : controls = 11'b10010010000;
            7'b0100011 : controls = 11'b00111000000;
            7'b0110011 : controls = 11'b1xx00000100;
            7'b1100011 : controls = 11'b01000001010;
            7'b0010011 : controls = 11'b10010000100;
            7'b1101111 : controls = 11'b11100100001;
            default:     controls = 11'bxxxxxxxxxxx;
        endcase
    end
endmodule
