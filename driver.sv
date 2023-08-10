
`include "defines.v"
class driver;

//PROPERTIES  
//ADD_CODE: Declare a handle called "drv_trans" for fifo_transaction class
  fifo_transaction drv_trans;
//ADD_CODE: Declare a mailbox called "mbx_gd" parameterized with fifo_transaction class 
//          for generator to driver connection
  mailbox #(fifo_transaction)mbx_gd;
//ADD_CODE: Declare a mailbox called "mbx_ds" parameterized with fifo_transaction class 
//          for driver to scoreboard connection
  mailbox #(fifo_transaction)mbx_ds;
//ADD_CODE: Declare a Virtual interface with driver modport DRV and its instance as "vif"
  virtual fifo_if.DRV vif;

//ADD_CODE: Here copy and paste the covergroup written in previous lab for the inputs 
//          i.e., functional coverage lab.
//          minor change to be done is : access all the inputs through the object drv_trans
covergroup input_cg;
  WRITE:   coverpoint drv_trans.write_enb { bins wrt[]={0,1}; }
  READ :   coverpoint drv_trans.read      { bins  rd[]={0,1}; }
  DATA_IN: coverpoint drv_trans.data_in   { bins data ={[0:255]}; } 

  WRXRD:   cross WRITE,READ;
endgroup
 
//METHODS

  function new(//ADD_CODE: Declare a mailbox called "mbx_gd" parameterized with fifo_transaction class
                mailbox #(fifo_transaction)mbx_gd,
               //ADD_CODE: Declare a mailbox called "mbx_ds" parameterized with fifo_transaction class
                mailbox #(fifo_transaction)mbx_ds,
               //ADD_CODE: Declare a Virtual interface with driver modport DRV and its instance as "vif"
                virtual fifo_if.DRV vif);
    //ADD_CODE: Make pointer assignment of mbx_gd with this.mbx_gd
    this.mbx_gd=mbx_gd;
    //ADD_CODE: Make pointer assignment of mbx_ds with this.mbx_ds
    this.mbx_ds=mbx_ds;
    //ADD_CODE: Make pointer assignment of vif with this.vif
    this.vif=vif;
    //ADD_CODE: Create the object for covergroup "input_cg"
    input_cg=new();
  endfunction

  task start();
    repeat(3) @ (vif.drv_cb);
    for(int i=0;i<`no_of_trans;i++)
      begin
        //ADD_CODE: Cretae object for drv_trans
        drv_trans=new();
        //ADD_CODE: get the transaction from generator to the driver using the mailbox
        //          i.e.,  mbx_gd.get(drv_trans);
        mbx_gd.get(drv_trans);
        // Checking for reset
        if(vif.drv_cb.reset==0)
         repeat(1) @ (vif.drv_cb)
          begin
            //Initializing all the values to the reset values
            drv_trans.write_enb=0;
            drv_trans.read=0;
            drv_trans.data_in=8'bz;
            vif.drv_cb.write_enb<=drv_trans.write_enb;
            vif.drv_cb.read<=drv_trans.read;
            vif.drv_cb.data_in<=drv_trans.data_in;   
            //ADD_CODE: put  the transaction from driver to scoreboard using the mailbox
            //          i.e.,  mbx_ds.put(drv_trans); 
            mbx_ds.put(drv_trans);
            repeat(1) @ (vif.drv_cb);   
            //ADD_CODE: Display the transaction values       
            $display("DRIVER DRIVING DATA TO INTERFACE data_in=%d,write_enb=%d,read=%d",vif.drv_cb.data_in,vif.drv_cb.write_enb,vif.drv_cb.read,$time);
          end
        else//if reset is de-asserted then do the following
         repeat(1) @ (vif.drv_cb)
          begin
            //ADD_CODE: Within fork join block:
            //          check for write operation and pass the "write_enb" and "data_in" transactions onto the interface
            //          check for read operation and pass the "read" transaction onto the interface
            fork
            if(drv_trans.write_enb) 
            begin
            vif.drv_cb.write_enb<=drv_trans.write_enb;
            vif.drv_cb.data_in<=drv_trans.data_in;  
            end
            else if ((drv_trans.write_enb) == 0)
            begin
            vif.drv_cb.write_enb<=drv_trans.write_enb;
            vif.drv_cb.data_in<=8'bz;  
            end
	    if(drv_trans.read)
            vif.drv_cb.read<=drv_trans.read;
            join

            //ADD_CODE: put  the transaction from driver to scoreboard using the mailbox
            //          i.e.,  mbx_ds.put(drv_trans);
            mbx_ds.put(drv_trans);
            //ADD_CODE: Call the sample method using the covergroup object "input_cg"
            input_cg.sample();
            //ADD_CODE: Display the functional coverage using input_cg.get_coverage()
            $display("FUNCTIONAL COVERAGE = %0d", input_cg.get_coverage());
            repeat(1) @ (vif.drv_cb);  
            //ADD_CODE: Display all the transactions  
            $display("DRIVER DRIVING DATA TO INTERFACE data_in=%d,write_enb=%d,read=%d",vif.drv_cb.data_in,vif.drv_cb.write_enb,vif.drv_cb.read,$time);
          end
            
     end
  endtask
endclass

