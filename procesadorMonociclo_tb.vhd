LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY procesadorMonociclo_tb IS
END procesadorMonociclo_tb;
 
ARCHITECTURE behavior OF procesadorMonociclo_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT procesadorMonociclo
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         ModuleOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';

 	--Outputs
   signal ModuleOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: procesadorMonociclo PORT MAP (
          clk => clk,
          reset => reset,
          ModuleOut => ModuleOut
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
		--reset <= '1';
      wait for 100 ns;
		reset<='0';

      wait;
   end process;

END;
