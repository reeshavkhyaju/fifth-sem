library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration
entity full_subtractor is
    port (
        a, b, bin : in  std_logic;  -- Inputs: a, b, borrow-in
        diff      : out std_logic;   -- Difference output
        bout      : out std_logic    -- Borrow-out
    );
end full_subtractor;

-- Architecture (Behavioral)
architecture behavioral of full_subtractor is
begin
    diff <= a xor b xor bin;  -- Difference = a XOR b XOR bin
    -- Borrow-out logic
    bout <= ((not a) and b) or ((not a) and bin) or (b and bin);
end behavioral;