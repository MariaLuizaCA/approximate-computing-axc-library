module mux2to1_exact (
    input wire a, //entrada do dado a e b
    input wire b,
    input wire sel, //linha de seleção
    output wire y //saida
);

    assign y = (~sel & a) | (sel & b);

    endmodule