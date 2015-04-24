library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUXnPC is
    Port ( AddResult : in  STD_LOGIC_VECTOR (31 downto 0);
           Value1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Value2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           nPC : out  STD_LOGIC_VECTOR (31 downto 0));
end MUXnPC;

architecture Behavioral of MUXnPC is

begin
process (PCSource,AddResult,Value1,Value2,ALUResult)
	begin
   case PCSource is
      when "00" => nPC <= ALUResult;
      when "01" => nPC <= Value2;--call pc+(4*disp30)
      when "10" => nPC <= Value1;--saltos pc+(4*SEU(disp22))
      when "11" => nPC <= AddResult;--pc+1
      when others => nPC <= (others => '0');
   end case;
end process;
 

end Behavioral;

