# Instruction Fields

Now, based on the instruction type, we can extract the instruction fields. Most fields always come from the same bits regardless of the instruction type but only have meaning for certain instruction types. The imm field, an "immediate" value embedded in the instruction itself, is the exception. It is constructed from different bits depending on the instruction type.

[InstructionTypes.png]

The immediate value is a bit more complicated. It is composed of bits from different fields depending on the type.

[InstructionTypesImmediateValue.png]

The immediate value for I-type instructions, for example is formed from 21 copies of instruction bit 31, followed by inst[30:20] (which is broken into three fields above for consistency with other formats).

The immediate field can be formed, based on this table, using a logic expression like the following. It uses a combination of bit extraction (e.g. $instr[30:20]), bit replication (e.g. {21{...}}), and bit concatenation (e.g. {..., …}):

   $imm[31:0] = $is_i_instr ? {  {21{$instr[31]}},  $instr[30:20]  } :
                $is_s_instr ? {...} :
                ...
                              32'b0;  // Default