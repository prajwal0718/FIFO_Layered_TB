// Code your design here
module fifo(
input clock, rd, wr,
output full, empty,
input [7:0] data_in,
output reg [7:0] data_out,
input rst);
//global control signal clock and reset are present 
//data control signals  rd and wr
// coditional flags full emppty to represent status of FIFO
 
  reg [7:0] mem [31:0];  // depth is 32 
reg [4:0] wr_ptr;
  reg [4:0] rd_ptr;  //to keep track of read and write operation!!
  
always@(posedge clock)
begin
  if(rst == 1'b1) 
    begin         // if rst then data_out =0 and pointers are 0
   data_out <= 0;
   rd_ptr<= 0;
   wr_ptr<= 0;
      for(int i=0;i<32; i++) begin 
        mem[i] <=0; //Makiing memory elements  = 0 in reset condition
      end
end
  else
    begin
      if((wr == 1'b1) && (full == 1'b0))  //if write enable is 1 and also FIFO is not full then 
   begin
     mem[wr_ptr]<= data_in;  //Write data into fifo if above condition satisfied
    wr_ptr =  wr_ptr + 1;  //Then increment write pointer
   end
     
     
      if((rd ==  1'b1) && (empty == 1'b0))// if read en 1 and fifo is not empty then 
        data_out <= mem[rd_ptr];  //read data from the read pointer pointing the memory location
    begin
   rd_ptr<=rd_ptr + 1;  //Then increment the read pointer
    end
  end
end
  
  
  assign empty = ((wr_ptr - rd_ptr) == 0) ? 1'b1 : 1'b0;  //when both are on same point whatever user has written inside fifo the user has already read it back this is empty condition of FIFO
  
  assign full = ((wr_ptr - rd_ptr) == 31) ? 1'b1 : 1'b0; //user has filled all available position in fifo 
  
endmodule
