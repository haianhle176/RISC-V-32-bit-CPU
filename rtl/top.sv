module top (
    input clk,rst_n,
    output logic memwrite,
    output logic [31:0] dataadr,writedata
);
    logic [31:0] pc,instr,readdata;
    cpu cpu (clk,rst_n,pc,instr,memwrite,dataadr,writedata,readdata);
    imem imem (pc,instr);
    dmem dmem (clk,memwrite,dataadr,writedata,readdata);
endmodule