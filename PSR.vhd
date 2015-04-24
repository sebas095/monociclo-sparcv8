library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PSR is
    Port ( clk : in  STD_LOGIC;
			  ncwp: in STD_LOGIC_VECTOR(1 downto 0);
           reset : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           carry : out  STD_LOGIC;
           icc : out  STD_LOGIC_VECTOR (3 downto 0);
			  cwp: out std_logic_vector(1 downto 0));
end PSR;

architecture Behavioral of PSR is

begin
	process(clk, reset, ncwp, nzvc)
	begin
		if (reset='1') then
			carry <= '0';
			icc <= "0000";
			cwp <= "00";
		else
			if(rising_edge(clk))then
				carry <= nzvc(0);
				icc <= nzvc;
				cwp <= ncwp;
			end if;
		end if;
	end process;
end Behavioral;

