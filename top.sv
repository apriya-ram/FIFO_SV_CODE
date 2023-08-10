
module top( );
//ADD_CODE: import the fifo_pkg ie.,   import fifo_pkg ::*;
  import fifo_pkg ::*;
//ADD_CODE: Declare signals clk and reset as one bit
  bit clk,reset;
//ADD_CODE: Generate clock signal of 20ns
  initial
    begin
      clk=0;
      
      forever #10 clk=~clk;
    end
//ADD_CODE: Generate reset i.e., Assert it at posedge of clock and de-assert it at the next posedge of clk
  initial
    begin
      @(posedge clk);
      reset=0;
      repeat(1)@(posedge clk);
      reset=1;
    end

//ADD_CODE: Instantiate the fifo interface "fifo_if" with instance as "intrf" and pass clk and reset as arguments
  fifo_if intrf(clk,reset);
//ADD_CODE: Instantiate the fifo RTL "fifo" with instance as "DUT"; Do the port mapping by name 
  fifo DUT(.data_in(intrf.data_in),
           .write_enb(intrf.write_enb),
           .read(intrf.read),
           .data_out(intrf.data_out),
           .full(intrf.full),
           .empty(intrf.empty),
           .clock(clk),
           .reset(reset));
//ADD_CODE: Declare and create objects for all the test classes written in the test file.
//          Don't forget to pass the static interface instances intrf.DRV and intrf.MON as arguments to function new()s
//          i.e.,   test            tb= new(intrf.DRV,intrf.MON);
//                  test_write      tb_write= new(intrf.DRV,intrf.MON);
//                  test_read       tb_read= new(intrf.DRV,intrf.MON);
//                  test_regression tb_regression= new(intrf.DRV,intrf.MON);
             test            tb= new(intrf.DRV,intrf.MON);
             test_write      tb_write= new(intrf.DRV,intrf.MON);
             test_read       tb_read= new(intrf.DRV,intrf.MON);
             test_regression tb_regression= new(intrf.DRV,intrf.MON);

 initial
   begin
    //ADD_CODE: Now run a test of your choice !!!!! 
    //          How ???
    //          Using the test class object of your choice call the "run" task
    //          This will start the simulation
    //tb_write.run();
    //tb_read.run();
    tb_regression.run();
    //ADD_CODE: Call $finish() system task now to end the simulation
    $finish();
   end
endmodule


