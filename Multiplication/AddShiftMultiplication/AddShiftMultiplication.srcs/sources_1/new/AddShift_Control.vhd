----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2020 08:47:14 AM
-- Design Name: 
-- Module Name: AddShift_Control - Behavioral
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

entity AddShift_Control is
 Port (
            CLK         : in std_logic;
            RESET       : in std_logic;
            ProductLSB   : in std_logic;
            Shift_Write  : out  std_logic;
            PS_Enable    : out  std_logic;
            Counter_En   : out  std_logic;
            Counter_Done : in std_logic;
            muxSEL       : out  std_logic;
            countReset   : out  std_logic
            
      );
end AddShift_Control;

architecture Behavioral of AddShift_Control is
    type state_type is (Initialise, LSBtest, Add, Shift, Done);
    signal PS, NS : state_type;
begin
    
    Sync_Process : process(clk, reset, NS) 
                      begin 
                        if(reset = '1') then 
                             PS <= Initialise;
                        elsif(rising_edge(clk)) then 
                             PS <= NS;
                        end if;
                      end process;
    
    Comb_process : process(PS, ProductLSB, Counter_Done)
                     begin 
                        Shift_Write <= '0';
                        PS_Enable   <= '0';
                        Counter_En  <= '0';
                         muxSEL     <= '0';
                         countReset <= '0';
                        case PS is 
                            when Initialise => 
                               muxSEL <= '0';
                               Counter_En <= '0';
                               PS_Enable <= '1';
                               Shift_Write <= '0';
                               NS <= LSBTest;
                               
                             when LSBTest => 
                                 Counter_En  <= '0';
                                 if(Counter_Done = '0') then 
                                     if(ProductLSB = '1') then 
                                        NS <= Add;
                                     else 
                                        NS <= Shift;
                                     end if;
                                 else 
                                        NS <= Done;
                                 end if;
                             
                             when Add =>
                                  muxSEL <= '1';
                                  PS_Enable <= '1';
                                  Shift_Write <= '0';
                                  NS <= shift;
                             
                             when shift => 
                                   PS_Enable <= '1';
                                   Shift_Write <= '1';
                                   Counter_En  <= '1';
                                   NS <= LSBTest;
                             when Done => 
                                  countReset <= '1';
                        end case;
                     end process;

end Behavioral;
