# Step 0: set up path to this file
variable tcl_path [ file dirname [ file normalize [ info script ] ] ] 
variable build_path ./

# Step 1: Create a new project
create_project my_project ./my_project -part xc7z020clg400-2 -force

set_property target_language VHDL [current_project]

proc program_ram {bitfile} {
    open_hw_manager
    connect_hw_server -allow_non_jtag
    open_hw_target
    set_property PROBES.FILE {} [get_hw_devices xc7z020_1]
    set_property FULL_PROBES.FILE {} [get_hw_devices xc7z020_1]
    set_property PROGRAM.FILE $bitfile [get_hw_devices xc7z020_1]
    program_hw_devices [get_hw_devices xc7z020_1]
    disconnect_hw_server
}


# Create and configure the block design
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

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0

set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]
set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
set rst_ps7_0_166M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps7_0_166M ]

# Create interface connections
connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins axi_timer_0/S_AXI]
connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins axi_interconnect_0/S00_AXI]

# Create port connections
connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins processing_system7_0/IRQ_F2P]
connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_ports FCLK_CLK0_0] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins rst_ps7_0_166M/slowest_sync_clk] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK]
connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_ports FCLK_RESET0_N_0] [get_bd_pins rst_ps7_0_166M/ext_reset_in]
connect_bd_net -net rst_ps7_0_166M_peripheral_aresetn [get_bd_pins rst_ps7_0_166M/peripheral_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN]
    
assign_bd_address
regenerate_bd_layout

save_bd_design

generate_target all [get_files  $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd]

export_ip_user_files -of_objects [get_files $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd]
launch_runs zynq_bd_processing_system7_0_0_synth_1 -jobs 32
export_simulation -of_objects [get_files $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd] -directory $build_path/my_project/my_project.ip_user_files/sim_scripts -ip_user_files_dir $build_path/my_project/my_project.ip_user_files -ipstatic_source_dir $build_path/my_project/my_project.ip_user_files/ipstatic -lib_map_path [list {modelsim=$build_path/my_project/my_project.cache/compile_simlib/modelsim} {questa=$build_path/my_project/my_project.cache/compile_simlib/questa} {riviera=$build_path/my_project/my_project.cache/compile_simlib/riviera} {activehdl=$build_path/my_project/my_project.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
wait_on_run zynq_bd_processing_system7_0_0_synth_1

add_files -norecurse $tcl_path/../vhdl_sources/generated_top.vhd
add_files -norecurse $tcl_path/../vhdl_sources/top.vhd
set_property top top [current_fileset]

write_hw_platform -fixed -force -file $build_path/zynq_hw_export.xsa

synth_design -rtl -rtl_skip_mlo -name rtl_1

set_property IOSTANDARD LVCMOS33 [get_ports [list led_blinker]]
place_ports led_blinker T12

close [ open $build_path/placed_design.xdc w ]
add_files -fileset constrs_1 $build_path/placed_design.xdc
set_property target_constrs_file $build_path/placed_design.xdc [current_fileset -constrset]
save_constraints -force

launch_runs synth_1 -jobs 32
wait_on_run synth_1

launch_runs impl_1 -jobs 32
wait_on_run impl_1

open_run impl_1 -name impl_1
write_bitstream -force jihuu.bit
#close_design
##launch_runs impl_1 -to_step write_bitstream -jobs 32
##wait_on_run impl_1
##
##proc write_bit_and_flash_images {imagename} {
##
##    # #VCCO(zero) = IO = 2.5V || 3.3V, GND IO bank0 = 1.8v
##    set_property CFGBVS VCCO [current_design]
##    set_property CONFIG_VOLTAGE 3.3 [current_design]
##    set_property BITSTREAM.Config.SPI_BUSWIDTH 4 [current_design]
##    set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
##
##    write_bitstream -force $imagename.bit
##    write_cfgmem -force  -format mcs -size 128 -interface SPIx4        \
##        -loadbit "up 0x0 ${imagename}.bit"\
##        -file $imagename.mcs
##}
program_ram jihuu.bit
