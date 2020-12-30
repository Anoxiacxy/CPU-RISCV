`timescale 1ns/100ps
`include "test.v"

module test_tb;

   wire A, B, C, D, E;
   integer k=0;

   assign {A,B,C} = k;
   test the_circuit(A, B, C, D, E);

   initial begin

      $dumpfile("test.vcd");
      $dumpvars(0, test_tb);

      for (k=0; k<8; k=k+1)
        #10 $display("done testing case %d", k);

      $finish;

   end

endmodule