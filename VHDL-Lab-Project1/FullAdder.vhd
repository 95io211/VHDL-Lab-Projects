LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FullAdder IS
		PORT(A,B,cin 	: IN STD_LOGIC;
				cout, S	: OUT STD_LOGIC);
END FullAdder;


ARCHITECTURE IO OF FullAdder IS
BEGIN
	S <= A XOR B XOR cin;
	cout <= (A AND B) OR (A AND cin) OR (B AND cin);
END IO;