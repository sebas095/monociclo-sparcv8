library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_O7 is
    Port ( nrd : in  STD_LOGIC_VECTOR (5 downto 0);
			  registerO7 : in std_logic_vector (5 downto 0);
           RFSourceO7 : in  STD_LOGIC;
           out_rd : out STD_LOGIC_VECTOR (5 downto 0));
end MUX_O7;

architecture Behavioral of MUX_O7 is

begin

process(nrd,registerO7,RFSourceO7)
	begin
		if RFSourceO7= '1' then
			out_rd <= registerO7;
		else 
			out_rd <= nrd;
		end if;
	end process;

end Behavioral;

