LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCA IS
	PORT( A,B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			cin : IN STD_LOGIC;
			S	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			cout : OUT STD_LOGIC);
END RCA;

ARCHITECTURE BEHAVIOR OF RCA IS

	COMPONENT FullAdder 
		PORT(A,B,cin : IN STD_LOGIC;
				S,cout : OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL sigCOUT : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL xorB : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	BEGIN
	
	genNum: FOR I IN 0 TO 3 GENERATE
		xorB_Gen: IF I <= 3 GENERATE
		xorB(I) <= B(I) XOR cin;
		END GENERATE xorB_Gen;
	END GENERATE genNum;
	
	FA1: FullAdder Port Map(A=>A(0), B=>xorB(0), cin=>cin, S=>S(0), cout=>sigCOUT(0));
	FA2: FullAdder Port Map(A=>A(1), B=>xorB(1), cin=>sigCOUT(0), S=>S(1), cout=>sigCOUT(1));
	FA3: FullAdder Port Map(A=>A(2), B=>xorB(2), cin=>sigCOUT(1), S=>S(2), cout=>sigCOUT(2));
	FA4: FullAdder Port Map(A=>A(3), B=>xorB(3), cin=>sigCOUT(2), S=>S(3), cout=>cout);
	
END BEHAVIOR;
	
