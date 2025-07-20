/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename       :  ram_4096.v   

Description    :  synchronous dual port Random Access Memory

Author Name    :  Putta Satish   

Support e-mail :  techsupport_vm@maven-silicon.com 

Version        :  1.0

Date           :  02/06/2020

*********************************************************************************************/

`define RAM_WIDTH 64
`define ADDR_SIZE 12

module ram_4096 ( clk,
                  data_in,
                  rd_address,
                  wr_address,
                  read,
                  write,
                  data_out);

   input clk;                              // RAM Clock
   input [`RAM_WIDTH-1 : 0] data_in;       // Data Input
   input [`ADDR_SIZE-1 : 0] rd_address;    // Read Address
   input [`ADDR_SIZE-1 : 0] wr_address;    // Write Address
   input read;                             // Read Control
   input write;                            // Write Control

   output tri [`RAM_WIDTH-1 : 0] data_out; // Data Output

  
   wire mem_wr0,
        mem_wr1,
        mem_wr2,
        mem_wr3;

   wire mem_rd0,
        mem_rd1,
        mem_rd2,
        mem_rd3;


   mem_dec wr_add_dec (.mem_in1   (wr_address[`ADDR_SIZE-1]),
                       .mem_in0   (wr_address[`ADDR_SIZE-2]),
                       .mem_out3  (mem_wr3),
                       .mem_out2  (mem_wr2),
                       .mem_out1  (mem_wr1),
                       .mem_out0  (mem_wr0)
                      );

   mem_dec rd_add_dec (.mem_in1   (rd_address[`ADDR_SIZE-1]),
                       .mem_in0   (rd_address[`ADDR_SIZE-2]),
                       .mem_out3  (mem_rd3),
                       .mem_out2  (mem_rd2),
                       .mem_out1  (mem_rd1),
                       .mem_out0  (mem_rd0)
                      );

   dual_mem DM_0 (.clk         (clk),
                  .mem_en      (mem_wr0),
                  .op_en       (mem_rd0),
                  .data_in     (data_in),
                  .rd_address  (rd_address[`ADDR_SIZE-3:0]),
                  .wr_address  (wr_address[`ADDR_SIZE-3:0]),
                  .read        (read),
                  .write       (write),                
                  .data_out    (data_out)
                 ); 

   dual_mem DM_1 (.clk         (clk),
                  .mem_en      (mem_wr1),
                  .op_en       (mem_rd1),
                  .data_in     (data_in),
                  .rd_address  (rd_address[`ADDR_SIZE-3:0]),
                  .wr_address  (wr_address[`ADDR_SIZE-3:0]),
                  .read        (read),
                  .write       (write),   
                  .data_out    (data_out)
                 );


   dual_mem DM_2 (.clk         (clk),
                  .mem_en      (mem_wr2),
                  .op_en       (mem_rd2),
                  .data_in     (data_in),
                  .rd_address  (rd_address[`ADDR_SIZE-3:0]),
                  .wr_address  (wr_address[`ADDR_SIZE-3:0]),
                  .read        (read),
                  .write       (write),   
                  .data_out    (data_out)
                 );

   dual_mem DM_3 (.clk         (clk),
                  .mem_en      (mem_wr3),
                  .op_en       (mem_rd3),
                  .data_in     (data_in),
                  .rd_address  (rd_address[`ADDR_SIZE-3:0]),
                  .wr_address  (wr_address[`ADDR_SIZE-3:0]),
                  .read        (read),
                  .write       (write),   
                  .data_out    (data_out)
                 );

endmodule
 
                    


