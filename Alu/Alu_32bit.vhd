LIBRARY ieee ;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL ;
USE ieee.std_logic_unsigned.ALL;
ENTITY Alu Is 
generic (n: integer:=4);
  PORT( a, b: IN STD_LOGIC_VECTOR(n-1 downto 0);
  cin ,sin : IN STD_LOGIC;
  func : IN STD_LOGIC_VECTOR(3 downto 0);
  sout, cout, ov : OUT STD_LOGIC;
  Z : OUT  STD_LOGIC_VECTOR(n-1 downto 0)
  );         
END Alu;
architecture behv of ALU is
  signal temp : std_logic_vector(n-1 downto 0);
  SIGNAL temp_z : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
  SIGNAL temp_zC : STD_LOGIC_VECTOR(n DOWNTO 0);
  SIGNAL temp_sout : STD_LOGIC ;
  SIGNAL temp_ov  : STD_LOGIC ;
  SIGNAL temp_cout  : STD_LOGIC ;

  begin
  process(a,b,func, sin, cin)
  begin
    case func is
      when "0000" =>
        temp <= not B;
        temp_z <= temp & B(n-2 DOWNTO 0); 
      ------------------------
      when "0001" =>
        temp_z <= a + b;
      ------------------------
      when "0010" =>
        temp_zC <= a + b;
        temp_z <= temp_zC(n-1 DOWNTO 0);
        if temp_zC(n) = '0' then
          temp_cout <= '0';
        else
          temp_cout <= '1';
    end if;
      ------------------------
      when "0011" =>
        temp_z <= a - b;
      ------------------------
      when "0100" =>
        temp <= not B;
        temp_z  <= std_logic_vector(unsigned(temp + 1));
      ------------------------
      when "0101" =>
        temp_z <= not B;
        temp_ov <= '0';
      ------------------------
      when "0110" =>
        temp_z <= A and B;
        temp_ov <= '0';
      ------------------------
      when "0111" =>
        temp_z <= A or B;
        temp_ov <= '0';
      ------------------------
      when "1000" =>
        temp_z <= A xor B;
        temp_ov <= '0';
      ------------------------
      when "1001" =>
        temp_z <= std_logic_vector(unsigned(A) sll N);
      ------------------------
      when "1010" =>
        temp_z <= std_logic_vector(unsigned(A) srl N);
      ------------------------
      when "1011" =>
        temp_sout <= a(n-1);
        temp_z  <=  a(n-2 DOWNTO 0) & a(n-1);
      ------------------------
      when "1100" =>
        temp_sout <= a(0);
        temp_z  <=  a(0) & a(n-1 DOWNTO 1);
      ------------------------
      when "1101" =>
        if(A>B) then
          temp_z <= "1" ;
        else
          temp_z <= "0" ;
        end if; 
      ------------------------
      when "1110" =>
        if(A<B) then
          temp_z <= "1" ;
        else
          temp_z <= "0" ;
        end if; 
      ------------------------
      when "1111" =>
        if(A=B) then
          temp_z <= "1" ;
        else
          temp_z <= "0" ;
        end if; 
      ------------------------
      when others =>
        temp_z <= "XXXX";
      ------------------------
    end case;
end process;
      Z <= temp_z;
      sout <= temp_sout;
      ov <= temp_ov;
end behv;
