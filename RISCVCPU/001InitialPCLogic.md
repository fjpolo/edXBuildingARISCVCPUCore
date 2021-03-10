# Implementing PC Logic

Initially, we will implement only sequential fetching, so the PC update will be, for now, simply a counter. Note that:

The PC is a byte address, meaning it references the first byte of an instruction in the IMem. Instructions are 4 bytes long, so, although the PC increment is depicted as "+1" (instruction), the actual increment must be by 4 (bytes). The lowest two PC bits must always be zero in normal operation.
Instruction fetching should start from address zero, so the first $pc value with $reset deasserted should be zero, as is implemented in the logic diagram below.
Unlike our earlier counter circuit, for readability, we use unique names for $pc and $next_pc, by assigning $pc to the previous $next_pc.

[InitialPCLogic.opng]

