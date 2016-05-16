----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:12:11 04/04/2014 
-- Design Name: 
-- Module Name:    memoriaRAM - Behavioral 
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
 ENTITY IO_test IS
 END IO_test;

  ARCHITECTURE behavior OF IO_test IS 

  
  component	RAM_128_32_master_slave is port (	  
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
 
 signal clk, reset, WE, RE, DMA_sync, IO_sync : std_logic; 
 signal ADDR : std_logic_vector (6 downto 0);
 signal Din, Dout: std_logic_vector (31 downto 0);
  -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
 begin
 
 IO: RAM_128_32_master_slave PORT MAP (CLK => CLK, reset => reset, ADDR => ADDR, Din => Din, WE => WE, RE => RE, DMA_sync => DMA_sync, IO_sync => IO_sync, Dout => Dout);
 
 -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
--pruebas
 stim_proc: process
   begin		
      reset <= '1';
      DMA_sync <= '0';
      re <= '0';
      wait for CLK_period;
      reset <= '0';
      addr <= "0000010";
      Din <= x"44550201";
      we <= '1'; -- compruebo que si DMA_sync no se pone a 1 no pasa nada
      wait for CLK_period*3;
	  DMA_sync <= '1';
	  wait until IO_sync ='1'; -- debe subir IO-sync y esperar a que DMA_sync baje
	  Din <= x"00000000"; --quito el dato ya debería estar escrito
	  DMA_sync <= '0'; --debe bajar IO_sync (aunque tarda varios ciclos en hacerlo)
	  wait until IO_sync ='0';	  
	  re <= '1';
	  we <= '0';
	  wait for CLK_period*3;
	  DMA_sync <= '1';
	  wait until IO_sync ='1'; -- debe subir IO-sync y esperar a que DMA_sync baje
	  Din <= x"00000000"; --quito el dato ya debería estar escrito
	  DMA_sync <= '0'; --debe bajar IO_sync (aunque tarda varios ciclos en hacerlo)
	  wait until IO_sync ='0';	
	  wait;
   end process;
 
 end; 

