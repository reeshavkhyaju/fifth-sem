library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration
entity half_adder is
    port (
        a, b   : in  std_logic;
        sum    : out std_logic;
        carry  : out std_logic
    );
end half_adder;

-- Architecture (Behavioral)
architecture behavioral of half_adder is
begin
    sum   <= a xor b;      -- Sum output
    carry <= a and b;      -- Carry output
end behavioral;