# Register File Read

[RegisterFileRead.png]

Like our mini IMem, the register file is a pretty typical array structure, so we can find a library component for it. This time, rather than using a Verilog module or macro as we did for IMem, we will use a TL-Verilog array definition, expanded by the M4 macro preprocessor.

Near the bottom of your code, and commented out, you’ll find the following example instantiation of a register file (RF) macro:

//m4+rf(32, 32, $reset, $wr_en, $wr_index[4:0], $wr_data[31:0], $rd1_en, $rd1_index[4:0], $rd1_data, $rd2_en, $rd2_index[4:0], $rd2_data)

This would instantiate a 32-entry, 32-bit-wide register file connected to the given input and output signals, as depicted below. Each of the two read ports requires an index to read from and an enable signal that must assert when a read is required, and it produces read data as output (on the same cycle).

[RegisterFileInstantiation.png]

For example, to read register 5 (x5) and register 8 (x8), $rd_en1 and $rd_en2 would both be asserted, and $rd_index1 and $rd_index2 would be driven with 5 and 8.

A few things to note:

- For this macro, output signal arguments are signal names. Inputs are expressions.
- Note that here we are using "rd" as an abbreviation for read, which is easily confused with the destination register to be written by an instruction which is also referred to in RISC-V as "rd".

