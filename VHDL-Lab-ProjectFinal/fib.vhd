library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

----------------------------------------
entity fibonacci is
generic (n:integer:=16);
	PORT(	clk, rst 	: IN STD_LOGIC;
			Z,countin: IN STD_LOGIC_VECTOR( 5 DOWNTO 0);
			ready:	OUT STD_LOGIC;
			fibo_series	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
end fibonacci;

----------------------------------------

architecture fibonacci of fibonacci is

 signal previous,current,counter,count : STD_LOGIC_VECTOR(15 DOWNTO 0);
 
begin
 process(clk,rst,counter,Z)
 begin
  if(rst = '1') then
   previous <= "0000000000000000";
   current <= "0000000000000001";
	counter <= "0000000000000001";
  elsif(clk'event and clk='1') then
  counter <= counter + 1;
  current <= current + previous;
  previous <= current;
	if ( counter = Z ) then
	previous <= "0000000000000000";
   current <= "0000000000000000";
	counter <= "0000000000000000";
	end if;
	end if;

 end process;
 fibo_series <= current;
end fibonacci;