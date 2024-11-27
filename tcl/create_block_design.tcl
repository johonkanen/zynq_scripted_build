create_bd_design "zynq_bd"

create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0

set_property -dict [list \
  CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {ARM PLL} \
  CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {166.666} \
  CONFIG.PCW_USE_M_AXI_GP0 {0} \
] [get_bd_cells processing_system7_0]

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
    make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_CLK0]
    make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_RESET0_N]

set_property CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} [get_bd_cells processing_system7_0]

set_property -dict [list \
  CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
  CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
] [get_bd_cells processing_system7_0]

set_property -dict [list \
  CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {16 Bit} \
  CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} \
] [get_bd_cells processing_system7_0]

set_property -dict [list \
  CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
  CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
] [get_bd_cells processing_system7_0]

set_property -dict [list \
  CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
  CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
] [get_bd_cells processing_system7_0]

startgroup
set_property -dict [list \
  CONFIG.PCW_IRQ_F2P_INTR {1} \
  CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
] [get_bd_cells processing_system7_0]
endgroup
startgroup
set_property CONFIG.PCW_USE_M_AXI_GP0 {1} [get_bd_cells processing_system7_0]
endgroup

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 eka_timeri
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 eka_interconnect
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 systeemin_resetti


connect_bd_intf_net [get_bd_intf_pins processing_system7_0/M_AXI_GP0] -boundary_type upper [get_bd_intf_pins eka_interconnect/S00_AXI]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins eka_interconnect/M00_AXI] [get_bd_intf_pins eka_timeri/S_AXI]
connect_bd_net [get_bd_pins eka_timeri/interrupt] [get_bd_pins processing_system7_0/IRQ_F2P]


connect_bd_net [get_bd_pins eka_interconnect/ACLK] [get_bd_pins eka_interconnect/S00_ACLK] -boundary_type upper
connect_bd_net [get_bd_pins eka_interconnect/S00_ACLK] [get_bd_pins eka_interconnect/M00_ACLK] -boundary_type upper
connect_bd_net [get_bd_pins eka_interconnect/M00_ACLK] [get_bd_pins eka_interconnect/M01_ACLK] -boundary_type upper
connect_bd_net [get_bd_pins eka_interconnect/ACLK] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins eka_timeri/s_axi_aclk]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins systeemin_resetti/slowest_sync_clk]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins systeemin_resetti/ext_reset_in]

connect_bd_net [get_bd_pins eka_interconnect/M01_ACLK] [get_bd_pins processing_system7_0/FCLK_CLK_0]

connect_bd_net [get_bd_pins eka_interconnect/ARESETN] [get_bd_pins processing_system7_0/FCLK_RESET0_N]
connect_bd_net [get_bd_pins eka_interconnect/S00_ARESETN] [get_bd_pins processing_system7_0/FCLK_RESET0_N]
connect_bd_net [get_bd_pins eka_interconnect/M00_ARESETN] [get_bd_pins processing_system7_0/FCLK_RESET0_N]
connect_bd_net [get_bd_pins eka_interconnect/M01_ARESETN] [get_bd_pins processing_system7_0/FCLK_RESET0_N]
connect_bd_net [get_bd_pins eka_timeri/s_axi_aresetn] [get_bd_pins processing_system7_0/FCLK_RESET0_N]

#works
#connect_bd_net [get_bd_pins eka_interconnect/ACLK] [get_bd_pins processing_system7_0/FCLK_CLK_0]
#connect_bd_net [get_bd_pins eka_interconnect/S00_ACLK] [get_bd_pins processing_system7_0/FCLK_CLK_0]
#connect_bd_net [get_bd_pins eka_interconnect/M00_ACLK] [get_bd_pins processing_system7_0/FCLK_CLK_0]
#
#connect_bd_net [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins systeemin_resetti/peripheral_aresetn]
#connect_bd_net [get_bd_pins eka_interconnect/M01_ARESETN] [get_bd_pins systeemin_resetti/peripheral_aresetn]
#connect_bd_net [get_bd_pins eka_interconnect/M00_ARESETN] [get_bd_pins systeemin_resetti/peripheral_aresetn]
#connect_bd_net [get_bd_pins eka_interconnect/S00_ARESETN] [get_bd_pins systeemin_resetti/peripheral_aresetn]
#connect_bd_net [get_bd_pins eka_interconnect/ARESETN] [get_bd_pins systeemin_resetti/peripheral_aresetn]

#assign_bd_address
#
#source D:/dev/zynq_scripted_build/tcl/create_block_design.tcl
