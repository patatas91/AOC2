----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:38:16 04/08/2014 
-- Design Name: 
-- Module Name:    memoriaRAM_I - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Memoria de 128 instrucciones sólo de lectura con una cache con 4 bloques de 4 instrucciones con emplazamiento directo
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

entity memoriaRAM_I_MC is port (
		  CLK : in std_logic;
		  reset : in  STD_LOGIC;
		  ADDR : in std_logic_vector (31 downto 0); --Dir 
          RE : in std_logic;		-- read enable		
          ready : out  std_logic;  -- indica si podemos leer la palabra solicitada
		  Dout : out std_logic_vector (31 downto 0));
end memoriaRAM_I_MC;

architecture Behavioral of memoriaRAM_I_MC is

component UC_MC is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   RE : in  STD_LOGIC;
		   hit : in  STD_LOGIC;
           RE_MI : out  STD_LOGIC;
           palabra_UC : out  STD_LOGIC_VECTOR (1 downto 0);
           mux_palabra: out STD_LOGIC;
           WE_MC_I : out  STD_LOGIC;
           WE_MC_tags : out  STD_LOGIC;
           RE_MC : out  STD_LOGIC;
           ready : out  STD_LOGIC);
end component;

component reg4 is
    Port ( Din : in  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           Dout :out  STD_LOGIC_VECTOR (3 downto 0));
