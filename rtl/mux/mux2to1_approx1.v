module mux2to1_approx (
    input wire a,
    input wire b,
    input wire sel,
    output wire y
);

    assign y = (a & b) | (sel & b);

endmodule