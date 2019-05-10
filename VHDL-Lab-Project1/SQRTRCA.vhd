LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SQRTRCA IS
	PORT( A,B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			cin : IN STD_LOGIC;
			S	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			cout : OUT STD_LOGIC);
END SQRTRCA;

ARCHITECTURE BEHAVIOR OF SQRTRCA IS

	COMPONENT FullAdder 
		PORT(A,B,cin : IN STD_LOGIC;
				S,cout : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT MUX2_1
		PORT(A, B, SEL : IN STD_LOGIC;
				F : OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL sigCOUT_0, sigCOUT_1,sigCOUT : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL xorB,Sum1,Sum0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	BEGIN
	
	genNum: FOR I IN 0 TO 3 GENERATE
		xorB_Gen: IF I <= 3 GENERATE
		xorB(I) <= B(I) XOR cin;
		END GENERATE xorB_Gen;
	END GENERATE genNum;
	
	FA1: FullAdder Port Map(A=>A(0), B=>xorB(0), cin=>cin, S=>S(0), cout=>sigCOUT(0));
	FA2: FullAdder Port Map(A=>A(1), B=>xorB(1), cin=>sigCOUT(0), S=>S(1), cout=>sigCOUT(1));
	
	FA3_0: FullAdder Port Map(A=>A(2), B=>xorB(2), cin=>'0', S=>Sum0(2), cout=>sigCOUT_0(2));
	FA4_1: FullAdder Port Map(A=>A(2), B=>xorB(2), cin=>'1', S=>Sum1(2), cout=>sigCOUT_1(2));
	MUX2_1_0: MUX2_1 PORT MAP(A=>Sum0(2), B=>Sum1(2), SEL=>sigCOUT(1), F=>S(2));

	FA3_00: FullAdder Port Map(A=>A(3), B=>xorB(3), cin=>sigCOUT_0(2), S=>Sum0(3), cout=>sigCOUT_0(3));
	FA4_11: FullAdder Port Map(A=>A(3), B=>xorB(3), cin=>sigCOUT_1(2), S=>Sum1(3), cout=>sigCOUT_1(3));
	MUX2_1_1: MUX2_1 PORT MAP(A=>Sum0(3), B=>Sum1(3), SEL=>sigCOUT(1), F=>S(3));
	
	MUX2_1_2: MUX2_1 PORT MAP(A=>sigCOUT_0(3), B=>sigCOUT_1(3), SEL=>sigCOUT(1), F=>cout);
	
END BEHAVIOR;
	
