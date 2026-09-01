module mux2to1(
    output [31:0] y, 
    input [31:0] a, b,
    input sel
);
    assign y = sel ? b : a;
endmodule