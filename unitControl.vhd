library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unitControl is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
			  op2 : in  STD_LOGIC_VECTOR (2 downto 0);
			  op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  cond : in STD_LOGIC_VECTOR (3 downto 0);
			  icc: in STD_LOGIC_VECTOR (3 downto 0);
			  enableMem : out STD_LOGIC;
           rfSource : out  STD_LOGIC_VECTOR (1 downto 0);
			  rfSourceO7 : out  STD_LOGIC;
			  pcSource : out STD_LOGIC_VECTOR (1 downto 0);
           wrEnMem : out  STD_LOGIC;
           wrEnRF : out  STD_LOGIC;
           ALUop : out  STD_LOGIC_VECTOR (5 downto 0));
end unitControl;

architecture Behavioral of unitControl is

begin
	process(op,op2,op3,cond,icc)
	  begin
			if(op = "01")then --CALL
				pcSource <= "01"; -- PC + (4 x disp30)
				wrEnRF <= '1'; -- Permito guardar el valor actual de PC
				rfSourceO7 <= '1';
				rfSource <= "10"; -- PC
				enableMem <= '1';
				wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
				ALUOP <= "111111"; -- Un valor que no se tenga en cuenta como alguna operacion
			else
				if(op = "00")then
					if(op2 = "010")then -- Branch on Integer Condition Codes Instructions
						case cond is

							when "1000" => -- Branch Always
								pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
								wrEnRF <= '0';
								enableMem <= '1';
								rfSourceO7 <= '0';
								rfSource <= "00"; -- No importa este valor ya que no se permite escritura en el Register File
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "111111";

							when "1001" => -- Branch on Not Equal
								if(not(icc(2)) = '1') then -- not Z
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;

							when "0001" => -- Branch on Equal
								if(icc(2) = '1') then --  Z
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;

							when "1010" => -- Branch on Greater
								if((not(icc(2) or (icc(3) xor icc(1)))) = '1') then -- not(Z or (N xor V))
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;

							when "0010" => -- Branch on Less or Equal
								if((icc(2) or (icc(3) xor icc(1))) = '1') then -- Z or (N xor V)
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;

							when "1011" => -- Branch on Greater or Equal
								if((not(icc(3) xor icc(1))) = '1') then -- not (N xor V)
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;

							when "0011" => -- Branch on Less
								if((icc(3) xor icc(1)) = '1') then -- (N xor V)
									pcSource <= "10"; -- Siempre se salta a PC + (4 x seu(disp22))
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								else
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0';
									enableMem <= '1';
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa este valor ya que no se permite escritura en el Register File
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "111111";
								end if;

							when others => -- Nop
								pcSource <= "00";
								wrEnRF <= '0';
								enableMem <= '1';
								rfSource <= "00";
								rfSourceO7 <= '0';
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "111111"; -- Un valor que no se tenga en cuenta como alguna operacion
						end case;
					else
						if(op2 = "100")then -- NOP
							pcSource <= "11"; -- Se salta a PC + 4
							wrEnRF <= '0'; -- Se guarda en el Register File el valor de
							rfSource <= "01";
							rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
							wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
							ALUOP <= "111111";
							enableMem <= '1';
						end if;
					end if;
				else
					if(op = "10")then
						case op3 is

							when "000000" => -- ADD
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000";
								enableMem <= '1';

							when "000100" => -- SUB
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000001";
								enableMem <= '1';

							when "000001" => -- AND
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000010";
								enableMem <= '1';

							when "000010" => -- OR
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000011";
								enableMem <= '1';

							when "000101" => -- ANDN
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000100";
								enableMem <= '1';

							when "000110" => -- ORN
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000101";
								enableMem <= '1';

							when "000011" => -- XOR
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000110";
								enableMem <= '1';

							when "000111" => -- XORN
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000111";
								enableMem <= '1';

							when "010000" => -- ADDCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "001000";
								enableMem <= '1';

							when "011000" => -- ADDxcc carry icc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "001001";
								enableMem <= '1';

							when "010100" => -- SUBCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "001010";
								enableMem <= '1';

							when "011100" => -- SUBxcc carry icc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "001011";
								enableMem <= '1';

							when "010001" => -- ANDCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "001100";
								enableMem <= '1';

							when "010101" => -- ANDNCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "001101";
								enableMem <= '1';

							when "010010" => -- ORCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "001110";
								enableMem <= '1';

							when "010110" => -- ORNCC
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "001111";
								enableMem <= '1';

							when "010011" => -- XORcc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "010000";
								enableMem <= '1';

							when "010111" => -- XORNcc
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "010001";
								enableMem <= '1';

							when "001000" => -- ADDX
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "010010";
								enableMem <= '1';

							when "001100" => -- SUBX
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "010011";
								enableMem <= '1';

							when "111101" => -- RESTORE
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000"; -- El restore es igual a un add pero modifica CWP
								enableMem <= '1';

							when "111100" => -- SAVE
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000"; -- El save es igual a un add pero modifica CWP
								enableMem <= '1';

							when "100101" => -- SLL
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "010100"; -- El save es igual a un add pero modifica CWP
								enableMem <= '1';

							when "100110" => -- SRL
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "010101"; -- El save es igual a un add pero modifica CWP
								enableMem <= '1';

							when "100111" => -- SRA
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "010110"; -- El save es igual a un add pero modifica CWP
								enableMem <= '1';

							when "111000" => -- JMPL
								pcSource <= "00"; -- Se salta a la dirección calculada.
								wrEnRF <= '1'; -- Se guarda en el Register File el valor del PC
								rfSource <= "10";
								rfSourceO7 <= '0'; -- Debe ser el valor del PC
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000"; -- Se deben sumar los dos operandos que entren a la ALU que determinan la dirección del salto
								enableMem <= '1';

							when others => -- Implementar demas instrucciones
								pcSource <= "11"; -- Se salta a PC + 4
								wrEnRF <= '0'; -- Se guarda en el Register File el valor de la Operacion
								rfSource <= "01";
								rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
								wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
								ALUOP <= "000000";
								enableMem <= '1';
						end case;

					else
						if(op = "11")then
							case op3 is
								when "000100" => -- SW
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0'; -- No Se guarda en el Register File
									rfSource <= "00";
									rfSourceO7 <= '0'; -- No importa porque no se va a guardar en el Register File
									wrEnMem <= '1'; -- El dato es escrito en Memoria de Datos
									ALUOP <= "000000";
									enableMem <= '1';

								when "000000" => -- LW
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '1'; -- Si se guarda en el Register File
									rfSource <= "00";
									rfSourceO7 <= '0'; -- Se debe guardar lo que se carga de la Memoria de Datos
									wrEnMem <= '0'; -- El dato no es escrito en Memoria de Datos
									ALUOP <= "000000";
									enableMem <= '1';

								when others => -- not
									pcSource <= "11"; -- Se salta a PC + 4
									wrEnRF <= '0'; -- Se guarda en el Register File el valor de la Operacion
									rfSource <= "01";
									rfSourceO7 <= '0'; -- Debe ser el resultado de la operacion
									wrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
									ALUOP <= "000000";
									enableMem <= '1';
							end case;
						end if;
					end if;
				end if;
			end if;
	end process;
end Behavioral;

