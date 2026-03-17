library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration
entity half_subtractor is
    port (
        a, b   : in  std_logic;   -- Inputs
        diff   : out std_logic;    -- Difference output
        borrow : out std_logic     -- Borrow output
    );
end half_subtractor;

-- Architecture (Behavioral)
architecture behavioral of half_subtractor is
begin
    diff   <= a xor b;        -- Difference = a XOR b
    borrow <= (not a) and b;  -- Borrow = NOT a AND b
end behavioral;
