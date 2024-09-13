This project focuses on comparing the performance of three digital modulation schemes—OOK (On-Off Keying), BPSK (Binary Phase Shift Keying), and QPSK (Quadrature Phase Shift Keying)—by analyzing their Bit Error Rate (BER) as a function of Signal-to-Noise Ratio (SNR).

1. **Binary Input Data**: A binary signal is generated and processed for each modulation scheme.
2. **Modulation**:
   - **OOK**: The binary signal is transmitted by turning the signal on and off.
   - **BPSK**: Binary bits are mapped to two phases of a signal.
   - **QPSK**: Binary bits are divided into even and odd streams to modulate two orthogonal carriers.
3. **Noise Addition**: AWGN (Additive White Gaussian Noise) is applied to simulate the transmission environment for each modulation scheme.
4. **Detection**: At the receiver, the noisy signal is decoded to recover the transmitted data.
5. **Error Calculation**: The practical BER is computed by comparing the transmitted and received data, and theoretical BER is calculated for comparison.
6. **Plotting**: Multiple graphs are generated to visualize both theoretical and practical BER versus SNR for OOK, BPSK, and QPSK.

