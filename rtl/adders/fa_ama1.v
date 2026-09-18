module fa_ama1(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

    assign cout = (a & b) | (b & cin) | (a & cin);
    assign sum = (~cin & (a ^ b)) | (cin & (~(a ^ b)));
endmodule