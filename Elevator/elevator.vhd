LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY four_floor_elevator IS
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
END four_floor_elevator;

ARCHITECTURE moore OF four_floor_elevator IS
    TYPE state IS (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13);
    SIGNAL curr_state, next_state  : state;
BEGIN

    com: PROCESS (switch, go, come, curr_state)
    BEGIN
        IF      curr_state = s0 THEN
            IF (come(1)='1') OR (go(1)='1') THEN
                next_state <= s0;
            ELSIF (come(2)='1') OR (come(3)='1') OR (come(4)='1') OR (go(2)='1') OR (go(3)='1') OR (go(4)='1') THEN
                next_state <= s1;
            END IF;
           
			motor_up   <= '0';
			motor_down <= '0';
			current_floor <= "00";
			move_state <= "00";

        ELSIF   curr_state = s1 THEN
            IF switch(2)='1' THEN
                next_state <= s5;
            END IF;
            
			motor_up   <= '1';
			motor_down <= '0';
			current_floor <= "00";
			move_state <= "01";

        ELSIF   curr_state = s2 THEN
            IF switch(1)='1' THEN
                next_state <= s0;
            END IF;
            
			motor_up   <= '0';
			motor_down <= '1';
			current_floor <= "01";
			move_state <= "10";

        ELSIF   curr_state = s3 THEN
            IF (come(1)='0') AND (go(1)='0') THEN
                next_state <= s4;
            ELSIF (come(1)='1') OR (go(1)='1') THEN
                next_state <= s2;
            END IF;
           
			motor_up   <= '0';
			motor_down <= '0';
			current_floor <= "01";
			move_state <= "10";

        ELSIF   curr_state = s4 THEN
            IF (come(2)='1') OR (go(2)='1') THEN
                next_state <= s4;
            ELSIF (come(3)='1') OR (come(4)='1') OR (go(3)='1') OR (go(4)='1') THEN
                next_state <= s5;
            ELSIF (come(1)='1') OR (go(1)='1') THEN
                next_state <= s3;
            END IF;
            
			motor_up   <= '0';
			motor_down <= '0';
			current_floor <= "01";
			move_state <= "00";

        ELSIF   curr_state = s5 THEN
            IF (come(3)='0') AND (come(4)='0') AND (go(3)='0') AND (go(4)='0') THEN
                next_state <= s4;
            ELSIF (come(3)='1') OR (come(4)='1') OR (go(3)='1') OR (go(4)='1') THEN
                next_state <= s6;
            END IF;
           
			motor_up   <= '0';
			motor_down <= '0';
			current_floor <= "01";
			move_state <= "01";

        ELSIF   curr_state = s6 THEN
            IF switch(3)='1' THEN
                next_state <= s10;
            END IF;
            
			motor_up   <= '1';
			motor_down <= '0';
			current_floor <= "01";
			move_state <= "01";

        ELSIF   curr_state = s7 THEN
            IF switch(2)='1' THEN
                next_state <= s3;
            END IF;
            
			motor_up   <= '0';
			motor_down <= '1';
			current_floor <= "10";
			move_state <= "10";

        ELSIF   curr_state = s8 THEN
            IF (come(1)='0') AND (come(2)='0') AND (go(1)='0') AND (go(2)='0') THEN
                next_state <= s9;
            ELSIF (come(1)='1') OR (come(2)='1') OR (go(1)='1') OR (go(2)='1') THEN
                next_state <= s7;
            END IF;
            
			motor_up   <= '0';
			motor_down <= '0';
			current_floor <= "10";
			move_state <= "10";

        ELSIF   curr_state = s9 THEN
            IF (come(3)='1') OR (go(3)='1') THEN
                next_state <= s9;
            ELSIF (come(4)='1') OR (go(4)='1') THEN
                next_state <= s10;
            ELSIF (come(1)='1') OR (come(2)='1') OR (go(1)='1') OR (go(2)='1') THEN
                next_state <= s8;
            END IF;
            
			motor_up   <= '0';
			motor_down <= '0';
			current_floor <= "10";
			move_state <= "00";

        ELSIF   curr_state = s10 THEN
            IF (come(4)='0') AND (go(4)='0') THEN
                next_state <= s9;
            ELSIF (come(4)='1') OR (go(4)='1') THEN
                next_state <= s11;
            END IF;
            
			motor_up   <= '0';
			motor_down <= '0';
			current_floor <= "10";
			move_state <= "01";

        ELSIF   curr_state = s11 THEN
            IF switch(4)='1' THEN
                next_state <= s13;
            END IF;
         
			motor_up   <= '1';
			motor_down <= '0';
			current_floor <= "10";
			move_state <= "01";

        ELSIF   curr_state = s12 THEN
            IF switch(3)='1' THEN
                next_state <= s8;
            END IF;
            
			motor_up   <= '0';
			motor_down <= '1';
			current_floor <= "11";
			move_state <= "10";

        ELSE -- curr_state = 13 
            IF (come(4)='1') OR (go(4)='1') THEN
                next_state <= s13;
            ELSIF (come(1)='1') OR (come(2)='1') OR (come(3)='1') OR (go(1)='1') OR (go(2)='1') OR (go(3)='1') THEN
                next_state <= s12;
            END IF;
            
			motor_up   <= '0';
			motor_down <= '0';
			current_floor <= "11";
			move_state <= "00";

        END IF;
    END PROCESS com;

    seq: PROCESS (nreset, clk)
    BEGIN
        IF nreset = '0' THEN
                curr_state <= s0; 
        ELSIF clk='1' AND clk'EVENT THEN
				curr_state <= next_state;
        END IF;
    END PROCESS seq;

END moore;
