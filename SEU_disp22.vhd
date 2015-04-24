library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU_disp22 is
    Port ( disp22 : in  STD_LOGIC_VECTOR (21 downto 0);
           out_disp32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU_disp22;

                                                                                                  architecture Behavioral of SEU_disp22 is

begin
	process(disp22)
		begin
			if disp22(21) = '0' then
				out_disp32 <= "0000000000" & disp22;
			else
				out_disp32 <= "1111111111" & disp22;
			end if;
	end process;

end Behavioral;

