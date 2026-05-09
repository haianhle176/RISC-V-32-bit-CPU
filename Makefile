# Source files
RTL = rtl/controller/*.sv rtl/datapath/*.sv rtl/*.sv
TB = sim/tb_top.sv

# Output
OUT = sim_build.vvp
VCD = wave.vcd

all: compile run view

compile:
	iverilog -g2012 -o $(OUT) $(RTL) $(TB)

run:
	vvp $(OUT)

view:
	gtkwave $(VCD)

clean:
	rm -f $(OUT) $(VCD) *.log