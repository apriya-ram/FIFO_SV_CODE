
//FIFO TEST CLASS for different features written in the verification class
//Write one parent class 
//Then start implementing each feature written in the verification plan
class test;
//ADD_CODE: Declare a Virtual interface with it's instance as "drv_vif"
  virtual fifo_if drv_vif ;
//ADD_CODE: Declare a Virtual interface with it's instance as "mon_vif"
  virtual fifo_if mon_vif;
//ADD_CODE: Declare the handle for environment class as "env"
  environment env;

  function new(//ADD_CODE: Declare a Virtual interface with it's instance as "drv_vif"
               virtual fifo_if drv_vif,
               //ADD_CODE: Declare a Virtual interface with it's instance as "mon_vif"
               virtual fifo_if mon_vif);
    //ADD_CODE: Make pointer assignment of drv_vif with this.drv_vif
    this.drv_vif=drv_vif;
    //ADD_CODE: Make pointer assignment of mon_vif with this.mon_vif
    this.mon_vif=mon_vif;
  endfunction

  task run();
    $display("parent test");
    //ADD_CODE: Create object for "env" and pass "drv_vif" and "mon_vif" as arguments to new()
    env=new(drv_vif,mon_vif);
    //ADD_CODE: call task "build" using object "env" 
    env.build;
    //ADD_CODE: call task "start" using object "env" 
    env.start;
  endtask
endclass

//////////////////////////////////////////////////////////////////////////////////////////////////////////

class test_write extends test;
 //ADD_CODE: Declare handle "trans_write" for fifo_transaction_write class
 fifo_transaction_write trans_write;

  function new(//ADD_CODE: Declare a Virtual interface with it's instance as "drv_vif"
                 virtual fifo_if drv_vif,
               //ADD_CODE: Declare a Virtual interface with it's instance as "mon_vif"
                 virtual fifo_if mon_vif);
    //ADD_CODE: call super.new() and pass "drv_vif" and mon_vif" as arguments to function new()
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    $display("child test");
    //ADD_CODE: Create object for "env" and pass "drv_vif" and "mon_vif" as arguments to new()
    env=new(drv_vif,mon_vif);
    //ADD_CODE: call task "build" using object "env" 
    env.build;
    begin 
    //ADD_CODE: create object for handle trans_write
    trans_write = new();
    //ADD_CODE: Make pointer assignment of "trans_write" to "env.gen.blueprint"
    //          i.e.,    env.gen.blueprint= trans_write;
    env.gen.blueprint= trans_write;
    end
    //ADD_CODE: call task "start" using object "env" 
    env.start;
  endtask
endclass

///////////////////////////////////////////////////////////////////////////////////////////////////////////

class test_read extends test;
 //ADD_CODE: Declare handle "trans_read" for fifo_transaction_read class
 fifo_transaction_read trans_read;

  function new(//ADD_CODE: Declare a Virtual interface with it's instance as "drv_vif"
                 virtual fifo_if drv_vif,
               //ADD_CODE: Declare a Virtual interface with it's instance as "mon_vif"
                 virtual fifo_if mon_vif);
    //ADD_CODE: call super.new() and pass "drv_vif" and mon_vif" as arguments to function new()
    super.new(drv_vif,mon_vif);
  endfunction

  task run();
    $display("child test");
    //ADD_CODE: Create object for "env" and pass "drv_vif" and "mon_vif" as arguments to new()
    env=new(drv_vif,mon_vif);
    //ADD_CODE: call task "build" using object "env" 
    env.build;
    begin 
    //ADD_CODE: create object for handle trans_read
    trans_read = new();
    //ADD_CODE: Make pointer assignment of "trans_read" to "env.gen.blueprint"
    //          i.e.,    env.gen.blueprint= trans_read;
    env.gen.blueprint= trans_read;
    end
    //ADD_CODE: call task "start" using object "env" 
    env.start;
  endtask
endclass

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// TEST CLASS FOR REGRESSION
class test_regression extends test;
 //ADD_CODE: Declare handles for fifo_transaction class, fifo_transaction_write class and fifo_transaction_read class
 //          as trans, trans_write and trans_read respectively
 fifo_transaction  trans;
 fifo_transaction_write trans_write;
 fifo_transaction_read trans_read;

  function new(//ADD_CODE: Declare a Virtual interface with it's instance as "drv_vif"
                 virtual fifo_if drv_vif,
               //ADD_CODE: Declare a Virtual interface with it's instance as "mon_vif"
                 virtual fifo_if mon_vif);
    //ADD_CODE: call super.new() and pass "drv_vif" and mon_vif" as arguments to function new()
    super.new(drv_vif,mon_vif);
  endfunction


  task run();
    $display("child_write test");
    //ADD_CODE: Create object for "env" and pass "drv_vif" and "mon_vif" as arguments to new()
    env=new(drv_vif,mon_vif);
    //ADD_CODE: call task "build" using object "env" 
    env.build;
///////////////////////////////////////////////////////
    begin 
    //ADD_CODE: create object for handle trans
    trans = new();
    //ADD_CODE: Make pointer assignment of "trans" to "env.gen.blueprint"
    //          i.e.,    env.gen.blueprint= trans;
    env.gen.blueprint= trans;
    end
    //ADD_CODE: call task "start" using object "env" 
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    //ADD_CODE: create object for handle trans_write
    trans_write = new();
    //ADD_CODE: Make pointer assignment of "trans_write" to "env.gen.blueprint"
    //          i.e.,    env.gen.blueprint= trans_write;
    env.gen.blueprint= trans_write;
    end
    //ADD_CODE: call task "start" using object "env" 
    env.start;
//////////////////////////////////////////////////////

///////////////////////////////////////////////////////
    begin 
    //ADD_CODE: create object for handle trans_read
    trans_read = new();
    //ADD_CODE: Make pointer assignment of "trans_read" to "env.gen.blueprint"
    //          i.e.,    env.gen.blueprint= trans_read;
    env.gen.blueprint= trans_read;
    end
    //ADD_CODE: call task "start" using object "env" 
    env.start;
//////////////////////////////////////////////////////

  endtask


class test_write_read extends test;
//ADD_CODE: Declare handles for fifo_transaction class, fifo_transaction_write class and fifo_transaction_read class
 //          as trans, trans_write and trans_read respectively

fifo_transaction_write trans_write;
fifo_transaction_read trans_read;

  function new(virtual fifo_if drv_vif,
		virtual fifo_if mon_vif);	//ADD_CODE: Declare a Virtual interface with it's instance as "drv_vif"
                
     super.new(drv_vif, mon_vif);  
  endfunction

///////////////////////////////////////////////////////
  task run();
    $display("child_write read test");
    //ADD_CODE: Create object for "env" and pass "drv_vif" and "mon_vif" as arguments to new()
    env = new(drv_vif, mon_vif);
    env.build(); //ADD_CODE: call task "build" using object "env" 
    begin 
    trans_write = new();	//ADD_CODE: create object for handle trans
  		    //ADD_CODE: Make pointer assignment of "trans" to "env.gen.blueprint"
    env.gen.blueprint= trans_write;
   
    end
    env.start();	//ADD_CODE: call task "start" using object "env" 

//////////////////////////////////////////////////////

    begin 
    trans_read = new();	//ADD_CODE: create object for handle trans_write
  //ADD_CODE: Make pointer assignment of "trans_write" to "env.gen.blueprint"
    env.gen.blueprint= trans_read;
    end
    env.start();	    //ADD_CODE: call task "start" using object "env" 
   

endtask
endclass


endclass



