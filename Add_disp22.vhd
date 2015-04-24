library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity Add_disp22 is
    Port ( PC : in  STD_LOGIC_VECTOR (31 downto 0);
           SEU_disp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           Result : out  STD_LOGIC_VECTOR (31 downto 0));
end Add_disp22;

architecture Behavioral of Add_disp22 is

begin
	Result <= PC + SEU_disp22;
end Behavioral;

