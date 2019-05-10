LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCABEHAVIORAL IS
	PORT( A,B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			cin : IN STD_LOGIC;
			S	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			cout : OUT STD_LOGIC);
END RCABEHAVIORAL;

ARCHITECTURE BEHAVIOR OF RCABEHAVIORAL IS
	
SIGNAL nA : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL wcout : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Sum : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
nA <= NOT A;
S(0)<= (nA(0) AND (B(0) XOR cin)) OR (A(0) AND (NOT(B(0) XOR cin)));
wcout(0)<= (A(0) AND B(0)) OR (cin AND (A(0) XOR B(0)));

S(1)<= (nA(1) AND (B(1) XOR wcout(0))) OR (A(1) AND (NOT(B(1) XOR wcout(0))));
wcout(1)<= (A(1) AND B(1)) OR (wcout(0) AND (A(1) XOR B(1)));

S(2)<= (nA(2) AND (B(2) XOR wcout(1))) OR (A(2) AND (NOT(B(2) XOR wcout(1))));
wcout(2)<= (A(2) AND B(2)) OR (wcout(1) AND (A(2) XOR B(2)));

S(3)<= (nA(3) AND (B(3) XOR wcout(2))) OR (A(3) AND (NOT(B(3) XOR wcout(2))));
cout <= (A(3) AND B(3)) OR (wcout(2) AND (A(3) XOR B(3)));
	
END BEHAVIOR;
	
