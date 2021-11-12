# FPGA-CoProcessor

The main idea is to implement a tensor coprocessor (accelerator) on an FPGA. The project is quite extensive and it is not a fact that we will have time to fully implement it in such a short time. For this reason, we expect to present a partial implementation that performs the basic mathematical functionality. To briefly explain the principle of operation, we transmit a data package (numbers (tensors) and instructions on them), and the FPGA transmits the result of calculations.

For now, our main tasks are as follows:
1) Implement data exchange between FPGA and PC.
2) Create software (for PC) to transfer data to the FPGA.
3) Implement basic mathematical operations on prime numbers in the FPGA itself (in the future on tensors).
4) Create our own set of executable instructions within the data exchange protocol.

The main goal of the project is research rather than commercial application. Nevertheless, in the future, this project can be used as a small and fairly effective hardware accelerator for computing in machine learning systems.
