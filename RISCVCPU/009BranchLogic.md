# Branch logic

[BranchLogic.png]

The last piece of the puzzle to get your test program executing properly is to implement the branch instructions. Our test program uses BLT to repeat the loop body if the next incrementing value to accumulate is less than ten. And it uses BGE to loop indefinitely at the end of the test program. We’ll go ahead and implement all the conditional branch instructions now.

A conditional branch instruction will branch to a target PC if its condition is true. Conditions are a comparison of the two source register values. Implementing conditional branch instructions will require:

- Determining whether the instruction is a branch that is taken ($taken_br).
- Computing the branch target ($br_tgt_pc).
- Updating the PC ($pc) accordingly.

[BranchLogicDetail.png]

Let’s start with the branch condition ($taken_br). Each conditional branch instruction has a different condition expression based on the two source register values ($src1_value and $src2_value, represented as x1 and x2 below).

[ConditionExpressionsTable.png]

Similar to the structure of the ALU, you’ll determine whether a branch is to be taken by selecting the appropriate comparison result.

[BranchTakenLogicDiagram.png]

Check the box for each completed step:


Code this as a single expression, as with the ALU. As the default case of the ternary operator, assign to zero for non-branch instructions. For each branch instruction, determine the value based on the Conditional Expression for that instruction listed in the table above.
We also need to know the target PC of the branch instruction. The target PC is given in the immediate field as a relative byte offset from the current PC. So, the target PC is the PC of the branch plus its immediate value.


Code an expression for $br_tgt_pc[31:0] = …

If the instruction is a taken branch, its next PC should be the branch target PC. Update the existing $next_pc expression to reflect this.

Compile/simulate and debug. Once all is correct, your program will be looping. It should stop looping once it has produced the sum of values 1..9 (45). The final ADDI subtracts 44 from this and should therefore produce a value of 1 in x30. Then the final BGE should loop indefinitely to itself.
Now that our test program seems to be working, let’s add some automated checking. We can tell the Makerchip platform that our test passed or failed by assigning the provided Verilog output signals passed and failed. In the \TLV context, Verilog signals are referenced with a preceeding "*".

We'll give you a little check that the program’s PC repeats, and that x30 contains a value of 1.


Enable this check by replacing the assignment of *passed with m4+tb()

Feel free to find the resulting macro expansion defining *passed in NAV-TLV. Check LOG for "Simulation PASSED!!!" message. CONGRATULATIONS!!! Save your work outside of Makerchip.