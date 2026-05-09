module mainfsm(
    input logic clk, rst_n,
    input logic [6:0] op,
    output logic branch,pcupdate,regwrite,memwrite,irwrite,
    output logic [1:0] resultsrc,alusrcB,alusrcA,
    output logic adrsrc,
    output logic [1:0] aluop
);
    logic [13:0] ctrlfsm;
    assign {branch,pcupdate,regwrite,memwrite,irwrite,resultsrc,alusrcB,alusrcA,adrsrc,aluop} = ctrlfsm;
    typedef enum logic [10:0] {
    FETCH =         11'b0000000000,
    DECODE =        11'b0000000001,
    MEMADR =        11'b0000000010,
    MEMREAD =       11'b0000000100,
    MEMWB =         11'b0000001000, 
    MEMWRITE =      11'b0000010000,
    EXECUTER =      11'b0000100000,
    ALUWB =         11'b0001000000,
    EXECUTERI =     11'b0010000000,
    JALR =          11'b0100000000,
    BEQ =           11'b1000000001
}   state_t;
    state_t state, next_state;
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) state <= FETCH;
        else state <= next_state;
    end
    always_comb begin 
        case(state)
            FETCH : begin 
                next_state = DECODE;
                ctrlfsm = 14'b01001101000000;
            end
            DECODE : begin
                case (op)
                    7'b0000011, 7'b0100011: next_state = MEMADR;
                    7'b0110011: next_state = EXECUTER;
                    7'b0010011: next_state = EXECUTERI;
                    7'b1101111: next_state = JALR;
                    7'b1100011: next_state = BEQ;
                    default: next_state = FETCH;
                endcase
                ctrlfsm = 14'b00000000101000;
            end
            MEMADR : begin
                if (op == 7'b0000011) next_state = MEMREAD;
                else if (op == 7'b0100011) next_state = MEMWRITE;
                else next_state = FETCH;
                ctrlfsm = 14'b00000000110000;
            end
            MEMREAD : begin
                next_state = MEMWB;
                ctrlfsm = 14'b00000000000100;
            end
            MEMWB : begin
                next_state = FETCH;
                ctrlfsm = 14'b00100010000000;
            end
            MEMWRITE : begin
                next_state = FETCH;
                ctrlfsm = 14'b00010000000100;
            end
            EXECUTER : begin
                next_state = ALUWB;
                ctrlfsm = 14'b00000000010010;
            end
            ALUWB : begin
                next_state = FETCH;
                ctrlfsm = 14'b00100000000000;
            end
            EXECUTERI : begin
                next_state = ALUWB;
                ctrlfsm = 14'b00000000110010;
            end
            JALR : begin
                next_state = ALUWB;
                ctrlfsm = 14'b01000001001000;
            end
            BEQ : begin
                next_state = FETCH;
                ctrlfsm = 14'b10000000010001;
            end
        endcase
    end
endmodule