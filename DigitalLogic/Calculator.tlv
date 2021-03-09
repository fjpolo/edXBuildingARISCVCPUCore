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
//   $reset = *reset;

   //  Calculator:
   //			op==00 -> +
   //			op==01 -> -
   //			op==10 -> *
   //			op==11 -> /
   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1 - $val2[31:0];
   $prod[31:0] = $val1 * $val2;
   $quot[31:0] = $val1 / $val2;
   
   $out[31:0] = $op == 2'b00 ? $sum :
                $op == 2'b01 ? $diff :
                $op == 2'b10 ? $prod :
                               $quot;
   
   

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
