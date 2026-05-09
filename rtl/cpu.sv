module cpu(
    input  logic clk, rst_n,
    output logic [31:0] pc,
    input  logic [31:0] instr,
    output logic memwrite,
    output logic [31:0] aluresult, writedata,
    input  logic [31:0] readdata
);
    logic regwrite,alusrc,pcsrc,zero;
    logic [2:0] alucontrol;
    logic [1:0] immsrc,resultsrc;
    controller ctrl (.op(instr[6:0]),.funct3(instr[14:12]),.funct7(instr[30]),.zero(zero),.memwrite(memwrite),.regwrite(regwrite),.pcsrc(pcsrc),.alusrc(alusrc),.resultsrc(resultsrc),.immsrc(immsrc),.alucontrol(alucontrol));
    datapath dat (clk,rst_n,regwrite,alusrc,pcsrc,alucontrol,immsrc,resultsrc,instr,readdata,aluresult,writedata,pc,zero);
endmodule
