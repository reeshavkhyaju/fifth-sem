library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration
entity full_adder is
    port (
        a, b, cin : in  std_logic;  -- Inputs: a, b, carry-in
        sum       : out std_logic;   -- Sum output
        cout      : out std_logic    -- Carry-out
    );
end full_adder;

-- Architecture (Behavioral)
architecture behavioral of full_adder is
begin
    sum  <= a xor b xor cin;                    -- Sum = a XOR b XOR cin
    cout <= (a and b) or (cin and (a xor b));   -- Carry-out logic
end behavioral;