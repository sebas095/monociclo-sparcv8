library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSRModifier is
    Port ( ALUop : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (31 downto 0);
			  --reset : in STD_LOGIC;
           op1 : in  STD_LOGIC;
           op2 : in  STD_LOGIC;
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end PSRModifier;

architecture Behavioral of PSRModifier is

begin
process(ALUResult,op1,op2,ALUop)--reset)
begin
	--if (reset='1') then
		--nzvc <= "0000";
	--else
		if(ALUop="001000" or ALUop="001001") then --Addcc Addxcc
			nzvc(0) <= (op1 and op2) or ((not ALUResult(31)) and (op1 or op2));
			nzvc(1) <= (op1 and op2) and ((not ALUResult(31)) or ((op1) and (not op2) and ALUResult(31)));
			if(ALUResult = X"00000000") then
				nzvc(2) <= '1';
			else
				nzvc(2) <= '0';
			end if;
				nzvc(3)<= ALUResult(31);
		else
			if(ALUop = "001010" or ALUop="001011")then--subcc subxcc
				nzvc(0) <= ((not op1) and op2) or (ALUResult(31) and ((not op1) or op2));
				nzvc(1) <= ((op1 and (not op2) and (not ALUResult(31))) or ((not op1) and op2 and ALUResult(31)));
				if(ALUResult = X"00000000")then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(3) <= ALUResult(31);
			else
				if(ALUop = "001100" or ALUop = "001101" or ALUop = "001110" or ALUop = "001111" or ALUop = "010000" or ALUop = "010001")then
					nzvc(0) <= '0';
					nzvc(1) <= '0';
					if(ALUResult = X"00000000")then
					nzvc(2) <= '1';
					else
						nzvc(2) <= '0';
					end if;
					nzvc(3) <= ALUResult(31);
				else
					--PSREnable <= '0';
					nzvc <= "1000";
				end if;
			end if;
			end if;
		--end if;
	end process;
end Behavioral;

