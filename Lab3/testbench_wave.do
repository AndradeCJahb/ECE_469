onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/cpu/clk
add wave -noupdate /testbench/cpu/rst
add wave -noupdate /testbench/cpu/Instr
add wave -noupdate /testbench/cpu/ReadData
add wave -noupdate /testbench/cpu/WriteData
add wave -noupdate -radix decimal -childformat {{{/testbench/cpu/PC[31]} -radix decimal} {{/testbench/cpu/PC[30]} -radix decimal} {{/testbench/cpu/PC[29]} -radix decimal} {{/testbench/cpu/PC[28]} -radix decimal} {{/testbench/cpu/PC[27]} -radix decimal} {{/testbench/cpu/PC[26]} -radix decimal} {{/testbench/cpu/PC[25]} -radix decimal} {{/testbench/cpu/PC[24]} -radix decimal} {{/testbench/cpu/PC[23]} -radix decimal} {{/testbench/cpu/PC[22]} -radix decimal} {{/testbench/cpu/PC[21]} -radix decimal} {{/testbench/cpu/PC[20]} -radix decimal} {{/testbench/cpu/PC[19]} -radix decimal} {{/testbench/cpu/PC[18]} -radix decimal} {{/testbench/cpu/PC[17]} -radix decimal} {{/testbench/cpu/PC[16]} -radix decimal} {{/testbench/cpu/PC[15]} -radix decimal} {{/testbench/cpu/PC[14]} -radix decimal} {{/testbench/cpu/PC[13]} -radix decimal} {{/testbench/cpu/PC[12]} -radix decimal} {{/testbench/cpu/PC[11]} -radix decimal} {{/testbench/cpu/PC[10]} -radix decimal} {{/testbench/cpu/PC[9]} -radix decimal} {{/testbench/cpu/PC[8]} -radix decimal} {{/testbench/cpu/PC[7]} -radix decimal} {{/testbench/cpu/PC[6]} -radix decimal} {{/testbench/cpu/PC[5]} -radix decimal} {{/testbench/cpu/PC[4]} -radix decimal} {{/testbench/cpu/PC[3]} -radix decimal} {{/testbench/cpu/PC[2]} -radix decimal} {{/testbench/cpu/PC[1]} -radix decimal} {{/testbench/cpu/PC[0]} -radix decimal}} -subitemconfig {{/testbench/cpu/PC[31]} {-radix decimal} {/testbench/cpu/PC[30]} {-radix decimal} {/testbench/cpu/PC[29]} {-radix decimal} {/testbench/cpu/PC[28]} {-radix decimal} {/testbench/cpu/PC[27]} {-radix decimal} {/testbench/cpu/PC[26]} {-radix decimal} {/testbench/cpu/PC[25]} {-radix decimal} {/testbench/cpu/PC[24]} {-radix decimal} {/testbench/cpu/PC[23]} {-radix decimal} {/testbench/cpu/PC[22]} {-radix decimal} {/testbench/cpu/PC[21]} {-radix decimal} {/testbench/cpu/PC[20]} {-radix decimal} {/testbench/cpu/PC[19]} {-radix decimal} {/testbench/cpu/PC[18]} {-radix decimal} {/testbench/cpu/PC[17]} {-radix decimal} {/testbench/cpu/PC[16]} {-radix decimal} {/testbench/cpu/PC[15]} {-radix decimal} {/testbench/cpu/PC[14]} {-radix decimal} {/testbench/cpu/PC[13]} {-radix decimal} {/testbench/cpu/PC[12]} {-radix decimal} {/testbench/cpu/PC[11]} {-radix decimal} {/testbench/cpu/PC[10]} {-radix decimal} {/testbench/cpu/PC[9]} {-radix decimal} {/testbench/cpu/PC[8]} {-radix decimal} {/testbench/cpu/PC[7]} {-radix decimal} {/testbench/cpu/PC[6]} {-radix decimal} {/testbench/cpu/PC[5]} {-radix decimal} {/testbench/cpu/PC[4]} {-radix decimal} {/testbench/cpu/PC[3]} {-radix decimal} {/testbench/cpu/PC[2]} {-radix decimal} {/testbench/cpu/PC[1]} {-radix decimal} {/testbench/cpu/PC[0]} {-radix decimal}} /testbench/cpu/PC
add wave -noupdate /testbench/cpu/ALUResult
add wave -noupdate /testbench/cpu/MemWrite
add wave -noupdate -radix decimal -childformat {{{/testbench/cpu/processor/u_reg_file/memory[15]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[14]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[13]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[12]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[11]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[10]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[9]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[8]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[7]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[6]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[5]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[4]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[3]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[2]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[1]} -radix decimal} {{/testbench/cpu/processor/u_reg_file/memory[0]} -radix decimal}} -subitemconfig {{/testbench/cpu/processor/u_reg_file/memory[15]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[14]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[13]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[12]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[11]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[10]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[9]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[8]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[7]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[6]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[5]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[4]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[3]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[2]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[1]} {-height 15 -radix decimal} {/testbench/cpu/processor/u_reg_file/memory[0]} {-height 15 -radix decimal}} /testbench/cpu/processor/u_reg_file/memory
add wave -noupdate /testbench/cpu/processor/FlagWrite
add wave -noupdate /testbench/cpu/processor/CondSuccess
add wave -noupdate /testbench/cpu/processor/FlagsReg
add wave -noupdate /testbench/cpu/processor/ALUFlags
add wave -noupdate /testbench/cpu/Instr
add wave -noupdate /testbench/cpu/processor/PCSrc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1001 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2912 ps}
