`timescale 10ns/1ps
//cpu testbench module
module cpu_tb ;

    reg clk;
    reg reset;

    //instantiate the module
    cpu dut (.clk(clk), .reset(reset));

    //clock generation
    initial begin
        clk = 0; 
    end
    always begin
        #10 clk = ~clk;
    end
    
    //stimulus
    initial begin
        //storing the waveform
        $dumpfile("cpu.vcd");
        $dumpvars(0,cpu_tb);

        //initial condition
        clk = 0; reset = 1;
        #25 reset = 0;
        #200;
        $finish;
    end
endmodule