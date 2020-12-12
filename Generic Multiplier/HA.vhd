LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
ENTITY Half_Adder IS
    PORT (X1, X2  : IN STD_LOGIC;
	  S, Cout: OUT STD_LOGIC);
END Half_Adder;
ARCHITECTURE halfadder OF Half_Adder IS
    BEGIN
	S<= X1 XOR X2;
	Cout<= (X1 AND X2);
END halfadder;