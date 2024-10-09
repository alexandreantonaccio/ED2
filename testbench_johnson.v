
`timescale 1ns / 1ps

module relogio_johnson_tb;

    reg reset;
    reg clk;
    reg LD_time;
    reg [1:0] H_in1;
    reg [3:0] H_in0;
    reg [3:0] M_in1;
    reg [3:0] M_in0;


    wire [9:0] H_out1_johnson;
    wire [9:0] H_out0_johnson;
    wire [9:0] M_out1_johnson;
    wire [9:0] M_out0_johnson;
    wire [9:0] S_out1_johnson;
    wire [9:0] S_out0_johnson;

    relogio_johnson uut (
        .reset(reset),
        .clk(clk),
        .LD_time(LD_time),
        .H_in1(H_in1),
        .H_in0(H_in0),
        .M_in1(M_in1),
        .M_in0(M_in0),
        .H_out1_johnson(H_out1_johnson),
        .H_out0_johnson(H_out0_johnson),
        .M_out1_johnson(M_out1_johnson),
        .M_out0_johnson(M_out0_johnson),
        .S_out1_johnson(S_out1_johnson),
        .S_out0_johnson(S_out0_johnson)
    );



    initial clk = 0;
    always #5 clk = ~clk; 


    initial begin

        reset = 1;
        LD_time = 0;
        H_in1 = 2'd1;
        H_in0 = 4'd0;
        M_in1 = 4'd0;
        M_in0 = 4'd0;

        #10;
        reset = 0;

        #10;
        LD_time = 1;
        H_in1 = 2'b01;
        H_in0 = 4'd5;
        M_in1 = 4'd3;
        M_in0 = 4'd0;
        #10;
        LD_time = 0;

        #1000;


        $finish;
    end


endmodule
