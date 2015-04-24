library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity windowManager is
    Port (
			op : in STD_LOGIC_VECTOR (1 downto 0);
			op3 : in STD_LOGIC_VECTOR (5 downto 0);
			cwp : in STD_LOGIC_VECTOR (1 downto 0);
			rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
			rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
			rd : in  STD_LOGIC_VECTOR (4 downto 0);
			ncwp : out STD_LOGIC_VECTOR (1 downto 0) := "00";
			new_rs1 : out  STD_LOGIC_VECTOR (5 downto 0);
			new_rs2 : out  STD_LOGIC_VECTOR (5 downto 0);
			new_rd : out  STD_LOGIC_VECTOR (5 downto 0);
			registroO7 : out STD_LOGIC_VECTOR (5 downto 0));
end windowManager;

architecture Behavioral of windowManager is
	signal auxrs1,auxrs2,auxrd: integer range 0 to 39:=0;
begin
	registroO7 <= conv_std_logic_vector((conv_integer(cwp)*16)+15,6);

	process(rs1,rs2,rd,cwp,op,op3)
	begin
		--if(rising_edge(clk))then
			if(op = "10" and op3 = "111100")then--SAVE
				ncwp <= conv_std_logic_vector(conv_integer(cwp) - 1,2);
			else
				if(op = "10" and op3 = "111101")then--RESTORE
					ncwp <= conv_std_logic_vector(conv_integer(cwp) + 1,2);
					--else
						--ncwp <= cwp;
				end if;
			end if;

		if(rs1>="00000" and rs1<="00111") then
			auxrs1 <= conv_integer(rs1);
		else
			if(rs1>="11000" and rs1<="11111") then
				auxrs1 <= conv_integer(rs1)-(conv_integer(cwp)*16);
			else
				if(rs1>="10000" and rs1<="10111") then
					auxrs1 <= conv_integer(rs1)+(conv_integer(cwp)*16);
				else
						if(rs1>="01000" and rs1<="01111") then
							auxrs1 <= conv_integer(rs1)+ (conv_integer(cwp)*16);
						end if;
				end if;
			end if;
		end if;



		if(rs2>="00000" and rs2<="00111") then
			auxrs2 <= conv_integer(rs2);
		else
			if(rs2>="11000" and rs2<="11111") then
				auxrs2 <= conv_integer(rs2) - (conv_integer(cwp)*16);
			else
				if(rs2>="11000" and rs2<="11111") then
					auxrs2 <= conv_integer(rs2) - (conv_integer(cwp)*16);
				else
					if(rs2>="10000" and rs2<="10111") then
						auxrs2 <= conv_integer(rs2)+ (conv_integer(cwp)*16);
					else
						if(rs2>="01000" and rs1<="01111") then
							auxrs2 <= conv_integer(rs2)+ (conv_integer(cwp)*16);
						end if;
					end if;
				end if;
			end if;
		end if;

		if(rd>="00000" and rd<="00111") then
			auxrd <= conv_integer(rd);
		else
			if(rd>="11000" and rd<="11111") then
				auxrd <= conv_integer(rd)  - (conv_integer(cwp)*16);
			else
				if(rd>="10000" and rs1<="10111") then
					auxrd <= conv_integer(rd)+ (conv_integer(cwp)*16);
				else
					if(rd>="01000" and rd<="01111") then
						auxrd <= conv_integer(rd)+ (conv_integer(cwp)*16);
					end if;
				end if;
			end if;
		end if;
		--end if; --- process del clk ojo
	end process;

	new_rs1 <= conv_std_logic_vector(auxrs1, 6);
	new_rs2 <= conv_std_logic_vector(auxrs2, 6);
	new_rd <= conv_std_logic_vector(auxrd, 6);
end Behavioral;