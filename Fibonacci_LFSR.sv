//Fibonacci Linear Feedback Shift Register (LFSR)

module Fibinacci_LFSR(rst,clk,seed,taps);

//Parameter declerations
LENGTH=16; 

//Inputs
input logic rst;                            //Active high logic
input logic clk;                            //Input clock
input logic [LENGTH-1:0] seed;              //Input seed - the initial state of the LFSR
input logic [LENGTH-1:0] taps;              //Taps locations represented by a binary word of width LENGTH

//Outputs
output logic [LENGTH-1:0] data;            //This is the output word

//Internal signals
logic feedback_bit;                         //Input to the leftmost flip-flop
//HDL code

//Shift register
always @(posedge clk or negedge rst)
    if (!rst)
        data<=seed;
    else
        data<={feedback_bit,data[LENGTH-1:1]}

//Calculating the feedback bit
assign feedback_bit = ^(taps&data);

endmodule 