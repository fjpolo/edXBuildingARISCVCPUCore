\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;

   //
   $out = ! $in1;
   
   //
   //  Unlike Verilog, there was no need to declare your signals 
   //(wires) ($out and $in1). In TL-Verilog, your assignment 
   //statement acts as the declaration of its output signal(s).
   //
   //  This circuit has a dangling input signal and a dangling 
   //output signal. It also probably has a dangling $reset signal 
   //that was provided in the template. These result in non-fatal 
   //warning/error conditions. They are reported, but they do not 
   //prevent simulation.
   //  
   //  There was no need to write a test bench to provide stimulus 
   //(input) to your inverter. Makerchip provides random stimulus for 
   //dangling inputs. As your designs mature, you will want to avoid 
   //dangling signals and provide more-targeted stimulus, but, while 
   //your code is under development, automatic stimulus can be a real 
   //convenience.
   //
   //  TL-Verilog defines syntax very rigidly. This can be a source of 
   //annoyance for newcomers with their own coding style preferences. 
   //But this rigidity has an important benefit. In industry, code is 
   //touched by many hands from many teams, and this rigidity enforces 
   //consistency. The TL-Verilog Syntax Specification can be found from 
   //the Makerchip "Help" menu.
   //
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
