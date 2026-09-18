module fa_axa2 (
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

    assign cout = (a & b) | (b & cin) | (a & cin);
    // soma sem portas xor assign 
    //sum = (a & b & cin) | (~cout & (a | b | cin));

    //soma aproximada 
    //só entraga 1 quando há 2 ou 3 bits ativos. se só for 1 bit ativo é forçada a 0
    assign sum = (a & b & cin) | ((a & ~b & cin) | (a & b & ~cin) | (~a & b & cin));


endmodule 