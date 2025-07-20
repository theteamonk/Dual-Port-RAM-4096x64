/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.


Filename       :  ram_model.sv   

Description    :  Reference Model for ram_testbench

Author Name    :  Putta Satish

Support e-mail :  techsupport_vm@maven-silicon.com 

Version        :  1.0

Date           :  02/06/2020

*********************************************************************************************/
// In class ram_model

class ram_model;
   //Declare two handles 'wrmon_data' and 'rdmon_data' for ram_trans
   //(to store the data from the read and write monitor)
   
   ram_trans wrmon_data;
   ram_trans rdmon_data;

   //Declare an associative array of 64 bits(logic type) and indexed int type
 
   logic [63:0] ref_data[int];

   //Declare three mailboxes 'wr2rm','rd2rm' and 'rm2sb' parameterized by ram_trans
   
   mailbox #(ram_trans) wr2rm;
   mailbox #(ram_trans) rd2rm;
   mailbox #(ram_trans) rm2sb;

   //In constructor
   //pass the mailboxes as the arguments
   //make the connections 
   function new(mailbox #(ram_trans) wr2rm,
                mailbox #(ram_trans) rd2rm,
                mailbox #(ram_trans) rm2sb);
      this.wr2rm = wr2rm;
      this.rd2rm = rd2rm;
      this.rm2sb = rm2sb;
   endfunction: new
   
   //Understand and include the virtual tasks dual_mem_fun_read and dual_mem_fun_write
   virtual task dual_mem_fun_write(ram_trans wrmon_data);
      begin
         if(wrmon_data.write)
            mem_write(wrmon_data);
      end
   endtask: dual_mem_fun_write

   virtual task dual_mem_fun_read(ram_trans rdmon_data);
      begin
         if(rdmon_data.read)
            mem_read(rdmon_data);
      end
   endtask: dual_mem_fun_read

   virtual task mem_write(ram_trans wrmon_data);
      ref_data[wrmon_data.wr_address]= wrmon_data.data;
   endtask: mem_write


   virtual task mem_read(inout ram_trans rdmon_data);
      if(ref_data.exists(rdmon_data.rd_address))   
         rdmon_data.data_out = ref_data[rdmon_data.rd_address];
   endtask: mem_read
   
   //In virtual task start
   virtual task start();
      //in fork join_none
      fork
         begin
            fork
               begin
                  forever 
                     begin
                        //get the data from wr2rm mailbox to wrmon_data
                        wr2rm.get(wrmon_data);
                        //call dual_mem_fun_write task and pass the data 'wrmon_data' as an arguments
                        dual_mem_fun_write(wrmon_data);
                    end
               end

               begin
                 forever
                     begin
                        //get the data from rd2rm mailbox to rdmon_data
                        rd2rm.get(rdmon_data);
                        //call dual_mem_fun_read task and pass the data 'rdmon_data' as an arguments
                        dual_mem_fun_read(rdmon_data);
                        //put 'rdmon_data' into rm2sb mailbox
                        rm2sb.put(rdmon_data);
                     end
               end
            join
         end
      join_none
   endtask: start

endclass: ram_model
