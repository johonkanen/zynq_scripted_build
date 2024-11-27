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
    DDR_addr          : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba            : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n         : inout STD_LOGIC;
    DDR_ck_n          : inout STD_LOGIC;
    DDR_ck_p          : inout STD_LOGIC;
    DDR_cke           : inout STD_LOGIC;
    DDR_cs_n          : inout STD_LOGIC;
    DDR_dm            : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq            : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n         : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p         : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt           : inout STD_LOGIC;
    DDR_ras_n         : inout STD_LOGIC;
    DDR_reset_n       : inout STD_LOGIC;
    DDR_we_n          : inout STD_LOGIC;
    FIXED_IO_ddr_vrn  : inout STD_LOGIC;
    FIXED_IO_ddr_vrp  : inout STD_LOGIC;
    FIXED_IO_mio      : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk   : inout STD_LOGIC;
    FIXED_IO_ps_porb  : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    -- led blinker
    led_blinker : out STD_LOGIC
  );
end top;

architecture STRUCTURE of top is


  signal clock_100MHz : STD_LOGIC;
  signal reset_n      : STD_LOGIC;

   signal counter           : natural range 0 to 50e6               := 0;
   signal led_state         : STD_LOGIC                             := '0';

   signal BRAM_PORTA_0_addr : STD_LOGIC_VECTOR ( 11 downto 0 );
   signal BRAM_PORTA_0_clk  : STD_LOGIC;
   signal BRAM_PORTA_0_din  : STD_LOGIC_VECTOR ( 31 downto 0 );
   signal BRAM_PORTA_0_dout : STD_LOGIC_VECTOR ( 31 downto 0 );
   signal BRAM_PORTA_0_en   : STD_LOGIC;
   signal BRAM_PORTA_0_rst  : STD_LOGIC;
   signal BRAM_PORTA_0_we   : STD_LOGIC_VECTOR ( 3 downto 0 );
   signal BRAM_PORTB_0_addr : STD_LOGIC_VECTOR ( 11 downto 0 );
   signal BRAM_PORTB_0_clk  : STD_LOGIC;
   signal BRAM_PORTB_0_din  : STD_LOGIC_VECTOR ( 31 downto 0 );
   signal BRAM_PORTB_0_dout : STD_LOGIC_VECTOR ( 31 downto 0 );
   signal BRAM_PORTB_0_en   : STD_LOGIC;
   signal BRAM_PORTB_0_rst  : STD_LOGIC;
   signal BRAM_PORTB_0_we   : STD_LOGIC_VECTOR ( 3 downto 0 );
   signal GPIO_0_tri_o      : STD_LOGIC_VECTOR ( 31 downto 0 );

begin

    led_blinker <= led_state;

    process(clock_100MHz)
    begin
        if rising_edge(clock_100MHz) then
            if counter < 25e6 then
                counter <= counter + 1;
            else
                counter <= 0;
            end if;

            if counter = 0 then
                led_state <= not led_state;
            end if;

        end if;
    end process;

    
    u_zynq_bd_wrapper: entity work.zynq_bd_wrapper
     port map (
      BRAM_PORTA_0_addr(11 downto 0) => BRAM_PORTA_0_addr(11 downto 0),
      BRAM_PORTA_0_clk               => BRAM_PORTA_0_clk,
      BRAM_PORTA_0_din(31 downto 0)  => BRAM_PORTA_0_din(31 downto 0),
      BRAM_PORTA_0_dout(31 downto 0) => BRAM_PORTA_0_dout(31 downto 0),
      BRAM_PORTA_0_en                => BRAM_PORTA_0_en,
      BRAM_PORTA_0_rst               => BRAM_PORTA_0_rst,
      BRAM_PORTA_0_we(3 downto 0)    => BRAM_PORTA_0_we(3 downto 0),
      BRAM_PORTB_0_addr(11 downto 0) => BRAM_PORTB_0_addr(11 downto 0),
      BRAM_PORTB_0_clk               => BRAM_PORTB_0_clk,
      BRAM_PORTB_0_din(31 downto 0)  => BRAM_PORTB_0_din(31 downto 0),
      BRAM_PORTB_0_dout(31 downto 0) => BRAM_PORTB_0_dout(31 downto 0),
      BRAM_PORTB_0_en                => BRAM_PORTB_0_en,
      BRAM_PORTB_0_rst               => BRAM_PORTB_0_rst,
      BRAM_PORTB_0_we(3 downto 0)    => BRAM_PORTB_0_we(3 downto 0),
      DDR_addr(14 downto 0)          => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0)             => DDR_ba(2 downto 0),
      DDR_cas_n                      => DDR_cas_n,
      DDR_ck_n                       => DDR_ck_n,
      DDR_ck_p                       => DDR_ck_p,
      DDR_cke                        => DDR_cke,
      DDR_cs_n                       => DDR_cs_n,
      DDR_dm(3 downto 0)             => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0)            => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0)          => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0)          => DDR_dqs_p(3 downto 0),
      DDR_odt                        => DDR_odt,
      DDR_ras_n                      => DDR_ras_n,
      DDR_reset_n                    => DDR_reset_n,
      DDR_we_n                       => DDR_we_n,
      FCLK_CLK0_0                    => clock_100MHz,
      FCLK_RESET0_N_0(0)             => reset_n,
      FIXED_IO_ddr_vrn               => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp               => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0)      => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk                => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb               => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb              => FIXED_IO_ps_srstb,
      GPIO_0_tri_o(31 downto 0)      => GPIO_0_tri_o(31 downto 0));
end STRUCTURE;
