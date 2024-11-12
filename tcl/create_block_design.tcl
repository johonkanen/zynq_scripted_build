
startgroup
set_property -dict [list \
  CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} \
  CONFIG.PCW_UART0_UART0_IO {MIO 14 .. 15} \
] [get_bd_cells processing_system7_0]
endgroup

startgroup
set_property -dict [list \
  CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {ARM PLL} \
  CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {166.666667} \
] [get_bd_cells processing_system7_0]
endgroup

startgroup
make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_CLK0]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_RESET0_N]
endgroup

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

regenerate_bd_layout
assign_bd_address

save_bd_design
