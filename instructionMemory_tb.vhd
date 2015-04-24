LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY instructionMemory_tb IS
END instructionMemory_tb;
 
ARCHITECTURE behavior OF instructionMemory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT instructionMemory
    PORT(
         clk : IN  std_logic;
         address : IN  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         outInstruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal reset : std_logic := '0';

 	--Outputs
   signal outInstruction : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: instructionMemory PORT MAP (
          clk => clk,
          address => address,
          reset => reset,
          outInstruction => outInstruction
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
      address <= "00000000000000000000000000000010";
      wait for 100 ns;	
		reset <= '1';
		wait for 100 ns;
		reset <= '0';
		address <= "00000000000000000000000000100000";
      wait;
   end process;

END;
