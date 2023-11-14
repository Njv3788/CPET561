# Dr. Kaputa
# Quartus II compile script for DE1-SoC board
set project_name "Arbitration_part1"

cd project
load_package flow
project_open $project_name

execute_flow -compile
project_close


