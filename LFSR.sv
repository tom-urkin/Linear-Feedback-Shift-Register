//Fibonacci Linear Feedback Shift Register (LFSR)

module LFSR(rst,clk,seed,data);

//Parameter declerations
parameter TYPE = 1;                                     //LFSR type: 0 for Fibonacci and 1 for Galois
parameter LENGTH=16;                                    //LFSR structure: [0][1][2]--->[LENGTH]
//parameter TAPS=16'b0110100000000001;                  //TAP locations. Deafutls is the polynomial for maximal 16-bit LFSR 
parameter TAPS=16'b0110100000000000; 						  //TAP locations for Galios
//Inputs
input logic rst;                                        //Active high logic
input logic clk;                                        //Input clock
input logic [0:LENGTH-1] seed;                          //Input seed - the initial state of the LFSR
integer k;
//Outputs
output logic [0:LENGTH-1] data;                         //This is the output word

//Internal signals
logic feedback_bit;                                     //Input to the leftmost flip-flop
logic [0:LENGTH-1] data_tmp;

//HDL code
generate
	if (TYPE==0)        			                            //Fibonacci LFSR
	begin
		//Shift register
		always @(posedge clk or negedge rst)
			if (!rst)
					data<=seed;
			else
					data<={feedback_bit,data[0:LENGTH-2]};

		//Calculating the feedback bit
		assign feedback_bit = ^(TAPS&data);
	end
else                                                   //Galois LFSR
	begin
	
	assign data_tmp=(TAPS&{LENGTH{data[LENGTH-1]}})^(data);
	
	always @(posedge clk or negedge rst)
		if (!rst)
			data<=seed;
		else
			data<={data_tmp[15],data_tmp[0:14]};
	end
endgenerate

endmodule 

