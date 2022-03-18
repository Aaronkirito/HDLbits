module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    reg [3:0] hh1, hh2;//store the hours
    reg [3:0] mm1, mm2;//store the minutes
    reg [3:0] ss1, ss2;//store the seconds
    reg [3:0] aft;
    
    //pm
    always@(posedge clk) begin
        if(reset)
            pm <= 1'b0;
        else if(hh1 == 4'd1 && hh2 == 4'd1 && mm1 == 4'd5 && mm2 == 4'd9 && ss1 == 4'd5 && ss2 == 4'd9)
            pm <= ~pm;
    end
    
    //seconds
    always@ (posedge clk) begin
        if(reset)
            ss2 <= 4'd0;
        else if(ena) begin
            if(ss2 == 4'd9)
                ss2 <= 4'd0;
            else
                ss2 <= ss2 + 1'b1;
        end
    end
    
    assign aft[0] = (ss2 == 4'd9) ? 1'b1 : 1'b0;
    
    always@ (posedge clk) begin
        if(reset)
            ss1 <= 4'd0;
        else if(ena & aft[0]) begin
            if(ss1 == 4'd5)
                ss1 <= 4'd0;
            else
                ss1 <= ss1 + 1'b1;
        end
        else ss1 <= ss1;
    end
    
    assign aft[1] = (ss2 == 4'd9 && ss1 == 4'd5) ? 1'b1 : 1'b0;
    
    always@ (posedge clk) begin
        if(reset)
            mm2 <= 4'd0;
        else if(ena & aft[1]) begin
            if(mm2 == 4'd9)
                mm2 <= 4'd0;
            else
                mm2 <= mm2 + 1'b1;
        end
        else
            mm2 <= mm2;
    end
    
    assign aft[2] = (ss2 == 4'd9 && ss1 == 4'd5 && mm2 == 4'd9) ? 1'b1 : 1'b0;
    
    always@ (posedge clk) begin
        if(reset)
            mm1 <= 4'd0;
        else if(ena & aft[2]) begin
            if(mm1 == 4'd5)
                mm1 <= 4'd0;
            else
                mm1 <= mm1 + 1'b1;
        end
        else
            mm1 <= mm1;
    end    
    
    assign aft[3] = (ss2 == 4'd9 && ss1 == 4'd5 && mm2 == 4'd9 && mm1 == 4'd5) ? 1'b1 : 1'b0;
    
    always@(posedge clk) begin
        if(reset)
            hh2 <= 4'd2;
        else if(ena & aft[3]) begin
            if((hh2 == 4'd9)&&(hh1 == 4'd0))
                hh2 <= 4'd0;
            else if(hh2 == 4'd2 && hh1 == 4'd1)
                hh2 <= 4'd1;
            else
                hh2 <= hh2 + 1'b1;
        end
        else
            hh2 <= hh2;

    end
    
    always@(posedge clk) begin
        if(reset)
            hh1 <= 4'd1;
        else if(ena & aft[3]) begin
            if(hh1 == 4'd1 & hh2 == 4'd2) 
                hh1 <= 4'd0;
            else if(hh1 == 4'd0 & hh2 == 4'd9)
                hh1 <= hh1 + 1'b1;
        end
        else
            hh1 <= hh1;
    end
    
    assign hh = {hh1, hh2};
    assign mm = {mm1, mm2};
    assign ss = {ss1, ss2};
    
endmodule
