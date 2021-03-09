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
   
   //  Verilog provides no less than six reasonable syntaxes for 
   //coding a multiplexer, each with pros and cons. TL-Verilog 
   //favors the use of the ternary (? :) operator, and we will 
   //stick with this throughout the course. In its simplest form, 
   //the ternary operator is:
   //
   //$out = $sel ? $in1 : $in0;
   
   //  The ternary operator can be chained to implement multiplexers 
   //with more than two input values from which to select. And these 
   //inputs can be vectors. We will use very specific code formatting 
   //for consistency, illustrated below for a four-way, 8-bit wide 
   //multiplexer with a one-hot select. (Here, $in0-3 must be 8-bit 
   //vectors.)
   
   $out[7:0] =
      $sel[3]
         ? $in3 :
      $sel[2]
         ? $in2 :
      $sel[1]
         ? $in1 :
     //default
        $in0;
   
   //  This expression prioritizes top-to-bottom. So, if $sel[3] is 
   //asserted, $in3 will be driven on the output regardless of the 
   //other $sel bits. Its literal interpretation is depicted below, 
   //along with its single-gate representation (which is ambiguous 
   //about the priority).
   


   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
