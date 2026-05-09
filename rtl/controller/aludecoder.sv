module aludecoder(
    input logic op5,
    input logic [1:0] aluop,
    input logic [2:0] funct3,
    input logic funct7_5,
    output logic [2:0] alucontrol
);
    logic cont;
    assign cont = funct7_5 & op5;
    always_comb begin 
        case (aluop)
            2'b00 : alucontrol = 3'b000;
            2'b01 : alucontrol = 3'b001;
            default: case (funct3)
                3'b000: alucontrol = cont ? 3'b001 : 3'b000;
                3'b010: alucontrol = 3'b101;
                3'b110: alucontrol = 3'b011;
                3'b111: alucontrol = 3'b010;
                default: alucontrol = 3'bxxx;
            endcase
        endcase
    end
endmodule
