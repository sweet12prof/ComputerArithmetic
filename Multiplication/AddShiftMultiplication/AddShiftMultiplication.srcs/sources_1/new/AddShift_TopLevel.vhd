----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2020 09:30:46 AM
-- Design Name: 
-- Module Name: AddShift_TopLevel - Behavioral
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

entity AddShift_TopLevel is
  Port (
            clk          : in  std_logic;
            reset        : in  std_logic;
            Multiplicand : in std_logic_vector(63 downto 0);
            Multiplier   : in std_logic_vector(63 downto 0);
            Product      : out std_logic_vector(127 downto 0)
        );
end AddShift_TopLevel;
 
architecture Behavioral of AddShift_TopLevel is
    component AddShift_Datapath 
          Port ( 
                    clk          : in  std_logic;
                    reset        : in  std_logic;
                    Multiplicand : in std_logic_vector(63 downto 0);
                    Multiplier   : in std_logic_vector(63 downto 0);
                    Product      : out std_logic_vector(127 downto 0);
                    ProductLSB   : out std_logic;
                    Shift_Write  : in  std_logic;
                    PS_Enable    : in  std_logic;
                    Counter_En   : in  std_logic;
                    Counter_Done : out std_logic;
                    muxSEL       : in  std_logic;
                    countReset   : in  std_logic
            );
    end component;
    
    component AddShift_Control is
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
    end component;
    
    signal ProductLSB    :  std_logic;
    signal Shift_Write   :  std_logic;
    signal PS_Enable     :  std_logic;
    signal Counter_En    :  std_logic;
    signal Counter_Done  :  std_logic;
    signal muxSEL        :  std_logic;
    signal countReset    :  std_logic;
    
    
  
begin
    
    DatapathMap : AddShift_Datapath port map (
                                                    clk           => clk,
                                                    reset         => reset,
                                                    Multiplicand  => Multiplicand,
                                                    Multiplier    => Multiplier,
                                                    ProductLSB    => ProductLSB  ,
                                                    Shift_Write   => Shift_Write ,
                                                    PS_Enable     => PS_Enable   ,
                                                    Counter_En    => Counter_En  ,
                                                    Counter_Done  => Counter_Done,
                                                    muxSEL        => muxSEL,
                                                    Product       => Product,
                                                    countReset    => countReset    
                                              );
                                              
    ControlMap : AddShift_Control port map (
                                                 CLK          => clk,
                                                 RESET        => reset,
                                                 ProductLSB   => ProductLSB  , 
                                                 Shift_Write  => Shift_Write , 
                                                 PS_Enable    => PS_Enable   , 
                                                 Counter_En   => Counter_En  , 
                                                 Counter_Done => Counter_Done, 
                                                 muxSEL       => muxSEL,
                                                 countReset   => countReset         
                                            );
                                            
                                            
    

end Behavioral;
