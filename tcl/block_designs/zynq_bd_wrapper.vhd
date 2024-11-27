--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
--Date        : Wed Nov 27 11:28:18 2024
--Host        : Tehoin-PC running 64-bit major release  (build 9200)
--Command     : generate_target zynq_bd_wrapper.bd
--Design      : zynq_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity zynq_bd_wrapper is
  port (
    BRAM_PORTA_0_addr : out STD_LOGIC_VECTOR ( 11 downto 0 );
    BRAM_PORTA_0_clk  : out STD_LOGIC;
    BRAM_PORTA_0_din  : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_0_en   : out STD_LOGIC;
    BRAM_PORTA_0_rst  : out STD_LOGIC;
    BRAM_PORTA_0_we   : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORTB_0_addr : out STD_LOGIC_VECTOR ( 11 downto 0 );
    BRAM_PORTB_0_clk  : out STD_LOGIC;
    BRAM_PORTB_0_din  : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTB_0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTB_0_en   : out STD_LOGIC;
    BRAM_PORTB_0_rst  : out STD_LOGIC;
    BRAM_PORTB_0_we   : out STD_LOGIC_VECTOR ( 3 downto 0 );
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
    FCLK_CLK0_0       : out STD_LOGIC;
    FCLK_RESET0_N_0   : out STD_LOGIC_VECTOR ( 0 to 0 );
    FIXED_IO_ddr_vrn  : inout STD_LOGIC;
    FIXED_IO_ddr_vrp  : inout STD_LOGIC;
    FIXED_IO_mio      : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk   : inout STD_LOGIC;
    FIXED_IO_ps_porb  : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    GPIO_0_tri_o      : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end zynq_bd_wrapper;

architecture STRUCTURE of zynq_bd_wrapper is
  component zynq_bd is
  port (
    DDR_cas_n         : inout STD_LOGIC;
    DDR_cke           : inout STD_LOGIC;
    DDR_ck_n          : inout STD_LOGIC;
    DDR_ck_p          : inout STD_LOGIC;
    DDR_cs_n          : inout STD_LOGIC;
    DDR_reset_n       : inout STD_LOGIC;
    DDR_odt           : inout STD_LOGIC;
    DDR_ras_n         : inout STD_LOGIC;
    DDR_we_n          : inout STD_LOGIC;
    DDR_ba            : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr          : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm            : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq            : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n         : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p         : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio      : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn  : inout STD_LOGIC;
    FIXED_IO_ddr_vrp  : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk   : inout STD_LOGIC;
    FIXED_IO_ps_porb  : inout STD_LOGIC;
    FCLK_CLK0_0       : out STD_LOGIC;
    FCLK_RESET0_N_0   : out STD_LOGIC_VECTOR ( 0 to 0 );
    BRAM_PORTA_0_addr : out STD_LOGIC_VECTOR ( 11 downto 0 );
    BRAM_PORTA_0_clk  : out STD_LOGIC;
    BRAM_PORTA_0_din  : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_0_en   : out STD_LOGIC;
    BRAM_PORTA_0_rst  : out STD_LOGIC;
    BRAM_PORTA_0_we   : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BRAM_PORTB_0_addr : out STD_LOGIC_VECTOR ( 11 downto 0 );
    BRAM_PORTB_0_clk  : out STD_LOGIC;
    BRAM_PORTB_0_din  : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTB_0_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTB_0_en   : out STD_LOGIC;
    BRAM_PORTB_0_rst  : out STD_LOGIC;
    BRAM_PORTB_0_we   : out STD_LOGIC_VECTOR ( 3 downto 0 );
    GPIO_0_tri_o      : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component zynq_bd;
begin
zynq_bd_i: component zynq_bd
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
      FCLK_CLK0_0                    => FCLK_CLK0_0,
      FCLK_RESET0_N_0(0)             => FCLK_RESET0_N_0(0),
      FIXED_IO_ddr_vrn               => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp               => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0)      => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk                => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb               => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb              => FIXED_IO_ps_srstb,
      GPIO_0_tri_o(31 downto 0)      => GPIO_0_tri_o(31 downto 0)
    );
end STRUCTURE;

