--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
--Date        : Sun Oct  6 22:46:36 2024
--Host        : Tehoin-PC running 64-bit major release  (build 9200)
--Command     : generate_target zynq_bd_wrapper.bd
--Design      : zynq_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  port (
    FIXED_IO_mio      : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk   : inout STD_LOGIC;
    FIXED_IO_ps_porb  : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    -- led blinker
    led_blinker : out STD_LOGIC
  );
end top;

architecture STRUCTURE of top is
  component zynq_bd is
  port (
    FIXED_IO_mio      : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk   : inout STD_LOGIC;
    FIXED_IO_ps_porb  : inout STD_LOGIC;
    FCLK_CLK0_0       : out STD_LOGIC;
    FCLK_RESET0_N_0   : out STD_LOGIC
  );
  end component zynq_bd;


  signal clock_100MHz : STD_LOGIC;
  signal reset_n      : STD_LOGIC;

  signal counter : natural range 0 to 50e6 := 0;
  signal led_state : STD_LOGIC := '0';

begin

    led_blinker <= led_state;

    process(clock_100MHz)
    begin
        if rising_edge(clock_100MHz) then
            if counter < 50e6 then
                counter <= counter + 1;
            else
                counter <= 0;
            end if;

            if counter = 0 then
                led_state <= not led_state;
            end if;

        end if;
    end process;

    
zynq_bd_i: component zynq_bd
     port map (
      FCLK_CLK0_0               => clock_100MHz,
      FCLK_RESET0_N_0           => reset_n,

      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk           => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb          => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb         => FIXED_IO_ps_srstb
    );
end STRUCTURE;
