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
-- Memoria RAM de 128 oalabras de 32 bits
entity RAM_128_32_master_slave is port (
		  CLK : in std_logic;
		  reset : in  STD_LOGIC;
		  ADDR : in std_logic_vector (6 downto 0); --Dir 
          Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
          WE : in std_logic;		-- write enable	
		  RE : in std_logic;		-- read enable	
		  DMA_sync : in std_logic;  
		  IO_sync: out std_logic; 
		  Dout : out std_logic_vector (31 downto 0));
end RAM_128_32_master_slave;

architecture Behavioral of RAM_128_32_master_slave is
type RamType is array(0 to 127) of std_logic_vector(31 downto 0);
signal RAM : RamType := ( 			X"11111111", X"22222222", X"33333333", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", -- posiciones 0,1,2,3,4,5,6,7
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", --posicones 8,9,...
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF",
									X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF");

type state_type is (INI, Wait1, Wait2, Leer_escribir, Avisar, Wait3, Wait4, Wait5, Wait6); 
   signal state, next_state : state_type; 
   signal escribir: std_logic; 																		
begin
 
   SYNC_PROC: process (clk)
   begin
      if (clk'event and clk = '1') then
         if (reset = '1') then
            state <= INI;
         else
            state <= next_state;
         end if;        
      end if;
   end process;

   escritura_mem: process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (escribir = '1') then -- sólo se escribe si escribir vale 1
                RAM(conv_integer(ADDR)) <= Din;
            end if;
        end if;
    end process;

  --MEALY State-Machine - Outputs based on state and inputs
   OUTPUT_DECODE: process (state, DMA_sync, WE, RE, ADDR, Din)
   begin
			  -- valores por defecto, si no se le asigna un uno las señales valdrán 0
		   IO_sync <= '0';
		   Dout <= x"00000000";
		   next_state <= state;
		   escribir <= '0';
		 if (state = INI) then 
			if (DMA_sync= '0') then
         		next_state <= INI;
         	else
         		next_state <= Wait1;
         	end if;
         elsif state= Wait1 then
			next_state <= Wait2;
		 elsif state= Wait2 then
			next_state <= Leer_escribir;
		 elsif state= Leer_escribir then
			if WE ='1' then
         		escribir <= '1'; --se da la orden de escribir
         	elsif RE ='1' then
         		Dout <= RAM(conv_integer(ADDR));
         	end if;
         	next_state <= Avisar;
         elsif state= Avisar then
            IO_sync <= '1';
            if DMA_sync= '1' then
         		next_state <= Avisar;	
            	If RE = '1' then 
            		Dout <= RAM(conv_integer(ADDR)); --mientras no bajen DMA_sync mantenemos el dato, si lo bajan ¡lo quitamos en el acto!
         		end if;
			else
         		next_state <= Wait3;
         	end if;
         elsif state= Wait3 then
			IO_sync <= '1'; -- simulamos que el periférico tarda en bajar IO_Sync	
           	next_state <= Wait4;
		 elsif state= Wait4 then
			IO_sync <= '1'; -- simulamos que el periférico tarda en bajar IO_Sync	
           	next_state <= Wait5;
         elsif state= Wait5 then
			IO_sync <= '1'; -- simulamos que el periférico tarda en bajar IO_Sync	
           	next_state <= Wait6;
         elsif state= Wait6 then
			IO_sync <= '0'; -- Por fin lo baja
           	next_state <= INI;
         end if;
    end process;

    

end Behavioral;

