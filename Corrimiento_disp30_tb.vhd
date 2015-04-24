LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Corrimiento_disp30_tb IS
END Corrimiento_disp30_tb;
 
ARCHITECTURE behavior OF Corrimiento_disp30_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Corrimiento_disp30
    PORT(
         disp30 : IN  std_logic_vector(29 downto 0);
         disp32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal disp30 : std_logic_vector(29 downto 0) := (others => '0');

 	--Outputs
   signal disp32 : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Corrimiento_disp30 PORT MAP (
          disp30 => disp30,
          disp32 => disp32
        );

   -- Stimulus process
   stim_proc: process
   begin		
	   disp30 <= "000000000000000000000000000011";
      wait for 100 ns;
		disp30 <= "111111111111111111111111111100";
      wait;
   end process;

END;
