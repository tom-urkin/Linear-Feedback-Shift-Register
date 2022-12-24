`timescale 1ns/100ps
//
module LFSR_TB();
//Parameter declarations
parameter CLK_PERIOD = 20;
parameter LENGTH = 16;                        //Word width
parameter TAPS_FIBONACCI = 16'b0110100000000001;		  //[0][1][2]----[15]
parameter TAPS_GALOIS = 16'b0110100000000000;		  //[0][1][2]----[15]
parameter FIBONACCI = 0;
parameter GALOIS = 1;
//Internal signals declarations
logic clk;
logic rst;
logic [0:LENGTH-1] data;
//integer k;

//Fibonacci LFSR instantiation
LFSR #(.LENGTH(LENGTH), .TAPS(TAPS_GALOIS), .TYPE(GALOIS)) U1(
                .clk(clk),
                .rst(rst),
                .seed(16'd1),
				.data(data)
                );

//Initial blocks
initial
begin
    rst=1'b0;
    clk=1'b0;
    @(posedge clk);
    rst=1'b1;

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
