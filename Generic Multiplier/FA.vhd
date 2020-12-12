LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
ENTITY Full_Adder IS
    PORT (X1, X2, Cin : IN std_logic;
            S, Cout : OUT std_logic);
END Full_Adder;
ARCHITECTURE fulladder OF Full_Adder IS
	BEGIN
	S<= X1 XOR X2 XOR Cin;
	Cout<= (X1 AND X2) OR ((X1 XOR X2)AND Cin);
END;