library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;

entity ALU is
    Port ( CRs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  carry : in STD_LOGIC;
			  reset : in STD_LOGIC;
           ALUop : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
	process(CRs1,CRs2,reset,ALUop,carry)
		begin
			if(reset='1') then ALUResult<=(others=>'0');
			elsif(ALUop="000000" or ALUop="001000") then ALUResult <= CRs1 + CRs2;--Add,Addcc,Save,Restore,JMPL
			elsif(ALUop="000001" or ALUop="001010") then ALUResult <= CRs1 - CRs2;--Sub,Subcc
			elsif(ALUop="000010" or ALUop="001100") then ALUresult <= CRs1 and CRs2; --And,Andcc
			elsif(ALUop="000100" or ALUop="001101") then ALUResult <= CRs1 and (not CRs2);--Andn,Andncc
			elsif(ALUop="000011" or ALUop="001110") then ALUResult <= CRs1 or CRs2;--Or,Orcc
			elsif(ALUop="000101" or ALUop="001111") then ALUResult <= CRs1 or (not CRs2);--Orn,Orncc
			elsif(ALUop="000111" or ALUop="010000") then ALUResult <= CRs1 xor CRs2;--Xor,Xorcc
			elsif(ALUop="000111" or ALUop="010001") then ALUResult <= CRs1 xnor CRs2;--Xnor,Xnorcc
			elsif(ALUop="010010" or ALUop="001001") then ALUResult <= CRs1 + CRs2 + carry; -- Addx, Addxcc
			elsif(ALUop="010011" or ALUop="001011") then ALUResult <= CRs1 - CRs2 - carry; -- Subx, Subxcc
			elsif(ALUop="010100") then ALUResult <= to_stdlogicvector((to_bitvector(CRs1)) sll conv_integer (CRs2));
			elsif(ALUop="010101") then ALUResult <= to_stdlogicvector((to_bitvector(CRs1)) srl conv_integer (CRs2));
			elsif(ALUop="010110") then ALUResult <= to_stdlogicvector((to_bitvector(CRs1)) sra conv_integer (CRs2));
			else
				ALUResult <= (others=>'0');
			end if;
	end process;
end Behavioral;

