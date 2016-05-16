-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY DMA_test IS
  END DMA_test;

  ARCHITECTURE behavior OF DMA_test IS 

  -- DMA
component DMA is port (
		  CLK : in std_logic;
		  reset: in std_logic;
		  addr : in std_logic_vector (31 downto 0); --Dir 
          Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
          WE : in std_logic;		-- write enable	del bus
		  RE : in std_logic;		-- read enable	del bus	  
		  IO_sync: in std_logic; -- señal de sincro del periférico
		  DMA_IO_in : in std_logic_vector (31 downto 0);--entrada de datos desde el periférico
		  DMA_ack : in std_logic; -- concesión del bus
		  DMA_enable : in std_logic;		-- write enable	del bus
		  DMA_req: out std_logic; -- solicitud del bus
		  DMA_MD_RE: out std_logic; -- enable lectura mem
		  DMA_MD_WE: out std_logic; -- enable escritura mem
		  DMA_IO_RE: out std_logic; -- enable lectura IO
		  DMA_IO_WE: out std_logic; -- enable escritura IO
		  DMA_sync: out std_logic; -- señal de sincro con el periférico
		  DMA_addr_IO : out std_logic_vector (6 downto 0); -- dirección para el periferico
		  DMA_addr : out std_logic_vector (31 downto 0); -- dirección para la memoria de datos
		  DMA_IO_out : out std_logic_vector (31 downto 0); --datos enviados al periférico
		  DMA_bus_out : out std_logic_vector (31 downto 0)		  -- salida de datos, para enviar al registro MDR (si el procesador quiere leer alguno de sus registros) o a la memoria de datos
		  );
end component;
		signal DMA_addr_IO : std_logic_vector (6 downto 0);
        signal addr, Din, DMA_addr, DMA_IO_out, DMA_bus_out , DMA_IO_in: std_logic_vector (31 downto 0);  
		SIGNAL clk, reset, WE, RE, IO_sync, DMA_ack, DMA_enable, DMA_req, DMA_MD_RE, DMA_MD_WE, DMA_IO_RE, DMA_IO_WE, DMA_sync :  std_logic;
    
  -- Clock period definitions
   constant CLK_period : time := 10 ns;
  BEGIN

  -- Component Instantiation
  my_DMA: DMA port map ( clk, reset, addr, Din, WE, RE, IO_sync, DMA_IO_in, DMA_ack, DMA_enable, DMA_req, DMA_MD_RE, DMA_MD_WE, DMA_IO_RE, DMA_IO_WE, DMA_sync, DMA_addr_IO, DMA_addr, DMA_IO_out, DMA_bus_out);

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
      Din <= x"44550201";
      we <= '1';
      addr<= x"00000200";
      wait for CLK_period;
	  we <= '0';
      wait for CLK_period;
      wait for CLK_period*2;
	  DMA_ack <= '1';
	  wait for CLK_period*2;	  
	  IO_sync <= '1';
	  wait for CLK_period*2;	  
	  IO_sync <= '0';
	  wait for CLK_period*2;
	  DMA_ack <= '1';
	  wait for CLK_period*2;	  
	  IO_sync <= '1';
	  wait for CLK_period*2;
	  IO_sync <= '0';
	  wait for CLK_period*5;
	  Din <= x"44550203";
	  we <= '1';
	  wait for CLK_period;
	  we <= '0';
      wait for CLK_period;
      wait for CLK_period*2;
	  DMA_ack <= '1';
	  wait for CLK_period*2;	  
	  IO_sync <= '1';
	  wait for CLK_period*2;	  
	  IO_sync <= '0';
	  wait for CLK_period*2;
	  DMA_ack <= '1';
	  wait for CLK_period*2;	  
	  IO_sync <= '1';
	  wait for CLK_period*2;
	  IO_sync <= '0';
	  wait for CLK_period*5;
      wait;
   end process;

  END;
