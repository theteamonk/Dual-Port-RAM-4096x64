/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename       :  ram_trans.sv   

Description    :  Transaction class for Dual Port Ram Testbench

Author Name    :  Putta Satish

Support e-mail :  techsupport_vm@maven-silicon.com 

Version        :  1.0

Date           :  02/06/2020

*********************************************************************************************/
// In class ram_trans

class ram_trans;
   // Declare the following rand fields
   // data (bit/logic type , size 64)
   // rd_address, wr_address (bit/logic type , size 12)
   // read, write (bit/logic type , size 1)
   
   rand bit[63:0] data;
   rand bit[11:0] rd_address;
   rand bit[11:0] wr_address;
   rand bit       read;
   rand bit       write;
   
   // Declare a variable data_out (logic type , size 64)
   logic [63:0] data_out;
 
   // Declare a static variable trans_id (int type), to keep the count of transactions generated
   static int trans_id;

   static int no_of_read_trans;
   static int no_of_write_trans;
   static int no_of_RW_trans;

   // Add the following constraints 

   // wr_address != rd_address;
   // read,write != 2'b00;
   // data between 1 and 4294   
   constraint VALID_ADDR {wr_address != rd_address;}
   constraint VALID_CTRL {{read,write} != 2'b00;}
   constraint VALID_DATA {data inside {[1:4294]};}

   // In post_randomize method 
      // Increment trans_id
      // If it is only read transaction,  increment no_of_read_trans
      // If it is only write transaction, increment no_of_write_trans
      // If it is read-write transaction, increment no_of_RW_trans
      // call the display method and pass a string
   function void post_randomize();
      trans_id++;
      if(this.read==1 && this.write==0)
         no_of_read_trans++;
      if(this.write==1 && this.read==0)
         no_of_write_trans++;
      if(this.read==1 && this.write==1)
         no_of_RW_trans++;
      this.display("\tRANDOMIZED DATA");
   endfunction: post_randomize

   //In virtual function display
      // display the string
      // display all the properties of the transaction class
   virtual function void display(input string message);
      $display("=============================================================");
      $display("%s",message);
      if(message=="\tRANDOMIZED DATA")
         begin
            $display("\t_______________________________");
            $display("\tTransaction No. %d",trans_id);
            $display("\tRead Transaction No. %d", no_of_read_trans);
            $display("\tWrite Transaction No. %d", no_of_write_trans);
            $display("\tRead-Write Transaction No. %d", no_of_RW_trans);
            $display("\t_______________________________");
         end
      $display("\tRead=%d, write=%d",read,write);
      $display("\tRead_Address=%d, Write_Address=%d",rd_address, wr_address);
      $display("\tData=%d",data);
      $display("\tData_out= %d",data_out);
      $display("=============================================================");
   endfunction: display


   //Understand and include the virtual function compare
   virtual function bit compare (input ram_trans rcvd,output string message);
      compare='0;
      begin
         if(this.rd_address != rcvd.rd_address)
            begin
               $display($time);
               message ="--------- ADDRESS MISMATCH ---------";
               return(0);
            end
        
         if(this.data_out != rcvd.data_out)
            begin
               $display($time);
               message="--------- DATA MISMATCH ---------";
               return(0);
            end
     
            begin
               message=" SUCCESSFULLY COMPARED";
               return(1);
            end
      end
   endfunction: compare

endclass: ram_trans
