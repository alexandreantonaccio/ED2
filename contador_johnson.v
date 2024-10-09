module relogio_johnson(
    input reset,
    input clk,
    input LD_time,
    input [1:0] H_in1,
    input [3:0] H_in0,
    input [3:0] M_in1,
    input [3:0] M_in0,
    output reg [9:0] H_out1_johnson,
    output reg [9:0] H_out0_johnson,
    output reg [9:0] M_out1_johnson,
    output reg [9:0] M_out0_johnson,
    output reg [9:0] S_out1_johnson,
    output reg [9:0] S_out0_johnson
);

reg [3:0] cnt_sec_0;
reg [3:0] cnt_sec_1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt_sec_0 <= 0;
        cnt_sec_1 <= 0;
    end
    else if (LD_time) begin
        cnt_sec_0 <= 0;
        cnt_sec_1 <= 0;
    end
    else begin
        if (cnt_sec_0 == 9) begin
            cnt_sec_0 <= 0;
            if (cnt_sec_1 == 5)
                cnt_sec_1 <= 0;
            else
                cnt_sec_1 <= cnt_sec_1 + 1;
        end
        else
            cnt_sec_0 <= cnt_sec_0 + 1;
    end
end

reg [3:0] cnt_min_0;
reg [3:0] cnt_min_1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt_min_0 <= 0;
        cnt_min_1 <= 0;
    end
    else if (LD_time) begin
        cnt_min_0 <= M_in0;
        cnt_min_1 <= M_in1;
    end
    else if (cnt_sec_1 == 5 && cnt_sec_0 == 9) begin
        if (cnt_min_0 == 9) begin
            cnt_min_0 <= 0;
            if (cnt_min_1 == 5)
                cnt_min_1 <= 0;
            else
                cnt_min_1 <= cnt_min_1 + 1;
        end
        else
            cnt_min_0 <= cnt_min_0 + 1;
    end
end

reg [3:0] cnt_hr_0;
reg [1:0] cnt_hr_1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt_hr_0 <= 0;
        cnt_hr_1 <= 0;
    end
    else if (LD_time) begin
        cnt_hr_0 <= H_in0;
        cnt_hr_1 <= H_in1;
    end
    else if (cnt_min_1 == 5 && cnt_min_0 == 9 && cnt_sec_1 == 5 && cnt_sec_0 == 9) begin
        if (cnt_hr_0 == 9) begin
            cnt_hr_0 <= 0;
            if (cnt_hr_1 == 2 && cnt_hr_0 == 3)
                cnt_hr_1 <= 0;
            else
                cnt_hr_1 <= cnt_hr_1 + 1;
        end
        else
            cnt_hr_0 <= cnt_hr_0 + 1;
    end
end

always @(*) begin
    H_out0_johnson = 10'b0000000001 << cnt_hr_0;
    H_out1_johnson = 10'b0000000001 << cnt_hr_1;
    M_out0_johnson = 10'b0000000001 << cnt_min_0;
    M_out1_johnson = 10'b0000000001 << cnt_min_1;
    S_out0_johnson = 10'b0000000001 << cnt_sec_0;
    S_out1_johnson = 10'b0000000001 << cnt_sec_1;
end

endmodule
