# Approximate Logic & Arithmetic Library (AxC)

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)
![Simulator](https://img.shields.io/badge/Simulator-Icarus%20Verilog-green)
![Waveform](https://img.shields.io/badge/Waveform-GTKWave-orange)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

## 📌 Project Overview

This repository provides a hardware description and functional validation library of **Approximate Computing (AxC)** combinational primitives written in **Verilog HDL**. The primary objective is to investigate the hardware trade-offs (e.g., transistor count reduction, power savings) against controlled accuracy degradation in software applications[cite: 1, 4].

The project was evaluated within a **WSL (Windows Subsystem for Linux)** environment utilizing **Icarus Verilog (`iverilog`)** for simulation and **GTKWave** for waveform and temporal analysis[cite: 1, 4].

---

## 🏗️ Implemented Architectures

### 1. Data Selector: Hybrid 2:1 MUX (8-bit)
- **3 LSBs (Bits 0 to 2):** Implemented using the **`mux2to1_approx`** cell, simplifying the control logic by eliminating the inverted select signal ($\sim S$) to reduce inverter count.
- **5 MSBs (Bits 3 to 7):** Implemented using the exact **`mux2to1_exact`** cell to preserve critical higher-order bits.

### 2. Arithmetic Unit: Hybrid Ripple Carry Adder - RCA (8-bit)
- **3 LSBs (Bits 0 to 2):** Implemented using approximate **`fa_axa2`** cells. These eliminate multi-level XOR gates and force the sum output to $0$ when a single input bit is active.
- **5 MSBs (Bits 3 to 7):** Implemented using exact **`fa_exact`** (1-bit Full Adder) cells to confine noise within lower-order magnitude boundaries.

---

## 📊 Error Evaluation Metrics & Results

Dedicated Verilog testbenches were built to extract classical quality evaluation metrics from AxC literature:
* **Error Rate (ER):** The percentage frequency of incorrect output occurrences ($ER = \frac{N_{errors}}{N_{total}} \times 100$).
* **Mean Error Distance (MED):** The average arithmetic distance between exact and approximate results ($ED = \vert{}S_{exact} - S_{approx}\vert{}$).

### Simulation Performance Summary

| Module | Approx. LSBs | Simulated Vectors | Error Rate (ER) | Mean Error Distance (MED) |
| :--- | :---: | :---: | :---: | :---: |
| **Hybrid 2:1 MUX (8-bit)** | 3 LSBs (AxMUX) | 100 | ~43.75% | N/A (Data Selector) |
| **Hybrid RCA Adder (8-bit)** | 3 LSBs (AXA2) | 100 | 100.00% | **2.4800** |

> **Result Analysis:** Although the hybrid adder exhibits a high Error Rate due to the aggressive logic gate reduction in AXA2 cells, the **MED of only 2.4800** confirms that numerical noise is tightly bounded within the least significant bits. This makes the architecture suitable for noise-tolerant workloads such as signal processing, image filtering, and Edge AI/TinyML workloads.

