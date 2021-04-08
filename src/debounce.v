`default_nettype none
`timescale 1ns/1ns
module debounce (
    input wire clk,
    input wire reset,
    input wire button,
    output reg debounced
    );

    reg [7:0] measurements;
    wire enable = (measurements == 8'hFF || measurements == 8'h0);

    always @(posedge clk) begin
        if (reset) begin
            measurements <= 8'b0;
            debounced <= 1'b0;
        end else begin
            measurements <= (measurements << 1) | button;

            if (enable) begin
                debounced <= (measurements == 8'hFF) ? 1'b1 : 1'b0;
            end
        end
    end

endmodule
