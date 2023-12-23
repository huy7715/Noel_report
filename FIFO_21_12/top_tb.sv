module top_tb;
    fifo_inf f_inf();
    test t1(f_inf);
    fifo dut (f_inf.clock,f_inf.rd,f_inf.wr,f_inf.full,f_inf.empty,f_inf.data_in,f_inf.data_out,f_inf.reset);
    initial begin
        f_inf.clock<=0;
    end
    
    always #10 f_inf,clock<=f_inf.~clock;
    
endmodule