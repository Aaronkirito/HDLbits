module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    //declare 4 states
    parameter IDLE = 2'd0, SENSOR_1 = 2'd1, SENSOR_2 = 2'd2, SENSOR_3 = 2'd3;
    reg[1:0] current_state, next_state;
    
    //transition block
    always@(*) begin
        case(current_state)
            IDLE : begin
                case(s)
                    3'b001 : next_state = SENSOR_1;
                    3'b011 : next_state = SENSOR_2;
                    3'b111 : next_state = SENSOR_3;
                    default : next_state = IDLE;
                endcase
            end
            SENSOR_1 : begin
                case(s)
                    3'b001 : next_state = SENSOR_1;
                    3'b011 : next_state = SENSOR_2;
                    3'b111 : next_state = SENSOR_3;
                    default : next_state = IDLE;
                endcase
            end
            SENSOR_2 : begin
                case(s)
                    3'b001 : next_state = SENSOR_1;
                    3'b011 : next_state = SENSOR_2;
                    3'b111 : next_state = SENSOR_3;
                    default : next_state = IDLE;
                endcase
            end
            SENSOR_3 : begin
                case(s)
                    3'b001 : next_state = SENSOR_1;
                    3'b011 : next_state = SENSOR_2;
                    3'b111 : next_state = SENSOR_3;
                    default : next_state = IDLE;
                endcase
            end
            default: next_state = IDLE;
        endcase
    end
    
    //flip-flop block
    always@(posedge clk) begin
        if(reset)
            current_state = IDLE;
        else
            current_state = next_state;
    end
    
    //output of FR1, FR2, FR3
    assign fr1 = (current_state == IDLE | current_state == SENSOR_1 | current_state == SENSOR_2);
    assign fr2 = (current_state == IDLE | current_state == SENSOR_1);
    assign fr3 = (current_state == IDLE);
    
    //control the dfr
    reg fr1_reg, fr2_reg, fr3_reg;
    always@(posedge clk) begin
        fr1_reg <= fr1;
    end
    always@(posedge clk) begin
        fr2_reg <= fr2;
    end
    always@(posedge clk) begin
        fr3_reg <= fr3;
    end
    
    
    always@(*) begin
        if(~fr1 & fr1_reg | ~fr2 & fr2_reg | ~fr3 & fr3_reg)
            dfr = 1'b0;
        else if(fr1 & ~fr1_reg | fr2 & ~fr2_reg | fr3 & ~fr3_reg)
            dfr = 1'b1;
    end

endmodule
