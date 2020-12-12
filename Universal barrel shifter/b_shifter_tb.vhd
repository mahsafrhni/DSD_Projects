LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
Use IEEE.std_logic_unsigned.All;

ENTITY  b_shifter_tb IS
END	b_shifter_tb;

ARCHITECTURE sh_tb OF b_shifter_tb IS
		CONSTANT data_w : integer := 32;
		COMPONENT b_shifter IS
			GENERIC (n : INTEGER := 32);
			PORT(
                clk, nrst : IN	STD_LOGIC;
                sham      : IN STD_LOGIC_VECTOR (4  DOWNTO 0 );
                shty      : IN STD_LOGIC_VECTOR (1  DOWNTO 0 );
                dir       : IN	STD_LOGIC; 
                din	      : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0 );
                sin       : IN	STD_LOGIC;
                dout      : OUT STD_LOGIC_VECTOR  (n-1 DOWNTO 0);
                sout      : OUT STD_LOGIC
		        );
		END COMPONENT;
		
		SIGNAL		clk_t, nrst_t : STD_LOGIC;
		SIGNAL		sham_t        : STD_LOGIC_VECTOR (4  DOWNTO 0 );
		SIGNAL		shty_t        : STD_LOGIC_VECTOR (1  DOWNTO 0 );
		SIGNAL		dir_t         : STD_LOGIC;
		SIGNAL 	    din_t	      : STD_LOGIC_VECTOR (data_w -1 DOWNTO 0 );
		SIGNAL		sin_t         : STD_LOGIC;
		SIGNAL		dout_t	      : STD_LOGIC_VECTOR  (data_w -1 DOWNTO 0);
		SIGNAL		sout_t        : STD_LOGIC;
		
	BEGIN
	U1 : b_shifter
		GENERIC MAP (32)
		PORT MAP (
		  clk => clk_t,
		  nrst => nrst_t,
		  sham => sham_t,
		  shty => shty_t,
		  dir => dir_t,
		  din => din_t,
		  sin => sin_t,
		  dout => dout_t,
		  sout => sout_t  
		);
		
	clk_g: PROCESS
	BEGIN
    		clk_t <= '1';
    		WAIT FOR 5 ns;
    		clk_t <= '0';
    		WAIT FOR 5 ns;
			
  	END PROCESS clk_g;
	
    nrst_t	<= '0', '1' after 5 ns;
    sham_t  <= "00011";
	dir_t   <= '1';
	sin_t   <= '1';	
	din_t   <= "00001110000001111000000000000000";
    shty_t  <= "11", "00" AFTER 20 ns,"01" AFTER 40 ns,"10" AFTER 60 ns;
		
END sh_tb;	

