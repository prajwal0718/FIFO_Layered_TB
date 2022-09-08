class transaction;
  rand bit rd,wr;
  rand bit[7:0] data_in;
  bit full , empty;
  rand bit[7:0] data-out;
  
  //No need to randomize the global signals (clk or rst)
  
  //constraint because we added random generator
  constraint wr_rd{
    rd != wr;  // whenever rd high rd must not be high or viceversa
    wr dist {0:/50 , 1:/50};  //both rd and wr for equal haf times
    rd dist {0:/50 , 1:/50};  // equally divide operator prob = 1/2 for both wr , rd
  }
  
  constraint data_con {
    data_in>1; data_in<5;  // 2 3 4 are values generated 
  }
  
  // Print values of a variable
  function void display(input string tag);  //void as this function do not return anything 
    $display("[%0s] : WR : %0b\t RD : %0b\t DATAWR  :%0d\t DATARD : %Od\t FULL : %0b\t EMPTY : %0b @ 0b\t" , tag , wr, rd, data_in , data_out , full , empty , $time);   
  endfunction 
    
   //We get to know which specific class is printing the value!!
    
  
  //A method to perform a deep copy is been added here
  function transaction copy();
    copy = new();
    copy.rd = this.rd; //whatever is rd gets updated to copy.rd
    copy.wr = this.wr;
    copy.data_in = this.data_in;
    copy.data_out = this.data_out;
    copy.full = this.full;
    copy.empty = this.empty;
  endfunction
    
    //copy of the transaction class will be sent to the driver!!
endclass


//Just to check if transaction class is correct not required actually

module tb;
  transaction tr;
  initial begin
  tr = new();
  tr.display("TOP");
  end
endmodule
  
    
