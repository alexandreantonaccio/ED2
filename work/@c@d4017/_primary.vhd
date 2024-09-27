library verilog;
use verilog.vl_types.all;
entity CD4017 is
    port(
        CLK             : in     vl_logic;
        \OUT\           : out    vl_logic_vector(9 downto 0)
    );
end CD4017;
