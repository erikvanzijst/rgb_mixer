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
    // wire deb0_a, deb0_b;
    // wire deb1_a, deb1_b;
    // wire deb2_a, deb2_b;

    wire [2:0] a = {enc0_a, enc1_a, enc2_a};
    assign a[0] = enc0_a;
    assign a[1] = enc1_a;
    assign a[2] = enc2_a;
    wire [2:0] deb_a;

    wire [2:0] b = {enc0_b, enc1_b, enc2_b};
    assign b[0] = enc0_b;
    assign b[1] = enc1_b;
    assign b[2] = enc2_b;
    wire [2:0] deb_b;

    wire [7:0] enc [2:0];
    assign enc0 = enc[0];
    assign enc1 = enc[1];
    assign enc2 = enc[2];

    wire [2:0] pwm_out;
    assign pwm0_out = pwm_out[0];
    assign pwm1_out = pwm_out[1];
    assign pwm2_out = pwm_out[2];

    genvar i;
    generate
        for (i = 0; i < 3; i = i + 1) begin
            debounce deb_a(.clk(clk), .reset(reset), .button(a[i]), .debounced(deb_a[i]));
            debounce deb_b(.clk(clk), .reset(reset), .button(b[i]), .debounced(deb_b[i]));
            encoder e(.clk(clk), .reset(reset), .a(deb_a[i]), .b(deb_b[i]), .value(enc[i]));
            pwm p(.clk(clk), .reset(reset), .out(pwm_out[i]), .level(enc[i]));
        end
    endgenerate

    // debounce debounce0_a(.clk(clk), .reset(reset), .button(enc0_a), .debounced(deb0_a));
    // debounce debounce0_b(.clk(clk), .reset(reset), .button(enc0_b), .debounced(deb0_b));
    // encoder encoder0(.clk(clk), .reset(reset), .a(deb0_a), .b(deb0_b), .value(enc0));
    // pwm pwm0(.clk(clk), .reset(reset), .out(pwm0_out), .level(enc0));

    // debounce debounce1_a(.clk(clk), .reset(reset), .button(enc1_a), .debounced(deb1_a));
    // debounce debounce1_b(.clk(clk), .reset(reset), .button(enc1_b), .debounced(deb1_b));
    // encoder encoder1(.clk(clk), .reset(reset), .a(deb1_a), .b(deb1_b), .value(enc1));
    // pwm pwm1(.clk(clk), .reset(reset), .out(pwm1_out), .level(enc1));

    // debounce debounce2_a(.clk(clk), .reset(reset), .button(enc2_a), .debounced(deb2_a));
    // debounce debounce2_b(.clk(clk), .reset(reset), .button(enc2_b), .debounced(deb2_b));
    // encoder encoder2(.clk(clk), .reset(reset), .a(deb2_a), .b(deb2_b), .value(enc2));
    // pwm pwm2(.clk(clk), .reset(reset), .out(pwm2_out), .level(enc2));

    // color color0(.clk(clk), .reset(reset), .enc_a(enc0_a), .enc_b(enc0_b), .pwm_out(pwm0_out));
    // single_mixer color1(.clk(clk), .reset(reset), .enc_a(enc1_a), .enc_b(enc1_b), .pwm_out(pwm1_out));
    // single_mixer color2(.clk(clk), .reset(reset), .enc_a(enc2_a), .enc_b(enc2_b), .pwm_out(pwm2_out));

endmodule

// module color (
//     input clk,
//     input reset,
//     input enc_a,
//     input enc_b,
//     output pwm_out
//     );

//     reg debounced_a, debounced_b;
//     reg [7:0] duty;

//     debounce debounce_a(.clk(clk), .reset(reset), .button(enc_a), .debounced(debounced_a));
//     debounce debounce_b(.clk(clk), .reset(reset), .button(enc_b), .debounced(debounced_b));

//     encoder encoder0(.clk(clk), .reset(reset), .a(debounced_a), .b(debounced_b), .value(duty));

//     pwm pwm0(.clk(clk), .reset(reset), .out(pwm_out), .level(duty));

// endmodule
