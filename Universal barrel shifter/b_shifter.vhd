LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY b_shifter IS
  GENERIC (n : INTEGER := 32);
  PORT(
    clk, nrst : IN	STD_LOGIC;
    din	      : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0 );
    sham      : IN STD_LOGIC_VECTOR (4  DOWNTO 0 );
    shty      : IN STD_LOGIC_VECTOR (1  DOWNTO 0 );
    dir       : IN	STD_LOGIC; 
   	sin       : IN	STD_LOGIC;
    dout      : OUT STD_LOGIC_VECTOR  (n -1 DOWNTO 0);
    sout      : OUT STD_LOGIC
    );  
END b_shifter;

ARCHITECTURE sh OF b_shifter IS
SIGNAL sham_int   :  INTEGER;
BEGIN
sham_int <= to_integer(signed(sham));
PROCESS (clk)
    VARIABLE temp   :	STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	BEGIN
		IF (clk = '1')	THEN
			IF (nrst = '0') THEN
				temp := (OTHERS => '0');	
			ELSE
			  --logical
                IF (shty = "00" )	THEN
                                    
                IF (dir = '0')  THEN
                    ls0: for i in 1 to (sham_int) loop
                        sout <= temp(n-1);
                        temp := temp(n-2 DOWNTO 0) & sin;
                    end loop ls0;   
                ELSIF (dir = '1')  THEN
                    ls1: for i in 1 to sham_int loop
                        sout <= temp(0);
                        temp := sin & temp(n-1 DOWNTO 1);
                    end loop ls1;
                END IF;
                
                --arithmetic 
                ELSIF (shty = "01")	THEN 
                    
                IF (dir='0') THEN
                    as0: for I in 1 to sham_int loop
                        sout <= temp(n-1);
                        temp := temp(n-2 DOWNTO 0) & '0';
                    end loop as0;
                    
                ELSIF (dir='1')  THEN
                as1:for I in 1 to sham_int loop
                        sout <= temp(0);
                        temp := temp(n-1) & temp(n-1 DOWNTO 1);
                    end loop as1;
                END IF;
                    
                --circular 
                ELSIF (shty = "10")	THEN 
                    
                    IF (dir='0')    THEN
                    cs0: for I in 1 to sham_int loop
                        sout <= temp(n-1);
                        temp := temp(n-2 DOWNTO 0) & temp(31);
                    end loop cs0;
                    
                    ELSIF (dir='1') THEN 
                    cs1:for I in 1 to sham_int loop
                        sout <= temp(0);
                        temp := temp(0) & temp(n-1 DOWNTO 1);
                    end loop cs1;
                    END IF;
                    
                --parallel load
                ELSIF (shty = "11")	THEN
                    temp := din; 
                    
                END IF;
            
            END IF;
        END IF;
        dout <= temp;
	END PROCESS;
	
END	sh;
