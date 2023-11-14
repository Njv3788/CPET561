# Dr. Kaputa
# Quartus II compile script for DE1-SoC board
set project_name "Arbitration_part1"

cd project
load_package flow
project_open $project_name
# 1] include your relative path files here

set_global_assignment -name VHDL_FILE ../../src/HW/Arbitration_part1.vhd
set_global_assignment -name VHDL_FILE ../../src/HW/RAM_controller.vhd
set_global_assignment -name QIP_FILE ../../src/HW/nios_system/nios_system/synthesis/nios_system.qip
set_global_assignment -name QIP_FILE ../../src/HW/external_RAM/external_RAM.qip

#execute_flow -compile
project_close


