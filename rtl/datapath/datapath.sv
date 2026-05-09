module datapath(
    input logic clk,rst_n,
    input logic regwrite,alusrc,pcsrc,
    input logic [2:0] alucontrol,
    input logic [1:0] immsrc,resultsrc,
    input logic [31:0] instr,readdata,
    output logic [31:0] aluresult,writedata,pc,
    output logic zero
);
    logic [31:0] pcnext,pcplus4,pctarget;
    logic [31:0] immext;
    logic [31:0] srca, srcb;
    logic [31:0] result;
    //nextpc logic 
    dff #(32)fl1 (clk,rst_n,1'b1,pcnext,pc);
    adder ad1 (pc,32'b100,pcplus4);
    adder ad2 (pc,immext,pctarget);
    mux2 #(32) pcbrmux(pcplus4,pctarget,pcsrc,pcnext);
    //register file logic
    regfile rf(clk,regwrite,instr[19:15],instr[24:20],instr[11:7],result,srca,writedata);
    signext se(instr[31:7],immsrc,immext);
    //alu logic 
    mux2 #(32) srcbmux (writedata,immext,alusrc,srcb);
    alu  alu(srca,srcb,alucontrol,aluresult,zero);
    mux3 #(32) resmux(aluresult,readdata,pcplus4,resultsrc,result);
endmodule
