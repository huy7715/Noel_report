class driver;
    virtual fifo_inf vf_inf;
    mailbox #(transaction) gen2drv;
    transaction datac;//data container
    event next;

    function new (mailbox #(transaction)gen2drv);
        this.gen2drv=gen2drv;
    endfunction

    task reset();
        vf_inf.rst<=1'b1;
        vf_inf.rd<=1'b0;
        vf_inf.wr<=1'b0;
        vf_inf.data_in<=0;
        repeat(5) @(posedge vf_inf.clock);
        vf_inf.rst <=1'b0;  
    endtask

    task run();
        forever begin
            gen2drv.get(datac);
            datac.display("DRV");
            vf_inf.rd<=datac.rd;
            vf_inf.wr<=datac.wr;
            vf_inf.data_in<=datac.data_in;
            repeat(2) @(posedge vf_inf.clock);
            ->next;
        end
    endtask
endclass