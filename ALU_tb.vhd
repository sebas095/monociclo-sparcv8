LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         CRs1 : IN  std_logic_vector(31 downto 0);
         CRs2 : IN  std_logic_vector(31 downto 0);
         ALUop : IN  std_logic_vector(5 downto 0);
         ALUResult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CRs1 : std_logic_vector(31 downto 0) := (others => '0');
   signal CRs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal ALUop : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ALUResult : std_logic_vector(31 downto 0);
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          CRs1 => CRs1,
          CRs2 => CRs2,
          ALUop => ALUop,
          ALUResult => ALUResult
        );

   -- Stimulus process
   stim_proc: process
   begin		
      CRs1 <= "00000000000000000000000000000110";
		CRs2 <= "00000000000000000000000000000100";
		ALUop <= "000000";
      wait for 100 ns;
		CRs1 <= "00000000000000000000000000000100";
		CRs2 <= "00000000000000000000000000000110";		
		ALUop <= "000001";
		wait for 100 ns;
		CRs1 <= "00000000000000000000000000000110";
		CRs2 <= "00000000000000000000000000000100";
		ALUop <= "000010";
      wait for 100 ns;
		CRs1 <= "00000000000000000000000000000110";
		CRs2 <= "00000000000000000000000000000100";
		ALUop <= "001010";
		wait;
   end process;

END;
