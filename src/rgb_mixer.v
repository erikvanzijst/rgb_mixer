`default_nettype none
`timescale 1ns/1ns
module rgb_mixer (
    input clk,
    input reset,
    input enc0_a,
    input enc0_b,
    input enc1_a,
    input enc1_b,
    input enc2_a,
    input enc2_b,
    output pwm0_out,
    output pwm1_out,
    output pwm2_out
    );

    wire [7:0] enc0;
    wire [7:0] enc1;
    wire [7:0] enc2;
    wire deb0_a, deb0_b;
    wire deb1_a, deb1_b;
    wire deb2_a, deb2_b;

    debounce debounce0_a(.clk(clk), .reset(reset), .button(enc0_a), .debounced(deb0_a));
    debounce debounce0_b(.clk(clk), .reset(reset), .button(enc0_b), .debounced(deb0_b));
    encoder encoder0(.clk(clk), .reset(reset), .a(deb0_a), .b(deb0_b), .value(enc0));
    pwm #(.WIDTH(8)) pwm0(.clk(clk), .reset(reset), .out(pwm0_out), .level(enc0));

    debounce debounce1_a(.clk(clk), .reset(reset), .button(enc1_a), .debounced(deb1_a));
    debounce debounce1_b(.clk(clk), .reset(reset), .button(enc1_b), .debounced(deb1_b));
    encoder encoder1(.clk(clk), .reset(reset), .a(deb1_a), .b(deb1_b), .value(enc1));
    pwm #(.WIDTH(8)) pwm1(.clk(clk), .reset(reset), .out(pwm1_out), .level(enc1));

    debounce debounce2_a(.clk(clk), .reset(reset), .button(enc2_a), .debounced(deb2_a));
    debounce debounce2_b(.clk(clk), .reset(reset), .button(enc2_b), .debounced(deb2_b));
    encoder encoder2(.clk(clk), .reset(reset), .a(deb2_a), .b(deb2_b), .value(enc2));
    pwm #(.WIDTH(8)) pwm2(.clk(clk), .reset(reset), .out(pwm2_out), .level(enc2));
endmodule
