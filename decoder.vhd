library IEEE;
use IEEE.std_logic_1164.all;
--Additional standard or custom libraries go here if needed

package decoder is

	COMPONENT leddcd is
		port(           
		data_in : in std_logic_vector (3 downto 0);            
		segments_out : out std_logic_vector (6 downto 0) 
		);  -- enter the port declaration of your led decoder here
	end COMPONENT;
	
	-- For each module, which you want to add to this package, you will
	-- place their COMPONENT declarations here one by one, in this case we
	-- just have one module
	
end package decoder;

package body decoder is

--Subroutine declarations (if there are any such as functions and procedures)
-- go here

end package body decoder;