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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2 is
 generic(size : integer);
 Port (
            A       : in std_logic_vector(size -1 downto 0);
            B       : in std_logic_vector(size -1 downto 0);
            muxSEL  : IN std_logic;
            muxOut  : out std_logic_vector(size -1 downto 0)
        );
end mux2;

architecture Behavioral of mux2 is

begin
    muxOut <= A when muxSEL = '0' else B;
end Behavioral;
