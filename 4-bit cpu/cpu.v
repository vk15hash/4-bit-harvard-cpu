//4-bit cpu module
module cpu (
    input clk,      //clock
    input reset     //reset
);

    //counter to rom
    wire [7:0]count;
    //rom to fsm
    wire [15:0]commands;
    //fsm to counter
    wire jump_en;
    wire [7:0]jump;
    //fsm to alu
    wire [3:0]S;
    wire M, Cn;
    //fsm to register
    wire [1:0]W, Read_A, Read_B;
    wire w_en;
    //register to alu
    wire [3:0]A, B;
    //alu to register
    wire [3:0]F;
    wire Cn4, eq;

    //instantiation of 8 bit counter
    counter PC (.clk(clk), .Q(count), .reset(reset), .jump_en(jump_en), .jump(jump));
    //instantiation of ROM
    rom Instrunction_memory (.address_lines(count), .commands(commands));
    //instantiation of FSM unit
    FSM Control_unit (.commands(commands), .jump_en(jump_en), .jump(jump), .S(S), 
                    .M(M), .Cn(Cn), .W(W), .Read_A(Read_A), .Read_B(Read_B), .w_en(w_en));
    //instantiation of 4X4 register file
    register_block Storage (.I(F), .W(W), .Read_A(Read_A), .Read_B(Read_B), 
                    .reset(reset), .w_en(w_en), .clk(clk), .A(A), .B(B));
    //instantiation of IC-74181 inspired ALU
    ALU logic_unit (.A(A), .B(B), .S(S), .M(M), .Cn(Cn), .F(F), .Cn4(Cn4), .eq(eq));

endmodule

