library IEEE;
library STD;

use IEEE.std_logic_1164.all;
--Additional standard or custom libraries go here
use WORK.decoder.all;
use WORK.calc_const.all;
use IEEE.numeric_std.all;

entity calculator is
	port(
		--Inputs
		DIN1 : in std_logic_vector (DIN1_WIDTH - 1 downto 0);
		DIN2 : in std_logic_vector (DIN2_WIDTH - 1 downto 0);
		operation : in std_logic_vector (OP_WIDTH - 1 downto 0);
		
		--Outputs
		DOUT : out std_logic_vector (DOUT_WIDTH - 1 downto 0);
		sign : out std_logic
		);
end entity calculator;

architecture behavioral of calculator is

--Signals and components go here
signal dout_dummy : std_logic_vector (11 downto 0); 
signal sign_dummy : std_logic; 

begin

dout_dummy <= std_logic_vector(resize((abs(signed(DIN1)+signed(DIN2))), 12)) when operation = "00" else
				  std_logic_vector(resize((abs(signed(DIN1)-signed(DIN2))), 12)) when operation = "01" else
				  std_logic_vector(signed(DIN1)*signed(DIN2)) when operation = "10";

sign_dummy <= '1' when signed(dout_dummy) < 0 else
				  '0';
				  
DOUT <= std_logic_vector(dout_dummy);
sign <= std_logic(sign_dummy);
				  
--Behavioral design goes here
--Addition, Subtraction, Multiplication 
--calculator: PROCESS (DIN1, DIN2, operation)

--BEGIN

--	if (operation = "00") then
--		dout_dummy <= "0000" & std_logic_vector(abs(signed(DIN1)+signed(DIN2)));	
--	elsif (operation = "01") then
--		dout_dummy <= "0000" & std_logic_vector(abs(signed(DIN1)-signed(DIN2)));	
--	elsif (operation = "10") then
--		dout_dummy <= std_logic_vector(signed(DIN1)*signed(DIN2));
--	else 
--		null;
--	end if;

--	if (signed(dout_dummy) < 0) then
--		sign_dummy <= '1';
--		DOUT <= std_logic_vector(abs(signed(dout_dummy)));
--	else
--		sign_dummy <= '0';
-- end if;
	
--	DOUT <= std_logic_vector(dout_dummy);
--	sign <= std_logic(sign_dummy);

-- END PROCESS calculator;

end architecture behavioral;