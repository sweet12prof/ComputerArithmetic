----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2020 07:06:45 AM
-- Design Name: 
-- Module Name: AddShift_Datapath - Behavioral
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

entity AddShift_Datapath is
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
end AddShift_Datapath;

architecture Behavioral of AddShift_Datapath is
    component CLA64 is
      Port ( 
                A    : in std_logic_vector( 63 downto 0 );
                B    : in std_logic_vector( 63 downto 0 );
                Cin  : in std_logic;
                Cout : out std_logic;
                Sum  : out std_logic_vector( 63 downto 0 )
            );
    end component;
    
    component Product_ShiftRegister is
     generic (
                size : integer
                );
     Port (
                clk         : in std_logic;
                shift_Write : in std_logic;
                Enable      : in std_logic;
                d           : in std_logic_vector(size - 1 downto 0);
                q           : out std_logic_vector(size - 1 downto 0)
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
    
    component counter is
     Port (
               clk, reset : in std_logic;
               countReset : in std_logic;
               done  : out std_logic;
               En    : in std_logic
            );
    end component;
    
    signal AdderOut : std_logic_vector(63 downto 0);
    signal PS_In, PS_Out : std_logic_vector(127 downto 0);
    signal mux_In_A, mux_In_B : std_logic_vector(127 downto 0);
    constant zero64 : std_logic_vector(63 downto 0) := (others => '0');
    
begin
    Adder64Map :  CLA64 port map (
                                      A    =>  PS_Out(127 downto 64),
                                      B    =>  Multiplicand,
                                      Cin  => '0',
                                      Cout => open,
                                      Sum  => AdderOut
                                 );
    
    productRegisterMap : Product_ShiftRegister generic map(128)
                                               port map (
                                                            clk          => clk,
                                                            --reset        => reset,
                                                            shift_Write  => Shift_Write,
                                                            Enable       => PS_Enable,
                                                            d            => PS_In,
                                                            q            => PS_Out
                                                        );
   
   mux_In_A <= zero64 & Multiplier;
   mux_In_B <= AdderOut & PS_Out(63 downto 0);                                    
   mux2Map  : mux2 generic map(128)
              Port map (
                            A        =>   mux_In_A,
                            B        =>   mux_In_B,
                            muxSEL   =>   muxSEL,
                            muxOut   =>   PS_In
                       );
                       
  ProductLSB <=  PS_Out(0);
  
  CounterMap : counter Port map (
                                   clk   => clk, 
                                   reset => reset,
                                   countReset => countReset,
                                   done  => Counter_Done,
                                   En    =>  Counter_En 
                                 );
   Product <= PS_Out;

end Behavioral;
