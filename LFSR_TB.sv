`timescale 1ns/100ps
//
module LFSR_TB();
//Parameter declarations
parameter FIBONACCI = 0;
parameter GALOIS = 1;
parameter LENGTH = 8;                                   //Word width
parameter EXTENDED = 1;	                                //Include all-zero state
parameter CONVENTIONAL = 0;	                            //Conventional implementation (without the all-zero state)

//parameter TAPS_FIBONACCI = 16'b0110100000000001;      //[0][1][2]----[15]. Use for 16-bit LFSR
parameter TAPS_FIBONACCI = 8'b01110001;                 //[0][1][2]----[7]. Use fir 8-bit LFSR

//parameter TAPS_GALOIS =    16'b0110100000000000;      //[0][1][2]----[15]. Use for 16-bit LFSR
parameter TAPS_GALOIS =    8'b01110000;                 //[0][1][2]----[7]. Use for 8-bit LFSR

parameter CLK_PERIOD = 20;


//Internal signals declarations
logic clk;                                             //LFSR clock
logic rst;                                             //Active high logic
logic [0:LENGTH-1] data;                               //Output of the LFSR module
logic enable;                                          //LFSR enable signal
logic previous_msb;

//LFSR instantiation
LFSR #(.LENGTH(LENGTH), .TAPS(TAPS_FIBONACCI), .TYPE(FIBONACCI), .EXTEND(CONVENTIONAL)) U1(
                .clk(clk),
				.enable(enable),
                .rst(rst),
                .seed(8'd1),
				.data(data),
				.previous_msb(previous_msb)
                );

//Initial blocks
initial
begin
    rst=1'b0;
    clk=1'b0;
	enable=1'b0;
    @(posedge clk);
    rst=1'b1;
	repeat (50)
	@(posedge clk);
	enable=1'b1; 
	repeat (100000)
    @(posedge clk);
	$finish;
end

//Clock generation (50MHz)
always
begin
#(CLK_PERIOD/2);
clk=~clk;
end


endmodule
