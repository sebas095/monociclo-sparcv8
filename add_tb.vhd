--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:45:46 03/10/2015
-- Design Name:   
-- Module Name:   D:/Arquitectura/Procesador_monociclo/add_tb.vhd
-- Project Name:  Procesadoer_monociclo
-- Target Device:  
-- Tool versions:  
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY add_tb IS
END add_tb;
 
ARCHITECTURE behavior OF add_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT add
    PORT(
         input_add : IN  std_logic_vector(31 downto 0);
         result : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input_add : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(31 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: add PORT MAP (
          input_add => input_add,
          result => result
        );
		  
   stim_proc: process
   begin		
      input_add <= "00000000000000000000000000000000";
      wait for 100 ns;	
		input_add <= "00000000000000000000000000000010";
      wait;
   end process;

END;
