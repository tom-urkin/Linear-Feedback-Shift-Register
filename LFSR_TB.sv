`timescale 1ns/100ps
//
module Fibonacci_LFSR_TB();

//Parameter declarations
parameter CLK_PERIOD = 20;
parameter LENGTH = 16;                        //Word width
parameter TAPS = 53256;
//Internal signals declarations
logic clk;
logic rst;
logic [LENGTH-1:0] data;
//integer k;

//Fibonacci LFSR instantiation
Fibonacci_LFSR #(.LENGTH(LENGTH), .TAPS(TAPS), .TYPE(0)) U1(
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
