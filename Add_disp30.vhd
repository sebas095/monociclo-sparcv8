library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity Add_disp30 is
    Port ( PC : in  STD_LOGIC_VECTOR (31 downto 0);
           Corr_disp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           Result : out  STD_LOGIC_VECTOR (31 downto 0));
end Add_disp30;

architecture Behavioral of Add_disp30 is

begin
	Result <= PC + Corr_disp30;
end Behavioral;

