----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2020 11:35:55 AM
-- Design Name: 
-- Module Name: BoothControl - Behavioral
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

entity BoothControl is
  Port (
            clk , reset : in std_logic;
            BoothChekBits   : in std_logic_vector(1 downto 0);    
            Done            : in std_logic ;
            Add_Sub         : out std_logic;                        
            
            shift_Write     : out std_logic;                        
            ProductEnable   : out std_logic;                        
            CountReset      : out std_logic;                        
            CountEn         : out std_logic;                        
            muxSEL          : out std_logic; 
            QBoothEnable    : out std_logic                    
           );
end BoothControl;

architecture Behavioral of BoothControl is
    type state_type is (Initialise, TestBoothBits, add, Sub, shift, Finish);
    signal PS, NS : state_type;
begin
    Syc_Proc : process(clk, reset, NS)
                    begin 
                        if(reset = '1') then 
                            PS <= Initialise;
                        elsif(rising_edge(clk)) then 
                            PS <= NS;
                        end if;
                    end process;
     
     Comb_Proc : process (PS, BoothChekBits, Done)
                    Begin 
                        Add_Sub        <= '0';
                        shift_Write    <= '0';
                        ProductEnable  <= '0';
                        CountReset     <= '0';
                        CountEn        <= '0';
                        muxSEL         <= '0';
                        QBoothEnable   <= '0';
                        case PS is 
                            when Initialise => 
                                muxSEL        <= '0';
                                ProductEnable <= '1';
                                shift_Write <= '0';
                                NS <= TestBoothBits;
                            
                            when TestBoothBits =>
                                if(Done = '0') then  
                                    if(BoothChekBits = "00" or BoothChekBits = "11") then 
                                        QBoothEnable  <= '1';
                                        NS <= shift;
                                    elsif( BoothChekBits = "10") then 
                                        QBoothEnable  <= '1';
                                        NS <= Sub;
                                    else 
                                        QBoothEnable  <= '1';
                                        NS <= Add; 
                                    end if;
                                else 
                                    NS <= Finish;
                                end if;
                            
                            when Add => 
                                Add_Sub <= '0';
                                ProductEnable <= '1';
                                Shift_Write   <= '0';
                                muxSEL        <= '1';
                                NS <= Shift;
                                
                            
                            when  Sub => 
                                Add_Sub <= '1';
                                ProductEnable <= '1';
                                Shift_Write   <= '0';
                                muxSEL        <= '1';
                                NS <= Shift;
                                
                             
                             when Shift => 
                                ProductEnable <= '1';
                                Shift_Write   <= '1';
                                CountEn <= '1';
                                NS <= TestBoothBits;
                              
                              when Finish => 
                                countReset <= '1';
                                     
                        end case;
                    end process;

end Behavioral;
