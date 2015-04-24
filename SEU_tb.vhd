LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY SEU_tb IS
END SEU_tb;
 
ARCHITECTURE behavior OF SEU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU
    PORT(
         simm13 : IN  std_logic_vector(12 downto 0);
         simm32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal simm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal simm32 : std_logic_vector(31 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU PORT MAP (
          simm13 => simm13,
          simm32 => simm32
        );

   stim_proc: process
   begin		
      simm13 <= "1000000010000";
      wait for 100 ns;	
		simm13 <= "0000000001001";
      wait;
   end process;

END;
