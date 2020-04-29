----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2020 10:31:13 AM
-- Design Name: 
-- Module Name: ProductReg - Behavioral
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

entity ProductReg is
  Port ( 
           clk          : in std_logic;
           shift_Write  : in std_logic;
           En           : in std_logic;
           d            : in  std_logic_vector(127 downto 0);
           q            : out std_logic_vector(127 downto 0)
        );
end ProductReg;

architecture Behavioral of ProductReg is
signal qSig       :  std_logic_vector(127 downto 0);
begin
    RegProc : process(clk)
                begin 
                    if(rising_edge(clk)) then 
                        if(En = '1') then 
                            if(shift_write = '1') then 
                                if(qSig(127) = '0') then 
                                    qSig <= '0' & qSig(127 downto 1);
                                 else
                                    qSig <= '1' & qSig(127 downto 1);
                                end if;
                            else 
                                qSig <= d;
                            end if;
                        end if;
                    end if;
                end process;
    q <= qSig;
end Behavioral;
