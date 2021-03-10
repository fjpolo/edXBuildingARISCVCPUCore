# Instruction Memory

[InstructionMemory.png]

We will implement our IMem by instantiating a Verilog macro. This macro accepts a byte address as input, and produces the 32-bit read data as output. The macro can be instantiated, for example, as:

`READONLY_MEM($addr, $$read_data[31:0])

Verilog macro instantiation is preceded by a back-tick (not to be confused with a single quote).

In expressions like this that do not syntactically differentiate assigned signals from consumed signals, it is necessary to identify assigned signals using a "$$" prefix. And, as always, an assigned signal declares its bit range. Thus, $$read_data[31:0] is used above.

This macro is simplified in several ways versus what you would typically see for an array macro:

- There is no way to write to our array. The program specified in the template is magically populated into this array for you.
- Typically, an array would have a read enable input as well. This read enable would indicate, each cycle, whether to perform a read. Our array will always read, and we are not concerned with the power savings a read enable could offer.
- Typically, a memory structure like our IMem would be implemented using a physical structure called static random access memory, or SRAM. The address would be provided in one clock cycle, and the data would be read out in the next cycle. Our entire CPU, however, will execute within a single clock cycle. Our array provides its output data on the same clock cycle as the input address. Our macro would result in an implementation using flip-flops that would be far less optimal than SRAM.

[InstructionMemoryHookup.png]