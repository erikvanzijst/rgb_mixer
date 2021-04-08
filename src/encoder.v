`default_nettype none
`timescale 1ns/1ns
module encoder (
    input clk,
    input reset,
    input a,
    input b,
    output reg [7:0] value
    );

    reg oldA;
    reg oldB;

    always @(posedge clk) begin
        if (reset) begin
            value <= 0;
            oldA <= 0;
            oldB <= 0;

        end else begin
            oldA <= a;
            oldB <= b;

            case ({a, oldA, b, oldB})
                4'b1000,
                4'b0111:
                    value <= value + 1'b1;
                4'b0010,
                4'b1101:
                    value <= value - 1'b1;
                default:
                    value <= value;
            endcase
        end
    end

endmodule
