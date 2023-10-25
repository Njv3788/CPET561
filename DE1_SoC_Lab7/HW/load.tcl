# Dr. Kaputa
# Quartus II compile script for DE1-SoC board
set project_name "lab7_top"

cd project
load_package flow
project_open $project_name
# 1] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/HW/synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/HW/lab7_top.vhd
set_global_assignment -name QIP_FILE ../../src/HW/nios_system/nios_system/synthesis/nios_system.qip

#execute_flow -compile
project_close


