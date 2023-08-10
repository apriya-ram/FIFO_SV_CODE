
`include "defines.v"
class environment;

//PROPERTIES
//ADD_CODE: Declare a Virtual interface with it's instance as "drv_vif"
  virtual fifo_if drv_vif ;
//ADD_CODE: Declare a Virtual interface with it's instance as "mon_vif"
  virtual fifo_if mon_vif;
//ADD_CODE: Declare a mailbox called "mbx_gd" parameterized with fifo_transaction class 
  mailbox #(fifo_transaction) mbx_gd;
//ADD_CODE: Declare a mailbox called "mbx_ds" parameterized with fifo_transaction class 
  mailbox #(fifo_transaction) mbx_ds;
//ADD_CODE: Declare a mailbox called "mbx_ms" parameterized with fifo_transaction class
  mailbox #(fifo_transaction) mbx_ms;

//ADD_CODE: Declare handles for generator, driver, monitor and scoreboard as gen, drv, mon and scb respectively
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;

//METHODS
  function new (//ADD_CODE: Declare a Virtual interface with it's instance as "drv_vif"
                 virtual fifo_if drv_vif,
                //ADD_CODE: Declare a Virtual interface with it's instance as "mon_vif"
                 virtual fifo_if mon_vif);
    //ADD_CODE: Make pointer assignment of drv_vif with this.drv_vif
    this.drv_vif=drv_vif;
    //ADD_CODE: Make pointer assignment of mon_vif with this.mon_vif
    this.mon_vif=mon_vif;
  endfunction


  task build();
    begin
    //ADD_CODE: Create objects for mailboxes mbx_gd, mbx_ds and mbx_ms
    mbx_gd=new();
    mbx_ds=new();
    mbx_ms=new();

    //ADD_CODE: Cretate object for handle "gen" and pass "mbx_gd" as the argument to new() 
    gen=new(mbx_gd);
    //ADD_CODE: Cretate object for handle "drv" and pass "mbx_gd", "mbx_ds" and "drv_vif" as the arguments to new() 
    drv=new(mbx_gd,mbx_ds,drv_vif);
    //ADD_CODE: Cretate object for handle "mon" and pass "mon_vif" and "mbx_ms" as the arguments to new() 
    mon=new(mon_vif,mbx_ms);
    //ADD_CODE: Cretate object for handle "scb" and pass "mbx_ds" and "mbx_ms"  as the arguments to new() 
    scb=new(mbx_ds,mbx_ms);
   end
  endtask

  task start();
    fork
    //ADD_CODE: call the start methods of all the components i.e., generator, driver, monitor, scoreboard
    //          using there respective objects
    gen.start;
    drv.start;
    mon.start;
    scb.start;
    join
    //ADD_CODE: call the task "comparing" using the scoreboard object 
    scb.comparing;
  endtask
endclass

