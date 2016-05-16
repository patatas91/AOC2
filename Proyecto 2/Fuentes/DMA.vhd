----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:12:11 04/04/2014 
-- Design Name: 
-- Module Name:    DMA - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity DMA is port (
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
end DMA;

architecture Behavioral of DMA is
component reg8 is
    Port ( Din : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component reg32 is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component counter is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           count_enable : in  STD_LOGIC;
           load : in  STD_LOGIC;
           D_in  : in  STD_LOGIC_VECTOR (7 downto 0);
		   count : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

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

signal load_reg_control, load_reg_DMA, count_enable, reset_count, empezar, load_data, update_done, bit7_control_in, fin, L_E: std_logic;
signal Dout_reg_control, Dout_num_palabras, palabra_inicial_MD, cuenta_palabras, palabra_inicial_IO, palabra_MD, control_in:  STD_LOGIC_VECTOR (7 downto 0);
signal reg_DMA, reg_data_in, reg_datos_DMA : STD_LOGIC_VECTOR (31 downto 0);

begin
-- interfaz con el MIPS
 load_reg_DMA <= '1' when Addr = x"00000200" AND WE = '1' else '0'; -- escribimos en el registro si el mips indica su dirección en un store 

 load_reg_control <= update_done or load_reg_DMA; -- update control se activa para poner el bit done a 1
 
control_in <= Din(7 downto 0) when update_done='0' else '1'&Dout_reg_control(6 downto 0); -- Si activamos update_done es que queremos indicar que hemos terminado poniendo un 1 en el bit 7 y mantener el resto

 
 reg_control: reg8 port map (Din => control_in, clk => clk, reset => reset, load => load_reg_control, Dout => Dout_reg_control);
 
 reg_num_palabras: reg8 port map (Din => Din(15 downto 8), clk => clk, reset => reset, load => load_reg_DMA, Dout => Dout_num_palabras);
 
 reg_addr_MD: reg8 port map (Din => Din(23 downto 16), clk => clk, reset => reset, load => load_reg_DMA, Dout => palabra_inicial_MD);
 
 reg_addr_IO: reg8 port map (Din => Din(31 downto 24), clk => clk, reset => reset, load => load_reg_DMA, Dout => palabra_inicial_IO);
 
 -- reg_DMA son los 4 registros de 8 bits juntos
 reg_DMA <= palabra_inicial_IO&palabra_inicial_MD&Dout_num_palabras&Dout_reg_control;
 
 -- calculo direcciones 
 
 cont_palabras: counter port map (clk => clk, reset => reset, count_enable => count_enable, load=> reset_count, D_in => "00000000", count => cuenta_palabras);
 
 --/////////////////////////
 DMA_addr_IO <= palabra_inicial_IO(6 downto 0) + cuenta_palabras(6 downto 0); -- dirección para el periferico

 palabra_MD <= palabra_inicial_MD + cuenta_palabras;
 
 --/////////////////////////
 DMA_Addr <= "0000000000000000000000"&palabra_MD&"00"; -- Dirección de la MD
 
 -- detección del fin
 
fin <= '1' when cuenta_palabras = Dout_num_palabras else '0';
 
 -- registros de datos
 reg_data_in <= DMA_IO_in when L_E= '1' else Din; --cuando escribe /de IO a MD
 reg_data: reg32 port map (Din => reg_data_in, clk => clk, reset => reset, load => load_data, Dout => reg_datos_DMA);
 
 -- UC
 empezar <= Dout_reg_control(0) and not Dout_reg_control(7); --empezamos si el bit d emepezar está activo y el de done esta a 0
 L_E <= Dout_reg_control(1); --indica si es lectura (0) o escritura(1) en MD
  
 U_control_DMA: UC_DMA port map ( clk, reset, empezar, fin, L_E, DMA_ack, IO_sync, update_done, DMA_req, reset_count, count_enable, load_data, DMA_MD_RE, DMA_MD_WE, DMA_IO_RE, DMA_IO_WE, DMA_sync);
  --Salida
    
  DMA_IO_out <= reg_datos_DMA; --salida para la IO
  
  DMA_bus_out <= 	reg_DMA when (Addr = x"00000200") else
	  				x"000000"&cuenta_palabras when (Addr = x"00000204") else
	  				reg_datos_DMA;
	
end Behavioral;

