//Fibonacci Linear Feedback Shift Register (LFSR)

module Fibonacci_LFSR(rst,clk,seed,data);

//Parameter declerations
parameter LENGTH=16; 								//LFSR length
parameter TAPS=53256;								//TAP locations not including the XOR operation with the right-most bit. Deafutls is the polynomial for maximal 16-bit LFSR 

//Inputs
input logic rst;                            //Active high logic
input logic clk;                            //Input clock
input logic [LENGTH-1:0] seed;              //Input seed - the initial state of the LFSR
integer k;
//Outputs
output logic [LENGTH-1:0] data;             //This is the output word

//Internal signals
logic feedback_bit;                         //Input to the leftmost flip-flop
//HDL code

//Shift register
always @(posedge clk or negedge rst)
    if (!rst)
        data<=seed;
    else
        data<={feedback_bit,data[LENGTH-1:1]};

//Calculating the feedback bit
assign feedback_bit = ^{(TAPS[LENGTH-1:0]&data),data[0]};

endmodule 