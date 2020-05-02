library IEEE;

use IEEE.std_logic_1164.all;
--Additional standard or custom libraries go here
use WORK.decoder.all;
use WORK.calc_const.all;
use IEEE.numeric_std.all;

entity display_calc is
	port(
		--You will replace these with your actual inputs and outputs
		DIN1_dc : in std_logic_vector (7 downto 0);
		DIN2_dc : in std_logic_vector (3 downto 0);
		operation_dc : in std_logic_vector (1 downto 0);
		segments_out_dc : out std_logic_vector (20 downto 0);
		sign_dc : out std_logic
	);
end entity display_calc;

architecture structural of display_calc is

--Signals and components go here
component calculator is
	port(
		DIN1 : in std_logic_vector (7 downto 0);
		DIN2 : in std_logic_vector (3 downto 0); 
		operation : in std_logic_vector (1 downto 0);
		
		DOUT : out std_logic_vector (11 downto 0);
		sign : out std_logic
	    );
end component calculator;

component leddcd is
	port(           
		data_in : in std_logic_vector (3 downto 0);            
		segments_out : out std_logic_vector (6 downto 0) 
		);  -- enter the port declaration of your led decoder here
end component leddcd;

signal DOUT_temp : std_logic_vector (11 downto 0);
--signal sign_temp : std_logic
constant DOUT_WIDTH : natural := 12;

begin

--segments_out <= std_logic_vector(segments_out_dummy);

dua : calculator port map(
			DIN1 => DIN1_dc,
			DIN2 => DIN2_dc,
			operation => operation_dc,
			DOUT => DOUT_temp,
			sign => sign_dc
		  );	  
		  
generate_led : for I in 0 to (DOUT_WIDTH/4-1) GENERATE
begin 
led_inst : leddcd port map (
         data_in => DOUT_temp(I*4+3 downto I*4),
         segments_out => segments_out_dc(I*7+6 downto I*7)
        );
end GENERATE generate_led;



end architecture structural;