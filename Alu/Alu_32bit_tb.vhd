LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Alu_tb IS
END Alu_tb;
ARCHITECTURE test OF Alu_tb IS 
	COMPONENT Alu_tb IS
		generic (n: integer:=32);
		PORT( a, b: IN STD_LOGIC_VECTOR(n -1  downto 0);
		cin ,sin : IN STD_LOGIC;
		func : IN STD_LOGIC_VECTOR(3 downto 0);
		sout, cout, ov : OUT STD_LOGIC;
		Z : OUT  STD_LOGIC_VECTOR(n-1 downto 0)
		);   
		
	END COMPONENT;
	SIGNAL a_t : STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL b_t :STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL sin_t		:STD_LOGIC;
	SIGNAL cin_t		: STD_LOGIC;
	SIGNAL func_t		: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL sout_t		: STD_LOGIC;
	SIGNAL cout_t		: STD_LOGIC;
	SIGNAL z_t		: std_logic_vector(31 DOWNTO 0);

BEGIN
	-------------------------
	--  CUT Instantiation
	-------------------------
	CUT:  Alu_tb	GENERIC MAP (32) 
				PORT MAP (a =>a_t,b=> b_t,sin=> sin_t,cin=> cin_t,func=> func_t,sout=> sout_t,cout=> cout_t,z=> z_t);   -- Entity Instantiation
	

	------------------------------
	--  Input Stimuli Assignment
	------------------------------
	a_t <= "00000000110100100100100110000001";
	b_t <= "01111111111111111111111111111111";
	sin_t <= '0';
	cin_t <= '0';
	func_t <= "0000", "0001" AFTER 50 ns, "0010" AFTER 100 ns, "0011" AFTER 150 ns,
				      "0100" AFTER 200 ns, "0101" AFTER 250 ns, "0110" AFTER 300 ns,
					  "0001" AFTER 350 ns, "0010" AFTER 400 ns, "0001" AFTER 450 ns,
				      "0111" AFTER 500 ns, "1000" AFTER 550 ns, "1001" AFTER 600 ns,
				      "1010" AFTER 650 ns, "1011" AFTER 700 ns, "1100" AFTER 750 ns,
				      "1101" AFTER 800 ns, "1110" AFTER 850 ns, "1111" AFTER 900 ns ;


END test;
