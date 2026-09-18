module hybrid_mux2to1_8bit (
    input wire [7:0] a, //barramento de entrada de 8 bits 
    input wire [7:0] b,
    input wire  sel,
    output wire [7:0] y 
);

    genvar i; 

    generate 
        //instanciando 3LSBs com o mux aproximado
        for (i = 0; i < 3; i = i + 1 ) begin : gen_exact_lsb
            mux2to1_approx u_ax (
                .a(a[i]),
                .b(b[i]),
                .sel(sel),
                .y(y[i])
            );
        end

        // instanciar os 5 MSBs com o mux exato
        for(i = 3; i < 8; i = i + 1) begin : gen_exact_msb
            mux2to1_exact u_ex (
                .a(a[i]),
                .b(b[i]),
                .sel(sel),
                .y(y[i])
            );
        end
    endgenerate

endmodule