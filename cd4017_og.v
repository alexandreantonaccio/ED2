module CD4017 (
    input CLK,
    output wire [9:0] OUT
);

// start output at 1
reg[9:0] counter = 10'd1;

always @(posedge CLK)
begin
    // shift counter each clock
    counter <= counter << 1;

    // when it shifts to the last position (to digit 9),
    // reset to 1
    if(counter == 10'b1000000000)
        counter <= 10'd1;
end

assign OUT = counter;

endmodule