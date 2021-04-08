`default_nettype none
`timescale 1ns/1ns

module pwm (
    input wire clk,
    input wire reset,
    output wire out,
    input wire [7:0] level
    );

    parameter INVERT = 0;
    parameter WIDTH = 8;

    reg [WIDTH-1:0] counter;
    wire duty = counter < level;
    assign out = INVERT ? !duty : duty;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 1'b0;
        end else begin
            counter <= counter + 1'b1;
        end
    end

endmodule
