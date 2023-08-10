///////////////////////////////////////////////
// Module: fifo.v
// Project:
// Description: Synchronous FIFO
//    data output (dout) is un-registered.
///////////////////////////////////////////////


`include "defines.v"
module fifo(input [`DATA_WIDTH-1:0]  data_in,
            input write_enb,
            input read,
            output [`DATA_WIDTH-1:0] data_out,
            output reg full,
            output reg empty,
 
            input clock,
            input reset
           );
 
    function integer log2;
      input integer n;
      begin
       log2 = 0;
       while(2**log2 < n)
        begin
         log2=log2+1;
        end
      end
    endfunction
 
    parameter ADDR_WIDTH = log2(`DEPTH);
    reg   [ADDR_WIDTH : 0]     rd_ptr; // note MSB is not really address
    reg   [ADDR_WIDTH : 0]     wr_ptr; // note MSB is not really address
    wire  [ADDR_WIDTH-1 : 0]  wr_loc;
    wire  [ADDR_WIDTH-1 : 0]  rd_loc;
    reg   [`DATA_WIDTH-1 : 0]  mem[`DEPTH-1 : 0];
 
    assign wr_loc = wr_ptr[ADDR_WIDTH-1 : 0];
    assign rd_loc = rd_ptr[ADDR_WIDTH-1 : 0];
 
    always @(posedge clock)
     begin
      if(~reset)
       begin
        wr_ptr <= 'h0;
        rd_ptr <= 'h0;
       end 
      else
       begin
        if(write_enb & (~full))
         begin
          wr_ptr <= wr_ptr+1;
         end
        if(read & (~empty))
          rd_ptr <= rd_ptr+1;
       end 
     end
 
    //empty if all the bits of rd_ptr and wr_ptr are the same.
    //full if all bits except the MSB are equal and MSB differes
    always @(rd_ptr or wr_ptr)
     begin
     //default catch-alls
     empty <= 1'b0;
     full  <= 1'b0;
     if(rd_ptr[ADDR_WIDTH-1:0]==wr_ptr[ADDR_WIDTH-1:0])
      begin
        if(rd_ptr[ADDR_WIDTH]==wr_ptr[ADDR_WIDTH])
          empty <= 1'b1;
        else
          full  <= 1'b1;
      end
     end
 
    always @(posedge clock)
     begin
      if (write_enb)
       mem[wr_loc] <= data_in;
     end 
 
    //comment if you want a registered data_out
    assign data_out = read ? mem[rd_loc]:'h0;
    //uncomment if you want a registered data_out
    //always @(posedge clock)
    // begin
    //   if (~reset)
    //      data_out <= 'h0;
    //   else if (read)
    //      data_out <= mem[rd_ptr];
    // end
endmodule
