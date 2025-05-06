----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2025 01:06:13 PM
-- Design Name: 
-- Module Name: sevenseg_decoder_tb - Behavioral
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

entity sevenseg_decoder_tb is
end sevenseg_decoder_tb;

architecture Behavioral of sevenseg_decoder_tb is

    component sevenseg_decoder
        Port ( i_Hex   : in  STD_LOGIC_VECTOR (3 downto 0);
               o_seg_n  : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    signal i_sig   : STD_LOGIC_VECTOR (3 downto 0);
    signal o_sig : STD_LOGIC_VECTOR (6 downto 0);

begin

        uut: sevenseg_decoder
        port map (
            i_Hex   => i_sig,
            o_seg_n => o_sig
        );
             
    test_process : process 
    begin
	   i_sig <= "0000"; wait for 10 ns;
	       assert (o_sig = "1000000") report "Test Fail input 0000" severity failure;
	   i_sig <= "0001"; wait for 10 ns;
	       assert (o_sig = "1111001") report "Test Fail input 0001" severity failure;
	   i_sig <= "0010"; wait for 10 ns;
	       assert (o_sig = "0100100") report "Test Fail input 0010" severity failure;
	   i_sig <= "0011"; wait for 10 ns;
	       assert (o_sig = "0110000") report "Test Fail input 0011" severity failure;
	   i_sig <= "0100"; wait for 10 ns;
	       assert (o_sig = "0011001") report "Test Fail input 0100" severity failure;	      
	   i_sig <= "0101"; wait for 10 ns;
	       assert (o_sig = "0010010") report "Test Fail input 0101" severity failure;
	   i_sig <= "0110"; wait for 10 ns;
	       assert (o_sig = "0000010") report "Test Fail input 0110" severity failure;	       
	   i_sig <= "0111"; wait for 10 ns;
	       assert (o_sig = "1111000") report "Test Fail input 0111" severity failure;	       
	   i_sig <= "1000"; wait for 10 ns;
	       assert (o_sig = "0000000") report "Test Fail input 1000" severity failure;	       
	   i_sig <= "1001"; wait for 10 ns;
	       assert (o_sig = "0011000") report "Test Fail input 1001" severity failure;	       
	   i_sig <= "1010"; wait for 10 ns;
	       assert (o_sig = "0001000") report "Test Fail input 1010" severity failure;	       
	   i_sig <= "1011"; wait for 10 ns;
	       assert (o_sig = "0000011") report "Test Fail input 1011" severity failure;	       
	   i_sig <= "1100"; wait for 10 ns;
	       assert (o_sig = "0100111") report "Test Fail input 1100" severity failure;	       
	   i_sig <= "1101"; wait for 10 ns;
	       assert (o_sig = "0100001") report "Test Fail input 1101" severity failure;	       
	   i_sig <= "1110"; wait for 10 ns;
	       assert (o_sig = "0000110") report "Test Fail input 1110" severity failure;	       
	   i_sig <= "1111"; wait for 10 ns;
	       assert (o_sig = "0001110") report "Test Fail input 1111" severity failure;	       
        
       wait;
    end process;       	  	      
	       
end Behavioral;
