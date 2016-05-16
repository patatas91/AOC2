----------------------------------------------------------------------------------
-- Description: Mips segmentado tal y como lo hemos estudiado en clase. Sus características son:
-- Saltos 1-retardados
-- instrucciones aritméticas, LW, SW y BEQ
-- MI y MD de 128 palabras de 32 bits
-- Registro de salida de 32 bits mapeado en la dirección FFFFFFFF. Si haces un SW en esa dirección se escribe en este registro y no en la memoria
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity MIPs_segmentado is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  output : out  STD_LOGIC_VECTOR (31 downto 0));
end MIPs_segmentado;

architecture Behavioral of MIPs_segmentado is
component reg32 is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component adder32 is
    Port ( Din0 : in  STD_LOGIC_VECTOR (31 downto 0);
           Din1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component mux2_1 is
  Port (   DIn0 : in  STD_LOGIC_VECTOR (31 downto 0);
           DIn1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  ctrl : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component memoriaRAM_D is port (
		  CLK : in std_logic;
		  ADDR : in std_logic_vector (31 downto 0); --Dir 
        Din : in std_logic_vector (31 downto 0);--entrada de datos para el puerto de escritura
        WE : in std_logic;		-- write enable	
		  RE : in std_logic;		-- read enable		  
		  Dout : out std_logic_vector (31 downto 0));
end component;

component memoriaRAM_I_MC is port (
		  CLK : in std_logic;
		  reset : in  STD_LOGIC; -- resetea el controlador de la Memoria Cache
		  ADDR : in std_logic_vector (31 downto 0); --Dir 
       	  RE : in std_logic;		-- read enable		 
       	  ready : out   std_logic;  -- indica si podemos leer la palabra solicitada
		  Dout : out std_logic_vector (31 downto 0));
end component;

component Banco_ID is
 Port ( 	IR_in : in  STD_LOGIC_VECTOR (31 downto 0); -- instrucción leida en IF
         PC4_in:  in  STD_LOGIC_VECTOR (31 downto 0); -- PC+4 sumado en IF
			clk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
         load : in  STD_LOGIC;
         IR_ID : out  STD_LOGIC_VECTOR (31 downto 0); -- instrucción en la etapa ID
         PC4_ID:  out  STD_LOGIC_VECTOR (31 downto 0)); -- PC+4 en la etapa ID
end component;

COMPONENT BReg
    PORT(
         clk : IN  std_logic;
			reset : in  STD_LOGIC;
         RA : IN  std_logic_vector(4 downto 0);
         RB : IN  std_logic_vector(4 downto 0);
         RW : IN  std_logic_vector(4 downto 0);
         BusW : IN  std_logic_vector(31 downto 0);
         RegWrite : IN  std_logic;
         BusA : OUT  std_logic_vector(31 downto 0);
         BusB : OUT  std_logic_vector(31 downto 0)
        );
END COMPONENT;

component Ext_signo is
    Port ( inm : in  STD_LOGIC_VECTOR (15 downto 0);
           inm_ext : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component two_bits_shifter is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component UC is
    Port ( IR_op_code : in  STD_LOGIC_VECTOR (5 downto 0);
           Branch : out  STD_LOGIC;
           RegDst : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC);
end component;

COMPONENT Banco_EX
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         load : IN  std_logic;
         busA : IN  std_logic_vector(31 downto 0);
         busB : IN  std_logic_vector(31 downto 0);
         busA_EX : OUT  std_logic_vector(31 downto 0);
         busB_EX : OUT  std_logic_vector(31 downto 0);
			inm_ext: IN  std_logic_vector(31 downto 0);
			inm_ext_EX: OUT  std_logic_vector(31 downto 0);
         RegDst_ID : IN  std_logic;
         ALUSrc_ID : IN  std_logic;
         MemWrite_ID : IN  std_logic;
         MemRead_ID : IN  std_logic;
         MemtoReg_ID : IN  std_logic;
         RegWrite_ID : IN  std_logic;
         RegDst_EX : OUT  std_logic;
         ALUSrc_EX : OUT  std_logic;
         MemWrite_EX : OUT  std_logic;
         MemRead_EX : OUT  std_logic;
         MemtoReg_EX : OUT  std_logic;
         RegWrite_EX : OUT  std_logic;
			 ALUctrl_ID: in STD_LOGIC_VECTOR (2 downto 0);
			  ALUctrl_EX: out STD_LOGIC_VECTOR (2 downto 0);
         Reg_Rt_ID : IN  std_logic_vector(4 downto 0);
         Reg_Rd_ID : IN  std_logic_vector(4 downto 0);
         Reg_Rt_EX : OUT  std_logic_vector(4 downto 0);
         Reg_Rd_EX : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;

    COMPONENT ALU
    PORT(
         DA : IN  std_logic_vector(31 downto 0);
         DB : IN  std_logic_vector(31 downto 0);
         ALUctrl : IN  std_logic_vector(2 downto 0);
         Dout : OUT  std_logic_vector(31 downto 0)
               );
    END COMPONENT;
	 
	 component mux2_5bits is
		  Port (   DIn0 : in  STD_LOGIC_VECTOR (4 downto 0);
					  DIn1 : in  STD_LOGIC_VECTOR (4 downto 0);
					  ctrl : in  STD_LOGIC;
					  Dout : out  STD_LOGIC_VECTOR (4 downto 0));
		end component;
	
COMPONENT Banco_MEM
    PORT(
         ALU_out_EX : IN  std_logic_vector(31 downto 0);
         ALU_out_MEM : OUT  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         load : IN  std_logic;
         MemWrite_EX : IN  std_logic;
         MemRead_EX : IN  std_logic;
         MemtoReg_EX : IN  std_logic;
         RegWrite_EX : IN  std_logic;
         MemWrite_MEM : OUT  std_logic;
         MemRead_MEM : OUT  std_logic;
         MemtoReg_MEM : OUT  std_logic;
         RegWrite_MEM : OUT  std_logic;
         BusB_EX : IN  std_logic_vector(31 downto 0);
         BusB_MEM : OUT  std_logic_vector(31 downto 0);
         RW_EX : IN  std_logic_vector(4 downto 0);
         RW_MEM : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
 
    COMPONENT Banco_WB
    PORT(
         ALU_out_MEM : IN  std_logic_vector(31 downto 0);
         ALU_out_WB : OUT  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         MDR : OUT  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         load : IN  std_logic;
         MemtoReg_MEM : IN  std_logic;
         RegWrite_MEM : IN  std_logic;
         MemtoReg_WB : OUT  std_logic;
         RegWrite_WB : OUT  std_logic;
         RW_MEM : IN  std_logic_vector(4 downto 0);
         RW_WB : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT; 

signal load_PC, PCSrc, RegWrite_ID, RegWrite_EX, RegWrite_MEM, RegWrite_WB, Z, Branch, RegDst_ID, RegDst_EX, ALUSrc_ID, ALUSrc_EX, MI_ready, avanzar_F, avanzar_ID, Mem_I_RE: std_logic;
signal riesgo_rs_d1, riesgo_rs_d2, riesgo_rt_d1, riesgo_rt_d2: std_logic;
signal Op_code_ID: std_logic_vector (5 downto 0);
signal MemtoReg_ID, MemtoReg_EX, MemtoReg_MEM, MemtoReg_WB, MemWrite_ID, MemWrite_EX, MemWrite_MEM, MemRead_ID, MemRead_EX, MemRead_MEM: std_logic;
signal PC_in, PC_out, four, PC4, DirSalto, IR_in, IR_ID, PC4_ID, inm_ext_EX, Mux_out : std_logic_vector(31 downto 0);
signal BusW, BusA, BusB, BusA_EX, BusB_EX, BusB_MEM, inm_ext, inm_ext_x4, ALU_out_EX, ALU_out_MEM, ALU_out_WB, Mem_out, MDR, MI_out : std_logic_vector(31 downto 0);
signal RW_EX, RW_MEM, RW_WB, Reg_Rd_EX, Reg_Rt_EX: std_logic_vector(4 downto 0);
signal ALUctrl_ID, ALUctrl_EX : std_logic_vector(2 downto 0);
begin
--********************************************************************************************************************
------------------------------------------Etapa IF-------------------------------------------------------------------
--********************************************************************************************************************
pc: reg32 port map (	Din => PC_in, clk => clk, reset => reset, load => load_PC, Dout => PC_out);

four <= "00000000000000000000000000000100";

adder_4: adder32 port map (Din0 => PC_out, Din1 => four, Dout => PC4);

muxPC: mux2_1 port map (Din0 => PC4, DIn1 => DirSalto, ctrl => PCSrc, Dout => PC_in);

Mem_I: memoriaRAM_I_MC PORT MAP (CLK => CLK, reset => reset, ADDR => PC_out, RE => Mem_I_RE, ready => MI_ready, Dout => MI_out);

Mem_I_RE <= not branch;--si la instrucción en D es un salto no leemos la MI para no dar falsos fallos de cache

IR_in(25 downto 0) <= MI_out(25 downto 0); -- mandamos la instrucción hacia adelante, pero el código de operación a veces lo podemos cambiar

--////////////////////INCLUIR AQUÍ EL CÓDIGO DE gestión de la parada en Fetch////////////////////////////////////


-- SI SALTO O M_I LISTA -> LOAD_PC = 1
actualizarPC: process (Branch, MI_ready, avanzar_ID)
begin
	if ((Branch = '1' OR MI_READY = '1') AND avanzar_ID = '1') then
		load_PC <= '1'; 
		avanzar_F <= '1';
	else
		load_PC <= '0'; 
		avanzar_F <= '0';
	end if;	
end process;
	
IR_in(31 downto 26) <= MI_out(31 downto 26) when avanzar_F='1' else "000000"; -- SUSTITUIR LAS Xs POR EL VALOR CORRECTO. Si paramos IF y no ID ¿qué código hay que mandar hacia adelante?
 
--********************************************************************************************************************
------------------------------------------Etapa ID-------------------------------------------------------------------
--********************************************************************************************************************
--////////////////////INCLUIR AQUÍ EL CÓDIGO DE gestión de la parada en ID////////////////////////////////////

Banco_IF_ID: Banco_ID port map (	IR_in => IR_in, PC4_in => PC4, clk => clk, reset => reset, load => avanzar_ID, IR_ID => IR_ID, PC4_ID => PC4_ID);

		
-- COMPROBAMOS RIESGOS / STORE, ARIT, LOAD, BEQ
DetectarRiesgos: process (IR_ID, RegWrite_EX, RegWrite_MEM, MemtoReg_MEM, RW_EX, RW_MEM, riesgo_rs_d1, riesgo_rs_d2, riesgo_rt_d1, riesgo_rt_d2)
begin
	riesgo_rs_d1 <= '0'; --riesgo de datos en rs con la instrucción que hay en EX. 
    riesgo_rs_d2 <= '0'; --riesgo de datos en rs con la instrucción que hay en Mem
    riesgo_rt_d1 <= '0'; --riesgo de datos en rt con la instrucción que hay en EX 
	riesgo_rt_d2 <= '0'; --riesgo de datos en rt con la instrucción que hay en Mem 
	-- STORE, ARIT Y BEQ -> Riesgos con LOAD Y ARIT
	if (IR_ID(31 downto 26)= "000011" OR IR_ID(31 downto 26)= "000001" OR IR_ID(31 downto 26)= "000100") then
		--EX / Comprobamos si es un un load o aritmetica la de EX
		if(RegWrite_EX='1') then			
			if(IR_ID(25 downto 21) = RW_EX) then
				riesgo_rs_d1 <= '1';
			end if;
			if(IR_ID(20 downto 16) = RW_EX) then
				riesgo_rt_d1 <= '1';
			end if;
		end if;
		--MEM / Comprobamos si es un un load o aritmetica la de MEM
		if(RegWrite_MEM='1') then			
			if(IR_ID(25 downto 21) = RW_MEM) then
				riesgo_rs_d2 <= '1';
			end if;
			if(IR_ID(20 downto 16) = RW_MEM) then
				riesgo_rt_d2 <= '1';
			end if;
		end if;
	-- LOAD - Riesgos con ARIT
	elsif (IR_ID(31 downto 26)= "000010") then
		--EX / Comprobamos si es una aritmetica la de EX
		if(regDst_EX='1') then			
			if(IR_ID(20 downto 16) = RW_EX) then
				riesgo_rt_d1 <= '1';
			end if;
		end if;
		--MEM / Comprobamos si es una aritmetica la de MEM
		if(MemtoReg_MEM='0' AND RegWrite_MEM='1') then			
			if(IR_ID(20 downto 16) = RW_MEM) then
				riesgo_rt_d2 <= '1';
			end if;
		end if;
	end if;		

	-- COMPROBAMOS SI HA HABIDO ALGUN RIESGO
	if (riesgo_rs_d1 = '1' OR riesgo_rs_d2 = '1' OR riesgo_rt_d1 = '1' OR  riesgo_rt_d2 = '1') then
		avanzar_ID <= '0';		
	end if;
	if (riesgo_rs_d1 = '0' AND riesgo_rs_d2 = '0' AND riesgo_rt_d1 = '0' AND  riesgo_rt_d2 = '0') then
		avanzar_ID <= '1';		
	end if;
end process;

Op_code_ID <= IR_ID(31 downto 26) when avanzar_ID='1' else "000000";-- SUSTITUIR LAS Xs POR EL VALOR CORRECTO. Si paramos ID ¿qué señales de control hay que mandar hacia adelante?
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////


Register_bank: BReg PORT MAP (clk => clk, reset => reset, RA => IR_ID(25 downto 21), RB => IR_ID(20 downto 16), RW => RW_WB, BusW => BusW, 
									RegWrite => RegWrite_WB, BusA => BusA, BusB => BusB);

sign_ext: Ext_signo port map (inm => IR_ID(15 downto 0), inm_ext => inm_ext);

two_bits_shift: two_bits_shifter	port map (Din => inm_ext, Dout => inm_ext_x4);

adder_dir: adder32 port map (Din0 => inm_ext_x4, Din1 => PC4_ID, Dout => DirSalto);

Z <= '1' when (busA=busB) else '0';


UC_seg: UC port map (IR_op_code => Op_code_ID, Branch => Branch, RegDst => RegDst_ID,  ALUSrc => ALUSrc_ID, MemWrite => MemWrite_ID,  
							MemRead => MemRead_ID, MemtoReg => MemtoReg_ID, RegWrite => RegWrite_ID);

				
-- si la operación es aritmética (es decir: IR_ID(31 downto 26)= "000001") miro el campo funct
-- como sólo hay 4 operaciones en la alu, basta con los bits menos significativos del campo func de la instrucción	
-- si no es aritmética le damos el valor de la suma (000)
ALUctrl_ID <= IR_ID(2 downto 0) when IR_ID(31 downto 26)= "000001" else "000"; 


PCSrc <= Branch AND Z; -- Ahora mismo sólo esta implementada la instrucción de salto BEQ. Si es una instrucción de salto y se activa la señal Z se carga la dirección de salto, sino PC+4 											
--********************************************************************************************************************
------------------------------------------Etapa EX-------------------------------------------------------------------
--********************************************************************************************************************

Banco_ID_EX: Banco_EX PORT MAP ( clk => clk, reset => reset, load => '1', busA => busA, busB => busB, busA_EX => busA_EX, busB_EX => busB_EX,
											RegDst_ID => RegDst_ID, ALUSrc_ID => ALUSrc_ID, MemWrite_ID => MemWrite_ID, MemRead_ID => MemRead_ID,
											MemtoReg_ID => MemtoReg_ID, RegWrite_ID => RegWrite_ID, RegDst_EX => RegDst_EX, ALUSrc_EX => ALUSrc_EX,
											MemWrite_EX => MemWrite_EX, MemRead_EX => MemRead_EX, MemtoReg_EX => MemtoReg_EX, RegWrite_EX => RegWrite_EX,
											ALUctrl_ID => ALUctrl_ID, ALUctrl_EX => ALUctrl_EX, inm_ext => inm_ext, inm_ext_EX=> inm_ext_EX,
											Reg_Rt_ID => IR_ID(20 downto 16), Reg_Rd_ID => IR_ID(15 downto 11), Reg_Rt_EX => Reg_Rt_EX, Reg_Rd_EX => Reg_Rd_EX);		

muxALU_src: mux2_1 port map (Din0 => busB_EX, DIn1 => inm_ext_EX, ctrl => ALUSrc_EX, Dout => Mux_out);

ALU_MIPs: ALU PORT MAP ( DA => BusA_EX, DB => Mux_out, ALUctrl => ALUctrl_EX, Dout => ALU_out_EX);

mux_dst: mux2_5bits port map (Din0 => Reg_Rt_EX, DIn1 => Reg_Rd_EX, ctrl => RegDst_EX, Dout => RW_EX);


--********************************************************************************************************************
------------------------------------------Etapa MEM-------------------------------------------------------------------
--********************************************************************************************************************

Banco_EX_MEM: Banco_MEM PORT MAP ( ALU_out_EX => ALU_out_EX, ALU_out_MEM => ALU_out_MEM, clk => clk, reset => reset, load => '1', MemWrite_EX => MemWrite_EX,
												MemRead_EX => MemRead_EX, MemtoReg_EX => MemtoReg_EX, RegWrite_EX => RegWrite_EX, MemWrite_MEM => MemWrite_MEM, MemRead_MEM => MemRead_MEM,
												MemtoReg_MEM => MemtoReg_MEM, RegWrite_MEM => RegWrite_MEM, BusB_EX => BusB_EX, BusB_MEM => BusB_MEM, RW_EX => RW_EX, RW_MEM => RW_MEM);

Mem_D: memoriaRAM_D PORT MAP (CLK => CLK, ADDR => ALU_out_MEM, Din => BusB_MEM, WE => MemWrite_MEM, RE => MemRead_MEM, Dout => Mem_out);

Banco_MEM_WB: Banco_WB PORT MAP ( ALU_out_MEM => ALU_out_MEM, ALU_out_WB => ALU_out_WB, Mem_out => Mem_out, MDR => MDR, clk => clk, reset => reset, load => '1', MemtoReg_MEM => MemtoReg_MEM, RegWrite_MEM => RegWrite_MEM, 
											MemtoReg_WB => MemtoReg_WB, RegWrite_WB => RegWrite_WB, RW_MEM => RW_MEM, RW_WB => RW_WB );
mux_busW: mux2_1 port map (Din0 => ALU_out_WB, DIn1 => MDR, ctrl => MemtoReg_WB, Dout => busW);

output <= IR_ID;
end Behavioral;

