//Fibonacci ('many-to-one')/Galois ('one-to-many') Linear Feedback Shift Registers (LFSR)

module LFSR(rst,clk,seed,data);

//Parameter declerations
parameter TYPE = 0;                                     //LFSR type: 0 for Fibonacci and 1 for Galois. Deafault is Fibonacci LFSR.
parameter LENGTH=16;                                    //LFSR structure: [0][1][2]--->[LENGTH]
parameter TAPS=16'b0110100000000001;                    //TAP locations. Deafutls is the polynomial for maximal 16-bit Fibonacci LFSR 
//Inputs
input logic rst;                                        //Active high logic
input logic clk;                                        //Input clock
input logic [0:LENGTH-1] seed;                          //Input seed - the initial state of the LFSR
integer k;
//Outputs
output logic [0:LENGTH-1] data;                         //Output word

//Internal signals
logic feedback_bit;                                     //Input to the leftmost flip-flop (Fibonacci LFSR)
logic [0:LENGTH-1] data_tmp;									  //Right-most bit XORed with the data vector as a function of tap locations (Galois LFSR)

//HDL code
generate
	if (TYPE==0)        			                           //Instantiate a Fibonacci LFSR
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
else                                                	   //Instantiate a Galois LFSR
	begin
	
		assign data_tmp=(TAPS&{LENGTH{data[LENGTH-1]}})^(data);
	
		//Shift register
		always @(posedge clk or negedge rst)
			if (!rst)
				data<=seed;
			else
				data<={data_tmp[LENGTH-1],data_tmp[0:LENGTH-2]};
	end
endgenerate

endmodule 

