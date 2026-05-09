module cpu(
    input logic clk, rst_n,
    input logic [31:0] instr_t,
    output logic [31:0] adr, writedata,
    output logic memwrite
);
    logic pcwrite,regwrite,irwrite,adrsrc,zero;
    logic [1:0] resultsrc,alusrcB,alusrcA,immsrc;
    logic [2:0] alucontrol;
    logic [31:0] instr;
    controller ctrl(.clk(clk),.rst_n(rst_n),.zero(zero),.op(instr[6:0]),.funct3(instr[14:12]),.funct7_5(instr[30]),.pcwrite(pcwrite),.regwrite(regwrite),.memwrite(memwrite),.irwrite(irwrite),.resultsrc(resultsrc),.alusrcB(alusrcB),.alusrcA(alusrcA),.adrsrc(adrsrc),.alucontrol(alucontrol),.immsrc(immsrc));
    datapath dat(.clk(clk),.rst_n(rst_n),.pcwrite(pcwrite),.adrsrc(adrsrc),.irwrite(irwrite),.regwrite(regwrite),.immsrc(immsrc),.alusrcA(alusrcA),.alusrcB(alusrcB),.resultsrc(resultsrc),.alucontrol(alucontrol),.instr_t(instr_t),.instr(instr),.adr(adr),.writedata(writedata),.zero(zero));
endmodule