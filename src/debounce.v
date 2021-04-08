`default_nettype none
`timescale 1ns/1ns
module debounce (
    input wire clk,
    input wire reset,
    input wire button,
    output reg debounced
    );

    parameter WIDTH = 16;
    localparam fully_on = 2 ** WIDTH - 1;
    reg [WIDTH-1:0] measurements;
    wire enable = (measurements == fully_on || measurements == 0);

    always @(posedge clk) begin
        if (reset) begin
            measurements <= 0;
            debounced <= 1'b0;
        end else begin
            measurements <= (measurements << 1) | button;

            if (enable) begin
                debounced <= (measurements == fully_on) ? 1'b1 : 1'b0;
            end
        end
    end

endmodule
