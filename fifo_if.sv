

  
//FIFO interface
interface fifo_if(//ADD_CODE: Declare the clock and reset as input to the interface
                   input bit clk,reset);

//ADD_CODE: Declare the FIFO pins as logic with there widths
//          i.e., data_in, data_out, full, empty, write_enb and read 
  logic[7:0] data_in,data_out;
  logic full,empty,write_enb,read;


//clocking block for driver
  clocking drv_cb@(posedge clk);
//Specifying the values for input and output skews 
    default input #0 output #0;
//ADD_CODE: Declare the write_enb, read and data_in pins as output without widths
    output write_enb,read,data_in;
//ADD_CODE: Declare the reset as input
    input reset;
  endclocking

//clocking block for monitor
   clocking mon_cb@(negedge clk);
//Specifying the values for input and output skews 
     default input #0 output #0;
//ADD_CODE: Declare the read, full, empty and data_out pins as input without widths
     input data_out,full,empty,read,reset;
   endclocking

//Modports for driver and monitor
  modport DRV(//ADD_CODE: Declare the instance of driver clocking block as "clocking drv_cb"
              clocking drv_cb);
  modport MON(//ADD_CODE: Declare the instance of monitor clocking block as "clocking mon_cb"
              clocking mon_cb);

endinterface
