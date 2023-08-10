
`include "defines.v"
class scoreboard;
 int j = 0;
//ADD_CODE: Declare a handle called "mon2sb_trans" for fifo_transaction class
  fifo_transaction mon2sb_trans;
//ADD_CODE: Declare a handle called "drv2sb_trans" for fifo_transaction class
  fifo_transaction drv2sb_trans;
//ADD_CODE: Declare a mailbox called "mbx_ds" parameterized with fifo_transaction class 
//          for driver to scoreboard connection
  mailbox #(fifo_transaction) mbx_ds;
//ADD_CODE: Declare a mailbox called "mbx_ms" parameterized with fifo_transaction class 
//          for monitor to scoreboard connection
  mailbox #(fifo_transaction) mbx_ms;

//ADD_CODE: Declare a memory called "drv_mem" with the same depth and width of FIFO
//          i.e.,   logic [`DATA_WIDTH-1:0] drv_mem [0:`no_of_trans]; 

  logic [`DATA_WIDTH-1:0] drv_mem [0:`no_of_trans]; 
//ADD_CODE: Declare a memory called "mon_mem" with the same depth and width of FIFO
//          i.e.,   logic [`DATA_WIDTH-1:0] mon_mem [0:`no_of_trans]; 
  logic [`DATA_WIDTH-1:0] mon_mem [0:`no_of_trans]; 

  function new(//ADD_CODE: Declare a mailbox called "mbx_ds" parameterized with fifo_transaction class
               mailbox #(fifo_transaction) mbx_ds,
               //ADD_CODE: Declare a mailbox called "mbx_ms" parameterized with fifo_transaction class
               mailbox #(fifo_transaction) mbx_ms);
    //ADD_CODE: Make pointer assignment of mbx_ds with this.mbx_ds
    this.mbx_ds=mbx_ds;
    //ADD_CODE: Make pointer assignment of mbx_ms with this.mbx_ms
    this.mbx_ms=mbx_ms;
  endfunction

  task start();

        drv2sb_trans=new();
        mon2sb_trans=new();
   fork
    for(int i=0;i<`no_of_trans;i++)
      begin
        //ADD_CODE: Cretae objects for mon_trans and drv_trans

        //ADD_CODE: get the transaction from driver to scoreboard using the mailbox
        //          i.e.,  mbx_ds.get(drv2sb_trans);
        mbx_ds.get(drv2sb_trans);
        fork
        if(drv2sb_trans.write_enb)
         begin
          //ADD_CODE: collect "drv2sb_trans.data_in" and store it in "drv_mem[j]"
          drv_mem[j]= drv2sb_trans.data_in;
          //ADD_CODE: Display "drv_mem[j]", with time
          $display("############SCOREBOARD REFdata_in=%0d###############",drv_mem[j],$time);
          j++;
         end
        if(drv2sb_trans.read)
         begin
          //ADD_CODE: get the transaction from monitor to scoreboard using the mailbox
          //          i.e.,  mbx_ms.get(mon2sb_trans);
          mbx_ms.get(mon2sb_trans);
          //ADD_CODE: collect "mon2sb_trans.data_out" and store it in "mon_mem[i]"
          mon_mem[i]=mon2sb_trans.data_out;
          //ADD_CODE: Display "mon_mem[i]", with time
          $display("!!!!!!!!!!!!!SCOREBOARD MONdata_out=%0d!!!!!!!!!!!!!!",mon_mem[i],$time);
         end
       join
          $display("PRIYA HERE IS THE DATA data_in=%0d###############",drv_mem[i],$time);
          $display("PRIYA value of i is %d", i,$time);
          $display("PRIYA value of j is %d", j,$time);
      end
   join
  endtask

task comparing();//Task for comparing FIFO data (data integrity check)

  if(drv2sb_trans.read)
    begin
       for(int i=0;i<`no_of_trans;i++)
        begin
         if(drv_mem[i] == mon_mem[i])
          begin
            $display("SCOREBOARD REFdata_in=%0d, MONdata_out=%0d",drv_mem[i],mon_mem[i],$time);
            $display("data received successfully");
          end
        else
          begin
            $display("SCOREBOARD REFdata_in=%0d, MONdata_out=%0d",drv_mem[i],mon_mem[i],$time);
            $display("data received is unsuccessfull");
          end
       end
    end
endtask
endclass

