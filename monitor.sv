
`include "defines.v"
class monitor;

//PROPERTIES
//ADD_CODE: Declare a handle called "mon_trans" for fifo_transaction class
  fifo_transaction mon_trans;
//ADD_CODE: Declare a Virtual interface with monitor modport MON and its instance as "vif"
  virtual fifo_if.MON vif;
//ADD_CODE: Declare a mailbox called "mbx_ms" parameterized with fifo_transaction class 
//          for monitor to scoreboard connection
  mailbox #(fifo_transaction) mbx_ms;


//ADD_CODE: Here copy and paste the covergroup written in previous lab for the inputs 
//          i.e., functional coverage lab.
//          minor change to be done is : access all the inputs through the object mon_trans
  covergroup output_cg;

    EMPTY: coverpoint mon_trans.empty {bins emp [] ={0,1};}
    FULL: coverpoint mon_trans.full {bins full [] ={0,1};}
    DATA_OUT: coverpoint mon_trans.data_out {bins  dout ={[0:255]};}

    
  endgroup


//METHODS
  function new( //ADD_CODE: Declare a Virtual interface with monitor modport MON and its instance as "vif"
                virtual fifo_if.MON vif,
                //ADD_CODE: Declare a mailbox called "mbx_ms" parameterized with fifo_transaction class
                mailbox #(fifo_transaction)mbx_ms);
    //ADD_CODE: Make pointer assignment of vif with this.vif
    this.vif=vif;
    //ADD_CODE: Make pointer assignment of mbx_ms with this.mbx_ms
    this.mbx_ms=mbx_ms;
    //ADD_CODE: Create the object for covergroup "output_cg"
    output_cg=new();
  endfunction

  task start();
   repeat(4) @ (vif.mon_cb); 
    for(int i=0;i<`no_of_trans;i++)
      begin
        //ADD_CODE: Cretae object for mon_trans
        mon_trans=new();
        // Checking for reset
        if(vif.mon_cb.reset==0)
         repeat(1) @ (vif.mon_cb)
          begin
            //Initializing all the values to the reset values
            mon_trans.data_out=vif.mon_cb.data_out;
            mon_trans.empty=vif.mon_cb.empty;
            mon_trans.full=vif.mon_cb.full;
          end
        else//if reset is de-asserted then do the following
         repeat(1) @ (vif.mon_cb)
          begin
            //ADD_CODE: Collect all the FIFO outputs from the virtual interface 
            //          and store them in the transaction object mon_trans
            //          i.e., mon_trans.data_out=vif.mon_cb.data_out;
            //                mon_trans.empty=vif.mon_cb.empty;
            //                mon_trans.full=vif.mon_cb.full;
            mon_trans.data_out=vif.mon_cb.data_out;
            mon_trans.empty=vif.mon_cb.empty;
            mon_trans.full=vif.mon_cb.full;
          end
        //ADD_CODE: Display all the transactions
        $display("MONITOR PASSING THE DATA TO SCOREBOARD data_out=%d,empty=%d,full=%d",
mon_trans.data_out,mon_trans.empty,mon_trans.full,$time);
        //ADD_CODE: put  the transaction from monitor to scoreboard using the mailbox
        //          i.e.,  mbx_ms.put(mon_trans);        
        mbx_ms.put(mon_trans);
        //ADD_CODE: Call the sample method using the covergroup object "output_cg"
        output_cg.sample();
             //ADD_CODE: Display the functional coverage using input_cg.get_coverage()
            $display("FUNCTIONAL COVERAGE = %0d", output_cg.get_coverage());
repeat(1) @(vif.mon_cb);
      end

  endtask
endclass      





