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

### ADDITIONAL

- [ ] Async FIFO (Gray code + CDC)
- [ ] FIFO + coverage + assertions
- [ ] Skid buffer / elastic buffer
- [ ] Fully pipelined register file

## Planned Modules

- [ ] async_fifo (gray code + CDC)
- [ ] axi_stream_fifo
- [ ] fsm_controller (parametric)
- [ ] bus_arbiter (round-robin / priority)
- [ ] instruction_decoder (RISC-V lite) **--(DONE)--**
- [ ] pipeline_register (stall / flush)
- [ ] skid_buffer
- [ ] barrel_shifter
- [ ] iterative_multiplier **--(DONE)--**
    - [ ] signed Booth version
- [ ] uart_tx_rx
- [ ] timer_interrupt
- [ ] self_checking_testbench

## Reusable Parametric Building Blocks

- [ ] register_slice (valid/ready)
- [ ] elastic_buffer
- [ ] skid_buffer
- [ ] transaction_counter
- [ ] fsm_timeout_watchdog
- [ ] event_flag_latch
- [ ] onehot_to_binary ++
- [ ] priority_encoder
- [ ] comparator ++
- [ ] saturating_adder
- [ ] popcount
- [ ] reset_synchronizer
- [ ] pulse_synchronizer
- [ ] write_mask_generator
- [ ] address_aligner ++
- [ ] read_data_formatter
- [ ] parity_checker
- [ ] crc_generator
- [ ] illegal_state_detector
- [ ] cycle_counter
- [ ] trace_trigger
- [ ] sticky_error_reg

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

##  Testbench and Simulation

### Learn and Use
- [ ] Assertion

---
