library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--kala865
--siriushpc

entity ProgramCounter is
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  input_pc : in  STD_LOGIC_VECTOR (31 downto 0);
           out_pc : out  STD_LOGIC_VECTOR (31 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is

begin
	process(clk,reset)
		begin
		if reset = '1' then
			out_pc <= (others=>'0');
		elsif rising_edge(clk) then
			if(input_pc = "00000000000000000000000001000000") then
				out_pc <= (others => '0');						
			else
				out_pc <= input_pc;
			end if;
		end if;
	end process;

end Behavioral;

