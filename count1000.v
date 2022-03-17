module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    reg[3:0] q0, q1, q2, q3;
    always@(posedge clk) begin
        if(reset)
            q0 <= 4'd0;
        else if(q0 == 4'd9)
            q0 <= 4'd0;
        else
            q0 <= q0 + 1'b1;
    end
    assign ena[1] = (q0 == 4'd9) ? 1'b1 : 1'b0;
    
    always@(posedge clk) begin
        if(reset)
            q1 <= 4'd0;
        else if(q0 == 4'd9) begin
             if(q1 == 4'd9)
                q1 <= 4'd0;
             else
            	q1 <= q1 + 1'b1;
        end
        else
            q1 <= q1;

    end
    assign ena[2] = (q0 == 4'd9 && q1 == 4'd9) ? 1'b1 : 1'b0;
    
    always@(posedge clk) begin
        if(reset)
            q2 <= 4'd0;
        else if (q0 == 4'd9 && q1 == 4'd9) begin
            if(q2 == 4'd9)
                q2 <= 4'd0;
            else
                q2 <= q2 + 1'b1;
        end
        else
            q2 <= q2;
    end
    assign ena[3] = (q0 == 4'd9 && q1 == 4'd9 && q2 == 4'd9) ? 1'b1 : 1'b0;
    
    always@(posedge clk) begin
        if(reset)
            q3 <= 4'd0;
        else if (q0 == 4'd9 && q1 == 4'd9 && q2 == 4'd9) begin
            if(q3 == 4'd9)
                q3 <= 4'd0;
            else
                q3 <= q3 + 1'b1;
        end
        else
            q3 <= q3;
    end
    assign q = {q3, q2, q1, q0};
    
endmodule
