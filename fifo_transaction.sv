
  
//FIFO TRANSACTION CLASS for different features written in the verification class
//Write one parent class with one general constraint for the inputs
//Then start implementing each feature written in the verification plan

class fifo_transaction;// for random transactions

//PROPERTIES
//ADD_CODE: Declare the inputs as rand variables and outputs as non-rand variables with there widths
//          i.e., data_in, data_out, full, empty, write_enb and read
  rand bit[7:0] data_in;
  rand bit write_enb,read;
       bit full,empty;
       bit[7:0]data_out;

//ADD_CODE: write the general constraint for write_enb and read. Let the constraint name be "c"
//          i.e., constraint c {{write_enb,read} inside {[0:3]};}
constraint c {{write_enb,read} inside {[0:3]};}

//METHODS
//Copying objects
 virtual function fifo_transaction copy();
//ADD_CODE: Create object for copy
  copy = new();
//ADD_CODE: Make pointer assignments of all the inputs to local object copy
//          i.e.,  copy.data_in = this.data_in;
//                 copy.write_enb = this.write_enb;
//                 copy.read= this.read;
  copy.data_in = this.data_in;
  copy.write_enb = this.write_enb;
  copy.read= this.read;
//ADD_CODE: Now return the object copy
//          i.e., return copy;
  return copy;
  endfunction
  
endclass 

///////////////////////////////////////////////////////////////////////////////////////////////

class fifo_transaction_write extends fifo_transaction;//for write transaction
  
//ADD_CODE: Now override the existing constraint "c" for write transaction. 
//          i.e., constraint c {{write_enb,read}==2'b10;}
constraint c {{write_enb,read}==2'b10;}

//METHODS
//Copying objects
 virtual function fifo_transaction copy();
//ADD_CODE: Declare a handle copy1 for fifo_transaction_write class
  fifo_transaction_write copy1;
//ADD_CODE: Create object for copy1
  copy1 = new();
//ADD_CODE: Make pointer assignments of all the inputs to local object copy1
//          i.e.,  copy1.data_in = this.data_in;
//                 copy1.write_enb = this.write_enb;
//                 copy1.read= this.read;
  copy1.data_in = this.data_in;
  copy1.write_enb = this.write_enb;
  copy1.read= this.read;
//ADD_CODE: Now return the object copy1
//          i.e., return copy1;
  return copy1;
  endfunction
endclass

//////////////////////////////////////////////////////////////////////////////////////////////////////


class fifo_transaction_read extends fifo_transaction;//for read transaction
  
//ADD_CODE: Now override the existing constraint "c" for read transaction. 
//          i.e., constraint c {{write_enb,read}==2'b01;}
constraint c {{write_enb,read}==2'b01;}

//METHODS
//Copying objects
 virtual function fifo_transaction copy();
//ADD_CODE: Declare a handle copy2 for fifo_transaction_read class
  fifo_transaction_read copy2;
//ADD_CODE: Create object for copy2
  copy2 = new();
//ADD_CODE: Make pointer assignments of all the inputs to local object copy2
//          i.e.,  copy2.data_in = this.data_in;
//                 copy2.write_enb = this.write_enb;
//                 copy2.read= this.read;
  copy2.data_in = this.data_in;
  copy2.write_enb = this.write_enb;
  copy2.read= this.read;
//ADD_CODE: Now return the object copy2
//          i.e., return copy2;
  return copy2;
 endfunction
endclass




