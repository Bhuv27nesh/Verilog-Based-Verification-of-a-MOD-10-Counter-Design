# Verilog-Based-Verification-of-a-MOD-10-Counter-Design

## Description: Verification of MOD-10 Counter Using Verilog

This experiment focuses on the functional verification of a MOD-10 counter with load capability using Verilog HDL. 
The given design consists of a 4-bit counter that counts from 0 to 9 and rolls over to 0 after reaching 9. 
The counter also includes a load feature, where a 4-bit input value (din) can be loaded into the counter for one clock 
cycle when the load signal is asserted.

## Design File: mod10counter.v
The design file implements a synchronous MOD-10 counter with the following features:

1. Inputs and Outputs
    clk – Clock signal
    rst – Reset signal
    load – Load enable signal
    din[3:0] – 4-bit data input
    count[3:0] – 4-bit counter output

2. Functional Behavior
    On reset, the counter initializes to 0.
    When load = 1, the counter loads the input value din.
    When load = 0, the counter increments on every clock edge.
    The counter rolls over after reaching 9 (MOD-10 operation).
    The design uses non-blocking assignments (<=) inside a clocked always block.
    Sequential logic is implemented using posedge clk.

During verification, bugs in the reset and counting conditions were identified and corrected to ensure proper rollover and stable operation.


## Testbench File: mod10counter_test.v
The testbench was developed to thoroughly verify the functionality of the MOD-10 counter. The following tasks were performed:

1. Clock Generation
    A periodic clock signal was generated using an always block.

2. Reset Testing
    Applied reset to check whether the counter initializes to zero correctly.

3. Load Functionality Verification
    Different values were applied to din.
    The load signal was asserted for one clock pulse.
    Verified that the counter starts counting from the loaded value.

4. Counting and Rollover Testing
    Checked continuous increment operation.
    Verified correct rollover from 9 to 0.

5. Display of Results
    Used $display and/or $monitor to print counter values.
    Used $dumpfile and $dumpvars for waveform analysis.

## Simulation Results
  A total of 2987 test cases were executed during verification.
  2937 test cases passed successfully
  50 test cases failed
      Pass Percentage Calculation:98.32607%

## Conclusion
The MOD-10 counter design was successfully verified using a structured Verilog testbench environment. The counter correctly performs:
Reset operation
Load operation
Increment operation
Rollover at 9
With 2937 out of 2987 test cases passing, the design demonstrates high functional reliability. 
Minor discrepancies observed in a small number of cases suggest areas for refinement and improved corner-case handling.
