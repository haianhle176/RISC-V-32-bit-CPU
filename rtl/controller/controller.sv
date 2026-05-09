module controller(
    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic funct7,
    input logic zero,
    output logic pcsrc,memwrite,alusrc,regwrite,
    output logic  [1:0] resultsrc,immsrc,
    output logic [2:0] alucontrol
);
    logic [1:0] aluop;
    logic branch,jump,jbranch;
    logic tzero,nzero;
    maindecoder mdc (.op(op),.memwrite(memwrite),.branch(branch),.alusrc(alusrc),.regwrite(regwrite),.resultsrc(resultsrc),.immsrc(immsrc),.jump(jump),.aluop(aluop));
    aludecoder adc (.funct3(funct3),.funct7(funct7),.op5(op[5]),.aluop(aluop),.alucontrol(alucontrol));
    branchdecoder bdc(funct3,tzero,nzero);
    assign jbranch = (tzero & zero) | (nzero & ~zero) ;
    assign pcsrc = (jbranch&branch)|jump;
endmodule 