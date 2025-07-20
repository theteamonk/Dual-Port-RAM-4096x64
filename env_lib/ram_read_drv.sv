/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename       :  ram_read_drv.sv   

Description    :  Driver class for dual port ram_testbench

Author Name    :  Putta Satish

Support e-mail :  techsupport_vm@maven-silicon.com 

Version        :  1.0

Date           :  02/06/2020

*********************************************************************************************/
// In class ram_read_drv

class ram_read_drv;
   // Instantiate virtual interface instance rd_drv_if of type ram_if with RD_DRV_MP modport
   virtual ram_if.RD_DRV_MP rd_drv_if;

   // Declare a handle for ram_trans as 'data2duv'
   ram_trans data2duv;

   // Declare a mailbox 'gen2rd' parameterized by ram_trans    
   mailbox #(ram_trans) gen2rd;  

   // In constructor 
   // pass the following as the input arguments 
   // virtual interface
   // mailbox handle 'gen2rd' parameterized by ram_trans    
   // make connections
   // For example this.gen2rd = gen2rd
   function new(virtual ram_if.RD_DRV_MP rd_drv_if,
                mailbox #(ram_trans) gen2rd);
      this.rd_drv_if = rd_drv_if;
      this.gen2rd    = gen2rd;
   endfunction: new

   virtual task drive();
      @(rd_drv_if.rd_drv_cb);
      rd_drv_if.rd_drv_cb.rd_address <= data2duv.rd_address;
      rd_drv_if.rd_drv_cb.read       <= data2duv.read;    
        
      // Wait for two clock cycles after applying all the inputs
      // if read is high, atleast one clock cycle will be required to read the data
      repeat(2) 
         @(rd_drv_if.rd_drv_cb);

      // Disable the read signal
      rd_drv_if.rd_drv_cb.read<='0;
   
   endtask: drive
   
   // In virtual task start      
   virtual task start();
      // Within fork join_none 
      fork
         forever
            begin
               // Within forever , inside begin end         
               // get the data from mailbox 'gen2rd'
               // call drive task
               gen2rd.get(data2duv);
               drive();
            end
      join_none
   endtask: start

endclass: ram_read_drv
