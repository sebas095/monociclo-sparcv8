library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUXdatam is
    Port ( DataValue : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RFSource : in  STD_LOGIC_VECTOR (1 downto 0);
           FinalValue : out  STD_LOGIC_VECTOR (31 downto 0));
end MUXdatam;

architecture Behavioral of MUXdatam is

begin
process (RFSource,DataValue,ALUResult,PC)
	begin
		case RFSource is
			when "00" => FinalValue <= DataValue;
			when "01" => FinalValue <= ALUResult;
			when "10" => FinalValue <= PC;
			when others => FinalValue <= (others => '0');
		end case;
end process;

end Behavioral;

