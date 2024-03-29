LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY t_jc2 IS
END t_jc2;

ARCHITECTURE behav OF t_jc2 IS 

component jc2
port(
     goLeft: in std_logic;
     goRight: in std_logic;
     stop: in std_logic;
     clk: in std_logic;
     q: out unsigned(3 downto 0)
);
end component;

----------------------------------------------

    --Inputs
    signal goLeft : std_logic := '1';
    signal goRight : std_logic := '1';
    signal stop : std_logic := '1';
    signal clk : std_logic := '1';
     --Outputs
    signal q : unsigned(3 downto 0);

----------------------------------------------

BEGIN

     -- Instantiate the Unit Under Test (UUT)
    uut: jc2 
    PORT MAP (
        goLeft => goLeft,
        goRight => goRight,
        stop => stop,
        clk => clk,
        q => q
    );

    -- Clock process definitions
    clock_gen: process
    begin
	for i in 1 to 510 loop
	    wait for 10 ns;
	    clk <= not clk;
	end loop;
    end process;

    -- Stimulus process
    stim_gen: process
    begin        
		wait for 50 ns;
		goLeft <= '0';
		wait for 20 ns;
		goLeft <= '1';
		wait for 180 ns;
		stop <= '0';
		wait for 20 ns;
		stop <= '1';
		wait for 40 ns;
		goRight <= '0';
		wait for 20 ns;
		goRight <= '1';
		wait; -- will wait forever;
    end process;

END;
