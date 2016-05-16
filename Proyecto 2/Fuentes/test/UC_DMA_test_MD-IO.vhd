-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY UC_DMA_test IS
  END UC_DMA_test;

  ARCHITECTURE behavior OF UC_DMA_test IS 

  component UC_DMA is
    Port ( clk : in  STD_LOGIC;
          reset : in  STD_LOGIC;
          empezar: in  STD_LOGIC;
          fin: in  STD_LOGIC; --
          L_E: in  STD_LOGIC;  -- 0 lectura de memoria, 1 escritura en memoria
          DMA_ack : in std_logic; -- concesión del bus
		  IO_sync: in std_logic; -- señal de sincro con el periférico
		  update_done :out std_logic; --para actualizar el bit done al terminar una transferencia
		  DMA_req: out std_logic; -- solicitud del bus
		  reset_count: out std_logic; -- pone el contador a 0
		  count_enable: out std_logic; -- incrementa el contador 
		  load_data: out std_logic; -- carga una plabara de memoria o de IO
		  DMA_MD_RE: out std_logic; -- enable lectura mem
		  DMA_MD_WE: out std_logic; -- enable escritura mem
		  DMA_IO_RE: out std_logic; -- enable lectura IO
		  DMA_IO_WE: out std_logic; -- enable escritura IO
		  DMA_sync: out std_logic -- señal de sincro con el periférico
		  );
end component;

          SIGNAL clk, reset, empezar, fin, L_E, DMA_ack, IO_sync, update_done, DMA_req, reset_count, count_enable, load_data, DMA_MD_RE, DMA_MD_WE, DMA_IO_RE, DMA_IO_WE, DMA_sync :  std_logic;
    
  -- Clock period definitions
   constant CLK_period : time := 10 ns;
  BEGIN

  -- Component Instantiation
  U_control_DMA: UC_DMA port map ( clk, reset, empezar, fin, L_E, DMA_ack, IO_sync, update_done, DMA_req, reset_count, count_enable, load_data, DMA_MD_RE, DMA_MD_WE, DMA_IO_RE, DMA_IO_WE, DMA_sync);

-- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

 stim_proc: process
   begin  
	    
	  --INI
	  -- Señales del principio
	  reset <= '1';
      empezar <= '0';
      fin <= '1';
      DMA_Ack <= '0';
      L_E <= '0';
      IO_sync <= '0';
      wait for CLK_period*2;
	  -- Señales para pasar al estado siguiente
	  reset <= '0';
	  empezar <= '1';
	  fin <= '0';
	  
	  -- MD-IO
	  L_E <= '0';	
	  
	  --ESC_BUS 
	  wait for CLK_period*2;
      -- DMA_req = 1
	  DMA_Ack <= '1';
	  -- load_data = 1
	  -- DMA_MD_RE = 1	  
	  
	  --ESC_SYNC
	  -- DMA_sync = 1
	  -- DMA_IO_WE = 1
	  wait for CLK_period*2;
	  IO_sync <= '1';	  
	  -- count_enable = 1	

	  --ESC_SYNC_ESPERA / Volvemos a ESC_BUS
	  -- DMA_sync = 0
	  wait for CLK_period*2;
	  IO_sync <= '0';	  
	  fin <= '0';	  
	  wait for CLK_period*2; 
	  
	  --ESC_BUS 
	  wait for CLK_period*2;
      -- DMA_req = 1
	  DMA_Ack <= '1';
	  -- load_data = 1
	  -- DMA_MD_RE = 1	  
	  
	  --ESC_SYNC
	  -- DMA_sync = 1
	  -- DMA_IO_WE = 1
	  wait for CLK_period*2;
	  IO_sync <= '1';	  
	  -- count_enable = 1	
	  
	  --ESC_SYNC_ESPERA / Volvemos a INI
	  -- DMA_sync = 0
	  wait for CLK_period*2;
	  IO_sync <= '0';	  
	  fin <= '1';
	  -- reset_count = 1
	  -- update_done = 1  
	  wait for CLK_period*2; 
	  	 
   end process;

  END;
