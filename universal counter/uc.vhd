	-- 0: regiser
	-- 1: logical right shift
	-- 2: arithmatic right shift
	-- 3: circular right shift
	-- 4: logical left shift
	-- 5: circular left shift
	-- 6: up count
	-- 7: down count
	
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY reg IS
   GENERIC(n : INTEGER := 8);
	PORT (
	nrst	: IN std_logic;
	clk		: IN std_logic;
	mode	: IN integer;
	din		: IN std_logic_vector(n-1 DOWNTO 0);
	dout	: OUT std_logic_vector(n-1 DOWNTO 0)
	);
END reg;
ARCHITECTURE behavioral OF reg IS
	SIGNAL temp : std_logic_vector(n-1 DOWNTO 0);
BEGIN
	PROCESS (clk)
	BEGIN
		IF clk = '1' THEN 
			IF nrst = '0' THEN
				dout <= (OTHERS => '0');
			ELSE
				IF mode = 0 THEN
					temp <= din;
				ELSIF mode = 1 THEN
					temp <= '0' & temp(n-1 DOWNTO 1);    
				ELSIF mode = 2 THEN
					temp <= temp(n-1) & temp(n-1 DOWNTO 1);  
				ELSIF mode = 3 THEN
					temp <= temp(0) & temp(n-1 DOWNTO 1);
				ELSIF mode = 4 THEN
					temp <= temp(n-2 DOWNTO 0) & '0';
				ELSIF mode = 5 THEN
        temp <= temp(n-2 DOWNTO 0) & temp(n-1) ;
				ELSIF mode = 6 THEN
					temp <= temp + 1; 
				ELSIF mode = 7 THEN
					temp <= temp - 1; 
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	dout <= temp;
END behavioral;
