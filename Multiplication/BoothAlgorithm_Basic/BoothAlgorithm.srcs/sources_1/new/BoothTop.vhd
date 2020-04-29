----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2020 12:07:10 PM
-- Design Name: 
-- Module Name: BoothTop - Behavioral
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

entity BoothTop is
  Port ( 
            clk, reset : in std_logic;
            Multiplicand, Multiplier : in std_logic_vector(63 downto 0 );
            Product : out std_logic_vector(127 downto 0 )   
        );
end BoothTop;

architecture Behavioral of BoothTop is
    component BoothDatapath is
      Port (
                clk, reset      : in std_logic;
                Multiplier      : in std_logic_vector(63 downto 0);
                Multiplicand    : in std_logic_vector(63 downto 0);
                Add_Sub         : in std_logic;
                shift_Write     : in std_logic;
                ProductEnable   : in std_logic;
                CountReset      : in std_logic;
                CountEn         : in std_logic;
                muxSEL          : in std_logic; 
                BoothChekBits   : out std_logic_vector(1 downto 0);
                Product         : out std_logic_vector(127 downto 0);
                Done            : out std_logic;
                QBoothEnable    : in std_logic
             );
    end component;
    
    component BoothControl is
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
    end component;
                
                signal Add_Sub         : std_logic;
                signal shift_Write     : std_logic;
                signal ProductEnable   : std_logic;
                signal CountReset      : std_logic;
                signal CountEn         : std_logic;
                signal muxSEL          : std_logic; 
                signal BoothChekBits   :  std_logic_vector(1 downto 0);
              
                signal Done, QBoothEnable            : std_logic; 
    
    
    
begin
    
    DatapathMap : BoothDatapath Port map (
                clk                 => clk,
                reset               => reset,
                Multiplier          => Multiplier,
                Multiplicand        => Multiplicand,
                Add_Sub             => Add_Sub       ,
                shift_Write         => shift_Write   ,
                ProductEnable       => ProductEnable ,
                CountReset          => CountReset    ,
                CountEn             => CountEn       ,
                muxSEL              => muxSEL        ,
                BoothChekBits       => BoothChekBits ,
                Product             => Product       ,
                Done                => Done,
                QBoothEnable        => QBoothEnable         
             );
    
    ControlMap : BoothControl Port map (
                clk                =>  clk,
                reset              =>  reset,
                BoothChekBits      =>  BoothChekBits,
                Done               =>  Done ,
                Add_Sub            =>  Add_Sub, 
                                       
                shift_Write        =>  shift_Write  , 
                ProductEnable      =>  ProductEnable, 
                CountReset         =>  CountReset   , 
                CountEn            =>  CountEn      , 
                muxSEL             =>  muxSEL       ,
                QBoothEnable       =>  QBoothEnable
               );
    
end Behavioral;
