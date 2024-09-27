// M�dulo CD4017 com Reset Personalizado para Contagem at� 5
module CD4017_custom (
    input CLK,
    input RESET, // Reset externo para o d�gito espec�fico
    output wire [9:0] OUT
);
    
    // Inicia a sa�da no primeiro estado
    reg [9:0] counter = 10'd1;
    
    always @(posedge CLK or posedge RESET)
    begin
        if (RESET) begin
            counter <= 10'd1;
        end
        else begin
            // Desloca o contador a cada clock
            counter <= counter << 1;
        
            // Quando atingir o sexto estado, reseta para 1
            if (counter == 10'b100000 || counter == 10'b1000000000)
                counter <= 10'd1;
        end
    end
    
    assign OUT = counter;
    
endmodule
