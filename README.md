# FIFO_SV_CODE
Design Specification
This FIFO Design is a simple First-In-First-Out data organization buffer or memory.
This FIFO consists of a read pointer and a write pointer, pointing to entries in a storage
array typically, made of flip-flops. This component contains the verilog code for the basic
2n deep FIFO implementation.
The implementation includes flow control indications for FIFO full, FIFO empty. A
flop-based FIFO can be integrated into a pipeline structure as it serves as a single
sampling stage when empty, and can generate pipe stall for upstream logic when full.
The data is written into the FIFO using the data_in port when write_enb is high and
the data is sent out from the FIFO using the data_out port when the read is high.
Independent write and read is possible and also concurrent write and read is possible.
Features
Single clock synchronous functionality
Synchronous reset of FIFO pointers
Flip-flop based memory array
Parameter controlled depth
Parameter controlled width
Empty and full indications
Prevents load when FIFO is full
Prevents extract when FIFO is empty
Parametrized Depth which are powers of 2 like 2, 4, 8, 16, 32, ... , 128,...

clock 1 Input It is the clock signal to Synchrounous FIFO
reset 1 Input It is the reset signal which is active low
write_en
b

1 Input When this signal is high it enables data writing

into the FIFO

read 1 Input When this signal is high it enables data

reading from the FIFO

data_in [`DATA_WIDTH-1:0
]

Input Width of the FIFO data written into FIFO

data_out [`DATA_WIDTH-1:0
]

output Width of the FIFO data read from FIFO
empty 1 output Indicates that the FIFO is empty
full 1 output Indicates that the FIFO is full
