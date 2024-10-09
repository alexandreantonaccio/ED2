module relogio_johnson(
    input reset,
    input clk,
    input LD,
    input [1:0] H_in1,
    input [3:0] H_in0,
    input [3:0] M_in1,
    input [3:0] M_in0,
    output reg [9:0] H_out1_johnson,
    output reg [9:0] H_out0_johnson,
    output reg [9:0] M_out1_johnson,
    output reg [9:0] M_out0_johnson,
    output reg [9:0] S_out1_johnson,
    output reg [9:0] S_out0_johnson,
    output reg reg_0_15s,
    output reg reg_15_30s,
    output reg reg_30_45s,
    output reg reg_45_59s
);

reg [3:0] cnt_sec_0;
reg [3:0] cnt_sec_1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt_sec_0 <= 0;
        cnt_sec_1 <= 0;
    end
    else if (LD) begin
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
    else if (LD) begin
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
    else if (LD) begin
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

reg [5:0] tmp_s;

 always @(posedge clk or posedge reset) begin
        if (reset) begin
            tmp_s <= 0;
        end else if (LD) begin
            tmp_s <= 0;
        end else begin
            tmp_s <= tmp_s + 1;
            if (tmp_s >= 59) begin
                tmp_s <= 0;
            end
        end
    end

    // Lógica para determinar os intervalos de tempo
    always @(*) begin
        // Resetar registradores
        reg_0_15s = 0;
        reg_15_30s = 0;
        reg_30_45s = 0;
        reg_45_59s = 0;

        // Ativar o registrador apropriado com base no valor de tmp_s
        if (tmp_s < 15) begin
            reg_0_15s = 1;  // Ativo para 0 a 15 segundos
        end else if (tmp_s < 30) begin
            reg_15_30s = 1;  // Ativo para 15 a 30 segundos
        end else if (tmp_s < 45) begin
            reg_30_45s = 1;  // Ativo para 30 a 45 segundos
        end else if (tmp_s <= 59) begin
            reg_45_59s = 1;  // Ativo para 45 a 59 segundos
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
