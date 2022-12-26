//Fibonacci ('many-to-one')/Galois ('one-to-many') Linear Feedback Shift Registers (LFSR)

module LFSR(rst,clk,enable,seed,data);

//Parameter declerations
parameter TYPE = 0;                                            //LFSR type: 0 for Fibonacci and 1 for Galois. Deafault is Fibonacci LFSR.
parameter EXTEND = 0;                                          //EXTEND Fibonacci LFSR to cycle through 2^LENGTH states (the all '0' state is included)
parameter LENGTH=16;                                           //LFSR structure: [0][1][2]--->[LENGTH]
parameter TAPS=16'b0110100000000001;                           //TAP locations. Deafutls is the polynomial for maximal 16-bit Fibonacci LFSR 
//Inputs
input logic rst;                                               //Active high logic
input logic clk;                                               //Input clock
input logic [0:LENGTH-1] seed;                                 //Input seed - the initial state of the LFSR
input logic enable;											   //Active high logic
integer k;
//Outputs
output logic [0:LENGTH-1] data;                                //Output word

//Internal signals
logic feedback_bit;                                            //Input to the leftmost flip-flop (Fibonacci LFSR)
logic [0:LENGTH-1] data_tmp;                                   //Right-most bit XORed with the data vector as a function of tap locations (Galois LFSR)

//HDL code
generate
	if (TYPE==0)        			                           //Instantiate a Fibonacci LFSR
	if (EXTEND==0)                                             //Cycle through 2^LENGTH-1 states
	begin
		//Shift register
		always @(posedge clk or negedge rst)
			if (!rst)
					data<=seed;
			else if (enable)
					data<={feedback_bit,data[0:LENGTH-2]};

		//Calculating the feedback bit
		assign feedback_bit = ^(TAPS&data);
	end
	else
	begin
		//Shift register
		always @(posedge clk or negedge rst)
			if (!rst)
					data<=seed;
			else if (enable)
					data<={feedback_bit,data[0:LENGTH-2]};

		//Calculating the feedback bit
		assign feedback_bit = ^({TAPS&data,~(|data[0:LENGTH-2])});         //Adding the all '0' state is carried by XORing the feedback bit and the NOR of data[0:LENGTH-2]
	end	
else                                                                      //Instantiate a Galois LFSR
	begin
	
		assign data_tmp=(TAPS&{LENGTH{data[LENGTH-1]}})^(data);
	
		//Shift register
		always @(posedge clk or negedge rst)
			if (!rst)
				data<=seed;
			else if (enable)
				data<={data_tmp[LENGTH-1],data_tmp[0:LENGTH-2]};
	end
endgenerate

endmodule 

