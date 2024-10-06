# Step 1: Create a new project
create_project my_project ./my_project -part xc7z020clg400-1

set_property target_language VHDL [current_project]

# Step 2: Add source files (VHDL/Verilog)
#add_files {./src/my_design.vhd}

# Step 3: Create and configure the block design
create_bd_design "zynq_bd"

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0
endgroup

startgroup
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {Auto}}  [get_bd_pins proc_sys_reset_0/ext_reset_in]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/processing_system7_0/FCLK_CLK0 (50 MHz)} Freq {50} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
endgroup

regenerate_bd_layout

#apply_bd_automation -rule processing_system7 -config { } [get_bd_cells ps7]
#regenerate_bd_layout
#
## Step 4: Synthesize, implement, and generate the bitstream
#synth_design -top top_module -part xc7z020clg400-1
#opt_design
#place_design
#route_design
#write_bitstream
#
## Step 5: Export hardware for SDK/Vitis
#write_hw_platform -include_bit -force ./my_project.sdk/my_project.xsa
#
#exit

