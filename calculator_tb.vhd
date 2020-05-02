library IEEE;
library STD;

use IEEE.std_logic_1164.all;
--Additional standard or custom libraries go here
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;

entity calculator_tb is
	--port(
	--	DOUT_tb : out std_logic_vector (11 downto 0);
	--	sign_tb : out std_logic
	--    );
end entity calculator_tb;

architecture behavioral of calculator_tb is

component calculator is
	port(
		DIN1 : in std_logic_vector;
		DIN2 : in std_logic_vector;
		operation : in std_logic_vector;
		
		DOUT : out std_logic_vector;
		sign : out std_logic
	    );
end component calculator;

signal DIN1_tb : std_logic_vector(7 downto 0);
signal DIN2_tb : std_logic_vector(3 downto 0);
signal operation_tb : std_logic_vector(1 downto 0);
signal DOUT_temp : std_logic_vector (11 downto 0);
signal sign_temp : std_logic;

signal sign_string : string (1 to 1);

begin

dut : calculator port map(
			DIN1 => DIN1_tb,
			DIN2 => DIN2_tb,
			operation => operation_tb,
			DOUT => DOUT_temp,
			sign => sign_temp
		  );


--stimulus_testinput : process is
--begin
--	DIN1_tb <= "00000000";
--	DIN2_tb <= "0000";
--	operation_tb <= "00";
--	wait for 10 ns; 	DIN1_tb <= "00001100";
--							DIN2_tb <= "0100";
--							operation_tb <= "00";
--	wait for 10 ns; 	DIN1_tb <= "00001100";
--							DIN2_tb <= "1100";
--							operation_tb <= "10";
--	wait for 10 ns; 	DIN1_tb <= "00001100";
--							DIN2_tb <= "0100";
--							operation_tb <= "01";
--	wait for 10 ns; 	DIN1_tb <= "11111011";
--							DIN2_tb <= "0101";
--							operation_tb <= "00";
--	wait for 10 ns; 	DIN1_tb <= "00000000";
--							DIN2_tb <= "0101";
--							operation_tb <= "10";
--	wait for 10 ns;
--end process stimulus_testinput;
--
stimulus_textoutput : process is 

    file file_VECTORS: text open read_mode is "cal8.in";
    file file_RESULTS: text open write_mode is "cal8.out";

    variable i_line : line;
    variable o_line : line;
    variable TERM1  : integer;
    variable TERM2  : integer;
    variable OP : character;
     
begin
 
    while not endfile(file_VECTORS) loop
      readline(file_VECTORS, i_line);
      read(i_line, TERM1);
      DIN1_tb <= std_logic_vector(to_signed(TERM1, 8));
      readline(file_VECTORS, i_line);
      read(i_line, TERM2);
      DIN2_tb <= std_logic_vector(to_signed(TERM2, 4));
      readline(file_VECTORS, i_line);
      read(i_line, OP);

      wait for 10 ns;

      if (OP = '+') then
          operation_tb <= "00";
      elsif (OP = '-') then
          operation_tb <= "01";
      elsif (OP = '*') then
          operation_tb <= "10";
      else
          null;
      end if;
      
      --TERM3 <= to_integer(signed(DIN1_tb)); 
      --TERM4 <= to_integer(signed(DIN2_tb)); 
      
      if (sign_temp = '1') then
	  sign_string <= "-";
      else 
	  sign_string <= " ";
      end if;
		
		wait for 10 ns;
      
      write(o_line, to_integer(signed(DIN1_tb)));
      write(o_line, OP);
      write(o_line, to_integer(signed(DIN2_tb)));
      write(o_line, string'("="));
      write(o_line, sign_string);
      write(o_line, to_integer(signed(DOUT_temp)));
      writeline(file_RESULTS, o_line);

    end loop;
 
    file_close(file_VECTORS);
    file_close(file_RESULTS);
     
    wait;
  end process stimulus_textoutput;

end architecture behavioral;