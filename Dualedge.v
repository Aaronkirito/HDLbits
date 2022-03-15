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

//参考答案
module top_module(
	input clk,
	input d,
	output q);
	
	reg p, n;
	
	// A positive-edge triggered flip-flop
    always @(posedge clk)
        p <= d ^ n;
        
    // A negative-edge triggered flip-flop
    always @(negedge clk)
        n <= d ^ p;
    
    // Why does this work? 
    // After posedge clk, p changes to d^n. Thus q = (p^n) = (d^n^n) = d.
    // After negedge clk, n changes to p^n. Thus q = (p^n) = (p^p^n) = d.
    // At each (positive or negative) clock edge, p and n FFs alternately
    // load a value that will cancel out the other and cause the new value of d to remain.
    assign q = p ^ n;
    
    
	// Can't synthesize this.
	/*always @(posedge clk, negedge clk) begin
		q <= d;
	end*/
    
    
endmodule
