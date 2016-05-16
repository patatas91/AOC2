-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY MD_IO_test IS
  END MD_IO_test;

  ARCHITECTURE behavior OF MD_IO_test IS 

component MD_mas_I_O is port (
		  CLK : in std_logic;
		  reset: in std_logic; -- sólo resetea el controlador de DMA
		  ADDR : in std_logic_vector (31 downto 0); --Dir 
          Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
          WE : in std_logic;		-- write enable	
		  RE : in std_logic;		-- read enable		  
		  Dout : out std_logic_vector (31 downto 0));
end component;
		signal addr, Din, Dout: std_logic_vector (31 downto 0);  
		SIGNAL clk, reset, WE, RE :  std_logic;
    
  -- Clock period definitions
   constant CLK_period : time := 10 ns;
  BEGIN

  -- Component Instantiation
 MD_IO: MD_mas_I_O port map ( clk, reset, addr, Din, WE, RE, Dout);

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
      wait for CLK_period;
      reset <= '0';
      Din <= x"04000201"; --operacion de escritura en IO
      we <= '1';
      re <= '0';
      addr<= x"00000200"; --escribo en el DMA (operación de lectura en memoria)
      wait for CLK_period;
	  we <= '0';
	  re <= '1'; --leo el contenido del DMA ( e impido que el DMA pueda acceder a la memoria)
	  wait for CLK_period*10;
	  re <= '0'; --dejo el bus libre
      wait for CLK_period*4;
      addr<= x"00000204"; --leo el contador ( e impido que el DMA pueda acceder a la memoria)
      re <= '1'; 
	  wait for CLK_period*10;
	  re <= '0'; --dejo el bus libre
      wait for CLK_period*30;
      addr<= x"00000200"; --escribo en el DMA
      Din <= x"000C0303"; --operación de escritura en memoria
      we <= '1';
      wait for CLK_period;
	  we <= '0';
      wait for CLK_period*10;
      addr<= x"00000204"; --leo el contador ( e impido que el DMA pueda acceder a la memoria)
      re <= '1'; 
	  wait for CLK_period*10;
	  re <= '0'; --espero a que todo termine
      wait;
   end process;

  END;
