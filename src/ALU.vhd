----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
    component ripple_adder is
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Cin : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR (3 downto 0);
               Cout : out STD_LOGIC);
    end component ripple_adder;
    
    signal s_B_modified : STD_LOGIC_VECTOR(7 downto 0);
    signal s_adder_result : STD_LOGIC_VECTOR(7 downto 0);
    signal s_and_result : STD_LOGIC_VECTOR(7 downto 0);
    signal s_or_result : STD_LOGIC_VECTOR(7 downto 0);
    signal s_result : STD_LOGIC_VECTOR(7 downto 0);
    
    signal s_carry_mid : STD_LOGIC;
    signal s_carry_out : STD_LOGIC;
    signal s_operation_cin : STD_LOGIC;
    
    signal s_negative : STD_LOGIC;
    signal s_zero : STD_LOGIC;
    signal s_carry : STD_LOGIC;
    signal s_overflow : STD_LOGIC;
    
begin
    process(i_B, i_op)
    begin
        if i_op = "001" then
            s_B_modified <= not i_B;
            s_operation_cin <= '1';
        else
            s_B_modified <= i_B;
            s_operation_cin <= '0';
        end if;
    end process;
    
    Lower_Adder: ripple_adder
    port map (
        A => i_A(3 downto 0),
        B => s_B_modified(3 downto 0),
        Cin => s_operation_cin,
        S => s_adder_result(3 downto 0),
        Cout => s_carry_mid
    );
    
    Upper_Adder: ripple_adder
    port map (
        A => i_A(7 downto 4),
        B => s_B_modified(7 downto 4),
        Cin => s_carry_mid,
        S => s_adder_result(7 downto 4),
        Cout => s_carry_out
    );
    
    s_and_result <= i_A and i_B;
    s_or_result <= i_A or i_B;
    
    process(i_op, s_adder_result, s_and_result, s_or_result)
    begin
        case i_op is
            when "000" => s_result <= s_adder_result;
            when "001" => s_result <= s_adder_result;
            when "010" => s_result <= s_and_result;
            when "011" => s_result <= s_or_result;
            when others => s_result <= (others => '0');
        end case;
    end process;
    
    s_negative <= s_result(7);
    s_zero <= '1' when s_result = "00000000" else '0';
    
    process(i_op, s_carry_out)
    begin
        case i_op is
            when "000" => s_carry <= s_carry_out;
            when "001" => s_carry <= s_carry_out;
            when others => s_carry <= '0';
        end case;
    end process;
    
    process(i_op, i_A, i_B, s_result)
    begin
        s_overflow <= '0';
        
        if i_op = "000" then
            if ((i_A(7) = '0' and i_B(7) = '0' and s_result(7) = '1') or
                (i_A(7) = '1' and i_B(7) = '1' and s_result(7) = '0')) then
                s_overflow <= '1';
            end if;
        elsif i_op = "001" then
            if ((i_A(7) = '0' and i_B(7) = '1' and s_result(7) = '1') or
                (i_A(7) = '1' and i_B(7) = '0' and s_result(7) = '0')) then
                s_overflow <= '1';
            end if;
        end if;
    end process;
    
    o_result <= s_result;
    o_flags(0) <= s_overflow;
    o_flags(1) <= s_carry;
    o_flags(2) <= s_zero;
    o_flags(3) <= s_negative;
    
end Behavioral;