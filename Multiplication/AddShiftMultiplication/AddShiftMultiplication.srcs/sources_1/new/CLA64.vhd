----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2020 06:55:00 AM
-- Design Name: 
-- Module Name: CLA64 - Behavioral
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

entity CLA64 is
  Port ( 
            A    : in std_logic_vector( 63 downto 0 );
            B    : in std_logic_vector( 63 downto 0 );
            Cin  : in std_logic;
            Cout : out std_logic;
            Sum  : out std_logic_vector( 63 downto 0 )
        );
end CLA64;

architecture Behavioral of CLA64 is
    component Adder32 is
        port(
                Add32i1, Add32i2 : in std_logic_vector(31 downto 0);
                Cin32 : in std_logic;
                Add32Sum : out std_logic_vector(31 downto 0);
                Cout32 : out std_logic
            );
     end component;
     
     signal Sum31_0 : std_logic_vector(31 downto 0);
     signal cout_Adder1 : std_logic;
     signal Sum63_32 : std_logic_vector(31 downto 0);
begin
    Adder32_1 : Adder32 port map (
                                     Add32i1  => A(31 downto 0),
                                     Add32i2  => B(31 downto 0),
                                     Cin32    => Cin,
                                     Add32Sum =>  Sum31_0,
                                     Cout32   => cout_Adder1
                                  );
     
    Adder32_2 : Adder32 port map (
                                     Add32i1  =>  A(63 downto 32),
                                     Add32i2  =>  B(63 downto 32),
                                     Cin32    =>  cout_Adder1,
                                     Add32Sum =>  Sum63_32,
                                     Cout32   =>  Cout
                                  ); 
    Sum <= Sum63_32 & Sum31_0;

end Behavioral;
