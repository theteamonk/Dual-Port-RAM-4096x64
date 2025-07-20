/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename       :  ram_gen.sv   

Description    :  Generator class for Dual Port Ram Testbench

Author Name    :  Putta Satish

Support e-mail :  techsupport_vm@maven-silicon.com 

Version        :  1.0

Date           :  02/06/2020

*********************************************************************************************/
//In class ram_gen

class ram_gen;

   //Declare a handle 'gen_trans' of class type ram_trans which has to be randomized
   ram_trans gen_trans;

   //Declare a handle 'data2send' of class type ram_trans which has to be put into the mailboxes
   ram_trans data2send;

   //Declare two mailboxes parameterized by ram_trans
   mailbox #(ram_trans) gen2rd;
   mailbox #(ram_trans) gen2wr;
 
   //In constructor
   //add mailboxes parameterized by transaction class as an argument and make the assignment 
   //and create the object for the handle to be randomized
   function new(mailbox #(ram_trans) gen2rd,
                mailbox #(ram_trans) gen2wr);
      this.gen_trans = new;
      this.gen2rd    = gen2rd;
      this.gen2wr    = gen2wr;
   endfunction: new

   //In virtual task start
   virtual task start();
      //Inside fork join_none 
      fork
         begin
            //Generate random transactions equal to number_of_transactions(defined in package) 
            for(int i=0; i<number_of_transactions; i++)
               begin       
                  //Randomize the transaction handle using 'if' or 'assert'
                  //If randomization fails, display a message "DATA NOT RANDOMIZED" and stop the simulation
                  assert(gen_trans.randomize()); 
                  //Shallow copy gen_trans to data2send
                  data2send = new gen_trans;
                  //Put the handle into both the mailboxes
                  gen2rd.put(data2send);
                  gen2wr.put(data2send);
               end
         end
      join_none
   endtask: start

endclass: ram_gen
   
      
 


