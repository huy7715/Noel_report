class transaction;
  rand bit rd, wr;
  rand bit [7:0] data_in;
  bit full, empty;
  bit [7:0] data_out;
  constraint wr_rd {
    rd != wr;  //read not equal to write
    wr dist {
      0 :/ 50,
      1 :/ 50
    };  //set distribution
    rd dist {
      0 :/ 50,
      1 :/ 50
    };
  }

  constraint data_con {
    data_in > 1;
    data_in < 5;
  }

  function void display(input string tag);
    $display(
        "[%0s]: WR : %0b\t RD:%0b\t DATAWR : %0d\t DATARD: %0d\t FULL : %0b\t EMPTY : %0d @ %0t",
        tag, wr, rd, data_in, data_out, full, empty, $time);
  endfunction

  function transaction copy();
    copy=new();
    copy.rd=this.rd;
    copy.wr=this.wr;
    copy.data_in=this.data_in;
    copy.data_out=this.data_out;
    copy.full=this.full;
    copy.empty=this.empty;
    return copy;
  endfunction
endclass
