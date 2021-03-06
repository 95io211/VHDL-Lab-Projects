LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;

ENTITY RCABEHAVIORAL IS
	GENERIC(N: INTEGER :=9);
	PORT( A,B : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			cin : IN STD_LOGIC;
			S	: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			cout : OUT STD_LOGIC);
END RCABEHAVIORAL;

ARCHITECTURE BEHAVIOR OF RCABEHAVIORAL IS
	
SIGNAL Sum : STD_LOGIC_VECTOR(N DOWNTO 0);

BEGIN
	Sum<= ('0' & A) + ('0' & B) + cin;
	S<= Sum(N-1 DOWNTO 0);
	cout<= Sum(N);
	
END BEHAVIOR;
	
