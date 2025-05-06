----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
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

entity controller_fsm is
    Port ( i_reset : in STD_LOGIC;
           i_adv : in STD_LOGIC;
           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
end controller_fsm;

architecture FSM of controller_fsm is
    signal f_state : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    signal f_next_state : STD_LOGIC_VECTOR (3 downto 0) := "0001";
begin
    f_next_state(0) <= (f_state(0) and not i_adv) or (f_state(3) and i_adv);
    f_next_state(1) <= (f_state(1) and not i_adv) or (f_state(0) and i_adv);
    f_next_state(2) <= (f_state(2) and not i_adv) or (f_state(1) and i_adv);
    f_next_state(3) <= (f_state(3) and not i_adv) or (f_state(2) and i_adv);
    
    process(i_reset, i_adv)
    begin
        if i_reset = '1' then
            f_state <= "0001";
        elsif rising_edge(i_adv) then
            f_state <= f_next_state;
        end if;
    end process;
    
    o_cycle <= f_state;
end FSM;