library verilog;
use verilog.vl_types.all;
entity relogio_johnson is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        LD              : in     vl_logic;
        H_in1           : in     vl_logic_vector(1 downto 0);
        H_in0           : in     vl_logic_vector(3 downto 0);
        M_in1           : in     vl_logic_vector(3 downto 0);
        M_in0           : in     vl_logic_vector(3 downto 0);
        H_out1_johnson  : out    vl_logic_vector(9 downto 0);
        H_out0_johnson  : out    vl_logic_vector(9 downto 0);
        M_out1_johnson  : out    vl_logic_vector(9 downto 0);
        M_out0_johnson  : out    vl_logic_vector(9 downto 0);
        S_out1_johnson  : out    vl_logic_vector(9 downto 0);
        S_out0_johnson  : out    vl_logic_vector(9 downto 0)
    );
end relogio_johnson;
