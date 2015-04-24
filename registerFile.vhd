library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;

entity registerFile is
    Port ( --clk : in STD_LOGIC;
			  reset : in STD_LOGIC;
			  rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
			  we : in STD_LOGIC;
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
           CRs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           CRs2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  CRd : out  STD_LOGIC_VECTOR (31 downto 0));
end registerFile;

architecture Behavioral of registerFile is

type RF_type is array (0 to 39) of std_logic_vector (31 downto 0);
signal registers : RF_type :=(others => x"00000000");

begin
--reset,address, instructions)
	process(reset,rs1,rs2,registers,we,rd,DWR)
	begin
		if(reset = '1')then
			CRs1 <= (others=>'0');
			CRs2 <= (others=>'0');
			CRd <= (others=>'0');
			registers <= (others => x"00000000");
		else
			CRs1 <= registers(to_integer(unsigned(rs1)));
			CRs2 <= registers(to_integer(unsigned(rs2)));
			CRd <= registers(to_integer(unsigned(rd)));
			if we = '1' and rd /= "000000" then
				registers(conv_integer(rd)) <= DWR;
			end if;
		end if;
	end process;
end Behavioral;

