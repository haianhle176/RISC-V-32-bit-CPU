# RISC-V 32-bit CPU Implementation (RV32I)

This repository contains a from-scratch implementation of a **32-bit RISC-V CPU** using **SystemVerilog**. The project demonstrates the evolution of processor architecture, featuring both foundational and advanced design approaches.

## 🚀 Architectures Supported

I have implemented two distinct versions of the RISC-V core:

1.  **Multi-cycle (Main Branch):** Optimized for hardware efficiency by breaking instruction execution into multiple clock cycles (Fetch, Decode, Execute, Memory, Write-back). This version utilizes a Finite State Machine (FSM) for control logic.
2.  **Single-cycle (Single-cycle Branch):** A foundational design where every instruction executes in exactly one clock cycle. Ideal for understanding the basic datapath and control signals.

## 🛠 Technical Specifications

- **Instruction Set:** RV32I (Base Integer Instruction Set).
- **Language:** SystemVerilog.
- **Key Modules:** 
    - **ALU:** Handles arithmetic and logical operations.
    - **Register File:** 32x32-bit registers with dual-read and single-write ports.
    - **Control Unit:** Custom FSM-based decoder for multi-cycle orchestration.
    - **Memory Interface:** Unified/Split memory support for instructions and data.

## 💻 Simulation & Verification

The design has been verified using **Icarus Verilog** and visualized via **GTKWave**.

### Prerequisites
- [Icarus Verilog](http://iverilog.icarus.com/)
- [GTKWave](http://gtkwave.sourceforge.net/)

### How to Run
The simulation process is automated via a **Makefile**. To compile the source files and run the testbench, execute:

```bash
make       # To compile and run
make clean # To clean artifacts
```
## 📂 Project Structure

- **rtl/**: Core SystemVerilog source files.
   - **controller/**: FSM, Instruction/ALU decoders.
   - **datapath/**: ALU, RegFile, Muxes, SignExt, etc.
   - `cpu.sv`: The RISC-V CPU Core module.
   - `top.sv`: **Top-level module** .
- **sim/**: Simulation files.
   - `tb_top.sv`: Main SystemVerilog testbench.
   - `memfile.dat`: Memory image for simulation (Hex format).
- `Makefile`: Automated build script for Icarus Verilog.
- `.gitignore`: Configured to exclude simulation artifacts.
