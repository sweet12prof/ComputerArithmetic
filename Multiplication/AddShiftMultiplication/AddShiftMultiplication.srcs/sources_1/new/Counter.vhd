----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2020 07:19:39 AM
-- Design Name: 
-- Module Name: mux2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
--use IEEE.NUMERIC_.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
 Port (
           clk, reset : in std_logic;
           countReset : in std_logic;
           done  : out std_logic;
           En    : in std_logic
        );
end counter;

architecture behavioral of counter is 
signal CountSig :  std_logic_vector(5 downto 0);
    begin 
        process(clk, reset, countReset) 
            begin   
                if(reset = '1' or countReset = '1') then 
                   countSIg <= (others => '0');
                   done <= '0';
                elsif(rising_edge(clk)) then
                    if(En = '1') then
                        if(CountSig =  "111111") then 
                            done <= '1';
                        end if;
                            CountSig <= CountSig + 1;                     
                        
                    end if;
                end if;
            end process;
            
            --Count <= CountSig;
    end behavioral;