library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU_disp30 is
    Port ( disp30 : in  STD_LOGIC_VECTOR (29 downto 0);
           disp32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU_disp30;

architecture Behavioral of SEU_disp30 is

begin
	disp32 <= "00" & disp30 when disp30(29)='0' else
	          "11" & disp30;
end Behavioral;

