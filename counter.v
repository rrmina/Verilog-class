module counter(out, clk, reset);
    parameter WIDTH = 8;

    output  [WIDTH - 1 : 0] out;
    input   clk, reset;

    reg     [WIDTH - 1 : 0] out;
    wire    clk, reset;

    always @(posedge clk)
        out <= out + 1;

    always @reset
        if (reset)
            assign out = 0;
        else
            deassign out;

endmodule


module test;
    // Make a reset that pulses once.
    reg reset = 0;
    initial begin
        #17 reset = 1;
        #11 reset = 0;
        #29 reset = 1;
        #11 reset = 0;
        #17 reset = 1;
        #200 $stop;
    end

    // Make a regular pulsing clock
    reg clk = 0;
    always #5 clk = !clk;

    wire [7:0] value;
    counter c1 (value, clk, reset);

    initial
        $monitor("At time %t, value = %h (%0d)", $time, value, value);
endmodule

    