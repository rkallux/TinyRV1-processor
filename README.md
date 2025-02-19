# TinyRV1 Processor

**TinyRV1** is a pipelined RISC-V processor designed for educational and experimental purposes. This repository contains the hardware design, simulation scripts, test benches, and related files to implement and evaluate the TinyRV1 processor.

---

## Features

- **RISC-V Compliance**: Implements a subset of the RISC-V instruction set.
- **Pipelined Architecture**: Efficiently executes instructions using a multi-stage pipeline.
- **Modular Design**:
  - ALU (Arithmetic Logic Unit)
  - Control and Datapath
  - Register Files
- **Test Bench Support**: Comprehensive test cases for functionality verification.
- **Simulation-Ready**: Includes scripts for running simulations and generating results.

---

## Repository Structure

- `hw/`: Hardware design files (e.g., Verilog modules for the ALU, pipeline stages, register files, etc.).
- `test/`: Test benches for verifying hardware functionality.
- `sim/`: Simulation scripts and test programs.
- `scripts/`: Helper scripts for running tests and generating dependencies.
- `build/`: Build artifacts (ignored by `.gitignore`).
- `configure` & `Makefile`: Build configuration files.

---

## Getting Started

### Prerequisites

- **Tools**:
  - **Verilator**: An open-source Verilog simulator for compiling and running simulations.
  - **Make**: For build automation.
  - **Python**: For running helper scripts.

### Clone the Repository
```bash
git clone https://github.com/rkallux/TinyRV1-processor.git
cd TinyRV1-processor
