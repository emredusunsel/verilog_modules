# verilog_modules
any module written with verilog that might help

LINT ERROR CHECK
-   write to terminal: wsl verilator --lint-only --Wall /mnt/d/Verilog/verilog_modules/.../.sv
-   or CTRL+SHIFT+B => Lint Verilog with Verilator (WSL)
    - for it to work, the path should be inserted in .vscode/task.json


# Verilog Modules – TODO List

This repository contains standalone, reusable Verilog HDL modules.
Each module is designed to be **parameterizable**, **well-tested**, and **production-oriented**.

---

## 🟢 Basic Modules

### ⬜ Parametric ALU
- [ ] Support ADD, SUB, AND, OR, XOR, SLT operations
- [ ] Parameterized data width (default: 32-bit)
- [ ] Zero, Carry, Overflow flags
- [ ] Signed & unsigned operation support
- [ ] Self-checking testbench with random vectors

---

### ⬜ Register File (RISC-style)
- [ ] 32 registers, parameterized width
- [ ] 2 read ports, 1 write port
- [ ] Synchronous write, combinational read
- [ ] Register x0 hardwired to zero
- [ ] Reset behavior clearly defined
- [ ] Testbench validating read/write hazards

---

### ⬜ UART Transmitter & Receiver
- [ ] Configurable baud rate generator
- [ ] UART TX module
- [ ] UART RX module
- [ ] Start bit, 8 data bits, stop bit framing
- [ ] Loopback simulation testbench
- [ ] Noise-free sampling logic

---

## 🟡 Intermediate Modules

### ⬜ Finite State Machine – Vending Machine
- [ ] Moore / Mealy FSM implementation
- [ ] Coin input handling
- [ ] Product selection logic
- [ ] Change calculation
- [ ] FSM state diagram added to README
- [ ] Testbench covering edge cases

---

### ⬜ SPI Master Controller
- [ ] Support CPOL / CPHA modes
- [ ] Configurable clock divider
- [ ] MOSI, MISO, SCLK, CS signals
- [ ] FSM-based transfer control
- [ ] Dummy SPI slave model for verification

---

### ⬜ FIFO Buffer
- [ ] Parameterized depth and data width
- [ ] Synchronous FIFO implementation
- [ ] Full / Empty flag logic
- [ ] Asynchronous FIFO version
- [ ] Gray code pointer synchronization
- [ ] Stress-tested with random push/pop

---

## 🔴 Advanced Modules

### ⬜ Mini RISC-V CPU (5-Stage Pipeline)
- [ ] IF, ID, EX, MEM, WB pipeline stages
- [ ] Instruction fetch & decode logic
- [ ] Arithmetic and memory instructions
- [ ] Hazard detection unit
- [ ] Data forwarding logic
- [ ] Minimal instruction set (ADD, SUB, LW, SW, BEQ)
- [ ] Program execution testbench

---

### ⬜ AXI4-Lite Slave Interface
- [ ] Read address channel implementation
- [ ] Write address & data channels
- [ ] Ready/Valid handshake compliance
- [ ] Register-mapped address space
- [ ] Protocol-compliant FSMs
- [ ] AXI-lite master testbench

---

### ⬜ SDRAM Controller
- [ ] Initialization sequence
- [ ] Refresh cycle handling
- [ ] Read / Write command FSM
- [ ] Timing parameter configuration
- [ ] Behavioral SDRAM model for simulation

---

## 🧪 Verification & Infrastructure

### ⬜ Common Testbench Framework
- [ ] Clock & reset generator
- [ ] Random stimulus generation
- [ ] Self-checking assertions
- [ ] Error counters and logs
- [ ] Clear pass/fail simulation output

---

## 📌 Notes
- All modules must be synthesizable
- Blocking vs non-blocking assignments used correctly
- Each module documented with timing diagrams when applicable
- Simulation tested using Icarus Verilog / Verilator

---
