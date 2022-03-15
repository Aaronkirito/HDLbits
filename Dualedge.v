/*这题是双边沿d触发器，这题的思路是先设计一个上边沿触发器和
一个下边沿触发器，然后通过一个锁存器来输出结果。*/
module top_module (
    input clk,
    input d,
    output q
);
    reg temp1, temp2;
    always@(posedge clk)begin
        temp1 <= d;
    end
    always@(negedge clk)begin
        temp2 <= d;
    end
    always@(clk) begin
        if(clk)
            q <= temp1;
        else
            q <= temp2;
    end

endmodule
