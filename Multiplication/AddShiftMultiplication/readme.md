# Add Shift Multiplication Algorithm 
  ## The Algorithm
  * The add shift algorithm is naive and spends a number of cycles equivalent to the size 
    of its operands.
  * The datapath consists of a multiplicand and a product register.
  * The product register has twice the length of an operand to accomodate multiply operations.
  * The operation of the algorithm can be summarized into the following steps
      ** Initialisation
      ** LSB TEST
      ** Add 
      ** Shift
      ** Finish
   * In the first stage the multiplier is loaded into the right half of the product register and Count initialised to 0
   * Next, Check if Count is equal to the size of an operand. If yes, we are done! 
     If not then, if the LSB of that register is '1' then proceed to stage 3 else stage 4. 
   * Add the multiplicand to the Left half of the product register 
   * Next, shift the product register right(srl) once, make a count(Count = Count + 1) and return to stage 2(LSB test)
   * We are done(at finish stage) if stage 2 branches on Count = Size of operand.
   
   ## Methodology
   * Attached in this folder are diagrams representing the datapath and Control Unit used in implementing the algorithm
