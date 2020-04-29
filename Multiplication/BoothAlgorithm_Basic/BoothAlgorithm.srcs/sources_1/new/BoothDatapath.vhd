----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2020 10:57:26 AM
-- Design Name: 
-- Module Name: BoothDatapath - Behavioral
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

entity BoothDatapath is
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
            QBoothEnable : in std_logic;
            BoothChekBits   : out std_logic_vector(1 downto 0);
            Product         : out std_logic_vector(127 downto 0);
            Done            : out std_logic
         );
end BoothDatapath;

architecture Behavioral of BoothDatapath is 
    component BoothQ is
         Port (
                    clk, reset : in std_logic;
                    d          : in std_logic;
                    QBoothEnable : in std_logic;
                    q          : out std_logic
               );
    end component; 
    
    component ProductReg is
      Port ( 
               clk          : in std_logic;
               shift_Write  : in std_logic;
               En           : in std_logic;
               d            : in  std_logic_vector(127 downto 0);
               q            : out std_logic_vector(127 downto 0)
            );
    end component;
    
    component counter is
         Port (
                   clk, reset : in std_logic;
                   countReset : in std_logic;
                   done  : out std_logic;
                   En    : in std_logic
                );
    end component;
    
    component CLA64 is
      Port ( 
                A    : in std_logic_vector( 63 downto 0 );
                B    : in std_logic_vector( 63 downto 0 );
                Cin  : in std_logic;
                Cout : out std_logic;
                Sum  : out std_logic_vector( 63 downto 0 )
            );
    end component;
    
    component mux2 is
     generic(size : integer);
     Port (
                A       : in std_logic_vector(size -1 downto 0);
                B       : in std_logic_vector(size -1 downto 0);
                muxSEL  : IN std_logic;
                muxOut  : out std_logic_vector(size -1 downto 0)
            );
    end component;
    
    signal muxIn1, muxIn2, PSIn, PSout : std_logic_vector(127 downto 0);
    constant zero : std_logic_vector(63 downto 0) := (others => '0');
    signal ALUout : std_logic_vector(63 downto 0);
    signal Qout : std_logic;
    signal MultipliacandInv : std_logic_vector(63 downto 0);
    signal CLA64In2 : std_logic_vector(63 downto 0);
    
begin
    muxIn1 <= zero & Multiplier;
    muxIn2 <= ALUout & PSout(63 downto 0);
    
    preProductmuxMap : mux2 generic map(128) 
                              port map (
                                            A      => muxIn1,
                                            B      => muxIn2,
                                            muxSEL => muxSEL,
                                            muxOut => PSIn
                                        );
                                        
    ProductRegMap : ProductReg Port map ( 
               clk         => clk,
               shift_Write => shift_Write,
               En          => ProductEnable,
               d           => PSIn,
               q           => PSout
            );
            
     BoothQMap :  BoothQ Port map (
                    clk         =>  clk,
                    reset       =>  reset,
                    d           =>  PSout(0),
                    QBoothEnable => QBoothEnable,
                    q           =>  Qout
               );
     
   
    BoothChekBits <= PSout(0) & Qout;  
    
    MultipliacandInv <= not Multiplicand;
    
    
    preCL6A_Invmux : mux2 generic map(64) 
                              port map (
                                            A      => Multiplicand,
                                            B      => MultipliacandInv,
                                            muxSEL => Add_Sub,
                                            muxOut => CLA64In2
                                        );
    
    CLA64map : CLA64  Port map ( 
                                    A     =>  PSout(127 downto 64),
                                    B     =>  CLA64In2,
                                    Cin   =>  Add_Sub,
                                    Cout  =>  open,
                                    Sum   =>  ALUout
                                );
    
    counterMap : counter Port map (
                                       clk          => clk,
                                       reset        => reset,
                                       countReset   => CountReset,
                                       done         => Done ,
                                       En           => CountEn
                                   );

    Product <= PSout;
                

end Behavioral;
