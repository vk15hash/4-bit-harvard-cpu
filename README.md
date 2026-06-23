# Custom 4-Bit Harvard Microprocessor in Verilog HDL

A custom 4-bit microprocessor designed and implemented in Verilog HDL using a modular RTL approach. The processor features a Harvard architecture, a custom control unit, a 74181-inspired ALU, register file, program counter, and instruction memory integrated into a complete working CPU.
## Project Background

This project was developed out of curiosity while exploring digital design and Verilog HDL. At the time of development, I had not formally studied computer architecture. The objective was not to replicate an existing processor, but to understand how individual hardware components such as ALUs, registers, counters, multiplexers, decoders, and control logic could be combined into a functioning computing system.

Building the processor required learning and connecting concepts from digital electronics, switching theory, finite state machines, and RTL design, ultimately resulting in a complete instruction-executing processor.

## Features

* 4-bit datapath
* 16-bit instruction format
* Harvard architecture
* Single-cycle instruction execution
* Custom combinational control unit
* 74181-inspired ALU supporting arithmetic and logic operations
* 4×4 register file with dual read ports
* 8-bit program counter with jump capability
* RTL implementation in Verilog HDL
* Functional verification through simulation

## Key Takeaways

This project provided hands-on exposure to:

* RTL hardware design
* Verilog HDL development
* Datapath and control-path integration
* Instruction decoding
* Processor organization
* Digital system verification through simulation

## Documentation

See [Project Report](./4_bit_cpu.pdf) for:
- Architecture overview
- Instruction format
- RTL implementation
- Simulation results
- Design observations

## Repository Contents

4-bit cpu/         Verilog source files
4_bit_cpu.pdf/      Project report and supporting material


## Note

This project was developed independently as a self-driven exploration of processor design, RTL development, and digital system integration.

