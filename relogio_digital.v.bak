module relogio(
    input reset,
    input clk,
    input [1:0] H_in1,
    input [3:0] H_in0,
    input [3:0] M_in1,
    input [3:0] M_in0,
    input LD_time,
    output [1:0] H_out1,
    output [3:0] H_out0,
    output [3:0] M_out1,
    output [3:0] M_out0,
    output [3:0] S_out1,
    output [3:0] S_out0,
    output reg [1:0] alt_H_out1,
    output reg [3:0] alt_H_out0,
    output reg [3:0] alt_M_out1,
    output reg [3:0] alt_M_out0,
    output reg [3:0] alt_S_out1,
    output reg [3:0] alt_S_out0
);

reg clk_1s;
reg [3:0] tmp_1s;
reg [5:0] tmp_h, tmp_m, tmp_s;
reg [1:0] c_h1;
reg [3:0] c_h0;
reg [3:0] c_m1;
reg [3:0] c_m0;
reg [3:0] c_s1;
reg [3:0] c_s0;
reg [4:0] display_timer; // conta de 15 em 15
reg [1:0] display_modo;  // 00 = segundos, 01 = minutos, 10 = houras

// mod 10 de 0 a 59
function [3:0] mod_10;
 input [5:0] numero;
 begin
 mod_10 = (numero >=50) ? 5 : ((numero >= 40)? 4 :((numero >= 30)? 3 :((numero >= 20)? 2 :((numero >= 10)? 1 :0))));
 end
endfunction

// logica do relogio
always @(posedge clk_1s or posedge reset) begin
    if(reset) begin
        tmp_h <= H_in1 * 10 + H_in0;
        tmp_m <= M_in1 * 10 + M_in0;
        tmp_s <= 0;
    end 
    else if(LD_time) begin 
        tmp_h <= H_in1 * 10 + H_in0;
        tmp_m <= M_in1 * 10 + M_in0;
        tmp_s <= 0;
    end 
    else begin  
        tmp_s <= tmp_s + 1;
        if(tmp_s >= 59) begin
            tmp_m <= tmp_m + 1;
            tmp_s <= 0;
            if(tmp_m >= 59) begin
                tmp_m <= 0;
                tmp_h <= tmp_h + 1;
                if(tmp_h >= 24) begin
                    tmp_h <= 0;
                end
            end 
        end
    end 
end

// Divisor de clock
always @(posedge clk or posedge reset) begin
    if(reset) begin
        tmp_1s <= 0;
        clk_1s <= 0;
    end
    else begin
        tmp_1s <= tmp_1s + 1;
        if(tmp_1s <= 5) 
            clk_1s <= 0;
        else if (tmp_1s >= 10) begin
            clk_1s <= 1;
            tmp_1s <= 1;
        end
        else
            clk_1s <= 1;
    end
end

// tempo para digitos
always @(*) begin
    if(tmp_h >= 20) 
        c_h1 = 2;
    else if(tmp_h >= 10) 
        c_h1 = 1;
    else
        c_h1 = 0;
        
    c_h0 = tmp_h - c_h1 * 10; 
    c_m1 = mod_10(tmp_m); 
    c_m0 = tmp_m - c_m1 * 10;
    c_s1 = mod_10(tmp_s);
    c_s0 = tmp_s - c_s1 * 10; 
end

// saidas
assign H_out1 = c_h1;
assign H_out0 = c_h0;
assign M_out1 = c_m1;
assign M_out0 = c_m0;
assign S_out1 = c_s1;
assign S_out0 = c_s0;

// modo de display
always @(posedge clk_1s or posedge reset) begin
    if(reset) begin
        display_timer <= 0;
        display_modo <= 2'b00; // modo segundos
    end
    else begin
        display_timer <= display_timer + 1;
        if(display_timer >= 15) begin
            display_timer <= 0;
            display_modo <= display_modo + 1;
            if(display_modo >= 2'b10) // loop entre segundos, minutos e horas
                display_modo <= 2'b00;
        end
    end
end

// alterna logica do display(muda de modos)
always @(posedge clk_1s or posedge reset) begin
    if(reset) begin
        alt_H_out1 <= 2'b00;
        alt_H_out0 <= 4'b0000;
        alt_M_out1 <= 4'b0000;
        alt_M_out0 <= 4'b0000;
        alt_S_out1 <= 4'b0000;
        alt_S_out0 <= 4'b0000;
    end
    else begin
        case(display_modo)
            2'b00: begin // Display segundos
                alt_H_out1 <= 2'b00;
                alt_H_out0 <= 4'b0000;
                alt_M_out1 <= 4'b0000;
                alt_M_out0 <= 4'b0000;
                alt_S_out1 <= S_out1;
                alt_S_out0 <= S_out0;
            end
            2'b01: begin // Display minutos
                alt_H_out1 <= 2'b00;
                alt_H_out0 <= 4'b0000;
                alt_M_out1 <= M_out1;
                alt_M_out0 <= M_out0;
                alt_S_out1 <= 4'b0000;
                alt_S_out0 <= 4'b0000;
            end
            2'b10: begin // Display hour
                alt_H_out1 <= H_out1;
                alt_H_out0 <= H_out0;
                alt_M_out1 <= 4'b0000;
                alt_M_out0 <= 4'b0000;
                alt_S_out1 <= 4'b0000;
                alt_S_out0 <= 4'b0000;
            end
        endcase
    end
end

endmodule
