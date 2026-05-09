module tb_top();
    logic clk;
    logic rst_n;
    logic [31:0] writedata, dataadr;
    logic memwrite;
// instantiate device to be tested
    top dut (clk, rst_n, memwrite, dataadr, writedata);
// initialize test
    initial begin
        rst_n <= 0; # 22; rst_n <= 1;
    end
// generate clock to sequence tests
    always begin
        clk <= 1; # 5; clk <= 0; # 5;
    end
// check results
    always @(negedge clk) begin
        if (memwrite) begin
            if (dataadr === 100 & writedata === 25) begin
                $display("Simulation succeeded");
                $stop;
            end 
        else if (dataadr !== 96) begin
                $display("Simulation failed");
                $stop;
            end
        end
    end
endmodule
