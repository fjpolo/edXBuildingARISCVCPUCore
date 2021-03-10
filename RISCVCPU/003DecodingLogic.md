# Decoding Logic

[DecodingLogic.png]

Now that we have an instruction, let’s figure out what it is. Remember, RISC-V defines various instruction types that define the layout of the fields of the instruction, according to this table from the RISC-V specifications [https://riscv.org/technical/specifications/]:

[BaseInstructionFormat.png]

Before we can interpret the instruction, we must know its type. This is determined by its opcode, in $instr[6:0]. In fact, $instr[1:0] must be 2'b11 for valid RV32I instructions. We will assume all instructions to be valid, so we can simply ignore these two bits. The ISA defines the instruction type to be determined as follows.

[InstructionTypes.png]

You'll assign a boolean signal for each instruction type that indicates whether the instruction is of that type. For example, we could decode U-type as:

   $is_u_instr = $instr[6:2] == 5'b00101 ||
                 $instr[6:2] == 5'b01101;

Complete and check off this step:


Observe how the binary values in this expression correspond to the two U-type boxes in the table.
SystemVerilog gives us an operator that makes this comparison a little simpler:

$is_u_instr = $instr[6:2] ==? 5'b0x101;

The ==? operator above allows some bits to be excluded from the comparison by specifying them as "x" (referred to as don’t-care).


