LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ProgramCounter_tb IS
END ProgramCounter_tb;
 
ARCHITECTURE behavior OF ProgramCounter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProgramCounter
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         input_pc : IN  std_logic_vector(31 downto 0);
         out_pc : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal input_pc : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_pc : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProgramCounter PORT MAP (
          clk => clk,
          reset => reset,
          input_pc => input_pc,
          out_pc => out_pc
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
      input_pc <= "00000000000000000000000000001000";
      wait for 100 ns;	
		input_pc <= "00000000000000000000000000100000";
      wait for 100 ns;
		reset <= '1';
      wait;
   end process;

END;
