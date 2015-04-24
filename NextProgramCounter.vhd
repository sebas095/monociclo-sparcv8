library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--kala865
--siriushpc

entity NextProgramCounter is
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  input_npc : in  STD_LOGIC_VECTOR (31 downto 0);
           out_npc : out  STD_LOGIC_VECTOR (31 downto 0));
end NextProgramCounter;

architecture Behavioral of NextProgramCounter is

begin
	process(clk,reset)
		begin
		if reset = '1' then
			out_npc <= (others =>'0');
		elsif rising_edge(clk) then
			if(input_npc = "00000000000000000000000001000000") then
				out_npc <= (others => '0');						
			else
				out_npc <= input_npc;
			end if;
		end if;
	end process;

end Behavioral;



