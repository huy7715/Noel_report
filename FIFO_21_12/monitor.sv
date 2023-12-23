class monitor;
    virtual fifo_inf vf_inf;
    mailbox #(transaction) mon2scb;
    transaction trans;
    event next;
    function new (mailbox #(transaction)mon2scb);
        this.mon2scb=mon2scb;
    endfunction

    task run();
        trans=new();
        forever begin
            repeat(2) @(posedge vf_inf.clock);
            trans.wr=vf_inf.wr;
            trans.rd=vf_inf.rd;
            trans.data_in=vf_inf.data_in;
            trans.data_out=vf_inf.data_out;
            trans.full=vf_inf.full;
            trans.empty=vf_inf.empty;
            mon2scb.put(trans);
            trans.display("MON");
            @(next);
        end
    endtask
endclass