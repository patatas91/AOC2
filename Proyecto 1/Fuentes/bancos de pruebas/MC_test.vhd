-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY MC_test IS
  END MC_test;

  ARCHITECTURE behavior OF MC_test IS 

  -- Component Declaration
          component memoriaRAM_I_MC is port (
			  CLK : in std_logic;
			  reset : in  STD_LOGIC; -- resetea el controlador de la Memoria Cache
			  ADDR : in std_logic_vector (31 downto 0); --Dir 
	       	  RE : in std_logic;		-- read enable		 
	       	  ready : out   std_logic;  -- indica si podemos leer la palabra solicitada
		  	  Dout : out std_logic_vector (31 downto 0));
end component;

          SIGNAL clk, reset, RE, ready :  std_logic;
          SIGNAL ADDR: std_logic_vector(31 downto 0);
          SIGNAL Dout :  std_logic_vector(31 downto 0);
          
  -- Clock period definitions
   constant CLK_period : time := 10 ns;
  BEGIN

  -- Component Instantiation
   Mem_I: memoriaRAM_I_MC PORT MAP (CLK => CLK, reset => reset, ADDR => ADDR, RE => RE, ready => ready, Dout => Dout);

-- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
-- Este banco es sólo un ejemplo. Pensad si podéis mejorarlo.
-- La calidad del banco de pruebas: es decir que compruebe los casos representativos se valorará en la nota
 stim_proc: process
   begin		
      reset <= '1';
      RE <= '0';
      ADDR <= x"00000000"; --dir 0 en hex
      wait for CLK_period*2;
	  reset <= '0';
	  RE <= '1';
	  wait until ready ='1' and clk'event and clk ='1'; --esperamos hasta que ready este a 1 y haya un flanco de subida en el reloj
	  ADDR <= x"00000001"; --dir 4 en hex
	  wait until ready ='1' and clk'event and clk ='1';
	  ADDR <= x"00000002"; --dir 16 en hex
	   wait until ready ='1' and clk'event and clk ='1';
	  ADDR <= x"00000003"; --dir 16 en hex
	  wait until ready ='1' and clk'event and clk ='1';
	  ADDR <= x"00000004"; --dir 16 en hex
	  wait until ready ='1' and clk'event and clk ='1';
	  ADDR <= x"00000005"; --dir 16 en hex
	  wait until ready ='1' and clk'event and clk ='1';
	  ADDR <= x"00000005"; --dir 16 en hex
	  wait until ready ='1' and clk'event and clk ='1';
	  ADDR <= x"00000006"; --dir 16 en hex
	  wait until ready ='1' and clk'event and clk ='1';
	  ADDR <= x"00000007"; --dir 16 en hex
	  wait for clk_period; wait until ready ='1' and clk'event and clk ='1';
	  ADDR <= x"00000008"; --dir 16 en hex
	  wait;
   end process;

  END;
