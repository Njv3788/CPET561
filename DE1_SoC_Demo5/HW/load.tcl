# Dr. Kaputa
# Quartus II compile script for DE1-SoC board
set project_name "custom_component_demo"

cd project
load_package flow
project_open $project_name
# 1] include your relative path files here
set_global_assignment -name QIP_FILE ../../src/HW/nios_system/nios_system/synthesis/nios_system.qip
set_global_assignment -name VHDL_FILE ../../src/HW/custom_component_demo.vhd

#execute_flow -compile
project_close


