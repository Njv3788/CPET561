# Dr. Kaputa
# Quartus II compile script for DE1-SoC board
set project_name "lab4_top"

cd project
load_package flow
project_open $project_name
# 1] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/HW/generic_counter.vhd
set_global_assignment -name VHDL_FILE ../../src/HW/generic_pulse.vhd
set_global_assignment -name VHDL_FILE ../../src/HW/angle_counter.vhd
set_global_assignment -name VHDL_FILE ../../src/HW/pwm_generator.vhd
set_global_assignment -name VHDL_FILE ../../src/HW/finite_state_machine.vhd
set_global_assignment -name VHDL_FILE ../../src/HW/read_only_ram.vhd
set_global_assignment -name VHDL_FILE ../../src/HW/servo_controller.vhd
set_global_assignment -name VHDL_FILE ../../src/HW/lab4_top.vhd

#execute_flow -compile
project_close


