# MAFA-Bio-Inspired-Physics-Driven-Activation-Layers-for-Stateful-In-Memory-Computing
# MAFA Non-Linear Activation Function & Hysteresis Simulation

A high-fidelity MATLAB simulation that tracks and visualizes the non-linear, dynamic state response of the Proposed MAFA operator compared against classical activation functions (Tanh and Sigmoid) under alternating excitation fields.

---

## 🛠️ Key Features

* Transient Dissipation: Simulates multiple cycles automatically to filter out initialization noise and capture steady-state dynamics.
* Dual-Panel Infographic Dashboard:
  * Left Panel: Plots the real-time continuous sinusoidal input stimulus profile.
  * Right Panel: Maps out the multi-valued functional geometry space (hysteretic loops).
* Live Vector Tracking: Employs dynamic mathematical arrows (\rightarrow, \leftarrow) to log trace orientation vectors in real time.
* Production Video Export: Compiles frames directly into a seamless 60 FPS presentation-ready Motion JPEG AVI file.

---

## 📐 Mathematical Underpinnings (The MAFA Model)

The script computes the state transition kinetics iteratively using a generalized thermodynamic polynomial expansion driving force:

Thermodynamic Force = E_t - (alpha1 * P) - (alpha11 * P^3) - (alpha111 * P^5)
State Evolution:     P_next = P_state + kappa * Thermodynamic Force

Where the multi-stability profiles are shaped by high-order saturation thresholds governed by the physical constraints where state bounds are strictly locked between [-1.0, 1.0].

---

## 📦 Requirements

* MATLAB (R2018a or newer).
* Standard graphics renderer (No extra toolboxes needed).

---

## 🚀 Quick Start

1. Create a new file in your separate repository named `MAFA_Visualization.m`.
2. Paste the provided MATLAB code inside it.
3. Run the script directly from your MATLAB Command Window.
4. Locate your output video file titled `MAFA_HighEnd_Visualization.avi` inside your active project working directory.
