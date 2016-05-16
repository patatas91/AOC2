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
entity RAM_128_32 is port (
		  CLK : in std_logic;
		   enable: in std_logic; --solo se lee o escribe si enable está activado
		  ADDR : in std_logic_vector (31 downto 0); --Dir 
        Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
        WE : in std_logic;		-- write enable	
		  RE : in std_logic;		-- read enable		  
		  Dout : out std_logic_vector (31 downto 0));
end RAM_128_32;

architecture Behavioral of RAM_128_32 is
type RamType is array(0 to 127) of std_logic_vector(31 downto 0);
signal RAM : RamType := (  X"44444444", X"55555555", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", X"FFFFFFFF", -- posiciones 0,1,2,3,4,5,6,7
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
signal dir_7:  std_logic_vector(6 downto 0); 
begin
 
 dir_7 <= ADDR(8 downto 2); -- como la memoria es de 128 plalabras no usamos la dirección completa sino sólo 7 bits. Como se direccionan los bytes, pero damos palabras no usamos los 2 bits menos significativos
 process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (WE = '1') and (enable ='1') then -- sólo se escribe si WE vale 1
                RAM(conv_integer(dir_7)) <= Din;
            end if;
        end if;
    end process;

    Dout <= RAM(conv_integer(dir_7)) when (RE='1') and (enable ='1') else "00000000000000000000000000000000"; --sólo se lee si RE vale 1

end Behavioral;

