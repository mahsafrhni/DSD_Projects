LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY four_floor_elevator_tb IS END four_floor_elevator_tb;
ARCHITECTURE testbench of four_floor_elevator_tb IS
    COMPONENT four_floor_elevator IS
        PORT(
            nreset          :   IN std_logic;
            clk             :   IN std_logic;
            switch          :   IN std_logic_vector(4 DOWNTO 1);
            go              :   IN std_logic_vector(4 DOWNTO 1);
            come            :   IN std_logic_vector(4 DOWNTO 1);
            motor_up        :   OUT std_logic;
            motor_down      :   OUT std_logic;
            current_floor   :   OUT std_logic_vector(1 DOWNTO 0);
            move_state      :   OUT std_logic_vector(1 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL nreset_t         :   std_logic;
    SIGNAL clk_t            :   std_logic := '0';
    SIGNAL switch_t         :   std_logic_vector(4 DOWNTO 1) := "0001";
    SIGNAL go_t             :   std_logic_vector(4 DOWNTO 1) := "0000";
    SIGNAL come_t           :   std_logic_vector(4 DOWNTO 1) := "0000";
    SIGNAL motor_up_t       :   std_logic;
    SIGNAL motor_down_t     :   std_logic;
    SIGNAL current_floor_t  :   std_logic_vector(1 DOWNTO 0);
    SIGNAL move_state_t     :   std_logic_vector(1 DOWNTO 0);

BEGIN
    CUT: four_floor_elevator PORT MAP (nreset_t, clk_t, switch_t, go_t, come_t, motor_up_t, motor_down_t, current_floor_t, move_state_t);
    clk_t <= NOT clk_t AFTER 5 ns;
    PROCESS
    BEGIN
        nreset_t <= '0';
        WAIT FOR 10 ns;   
        nreset_t <= '1';     
        WAIT FOR 10 ns;   	--  20 ns
        go_t(3)  <= '1';    --  1 want to go to the 3 floor
        WAIT FOR 10 ns;   	--  30 ns
		switch_t <= "0000"; --  Elevator between 1st and 2nd
		WAIT FOR 10 ns;     --  40 ns
		switch_t <= "0010"; --  Elevator arrives 2nd floor
		WAIT for 10 ns;    	--  50 ns
        switch_t <= "0000"; --  Elevator between 2nd and 3rd floor
		WAIT for 10 ns;    	--  60 ns
		switch_t <= "0100"; --  Elevator arrives 3rd floor
        go_t(3)  <= '0';    --  1 gets out
		WAIT FOR 10 ns;    	--  70 ns
		come_t   <= "0010";	--  2 want to get into elevator in second floor
		WAIT FOR 10 ns;    	--  80 ns
		switch_t <= "0000"; --  Elevator between 2nd and 3rd floor
		WAIT FOR 10 ns;    	--  90 ns
		switch_t <= "0010"; --  Elevator arrives 2nd floor
		come_t(2)<= '0';   	--  Person_2 on the 2nd floor gets in
        go_t(1)  <= '1';    --  Person_2 wanna go to the 1st floor
		WAIT FOR 10 ns;     --  100 ns
		switch_t <= "0000"; --  Elevator between 1st and 2nd floor
		WAIT FOR 10 ns;     --  110 ns
		switch_t <= "0001"; --  Elevator arrives 1st floor
		go_t(1)  <= '0';    --  2 gets out
		WAIT FOR 10 ns;  	-- 120 ns
		come_t(1)<= '0';   	-- Person_3 gets in
  
        WAIT;
    END PROCESS;
END testbench;