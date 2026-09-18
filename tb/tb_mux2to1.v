`timescale 1ns/1ps

module tb_mux2to1;
    //entradas precisam ser 'reg' no testbench
    reg [7:0] a;
    reg [7:0] b;
    reg     sel;

    //a saida é wire
    wire [7:0] y_approx;

    hybrid_mux2to1_8bit uut(
        .a(a),
        .b(b),
        .sel(sel),
        .y(y_approx)
    );

    //variáveis de contagem e estatística
    integer i;
    integer total_teste = 0;
    integer error_count = 0;
    reg [7:0] y_expected;

    initial begin
        //instrui a salvar o gráfico de ondas em um arquivo .vcd
        $dumpfile("waveform_hybrid_mux.vcd");
        $dumpvars(0, tb_mux2to1);

        for (i = 0; i < 50; i = i + 1) begin
            a = i;
            b = 8'hFF - i;

            //teste sel = 0
            sel = 0; #10;
            y_expected = a;
            total_teste = total_teste + 1;
            if (y_approx !== y_expected) error_count = error_count + 1;

            //teste sel = 1
            sel = 1; #10;
            y_expected = b;
            total_teste = total_teste + 1;
            if (y_approx !== y_expected) error_count = error_count + 1;
        
        end

        $display("RESULTADO DA SIMULAÇÃO");
        $display("Total de testes: ", total_teste);
        $display("Total de saidas erradas: ",error_count);
        $display("Error rate (ER): ", (error_count * 100.0)/total_teste);

        $finish;
    end
endmodule
