
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;

entity instructionMemory is
    Port ( --clk : in STD_LOGIC;
			  address : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end instructionMemory;

architecture arqInstructionMemory of instructionMemory is

	type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);
		
	impure function InitRomFromFile (RomFileName : in string) return rom_type is
		FILE RomFile : text open read_mode is RomFileName;
		variable RomFileLine : line;
		variable temp_bv : bit_vector(31 downto 0);
		variable temp_mem : rom_type;
		begin
			for I in rom_type'range loop
				readline (RomFile, RomFileLine);
				read(RomFileLine, temp_bv);
				temp_mem(i) := to_stdlogicvector(temp_bv);
			end loop;
		return temp_mem;
	end function;
	
	signal instructions : rom_type := InitRomFromFile("mult.txt");
	--IM_data ==> funcion mult
	--IM_data3 ==> funcion suma
	--IM_data4 ==> prueba if
	
begin
--reset,address, instructions)
	process(reset,address, instructions)--,clk)
	begin
		if(reset = '1')then
			outInstruction <= (others=>'0');
		else--if(rising_edge(clk))then
				outInstruction <= instructions(conv_integer(address(5 downto 0)));
		end if;
	end process;
end arqInstructionMemory;
