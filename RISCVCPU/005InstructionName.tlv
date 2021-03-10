 \m4_TLV_version 1d: tl-x.org
\SV
   // This code can be found in: https://github.com/stevehoover/LF-Building-a-RISC-V-CPU-Core/risc-v_shell.tlv
   
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/warp-v_includes/1d1023ccf8e7b0a8cf8e8fc4f0a823ebb61008e3/risc-v_defs.tlv'])
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/LF-Building-a-RISC-V-CPU-Core/main/lib/risc-v_shell_lib.tlv'])



   //---------------------------------------------------------------------------------
   // /====================\
   // | Sum 1 to 9 Program |
   // \====================/
   //
   // Program to test RV32I
   // Add 1,2,3,...,9 (in that order).
   //
   // Regs:
   //  x12 (a2): 10
   //  x13 (a3): 1..10
   //  x14 (a4): Sum
   // 
   m4_asm(ADDI, x14, x0, 0)             // Initialize sum register a4 with 0
   m4_asm(ADDI, x12, x0, 1010)          // Store count of 10 in register a2.
   m4_asm(ADDI, x13, x0, 1)             // Initialize loop count register a3 with 0
   // Loop:
   m4_asm(ADD, x14, x13, x14)           // Incremental summation
   m4_asm(ADDI, x13, x13, 1)            // Increment loop count by 1
   m4_asm(BLT, x13, x12, 1111111111000) // If a3 is less than a2, branch to label named <loop>
   // Test result value in x14, and set x31 to reflect pass/fail.
   m4_asm(ADDI, x30, x14, 111111010100) // Subtract expected value of 44 to set x30 to 1 if and only iff the result is 45 (1 + 2 + ... + 9).
   m4_asm(BGE, x0, x0, 0) // Done. Jump to itself (infinite loop). (Up to 20-bit signed immediate plus implicit 0 bit (unlike JALR) provides byte address; last immediate bit should also be 0)
   m4_asm_end()
   m4_define(['M4_MAX_CYC'], 50)
   //---------------------------------------------------------------------------------



\SV
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   /* verilator lint_on WIDTH */
\TLV
   
   $reset = *reset;
   
   // 1- PC Logic
   $next_pc[31:0] =  $reset ? '0 : $pc + 32'd4 ;
   $pc[31:0] = >>1$next_pc;
   
   // 2- Instruction Memory
   `READONLY_MEM($pc, $$instr[31:0]);
   
   // 3- Decoding Logic
   // u
   $is_u_instr = $instr[6:2] ==? 5'b0x101;
   // i
   $is_i_instr = $instr[6:2] ==? 5'b0000x ||
                 $instr[6:2] ==? 5'b001x0 ||
                 $instr[6:2] ==? 5'b11001 ;
   // r
   $is_b_instr = $instr[6:2] ==? 5'b11000;
   // s
   $is_s_instr = $instr[6:2] ==? 5'b0100x;
   // r
   $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                 $instr[6:2] ==? 5'b011x0 ||
                 $instr[6:2] ==? 5'b10100 ;
   // j 
   $is_j_instr = $instr[6:2] ==? 5'b11011;
   
   // 4- Instruction Fields
   //FUNCT7
   $funct7[6:0]   =  $instr[31:25];
   // FUNCT3
   $funct3[2:0]   =  $instr[14:12];
   // RS1
   $rs1[4:0] = $instr[19:15];
   // RS1
   $rs2[4:0] = $instr[24:20];
   // RD
   $rd[4:0] = $instr[11:7];
   // OPCODE
   $opcode[6:0] = $instr[6:0];
   //
   `BOGUS_USE($funct7 $funct3 $rs1 $rs2 $rd $opcode)
   
   // Validate 
   $funct7_valid  =  $is_r_instr;
   $funct3_valid  =  $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
   $rs1_valid     =  $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
   $rs2_valid     =  $is_r_instr || $is_s_instr || $is_b_instr ;
   $rd_valid      =  $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
   `BOGUS_USE($funct7_valid $funct3_valid $rs1_valid $rs2_valid $rd_valid $imm_valid)
   
   
    //4.1- Instrunction Fields
   $funct7_valid  =  $is_r_instr;
   $funct3_valid  =  $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
   $rs1_valid     =  $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
   $rs2_valid     =  $is_r_instr || $is_s_instr || $is_b_instr ;
   $rd_valid      =  $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
   $imm_valid     =  $is_i_instr || $is_s_instr || $is_b_instr || $is_u_instr || $is_j_instr;
   `BOGUS_USE($funct7_valid $funct3_valid $rs1_valid $rs2_valid $rd_valid $imm_valid)
      
   // 4.2- Immediate Value 
   $imm[31:0]  =  $is_i_instr ?  {{21{$instr[31]}}, $instr[30:20]}                                  :
                  $is_s_instr ?  {{21{$instr[31]}}, $instr[30:25], $instr[11:7]}                    :
                  $is_b_instr ?  {{20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0}   :
                  $is_u_instr ?  {$instr[31:12], 12'b0}                                             :
                  $is_j_instr ?  {{12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0} :
                                 32'b0 ;
   `BOGUS_USE($imm)
   
   // 5- Instruction Name
   $dec_bits[10:0]   =  {$funct7[5], $funct3, $opcode};
   // BEQ
   $is_beq           =  $dec_bits ==? 11'bx_000_1100011;
   // BNE
   $is_bne           =  $dec_bits ==? 11'bx_001_1100011;
   // BLT
   $is_blt           =  $dec_bits ==? 11'bx_100_1100011;
   // BGE
   $is_bge           =  $dec_bits ==? 11'bx_101_1100011;
   // BLTU
   $is_bltu          =  $dec_bits ==? 11'bx_110_1100011;
   // BGEU
   $is_bgeu          =  $dec_bits ==? 11'bx_111_1100011;
   // ADDI
   $is_addi          =  $dec_bits ==? 11'bx_000_0010011;
   // ADD
   $is_add           =  $dec_bits ==? 11'b0_000_0110011;
   `BOGUS_USE($is_beq $is_bne $is_blt $is_bge $is_bltu $is_bgeu $is_addi $is_add)
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = 1'b0;
   *failed = *cyc_cnt > M4_MAX_CYC;
   
   //m4+rf(32, 32, $reset, $wr_en, $wr_index[4:0], $wr_data[31:0], $rd1_en, $rd1_index[4:0], $rd1_data, $rd2_en, $rd2_index[4:0], $rd2_data)
   //m4+dmem(32, 32, $reset, $addr[4:0], $wr_en, $wr_data[31:0], $rd_en, $rd_data)
   m4+cpu_viz()
\SV
   endmodule