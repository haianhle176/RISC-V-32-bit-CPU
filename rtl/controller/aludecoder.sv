module aludecoder(
    input logic [2:0] funct3,
    input logic funct7,op5,
    input logic [1:0] aluop,
    output logic [2:0] alucontrol
);
    logic cont;
    assign cont = funct7&op5;
    always_comb begin 
        case (aluop)
            2'b00 : alucontrol = 3'b000;//add
            2'b01 : alucontrol = funct3[2] ? 3'b100 : 3'b001;//sub 
            default: case (funct3)
                3'b000: alucontrol = cont ? 3'b001 : 3'b000;
                3'b001: alucontrol = 3'b101;
                3'b010: alucontrol = 3'b100;
                3'b101: alucontrol = funct7 ? 3'b111 : 3'b110 ;
                3'b110: alucontrol = 3'b011;
                3'b111: alucontrol = 3'b010;
                default: alucontrol = 3'bxxx;
            endcase
        endcase
    end
endmodule
