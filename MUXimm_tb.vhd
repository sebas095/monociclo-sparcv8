--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:55:02 03/10/2015
-- Design Name:   
-- Module Name:   D:/Arquitectura/Procesador_monociclo/MUX_tb.vhd
-- Project Name:  Procesadoer_monociclo
-- Target Device:  
-- Tool versions:  
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
 
ENTITY MUX_tb IS
END MUX_tb;
 
ARCHITECTURE behavior OF MUX_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX
    PORT(
         CRs2 : IN  std_logic_vector(31 downto 0);
         simm32 : IN  std_logic_vector(31 downto 0);
         i : IN  std_logic;
         out_op2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CRs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal simm32 : std_logic_vector(31 downto 0) := (others => '0');
   signal i : std_logic := '0';

 	--Outputs
   signal out_op2 : std_logic_vector(31 downto 0);
    
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          CRs2 => CRs2,
          simm32 => simm32,
          i => i,
          out_op2 => out_op2
        );
		  
   stim_proc: process
   begin		
      CRs2 <= "00000000000000100010000010000100";
		simm32 <= "11111100000000000000000000000000";
		i <= '0';
      wait for 100 ns;	
		i <= '1';
      wait;
   end process;

END;
