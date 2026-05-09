module top(
    input logic clk, rst_n,
    output logic memwrite,
    output logic [31:0] adr, writedata
);
    logic [31:0] instr;
    cpu cpu_inst(.clk(clk),.rst_n(rst_n),.instr_t(instr),.adr(adr),.writedata(writedata),.memwrite(memwrite));
    memory mem(.clk(clk),.adr(adr),.writedata(writedata),.memwrite(memwrite),.dataout(instr));
endmodule