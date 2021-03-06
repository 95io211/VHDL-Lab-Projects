LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ACCUMULATOR IS
	PORT(D: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			clk,reset,EN: IN STD_LOGIC;
			AOUT: OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE BEHAVIORAL OF ACCUMULATOR IS

SIGNAL ACC: STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
	PROCESS(clk,reset,EN)
		BEGIN
			IF reset='0' THEN
				ACC<=(OTHERS=>'0');
			ELSIF clk'EVENT AND clk='1' THEN
				IF EN='1' THEN
					ACC<=ACC+D;
				ELSE
					ACC<=ACC;
				END IF;
			END IF;
	END PROCESS;
AOUT<=ACC;
END BEHAVIORAL;