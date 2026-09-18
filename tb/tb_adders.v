`timescale 1ns/1ps

module tb_adders;
    reg [7:0] a;
    reg [7:0] b;
    wire [7:0] sum_app;
    wire        cout;

    hybrid_rca_8bit uut (
        .a(a), 
        .b(b), 
        .sum(sum_app), 
        .cout(cout)
    );

    integer i;
    integer total_tests = 0;
    integer error_count = 0;
    real total_error_distance = 0.0;

    reg [8:0] exact_sum;
    real current_ed;

    initial begin
        $dumpfile("waveform_adder.vcd");
        $dumpvars(0, tb_adders);

        //zera os registros iniciais
        a = 8'd0;
        b = 8'd0;
        #10;

        //100 vetores de teste
        for (i = 0; i < 100; i = i + 1) begin   
        a = i[7:0];
        b = 100 - i[7:0]; //varia de forma inversa
        
        #10;//tempo de propagação

        exact_sum = a + b;
        total_tests = total_tests + 1;

        //comparando o resultado exato ao aproximado
        if({cout, sum_app} !== exact_sum) begin

            error_count = error_count + 1;

            if(exact_sum > {cout, sum_app})
                current_ed = exact_sum - {cout, sum_app};
            else
                current_ed = {cout, sum_app} - exact_sum;

            total_error_distance = total_error_distance + current_ed;

            //DEBUG
            $display("Falha de teste %d: A = %d, B=%d | exato = %d, aprox=%d | ed = %f",
                        total_tests, a, b, exact_sum, {cout, sum_app}, current_ed);
        end
    end

    $display("RESULTADOS SOMADOR HIBRIDO (RCA)");
    $display("Total de vetores: %d", total_tests);
    $display("Error rate (ER): %0.2f %%", (error_count * 100.0)/total_tests);
    $display("Mean Error Distance (MED): %0.4f", total_error_distance / total_tests);
    
    $finish;
end
endmodule