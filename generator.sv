
`include "defines.v"
class generator;

//PROPERTIES
//ADD_CODE: Declare a handle called "blueprint" for fifo_transaction class
  fifo_transaction  blueprint;
//ADD_CODE: Declare a mailbox called "mbx_gd" parameterized with fifo_transaction class 
//          for generator to driver connection
  mailbox #(fifo_transaction)mbx_gd;

//METHODS
  function new(//ADD_CODE: Declare a mailbox called "mbx_gd" parameterized with fifo_transaction class
                mailbox #(fifo_transaction)mbx_gd);
    //ADD_CODE: Make pointer assignment of mbx_gd with this.mbx_gd
    this.mbx_gd=mbx_gd;
    //ADD_CODE: Create the object for handle "blueprint"
    blueprint=new();
  endfunction

  task start();
    for(int i=0;i<`no_of_trans;i++)
      begin
        //ADD_CODE: call blueprint.randomize
        blueprint.randomize();    //randomizing the input value
        //ADD_CODE: call mbx.put(blueprint.copy())
        mbx_gd.put(blueprint.copy());   //putting the randomized value to mailbox
        //ADD_CODE: Display all the transactions
        $display("GENERATOR data_in=%d,write_enb=%d,read=%d",blueprint.data_in,blueprint.write_enb,blueprint.read,$time);
      end
  endtask
endclass
