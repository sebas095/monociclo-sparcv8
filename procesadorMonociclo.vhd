library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity procesadorMonociclo is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ModuleOut : out  STD_LOGIC_VECTOR (31 downto 0));
end procesadorMonociclo;

architecture Behavioral of procesadorMonociclo is

	component ProgramCounter is
   Port (  clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  input_pc : in  STD_LOGIC_VECTOR (31 downto 0);
           out_pc : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	 component add is
    Port ( input_add : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;

	 component instructionMemory is
    Port ( --clk : in STD_LOGIC;
			  address : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;

	 component windowManager is
    Port (op : in STD_LOGIC_VECTOR (1 downto 0);
			op3 : in STD_LOGIC_VECTOR (5 downto 0);
			cwp : in STD_LOGIC_VECTOR (1 downto 0);
			rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
			rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
			rd : in  STD_LOGIC_VECTOR (4 downto 0);
			ncwp : out STD_LOGIC_VECTOR (1 downto 0) := "00";
			new_rs1 : out  STD_LOGIC_VECTOR (5 downto 0);
			new_rs2 : out  STD_LOGIC_VECTOR (5 downto 0);
			new_rd : out  STD_LOGIC_VECTOR (5 downto 0);
			registroO7 : out STD_LOGIC_VECTOR (5 downto 0));
	end component;

	component MUX_O7 is
   Port (  nrd : in  STD_LOGIC_VECTOR (5 downto 0);
			  registerO7 : in std_logic_vector (5 downto 0);
           RFSourceO7 : in  STD_LOGIC;
           out_rd : out STD_LOGIC_VECTOR (5 downto 0));
	end component;

	 component registerFile is
    Port ( reset : in STD_LOGIC;
			  rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
			  we : in STD_LOGIC;
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
           CRs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           CRs2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  CRd : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;

	 component unitControl is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
			  op2 : in  STD_LOGIC_VECTOR (2 downto 0);
			  op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  cond : in STD_LOGIC_VECTOR (3 downto 0);
			  icc: in STD_LOGIC_VECTOR (3 downto 0);
			  enableMem : out STD_LOGIC;
           rfSourceO7 : out  STD_LOGIC;
			  rfSource : out  STD_LOGIC_VECTOR (1 downto 0);
			  pcSource : out STD_LOGIC_VECTOR (1 downto 0);
           wrEnMem : out  STD_LOGIC;
           wrEnRF : out  STD_LOGIC;
           ALUop : out  STD_LOGIC_VECTOR (5 downto 0));
	 end component;

	 component SEU is
    Port ( simm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;

	 component MUX is
    Port ( CRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           simm32 : in  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC;
           out_op2 : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;

	 component ALU is
    Port ( CRs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  carry : in STD_LOGIC;
			  reset : in STD_LOGIC;
           ALUop : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;

	component PSRModifier is
   Port ( ALUop : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (31 downto 0);
			  --reset : in STD_LOGIC;
           op1 : in  STD_LOGIC;
           op2 : in  STD_LOGIC;
			  --PSREnable : out STD_LOGIC;
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component PSR is
   Port (  clk : in  STD_LOGIC;
			  ncwp: in STD_LOGIC_VECTOR(1 downto 0);
           reset : in  STD_LOGIC;
			  --enable: in STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           carry : out  STD_LOGIC;
           icc : out  STD_LOGIC_VECTOR (3 downto 0);
			  cwp: out std_logic_vector(1 downto 0));
	end component;

	component DataMemory is
   Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           WriteEnable : in  STD_LOGIC;
           enableMem : in  STD_LOGIC;
           Address : in  STD_LOGIC_VECTOR (31 downto 0);
			  CRd : in  STD_LOGIC_VECTOR (31 downto 0);
           DataValue : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component MUXdatam is
   Port (  DataValue : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RFSource : in  STD_LOGIC_VECTOR (1 downto 0);
           FinalValue : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component MUXnPC is
   Port ( AddResult : in  STD_LOGIC_VECTOR (31 downto 0);
           Value1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Value2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           nPC : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component SEU_disp22 is
   Port (  disp22 : in  STD_LOGIC_VECTOR (21 downto 0);
           out_disp32 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component SEU_disp30 is
   Port (  disp30 : in  STD_LOGIC_VECTOR (29 downto 0);
           disp32 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component Add_disp22 is
   Port (  PC : in  STD_LOGIC_VECTOR (31 downto 0);
           SEU_disp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           Result : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component Add_disp30 is
   Port (  PC : in  STD_LOGIC_VECTOR (31 downto 0);
           Corr_disp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           Result : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	signal aux_npc : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_pc : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux2_pc : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_IM : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_ALUop : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
	signal aux_ALUResult : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_CRs1 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_CRs2 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_CRd : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_DWR : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_simm32 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_out_op2 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_ncwp : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal aux_cwp : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal aux_new_rs1 : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
	signal aux_new_rs2 : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
	signal aux_new_rd : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
	signal aux_registroO7 : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
	signal aux_salidaMUXO7 : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
	signal aux_icc: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
	signal aux_carry : STD_LOGIC := '0';
	signal aux_enableMem : STD_LOGIC := '0';
   signal aux_rfSource : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal aux_rfSourceO7 : STD_LOGIC := '0';
	signal aux_pcSource : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
   signal aux_wrEnMem : STD_LOGIC := '0';
   signal aux_wrEnRF : STD_LOGIC := '0';
	signal aux_PSREnable : STD_LOGIC := '0';
	signal aux_nzvc : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
	signal aux_DataValue : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_CallResult : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_SaltosResult : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_disp32 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_call : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_saltos : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal aux_salidaMUX : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

begin
	Instance_nPC : ProgramCounter port map(
		clk => clk,
		reset => reset,
		input_pc => aux_salidaMUX,
		out_pc => aux_pc
    );

	 Instance_PC : ProgramCounter port map(
		clk => clk,
		reset => reset,
		input_pc => aux_pc,
		out_pc => aux2_pc
    );

	 Instance_add : add port map(
		input_add => aux_pc,
		result => aux_npc
	 );

	 Instance_IM : instructionMemory port map(
		--clk => clk,
		address => aux2_pc,
		reset => reset,
		outInstruction => aux_IM
	 );

	 Instance_WM : windowManager port map(
		op => aux_IM(31 downto 30),
		op3 => aux_IM(24 downto 19),
		cwp => aux_cwp,
		rs1 => aux_IM(18 downto 14),
		rs2 => aux_IM(4 downto 0),
		rd => aux_IM(29 downto 25),
		ncwp => aux_ncwp,
		new_rs1 => aux_new_rs1,
		new_rs2 => aux_new_rs2,
		new_rd => aux_new_rd,
		registroO7 => aux_registroO7
	);

	 Instance_MUX_O7 : MUX_O7 port map(
		nrd => aux_new_rd,
		registerO7 => aux_registroO7,
      RFSourceO7 => aux_rfSourceO7,
      out_rd => aux_salidaMUXO7
	 );

	 Instance_RF : registerFile port map(
		reset => reset,
		rs1 => aux_new_rs1,
		rs2 => aux_new_rs2,
		rd => aux_salidaMUXO7,
		we => aux_wrEnRF,
		DWR => aux_DWR,
		CRs1 => aux_CRs1,
		CRs2 => aux_CRs2,
		CRd => aux_CRd
	);

	 Instance_UC : unitControl port map(
		op => aux_IM(31 downto 30),
		op2 => aux_IM(24 downto 22),
		op3 => aux_IM(24 downto 19),
		cond => aux_IM(28 downto 25),
	   icc => aux_icc,
	   enableMem => aux_enableMem,
	   rfSource => aux_rfSource,
		rfSourceO7 => aux_rfSourceO7,
	   pcSource => aux_pcSource,
	   wrEnMem => aux_wrEnMem,
	   wrEnRF => aux_wrEnRF,
      ALUop => aux_ALUop
	 );

	 Instance_SEU : SEU port map(
		simm13 => aux_IM(12 downto 0),
      simm32 => aux_simm32
	  );

	 Instance_MUX : MUX port map(
		CRs2 => aux_CRs2,
      simm32 => aux_simm32,
      i => aux_IM(13),
      out_op2 => aux_out_op2
	 );

	 Instance_ALU : ALU port map(
		CRs1 => aux_CRs1,
      CRs2 => aux_out_op2,
		carry => aux_carry,
		reset => reset,
      ALUop => aux_ALUop,
      ALUResult => aux_ALUResult
	 );

	 Instance_PSRModifier : PSRModifier port map(
		ALUop => aux_ALUop,
      ALUResult => aux_ALUResult,
		--reset => reset,
		op1 => aux_CRs1(31),
		op2 => aux_out_op2(31),
		--PSREnable => aux_PSREnable,
		nzvc => aux_nzvc
	 );

	Instance_PSR : PSR port map(
		clk => clk,
		ncwp => aux_ncwp,
      reset => reset,
		--enable => aux_PSREnable,
      nzvc => aux_nzvc,
      carry => aux_carry,
      icc => aux_icc,
		cwp => aux_cwp
	);

	Instance_DataMemory : DataMemory port map(
		clk => clk,
      reset => reset,
      WriteEnable => aux_wrEnMem,
      enableMem => aux_enableMem,
      Address => aux_ALUResult,
		CRd => aux_CRd,
      DataValue => aux_DataValue
	);

	Instance_MUXdatam : MUXdatam port map(
		DataValue => aux_DataValue,
      ALUResult => aux_ALUResult,
      PC => aux2_pc,
      RFSource => aux_rfSource,
      FinalValue => aux_DWR
	);

	Instance_MUXnPC : MUXnPC port map(
		AddResult => aux_npc,
	   Value1 => aux_SaltosResult,
	   Value2 => aux_CallResult,
	   ALUResult => aux_ALUResult,
	   PCSource => aux_pcSource,
	   nPC => aux_salidaMUX
	);

	Instance_SEU_disp22 : SEU_disp22 port map(
		disp22 => aux_IM(21 downto 0),
      out_disp32 => aux_saltos
	);

	Instance_SEU_disp30 : SEU_disp30 port map(
		disp30 => aux_IM(29 downto 0),
      disp32 => aux_call
	);

	Instance_Add_disp22 : Add_disp22 port map(
		PC => aux_pc,
      SEU_disp22 => aux_saltos,
      Result => aux_SaltosResult
	);

	Instance_Add_disp30 : Add_disp30 port map(
		PC => aux_pc,
      Corr_disp30 => aux_call,
      Result => aux_CallResult
	);

	ModuleOut <= aux_salidaMUX;

end Behavioral;

