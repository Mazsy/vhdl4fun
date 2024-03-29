
// Copyright (c) 2000-2009 Bluespec, Inc.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// $Revision: 17872 $
// $Date: 2009-09-18 14:32:56 +0000 (Fri, 18 Sep 2009) $

`ifdef BSV_ASSIGNMENT_DELAY
`else
`define BSV_ASSIGNMENT_DELAY
`endif


// A synchronization module for resets.   Output resets are held for
// RSTDELAY+1 cycles, RSTDELAY >= 0.  Reset assertion is asynchronous,
// while deassertion is synchronized to the clock.
module SyncResetA (
                   IN_RST_N,
                   CLK,
                   OUT_RST_N
                   );
  
   parameter          RSTDELAY = 1  ; // Width of reset shift reg
   
   input              CLK ;
   input              IN_RST_N ;
   output             OUT_RST_N ;

   reg [RSTDELAY:0]   reset_hold ;

   assign  OUT_RST_N = reset_hold[RSTDELAY] ;

   always @( posedge CLK or negedge IN_RST_N )
     begin
        if (IN_RST_N == 0)
           begin
              reset_hold <= `BSV_ASSIGNMENT_DELAY 0 ;
           end
        else
          begin
             reset_hold <= `BSV_ASSIGNMENT_DELAY ( reset_hold << 1 ) | 'b1 ;
          end
     end // always @ ( posedge CLK or negedge IN_RST_N )
   
`ifdef BSV_NO_INITIAL_BLOCKS
`else // not BSV_NO_INITIAL_BLOCKS
   // synopsys translate_off
   initial
     begin
        #0 ;
        // initialize out of reset forcing the designer to do one
        reset_hold = {(RSTDELAY + 1) {1'b1}} ;
     end
   // synopsys translate_on
`endif // BSV_NO_INITIAL_BLOCKS
   
endmodule // SyncResetA
