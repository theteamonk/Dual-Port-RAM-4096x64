/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename       :  mem_dec.v   

Description    :  2:4 decoder used to increase address width

Author Name    :  Putta Satish   

Support e-mail :  techsupport_vm@maven-silicon.com 

Version        :  1.0

Date           :  02/06/2020

*********************************************************************************************/


module mem_dec ( mem_in1,
                 mem_in0,
                 mem_out3,
                 mem_out2,
                 mem_out1,
                 mem_out0);

   input mem_in1,
         mem_in0;

   output reg mem_out3,
              mem_out2,
              mem_out1,
              mem_out0;

   always@(mem_in1,mem_in0)
      begin
         case ({mem_in1,mem_in0})
            2'b00 : {mem_out3,mem_out2,mem_out1,mem_out0} = 4'b0001;
            2'b01 : {mem_out3,mem_out2,mem_out1,mem_out0} = 4'b0010;
            2'b10 : {mem_out3,mem_out2,mem_out1,mem_out0} = 4'b0100;
            2'b11 : {mem_out3,mem_out2,mem_out1,mem_out0} = 4'b1000;
         endcase
      end
endmodule

