-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY MIPS_test IS
  END MIPS_test;

  ARCHITECTURE behavior OF MIPS_test IS 

  -- Component Declaration
          COMPONENT MIPs_segmentado is
			 Port ( clk : in  STD_LOGIC;
					  reset : in  STD_LOGIC;
					  output : out  STD_LOGIC_VECTOR (31 downto 0));
			END COMPONENT;

          SIGNAL clk, reset :  std_logic;
          SIGNAL output :  std_logic_vector(31 downto 0);
          
  -- Clock period definitions
   constant CLK_period : time := 10 ns;
  BEGIN

  -- Component Instantiation
   MIPS: MIPs_segmentado PORT MAP(clk => clk, reset => reset, output => output);

-- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
-- En este banco de pruebas no se define nada. Sencillamente se simulan 100 ciclos de reloj. En estos ciclos el Mips ejecutará las instrucciones que tenga en su Memoria de instrucciones
-- Para probar códigos distitnos basta con modificar la MI, y lo mismo con los datos: para modificarlos hay que editar la MD
 stim_proc: process
   begin		
      reset <= '1';
      wait for CLK_period*2;
		reset <= '0';
		wait for CLK_period*100;
		wait;
   end process;

  END;
