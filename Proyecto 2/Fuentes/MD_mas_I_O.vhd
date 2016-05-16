----------------------------------------------------------------------------------
--
-- Description: Incluye la memoria de datos inicial, un bus y un periférico con un controlador DMA para mover datos de la memoria al periférico y viceversa 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-- Memoria RAM de 128 palabras de 32 bits
entity MD_mas_I_O is port (
		  CLK : in std_logic;
		  reset: in std_logic; -- sólo resetea el controlador de DMA
		  ADDR : in std_logic_vector (31 downto 0); --Dir 
          Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
          WE : in std_logic;		-- write enable	
		  RE : in std_logic;		-- read enable		  
		  Dout : out std_logic_vector (31 downto 0));
end MD_mas_I_O;

architecture Behavioral of MD_mas_I_O is
-- misma memoria que en el proyecto anterior
component RAM_128_32 is port (
		  CLK : in std_logic;
		  enable: in std_logic; --solo se lee o escribe si enable está activado
		  ADDR : in std_logic_vector (31 downto 0); --Dir 
        Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
        WE : in std_logic;		-- write enable	
		  RE : in std_logic;		-- read enable		  
		  Dout : out std_logic_vector (31 downto 0));
end component;
-- Memoria del periférico. 128 bytes. Se lee y escribe byte a byte
component RAM_128_32_master_slave is port (
		  CLK : in std_logic;
		  reset : in  STD_LOGIC;
		  ADDR : in std_logic_vector (6 downto 0); --Dir 
          Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
          WE : in std_logic;		-- write enable	
		  RE : in std_logic;		-- read enable	
		  DMA_sync : in std_logic;  
		  IO_sync: out std_logic; 
		  Dout : out std_logic_vector (31 downto 0));
end component;
--- DMA
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
--señales del bus
signal Bus_addr:  std_logic_vector(31 downto 0); 
signal Bus_data:  std_logic_vector(31 downto 0); 
signal Bus_RE, Bus_WE: std_logic;
--señales de MD
signal MD_Dout:  std_logic_vector(31 downto 0); 
--señales de la IO
signal IO_Dout:  std_logic_vector(31 downto 0); 
-- señales arbitraje:
signal Mips_req, DMA_req, Mips_ack, DMA_ack: std_logic;
-- señales de sincro DMA IO
signal IO_sync, DMA_sync: std_logic;
-- señales DMA:
signal DMA_addr_IO: std_logic_vector (6 downto 0);
signal DMA_addr:  std_logic_vector(31 downto 0); 
signal DMA_IO_out, DMA_bus_out : std_logic_vector (31 downto 0);
signal DMA_MD_RE, DMA_MD_WE, DMA_IO_RE, DMA_IO_WE: std_logic;
-- Decodificación dir
signal MD_enable, DMA_enable: std_logic; -- se activan si la dirección del mips les corresponde

begin
 -- enable
 MD_enable <= '1' when Bus_addr(31 downto 9) = "00000000000000000000000" else '0'; -- si la dirección en el bus está en el rango de la memoria MD
 DMA_enable <= '1' when Bus_addr(31 downto 9) = "00000000000000000000001" else '0'; -- si la dirección en el bus está en el rango del DMA  
 --arbitro--------------------------------------- 

arbitro: process (WE, RE)
begin
	-- PETICION MIPS -> 1 cuando se quiera leer o escribir
	if (RE = '1' OR WE = '1') then
		Mips_req <= '1';
	else
		Mips_req <= '0'; 
	end if;		
end process; 

 Mips_ack <= '1' when Mips_req='1' else '0';--si el mips quiere usar la memoria siempre la encuentra disponible
 DMA_Ack <= '1' when (Mips_req='0' and DMA_req = '1') else '0';-- el DMA sólo puede usar la memoria si el Mips no la está usando
-- bus -------------------
 -- Ejemplo resuelto, el resto los tenéis que hacer vosotros
 Bus_addr <=  ADDR when Mips_ack='1' else -- hay dos fuentes para las direcciones: Mips o DMA
            DMA_addr when DMA_Ack ='1' else 
            x"00000000";			
 --COMPLETAR-----------------------------------------
 Bus_data <= Din when Mips_ack='1' else 
             MD_Dout when (DMA_Ack ='1' and Bus_RE='1') else -- En lectura el DMA lee de MD 
             DMA_bus_out when (DMA_Ack ='1' and Bus_WE='1') else -- En escritura escribe en MD
             x"00000000";
 
 Bus_RE <=  RE when Mips_ack = '1' else
			DMA_MD_RE when DMA_Ack = '1' else
			'0'; -- hay dos fuentes para RE: Mips o DMA. por defecto a 0 para evitar operaciones no deseadas
 
 Bus_WE <=  WE when Mips_ack = '1' else
			DMA_MD_WE when DMA_Ack = '1' else
			'0'; -- hay dos fuentes para WE: Mips o DMA. por defecto a 0 para evitar operaciones no deseadas
 --FIN COMPLETAR--------------------
 -- Memoria de datos original

 MD: RAM_128_32 PORT MAP (CLK => CLK, enable => MD_enable, ADDR => Bus_addr, Din => Bus_data, WE =>  Bus_WE, RE => Bus_RE, Dout => MD_Dout);
 
 -- memoria de datos IO: sólo se accede a ella a través de un DMA

 IO: RAM_128_32_master_slave PORT MAP (CLK => CLK, reset => reset, ADDR => DMA_addr_IO, Din => DMA_IO_out, WE => DMA_IO_WE, RE => DMA_IO_RE, DMA_sync => DMA_sync, IO_sync => IO_sync, Dout => IO_Dout);
 -- DMA
 
 my_DMA: DMA port map ( clk, reset, bus_addr, Bus_data, Bus_WE, Bus_RE, IO_sync, IO_Dout, DMA_ack, DMA_enable, DMA_req, DMA_MD_RE, DMA_MD_WE, DMA_IO_RE, DMA_IO_WE, DMA_sync, DMA_addr_IO, DMA_addr, DMA_IO_out, DMA_bus_out);
  
 -- salida
Dout <= MD_Dout when MD_enable='1' else  -- el procesador puede leer directamente la memoria MD o los registros del DMA
         DMA_bus_out when DMA_enable='1' else
         x"00000000";    
                

end Behavioral;

