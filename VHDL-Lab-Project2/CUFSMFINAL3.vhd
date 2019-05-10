LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CUFSMFINAL3 IS
	PORT(A: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			Run,Reset,clk: IN STD_LOGIC;
			MUXSEL: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			IRIN,R0,R1,R2,R3,R4,R5,R6,R7,AIN,ADDSUB,GIN: OUT STD_LOGIC;
			dDONE: BUFFER STD_LOGIC);
END CUFSMFINAL3;

ARCHITECTURE BEHAVIORAL OF CUFSMFINAL3 IS

COMPONENT DECODER IS
	PORT(A: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Q: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END COMPONENT;

SIGNAL I: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL XREG,YREG: STD_LOGIC_VECTOR(7 DOWNTO 0);
TYPE FSM_STATE IS(T0,T1,T2,T3);
SIGNAL STATE: FSM_STATE;

BEGIN
I<=A(8 DOWNTO 6);
DECX: DECODER PORT MAP(A(5 DOWNTO 3),XREG);
DECY: DECODER PORT MAP(A(2 DOWNTO 0),YREG); 

ASMTRANSITION:	PROCESS(Reset,clk)
	BEGIN
	IF Reset='0' THEN
		STATE<=T0;
--	END IF;
	ELSIF clk'EVENT AND clk='1' THEN
		CASE STATE IS
			WHEN T0 =>
				IF Run='1' THEN STATE<=T1; ELSE STATE<=T0; END IF;
			WHEN T1=>
				IF dDONE='1' THEN STATE<=T0; ELSE STATE<=T2;END IF;
			WHEN T2=>
				STATE<=T2;
				IF dDONE='1' THEN STATE<=T0; ELSE STATE<=T3;END IF;
			WHEN T3=>
				IF dDONE='1' THEN STATE<=T0; ELSE STATE<=T3; END IF;
			WHEN OTHERS=>
				STATE<=T0;
			END CASE;
		END IF;
	END PROCESS;

FSMOUTPUT: PROCESS(STATE,I,XREG,YREG)
	BEGIN
	IRIN<='0';
	dDONE<='0';
	MUXSEL<="0000000000";
	ADDSUB<='0';
		CASE STATE IS
			WHEN T0 =>
				IRIN<='1';
			WHEN T1 =>
				CASE I IS
					WHEN "000" =>
						R0<=XREG(0);
						R1<=XREG(1);
						R2<=XREG(2);
						R3<=XREG(3);
						R4<=XREG(4);
						R5<=XREG(5);
						R6<=XREG(6);
						R7<=XREG(7);
						MUXSEL<="00"&YREG;
						dDONE<='1';
					WHEN "001" =>
						R0<=XREG(0);
						R1<=XREG(1);
						R2<=XREG(2);
						R3<=XREG(3);
						R4<=XREG(4);
						R5<=XREG(5);
						R6<=XREG(6);
						R7<=XREG(7);
						MUXSEL<="0100000000";
						dDONE<='1';
					WHEN "010" =>
						MUXSEL<="00"&XREG;
						AIN<='1';
					WHEN "011" =>
						MUXSEL<="00"&XREG;
						AIN<='1';
					WHEN OTHERS =>
--						MUXSEL<="00"&XREG;
--						AIN<='1';
				END CASE;
			WHEN T2 =>
				CASE I IS
					WHEN "010" =>
						MUXSEL<="00"&YREG;
						GIN<='1';
					WHEN "011" =>
						MUXSEL<="00"&YREG;
						GIN<='1';
						ADDSUB<='1';
					WHEN OTHERS =>
--						MUXSEL<="00"&YREG;
--						GIN<='1';
--						ADDSUB<='1';
				END CASE;
			WHEN T3 =>
				CASE I IS
					WHEN "010" =>
						R0<=XREG(0);
						R1<=XREG(1);
						R2<=XREG(2);
						R3<=XREG(3);
						R4<=XREG(4);
						R5<=XREG(5);
						R6<=XREG(6);
						R7<=XREG(7);
						MUXSEL<="1000000000";
						dDONE<='1';
					WHEN "011" =>
						R0<=XREG(0);
						R1<=XREG(1);
						R2<=XREG(2);
						R3<=XREG(3);
						R4<=XREG(4);
						R5<=XREG(5);
						R6<=XREG(6);
						R7<=XREG(7);
						MUXSEL<="1000000000";
						dDONE<='1';
					WHEN OTHERS =>
						--others
				END CASE;
			WHEN OTHERS =>
				--others
			END CASE;
		END PROCESS;
END BEHAVIORAL;
			