module datapath (
    input logic clk,rst_n,
    input logic pcwrite,adrsrc,irwrite,regwrite,
    input logic [1:0] immsrc,alusrcA,alusrcB,resultsrc,
    input logic [2:0] alucontrol,
    input logic [31:0] instr_t,
    output logic [31:0] instr,
    output logic [31:0] adr,writedata,
    output logic zero
);
    logic [31:0] pc,oldpc,rd1_t,rd2_t,rd1,rd2,srca,srcb,aluresult,aluout,data,immext,result;
    //FETCH stage
    dff oldpcff(.clk(clk),.rst_n(rst_n),.en(irwrite),.d(pc),.q(oldpc));
    dff IRff(.clk(clk),.rst_n(rst_n),.en(irwrite),.d(instr_t),.q(instr));
    dff dataff(.clk(clk),.rst_n(rst_n),.en(1'b1),.d(instr_t),.q(data));
    //DECODE stage
    regfile rf(.clk(clk),.rst_n(rst_n),.we3(regwrite),.a1(instr[19:15]),.a2(instr[24:20]),.a3(instr[11:7]),.wd3(result),.rd1(rd1_t),.rd2(rd2_t));
    dff rd1ff(.clk(clk),.rst_n(rst_n),.en(1'b1),.d(rd1_t),.q(rd1));
    dff rd2ff(.clk(clk),.rst_n(rst_n),.en(1'b1),.d(rd2_t),.q(rd2));
    //EXECUTE stage
    alu alu(.a(srca),.b(srcb),.alucontrol(alucontrol),.aluresult(aluresult),.zero(zero));
    dff aluoutff(.clk(clk),.rst_n(rst_n),.en(1'b1),.d(aluresult),.q(aluout));
    //Sign extension
    signext se(.a(instr[31:7]),.s(immsrc),.y(immext));
    //MUX
    mux2#(32) adrsrcmux(.d0(pc),.d1(result),.s(adrsrc),.y(adr));
    mux3#(32) alusrcAmux(.d0(pc),.d1(oldpc),.d2(rd1),.s(alusrcA),.y(srca));
    mux3#(32) alusrcBmux(.d0(rd2),.d1(immext),.d2(32'd4),.s(alusrcB),.y(srcb));
    mux3#(32) resultsrcmux(.d0(aluout),.d1(data),.d2(aluresult),.s(resultsrc),.y(result));
    //pcff
    dff pcreg(.clk(clk),.rst_n(rst_n),.en(pcwrite),.d(result),.q(pc));
    //memory write
    assign writedata = rd2;
endmodule