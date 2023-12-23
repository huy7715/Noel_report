class scoreboard;
    mailbox #(transaction) mon2scb;
    transaction trans;
    event next;

    bit [7:0] din [$];
    bit [7:0] temp;

    function new (mailbox#(transaction)mon2scb);
        this.mon2scb=mon2scb;
    endfunction

    task run();
        forever 
        begin
             mon2scb.get(trans);
             trans.display("SCO");

             if(trans.wr==1'b1)
             begin
                din.push_front(trans.data_in);
                $display("[SCO]: DATA STORED IN QUEUE :%0d",trans.data_in);
             end

             if(trans.rd==1'b1)
             begin
                if(trans.empty==1'b0)
                begin
                    temp=din.pop_back();

                    if(trans.data_out==temp)
                    $display("[SCO]: DATA MATCH");
                    else
                    $error("[SCO]: DATA MISMATCH");
                end
                else//trans.empty==1'b1 --true
                    begin
                    $display("[SCO]: FIFO IS EMPTY");
                    end
             end
             ->next;
        end
    endtask
endclass