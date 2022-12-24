//Fibonacci Linear Feedback Shift Register (LFSR)

module LFSR(rst,clk,seed,data);

//Parameter declerations
parameter TYPE = 0;                                     //LFSR type: 0 for Fibonacci and 1 for Galois
parameter LENGTH=16;                                    //LFSR structure: [0][1][2]--->[LENGTH]
parameter TAPS=16'b011010000000001;                     //TAP locations. Deafutls is the polynomial for maximal 16-bit LFSR 

//Inputs
input logic rst;                                        //Active high logic
input logic clk;                                        //Input clock
input logic [0:LENGTH-1] seed;                          //Input seed - the initial state of the LFSR
integer k;
//Outputs
output logic [0:LENGTH-1] data;                         //This is the output word

//Internal signals
logic feedback_bit;                                     //Input to the leftmost flip-flop

//Conditional compilation
`define LFSR_Arch = TYPE;                               //Defining 
//HDL code

`ifdef (LFSR_Arch==0)                                   //Fibonacci LFSR
begin
    //Shift register
    always @(posedge clk or negedge rst)
        if (!rst)
            data<=seed;
        else
            data<={feedback_bit,data[1:LENGTH-1]};

    //Calculating the feedback bit
    assign feedback_bit = ^(TAPS&data);
end
`else                                                   //Galois LFSR
begin
    assign data = 16'd15;
end
endmodule 

