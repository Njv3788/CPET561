# Dr. Kaputa
# Quartus II compile script for DE1-SoC board
set project_name "TimeQuest_Demo"

cd project
load_package flow
project_open $project_name
# 1] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/HW/TimeQuest_Demo.vhd

#execute_flow -compile
project_close

