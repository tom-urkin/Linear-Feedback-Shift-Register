# Linear Feedback Shift Register (LFSR)

> SystemVerilog LFSR module   

Implementention in SystemVerilog of __Fibonacci and Galois LFSR__.  

## Get Started

The source files  are located at the repository root:

- [Linear Feedback Shift Register (LFSR)](./LFSR.sv)
- [Linear Feedback Shift Register (LFSR) TB](./LFSR_TB.sv)

## LFSR Architecture
Modify the 'TYPE' parameter to select LFSR architecture type:
-Fibonacci LFSR ('many-to-one') : TYPE = 0.
-Galois LFSR ('one-to-many') : TYPE = 1.

## Testbench

The testbench comprises two maximum length LFSR cases (8-bit and 16-bit). The seed in both cases is 'd1. The seed value and the tap locations can be changed via the parameters in the TB file. 
The LFSR output words are written to a text file and plotted as a dynamic histogram to visualize the LFSR operation.

1.	Maximum-length 8-bit Fibonacci LFSR  

		![QuestaSim terminal window](./docs/8_bit_Fibonacci.gif) 

2.	Maximum-length 8-bit Galois LFSR  

		![QuestaSim terminal window](./docs/8_bit_Galois.gif) 

## Support

I will be happy to answer any questions.  
Approach me here using GitHub Issues or at tom.urkin@gmail.com