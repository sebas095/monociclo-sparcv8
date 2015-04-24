library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX is
    Port ( CRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           simm32 : in  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC;
           out_op2 : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
	out_op2 <=  simm32 WHEN i ='1' ELSE 
					CRs2; 
end Behavioral;

