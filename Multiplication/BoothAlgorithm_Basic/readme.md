# Basic Booth Multiplication Algorithm
* The Booth algorithm is a multiplication algorithm that extends the basic add shift algorithm 
* Unlike the earlier one, it aims to reduce the number of addition cycles, 
thereby effectively decreasing the number of cycles it takes to compute an operation.
* This reduction is possible by means of recoding the multiplier to reduce the number of the 
addition
* The following summarises steps taken:
    * Initialise
    * Test ((LSB & Booth Bit) and Count)
    * Add (A + M) / Sub (A - M)
    * Shift 
    * Finish
* We maintain the size of the product register used in the earlier implementation
* We introduce a flop to hold an extra bit.(Booth booth Bit, I CALL IT)
## Steps(Elaboration)
* Initialise the product register and the boot flop as follows 
    * Fill the lower half of the product register with the Multiplier, upper half with zeros
    * Initialise the booth flop to Zero
    * Set counter to zero
* Test Count and (LSB & Booth Bit) as follows
    * If Count = size of operand register, then stage Finish else Stage 2 
    * IF the concatenation of product LSB and Booth Bit yields ;
        * 00 or 11, go to shift Stage
        * 01, Add stage
        * 10, Subtract stage
* Add Stage
        * Add Multiplicand to Upper half of Product register and store back in Upper half
        * go to shift Stage
* Subtract Stage
        * Subtract Upper half of product from Multiplicand and store back in upper half
        * Next go to Shift Stage
* Shift Stage
        * Make a one bit **Signed** right shift in Product reister, shifting its LSB into Booth flop
        * go back to Stage 2 to test again 
        
  ## Microarchitecture
  Shown in additional files
        
