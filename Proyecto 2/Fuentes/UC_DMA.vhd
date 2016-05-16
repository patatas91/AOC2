----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:38:18 05/15/2014 
-- Design Name: 
-- Module Name:    UC_DMA - Behavioral 
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

entity UC_DMA is
     Port ( clk : in  STD_LOGIC;
          reset : in  STD_LOGIC;
          empezar: in  STD_LOGIC;
          fin: in  STD_LOGIC;
          L_E: in  STD_LOGIC; -- 0 lectura de memoria, 1 escritura en memoria
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
end UC_DMA;

architecture Behavioral of UC_DMA is
	type state_type is (INI, LEC_SYNC, LEC_SYNC_ESPERA, LEC_BUS, FIN_LECTURA, ESC_BUS, ESC_SYNC, ESC_SYNC_ESPERA) ;
   signal state, next_state : state_type; 
   
begin
 
 
--Insert the following in the architecture after the begin keyword
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
   
    --MEALY State-Machine - Outputs based on state and inputs
   OUTPUT_DECODE: process (state, empezar, fin, L_E, DMA_ack, IO_sync)
   begin
		  -- valores por defecto, si no se asigna otro valor en un estado valdrán lo que se asigna aquí
		  update_done <= '0';
		  DMA_req <= '0';
		  reset_count <= '0';
		  count_enable <= '0';
		  load_data <= '0';
		  DMA_MD_RE <= '0';
		  DMA_MD_WE <= '0';
		  DMA_IO_RE <= '0';
		  DMA_IO_WE <= '0';
		  DMA_sync <= '0';
          next_state <= state; 
		-- ESTADO INICIAL: reseteamos contador y miramos empezar y fin; comprobamos L_E
        if (state = INI) then
			if(empezar= '1' AND fin= '0') then				
				if (L_E= '0') then
					--MD-IO				
					next_state <= ESC_BUS;
				else 
					--IO-MD	
					next_state <= LEC_SYNC;					
				end if;
			else
				next_state <= INI;
			end if;
		--/////IO-MD\\\\\
		--SYNC LECTURA
		elsif (state = LEC_SYNC) then 
			-- indicamos que queremos hacer algo
			DMA_sync <= '1';
			-- activamos el reg
			load_data <= '1';
			-- Leemos de IO
			DMA_IO_WE <= '0';
			DMA_IO_RE <= '1';
			-- Si IO ha terminado
            if IO_sync= '1' then
				next_state <= LEC_SYNC_ESPERA;            	
			else
				next_state <= LEC_SYNC;
			end if;
		--ESTADO DE ESPERA A QUE IO BAJE 
		elsif (state = LEC_SYNC_ESPERA) then
			--Bajamos cuando ya tenemos cargado el dato en el registro
			DMA_sync <= '0';
			--IO ha terminado
			if(IO_sync = '0') then					
				next_state <= LEC_BUS;				
			else
				next_state <= LEC_SYNC_ESPERA;
			end if;				
		--PEDIR BUS LECTURA
		elsif (state = LEC_BUS) then
			--Pedimos el bus
			DMA_req <= '1';
			--Miramos cuando nos lo conceden
			if(DMA_ack= '1') then
				-- Escribimos en MD
				DMA_MD_RE <= '0';					
				DMA_MD_WE <= '1';					
				count_enable <= '1';
				next_state <= FIN_LECTURA;			
			else
				next_state <= LEC_BUS;							
			end if;	
		--COMPROBACION FIN LECTURA
		elsif (state = FIN_LECTURA) then			
			if(fin = '1') then
				-- Total de palabras completado
				reset_count <= '1';	
				update_done <= '1';
				next_state <= INI;
			else 
				-- Volvemos a leer de IO
				next_state <= LEC_SYNC;	
			end if;	
		--/////MD-IO\\\\\	
		--PEDIR BUS ESCRITURA
		elsif (state = ESC_BUS) then
			--Pedimos el bus
			DMA_req <= '1';
			--Miramos cuando nos lo conceden
			if(DMA_ack= '1') then
				-- activamos el registro
				load_data <= '1';
				-- Leemos de MD
				DMA_MD_RE <= '1';
				DMA_MD_WE <= '0';				
				next_state <= ESC_SYNC;				
			else
				next_state <= ESC_BUS;
			end if;						
		--SYNC ESCRITURA
		elsif (state = ESC_SYNC) then
			-- indicamos que queremos hacer algo
			DMA_sync <= '1';
			-- Escribimos en IO
			DMA_IO_WE <= '1';					
			DMA_IO_RE <= '0';
			-- Si IO ha terminado
			if IO_sync= '1' then			
				count_enable <= '1';				
				next_state <= ESC_SYNC_ESPERA;		
			else 
				next_state <= ESC_SYNC;
			end if;	
		--ESTADO DE ESPERA A QUE IO BAJE ESCRITURA / COMPROBACION FIN 
		elsif (state = ESC_SYNC_ESPERA) then
			DMA_sync <= '0';
			--IO ha terminado
			if(IO_sync = '0') then					
				if(fin = '1') then
					-- Total de palabras completado
					reset_count <= '1';	
					update_done <= '1';
					next_state <= INI;
				else 
					-- Si no fin vuelve a leer de MD
					next_state <= ESC_BUS;	
				end if;	
			else
				next_state <= ESC_SYNC_ESPERA;
			end if;		
		end if;
	
	end process;
   
end Behavioral;

