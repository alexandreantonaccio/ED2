library verilog;
use verilog.vl_types.all;
entity relogio_alterado is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        H_in1           : in     vl_logic_vector(1 downto 0);
        H_in0           : in     vl_logic_vector(3 downto 0);
        M_in1           : in     vl_logic_vector(3 downto 0);
        M_in0           : in     vl_logic_vector(3 downto 0);
        LD_time         : in     vl_logic;
        H_out1          : out    vl_logic_vector(1 downto 0);
        H_out0          : out    vl_logic_vector(3 downto 0);
        M_out1          : out    vl_logic_vector(3 downto 0);
        M_out0          : out    vl_logic_vector(3 downto 0);
        S_out1          : out    vl_logic_vector(3 downto 0);
        S_out0          : out    vl_logic_vector(3 downto 0);
        alt_H_out1      : out    vl_logic_vector(1 downto 0);
        alt_H_out0      : out    vl_logic_vector(3 downto 0);
        alt_M_out1      : out    vl_logic_vector(3 downto 0);
        alt_M_out0      : out    vl_logic_vector(3 downto 0);
        alt_S_out1      : out    vl_logic_vector(3 downto 0);
        alt_S_out0      : out    vl_logic_vector(3 downto 0)
    );
end relogio_alterado;