end component;			  
-- definimos la memoria de instrucciones (MI) como un array de 128 palabras de 32 bits
type Rom_MI is array(0 to 127) of std_logic_vector(31 downto 0);
signal Mem_I : Rom_MI := (  X"08000000", X"08010004", X"04200000", X"04000000",  X"08010008", X"04200000", X"0C00000C",  X"1000FFF8", -- posiciones 0,1,2,3,4,5,6,7 EN HEXADECIMAL
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", --posicones 8,9,...
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", 
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");
-- definimos la memoria de contenidos de la cache de instrucciones como un array de 16 palabras de 32 bits
type Ram_MC_I is array(0 to 15) of std_logic_vector(31 downto 0);
signal MC_I : Ram_MC_I := (  		X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", -- posiciones 0,1,2,3,4,5,6,7 EN HEXADECIMAL
									X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");									
-- definimos la memoria de etiquetas de la cache de instrucciones como un array de 4 palabras de 26 bits
type Ram_MC_Tags is array(0 to 3) of std_logic_vector(25 downto 0);
signal MC_Tags : Ram_MC_Tags := (  		"00000000000000000000000000", "00000000000000000000000000", "00000000000000000000000000", "00000000000000000000000000");												
signal valid_bits_in, valid_bits_out, mask: std_logic_vector(3 downto 0); -- se usa para saber si un bloque tiene info válida. Cada bit representa un bloque.									
signal dir_MI:  std_logic_vector(6 downto 0); -- se usa para acceder a la Memoria princial de 128 palabras
signal dir_cjto: std_logic_vector(1 downto 0); -- se usa para elegir el cjto al que se accede en la cache de instrucciones. 
signal dir_palabra: std_logic_vector(1 downto 0); -- se usa para elegir la instrucción solicitada de un determinado bloque. 
signal RE_MI, RE_MC, mux_palabra, WE_MC_I, WE_MC_Tags, hit, valid_bit: std_logic;
signal palabra_UC: std_logic_vector(1 downto 0); --se usa al traer un bloque nuevo a la MC (va cambiando de valos para traer todas las palabras)
signal dir_MC_I: std_logic_vector(3 downto 0); -- se usa para leer/escribir las instrucciones almacenas en al MC. 
signal Dout_MI: std_logic_vector (31 downto 0);
signal Dout_MC_Tags: std_logic_vector(25 downto 0); 
begin
-- IMPORTANTE : HAY QUE SUSTITUIR LAS XXS POR LOS VALORES CORRECTOS 
-- PARA ELLO HAY QUE DESCOMPONER LA DIRECCIÓN E IDENTIFICAR LOS BITS DE CONJUNTO, ETIQUETA Y PALABRA
--- MI: memoria de instrucciones-----------------------------------------------------------------
 dir_MI <= ADDR(8 downto 4)&palabra_UC; -- Nota la memoria es de 128 plalabras cada una de 4 bytes. Las direcciones direccionan un byte, pero esta memoria siempre devuelve una palabra
 										-- cuando leemos de la MP siempre leemos un bloque entero, por eso en lugar de usar la palabra de la dirección inicial usamos la qu egener al UC (que irá pidiendo la 0, luego la 1...)		
 -- La MI es combinacional. Devuelve la palabra que le pides en el ciclo en el que se la pides
 -- Lo lógico es que fuese más lenta y tardase n ciclos en darte la primera palabra, y k ciclos en darte el resto pero para simplificar el diseño y acelerar la simulación la hemos dejado así.
 Dout_MI <= Mem_I(conv_integer(dir_MI)) when (RE_MI='1') else "00000000000000000000000000000000"; --sólo se lee si RE vale 1
-------------------------------------------------------------------------------------------------- 
 -----MC_I: memoria RAM que almacena los 4 bloques de 4 instrucciones que puede guardar la Cache
 -- dir palabra puede venir de la entrada (cuando se busca un dato solicitado) o de la Unidad de control, UC, (cuando se está escribiendo un bloque nuevo 
 dir_palabra <= ADDR(3 downto 2) when (mux_palabra='0') else palabra_UC;
 dir_cjto <= ADDR(5 downto 4);
 dir_MC_I <= dir_cjto&dir_palabra; --para direccionar una instrucción hay que especificar el cjto y la palabra.
 memoria_cache_I: process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (WE_MC_I = '1') then -- sólo se escribe si WE_MC_I vale 1
                MC_I(conv_integer(dir_MC_I)) <= Dout_MI;
            end if;
        end if;
    end process;
    Dout <= MC_I(conv_integer(dir_MC_I)) when (RE_MC='1') else "00000000000000000000000000000000"; --sólo se lee si RE_MC vale 1
-------------------------------------------------------------------------------------------------- 
-----MC_Tags: emoria RAM que almacena las 4 etiquetas

memoria_cache_tags: process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (WE_MC_tags = '1') then -- sólo se escribe si WE_MC_tags vale 1
                MC_Tags(conv_integer(dir_cjto)) <= ADDR(31 downto 6);
            end if;
        end if;
    end process;
    Dout_MC_Tags <= MC_Tags(conv_integer(dir_cjto)) when (RE_MC='1') else "00000000000000000000000000"; --sólo se lee si RE_MC vale 1
-------------------------------------------------------------------------------------------------- 
-- registro de validez. Al resetear los bits de validez se ponen a 0 así evitamos falsos positivos por basura en las memorias
-- en el bit de validez se escribe a la vez que en la memoria de etiquetas. Hay que poner a 1 el bit que toque y mantener los demás, para eso usamos una maskara generada por un decodificador
mask			<= 	"0001" when dir_cjto="00" else
						"0010" when dir_cjto="01" else
						"0100" when dir_cjto="10" else
						"1000" when dir_cjto="11" else
						"0000";
valid_bits_in <= valid_bits_out OR mask;
bits_validez: reg4 port map(	Din => valid_bits_in, clk => clk, reset => reset, load => WE_MC_tags, Dout => valid_bits_out);
-------------------------------------------------------------------------------------------------- 
valid_bit <= 	valid_bits_out(0) when dir_cjto="00" else
						valid_bits_out(1) when dir_cjto="01" else
						valid_bits_out(2) when dir_cjto="10" else
						valid_bits_out(3) when dir_cjto="11" else
						'0';
hit <= '1' when ((Dout_MC_Tags= ADDR(31 downto 6)) AND (valid_bit='1'))else '0'; --comparador que compara el tag almacenado en MC con el de la dirección y si es el mismo y el bloque tiene el bit de válido activo devuelve un 1
-------------------------------------------------------------------------------------------------- 
-----MC_UC: unidad de control
Unidad_Control: UC_MC port map (clk => clk, reset=> reset, RE => RE, hit => hit, RE_MI => RE_MI, palabra_UC => palabra_UC, mux_palabra => mux_palabra, WE_MC_I => WE_MC_I, WE_MC_tags=> WE_MC_tags, RE_MC=> RE_MC, ready=>ready);  

end Behavioral;