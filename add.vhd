library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity add is
    Port ( input_add : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end add;

architecture Behavioral of add is

begin
   result <= input_add + '1';

end Behavioral;

