module controller(
    input logic clk, rst_n,
    input logic zero,
    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic funct7_5,
    output logic pcwrite,regwrite,memwrite,irwrite,
    output logic [1:0] resultsrc,alusrcB,alusrcA,
    output logic adrsrc,
    output logic [2:0] alucontrol,
    output logic [1:0] immsrc
);
    logic branch,pcupdate;
    logic [1:0] aluop;
    mainfsm fsm(.clk(clk),.rst_n(rst_n),.op(op),.branch(branch),.pcupdate(pcupdate),.regwrite(regwrite),.memwrite(memwrite),.irwrite(irwrite),.resultsrc(resultsrc),.alusrcB(alusrcB),.alusrcA(alusrcA),.adrsrc(adrsrc),.aluop(aluop));
    aludecoder aludec(.op5(op[5]),.aluop(aluop),.funct3(funct3),.funct7_5(funct7_5),.alucontrol(alucontrol));
    instrdecoder id(.op(op),.immsrc(immsrc));
    assign pcwrite = pcupdate | (branch & zero);
endmodule