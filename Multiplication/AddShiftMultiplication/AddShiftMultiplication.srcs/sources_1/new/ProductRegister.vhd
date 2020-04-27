----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2020 06:21:32 AM
-- Design Name: 
-- Module Name: ProductRegister - Behavioral
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

entity Product_ShiftRegister is
 generic (
            size : integer := 128
            );
 Port (
            clk         : in std_logic;
            shift_Write : in std_logic;
            --        : in std_logic;
            Enable      : in std_logic;
            d           : in std_logic_vector(size - 1 downto 0);
            q           : out std_logic_vector(size - 1 downto 0)
        );
end Product_ShiftRegister;

architecture Behavioral of Product_ShiftRegister is
signal qSig : std_logic_vector(size - 1 downto 0);
begin
    process(clk)
        begin 
            if(rising_edge(clk)) then 
                if(Enable = '1') then 
                    if(shift_Write = '1') then 
                        qSig <= '0' & qSig(size - 1 downto 1);
                    else 
                        qSig <= d;
                    end if;
                 end if;
            end if;
        end process;
        
        q <= qSig;
end Behavioral;
