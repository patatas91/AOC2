----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:38:18 05/15/2014 
-- Design Name: 
-- Module Name:    UC_slave - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC_MC is
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
end UC_MC;

architecture Behavioral of UC_MC is
	type state_type is (S0, S1, S2, S3); -- S0: iddle; S1: leemos 1º pal; S2: enviamos y leemos palabra, S3: escribimos palabra
   signal state, next_state : state_type; 
   
begin
 
 
--Insert the following in the architecture after the begin keyword
   SYNC_PROC: process (clk)
   begin
      if (clk'event and clk = '1') then
         if (reset = '1') then
            state <= S0;
         else
            state <= next_state;
         end if;        
      end if;
   end process;
 
   --MEALY State-Machine - Outputs based on state and inputs
   OUTPUT_DECODE: process (state, RE, hit)
   begin
			  -- valores por defecto, si no se asigna otro valor en un estado valdrán lo que se asigna aquí
		   RE_MI <= '0';
           palabra_UC <= "00";
           WE_MC_I <= '0';
           WE_MC_tags <= '0';
           RE_MC <= RE;--leemos en la cache si se solicita una lectura de una instrucción
           ready <= '0';
           mux_palabra <= '0';
           next_state <= state;  
        if (state = S0 and RE= '0') then -- si no piden nada no hacemos nada
				ready <= '0';
         	next_state <= S0;
        elsif (state = S0 and RE= '1' and  hit='1') then -- si piden y es acierto mandamos el dato
         	ready <= '1';
         	next_state <= S0;
         	mux_palabra <= '0';
		elsif (state = S0 and RE= '1' and  hit='0') then -- si piden y es fallo empezamos a traer el bloque de MP a MC_I
				ready <= '0';
         	next_state <= S1;
         	WE_MC_I <= '1';
         	RE_MI <= '1';
         	palabra_UC <= "00";
         	mux_palabra <= '1';
		elsif state= S1 then -- traemos la segunda palabra
			ready <= '0';
         	next_state <= S2;
         	WE_MC_I <= '1';
         	RE_MI <= '1';
         	palabra_UC <= "01";
         	mux_palabra <= '1';
		elsif state =S2 then -- traemos la tercera palabra
			ready <= '0';
         	next_state <= S3;
         	WE_MC_I <= '1';
         	RE_MI <= '1';
         	palabra_UC <= "10";
         	mux_palabra <= '1';
		elsif state =S3 then -- traemos la última y volvemos a S0 dónde esta vez será un acierto
			ready <= '0';
         	next_state <= S0;
         	WE_MC_I <= '1';
         	RE_MI <= '1';
         	WE_MC_tags <= '1'; --escribimos la nueva etiqueta para que en el ciclo siguiente tengamos un acierto
         	palabra_UC <= "11";
         	mux_palabra <= '1';
      end if;
   end process;
 
   
end Behavioral;

