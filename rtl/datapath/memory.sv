module memory(
    input logic clk,
    input logic [31:0] adr,writedata,
    input logic memwrite,
    output logic [31:0] dataout
);
    logic [31:0] mem [0:255]; 
    always_ff @(posedge clk) begin
      if (memwrite) mem[adr[9:2]] <= writedata;
    end
    initial begin
        $readmemh("sim/memfile.dat",mem);
    end
    assign dataout = mem[adr[9:2]];
endmodule
