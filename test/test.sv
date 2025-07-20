/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename       :  test.sv   

Description    :  Test class for dual port ram_testbench

Author Name    :  Putta Satish

Support e-mail :  techsupport_vm@maven-silicon.com 
, 
Version        :  1.0

Date           :  02/06/2020

********************************************************************************************/

//class ram_trans_extnd1

class ram_trans_extnd1 extends ram_trans;

    constraint VALID_DATA {data inside {0};}
    constraint valid_random_wr {write == 1; wr_address inside {[0:1170], 4095};}
    constraint valid_random_rd {rd_address inside {0, 4095};}
      
   //define a constraint valid_random_data with data inside the range which is not covered 
   //define a constraint valid_random_rd  with rd_address inside the range which is not covered

endclass 
   //extend the ram trans if required to cover all the bins
   
//class ram_trans_extnd2
class ram_trans_extnd2 extends ram_trans;

    constraint VALID_DATA {data inside {[200:585], [4294:4294]};}
      
   //define a constraint valid_random_data with data inside the range which is not covered 
   //define a constraint valid_random_rd  with rd_address inside the range which is not covered

endclass

//class ram_trans_extnd3
class ram_trans_extnd3 extends ram_trans;

    constraint VALID_DATA {data inside {4294};}
      
   //define a constraint valid_random_data with data inside the range which is not covered 
   //define a constraint valid_random_rd  with rd_address inside the range which is not covered

endclass

class ram_base_test;

   //Instantiate virtual interface with Write Driver modport,
   //Read Driver modport, Write monitor modport, Read monitor modport
   virtual ram_if.RD_DRV_MP rd_drv_if;
   virtual ram_if.WR_DRV_MP wr_drv_if; 
   virtual ram_if.RD_MON_MP rd_mon_if; 
   virtual ram_if.WR_MON_MP wr_mon_if;
   
   // Declare a handle for ram_env 
   ram_env env_h;
     
   //In constructor
   //pass the Driver interface and monitor interface as arguments
   //create an object for env_h and pass the virtual interfaces 
   //as arguments in new() function
   function new(virtual ram_if.WR_DRV_MP wr_drv_if, 
                virtual ram_if.RD_DRV_MP rd_drv_if,
                virtual ram_if.WR_MON_MP wr_mon_if,
                virtual ram_if.RD_MON_MP rd_mon_if);
      this.wr_drv_if = wr_drv_if;
      this.rd_drv_if = rd_drv_if;
      this.wr_mon_if = wr_mon_if;
      this.rd_mon_if = rd_mon_if;
      
      env_h = new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);
   endfunction: new

   //Understand and include the virtual task build 
   //which builds the TB environment
   virtual task build();
      env_h.build();
   endtask: build
   
   //Understand and include the virtual task run 
   //which runs the simulation for different testcases
   virtual task run();              
      env_h.run();
   endtask: run   
   
endclass: ram_base_test

class ram_test_extnd1 extends ram_base_test;
      
   //Declare a handle for ram_trans_extnd1
   ram_trans_extnd1 data_h1;
   
   //In constructor
   //pass the Driver interface and monitor interface as arguments
   //create an object for env_h and pass the virtual interfaces 
   //as arguments in new() function
   function new(virtual ram_if.WR_DRV_MP wr_drv_if, 
                virtual ram_if.RD_DRV_MP rd_drv_if,
                virtual ram_if.WR_MON_MP wr_mon_if,
                virtual ram_if.RD_MON_MP rd_mon_if);
      super.new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);      
   endfunction: new

   //Understand and include the virtual task build 
   //which builds the TB environment
   virtual task build();
      super.build();
   endtask: build
   
   //Understand and include the virtual task run 
   //which runs the simulation for different testcases
   virtual task run();  
      data_h1 = new();
      env_h.gen_h.gen_trans = data_h1;
      super.run();
   endtask: run      
   
endclass: ram_test_extnd1


class ram_test_extnd2 extends ram_base_test;
      
   //Declare a handle for ram_trans_extnd1
   ram_trans_extnd2 data_h2;
   
   //In constructor
   //pass the Driver interface and monitor interface as arguments
   //create an object for env_h and pass the virtual interfaces 
   //as arguments in new() function
   function new(virtual ram_if.WR_DRV_MP wr_drv_if, 
                virtual ram_if.RD_DRV_MP rd_drv_if,
                virtual ram_if.WR_MON_MP wr_mon_if,
                virtual ram_if.RD_MON_MP rd_mon_if);
      super.new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);      
   endfunction: new

   //Understand and include the virtual task build 
   //which builds the TB environment
   virtual task build();
      super.build();
   endtask: build
   
   //Understand and include the virtual task run 
   //which runs the simulation for different testcases
   virtual task run();  
      data_h2 = new();
      env_h.gen_h.gen_trans = data_h2;
      super.run();
   endtask: run
   
endclass: ram_test_extnd2

class ram_test_extnd3 extends ram_base_test;
      
   //Declare a handle for ram_trans_extnd1
   ram_trans_extnd3 data_h3;
   
   //In constructor
   //pass the Driver interface and monitor interface as arguments
   //create an object for env_h and pass the virtual interfaces 
   //as arguments in new() function
   function new(virtual ram_if.WR_DRV_MP wr_drv_if, 
                virtual ram_if.RD_DRV_MP rd_drv_if,
                virtual ram_if.WR_MON_MP wr_mon_if,
                virtual ram_if.RD_MON_MP rd_mon_if);
      super.new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);      
   endfunction: new

   //Understand and include the virtual task build 
   //which builds the TB environment
   virtual task build();
      super.build();
   endtask: build
   
   //Understand and include the virtual task run 
   //which runs the simulation for different testcases
   virtual task run();  
      data_h3 = new();
      env_h.gen_h.gen_trans = data_h3;
      super.run();
   endtask: run
   
endclass: ram_test_extnd3