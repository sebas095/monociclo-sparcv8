LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY unitControl_tb IS
END unitControl_tb;
 
ARCHITECTURE behavior OF unitControl_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT unitControl
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         ALUop : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ALUop : std_logic_vector(5 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: unitControl PORT MAP (
          op => op,
          op3 => op3,
          ALUop => ALUop
        );

   -- Stimulus process
   stim_proc: process
   begin		
      op <= "10";
		op3 <= "000000";
      wait for 100 ns;	
		op3 <= "000100";
		wait for 100 ns;
		op3 <= "000101";
		wait for 100 ns;
		op3 <= "100110";
		wait for 100 ns;
		op3 <= "100111";
      wait;
   end process;

END;
