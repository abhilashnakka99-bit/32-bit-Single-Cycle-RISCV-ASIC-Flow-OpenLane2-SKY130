# 1. Primary clock
set clk_name clk
set clk_period 15.0

set clk_port [get_ports $clk_name]

create_clock \
    -name $clk_name \
    -period $clk_period \
    $clk_port


# 2. Clock characteristics
set_clock_uncertainty 0.25 [get_clocks $clk_name]
set_clock_transition 0.15 [get_clocks $clk_name]


# 3. Reset input
# rst is sampled synchronously by the sequential logic.
set rst_port [get_ports rst]

set_input_delay 0.0 \
    -clock $clk_name \
    $rst_port


# 4. Observation outputs
# These are debug/observation ports:
#   pc_out
#   alu_out_obs
#   reg_write_obs
#
# No external receiver timing requirement is specified,
# so do not reserve several nanoseconds of the 15 ns period.
set obs_output_ports [get_ports {pc_out alu_out_obs reg_write_obs}]

set_output_delay 0.0 \
    -clock $clk_name \
    $obs_output_ports


# 5. Input drive model
set_driving_cell \
    -lib_cell sky130_fd_sc_hd__buf_2 \
    -pin X \
    [get_ports rst]


# 6. Output load
set_load 0.010 \
    $obs_output_ports
