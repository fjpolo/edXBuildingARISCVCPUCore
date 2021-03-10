# Register File Write

$result needs to be written back to the destination register (rd) in the register file (if the instruction has a destination register). Complete and check off each step:


Connect the register file’s write inputs to perform this write-back for instructions that have a valid destination register.

Compile/simulate. Check LOG. And confirm using VIZ that the destination register is being written to the register file.
In RISC-V, x0 (at register file index 0) is "always-zero". One way to implement this behavior is to avoid writing x0.


Currently, our test program doesn’t write x0, so we have no way to test this change. Add an instruction after the branch that writes a non-zero value to x0, and watch it write in VIZ.

Modify your logic to deassert the register file write enable input if the destination register is 0. Compile/simulate, debug, and confirm in VIZ that the jump instruction no longer writes. Delete the added test instruction if you like, it won’t matter.