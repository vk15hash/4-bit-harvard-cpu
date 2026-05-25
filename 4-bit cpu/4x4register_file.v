
//2:4 decoder module
module decoder (
    input [1:0]X,       //2-bit input
    input w_en,         //write enable
    output reg [3:0]y   //4-bit output
);
    always @(*) begin
        if (w_en) begin //storing values of ALU output in the register
            case (X)
                //4 registers to have input to be stored at
                2'b00 : y = 4'b0001;    
                2'b01 : y = 4'b0010;
                2'b10 : y = 4'b0100;
                2'b11 : y = 4'b1000;
                //block all registers to store any value
                default: y = 4'b0000;
            endcase
        end
        else y = 4'b0000;  //block all registers to store any value
    end
endmodule

// d-ff module
module D_ff (
    input D,        //D
    input clk,      //clock
    input reset,    //reset
    input en,       //enable for d-ff
    output reg Q    //Q
);
    always @(posedge clk, posedge reset) begin
        if (reset) Q <= 0;   //reset button for D-ff
        else if (en) Q <= D; //stores values only when en = 1, else keep it unchanged
    end
endmodule

//register module
module register (
    input [3:0]D,   //4-bit D
    output [3:0]Q,  //4-bit Q
    input clk,      //clock
    input en,       //enable for register
    input reset     //reset
);

    //instantiate D-ffs
    D_ff FF0 (.D(D[0]), .clk(clk), .reset(reset), .en(en), .Q(Q[0]));
    D_ff FF1 (.D(D[1]), .clk(clk), .reset(reset), .en(en), .Q(Q[1]));
    D_ff FF2 (.D(D[2]), .clk(clk), .reset(reset), .en(en), .Q(Q[2]));
    D_ff FF3 (.D(D[3]), .clk(clk), .reset(reset), .en(en), .Q(Q[3]));
    
endmodule

//16:4 mux module
module mux (
    //four 4-bit input bus
    input [3:0] Q_0,    
    input [3:0] Q_1,
    input [3:0] Q_2,
    input [3:0] Q_3,
    //2-bit select line bus
    input [1:0] Sel,
    //4-bit output bus
    output reg [3:0] Y
);

    always @(*) begin
        case (Sel)
            2'b00 : Y = Q_0;
            2'b01 : Y = Q_1;
            2'b10 : Y = Q_2; 
            2'b11 : Y = Q_3;
            default: Y = 4'b0000;
        endcase
    end
endmodule

//4X4 register file module
module register_block (
    input [3:0]I,       //4-bit I
    input [1:0]W,       //2-bit WRITE
    input [1:0]Read_A,  //2-bit Read A signal
    input [1:0]Read_B,  //2-bit Read B signal
    input reset,        //reset
    input w_en,         //write enable
    input clk,          //clock
    output [3:0]A,      //4-bit output A
    output [3:0]B       //4-bit output B
    );
    
    //defining internal signals
    wire [3:0]en;   //4-bit enable signal for register
    wire [3:0]Q_0;  //4-bit output for register R0
    wire [3:0]Q_1;  //4-bit output for register R1
    wire [3:0]Q_2;  //4-bit output for register R2
    wire [3:0]Q_3;  //4-bit output for register R3

    //instantiate 2:4 decoder (write operation)
    decoder write (.X(W), .w_en(w_en), .y(en));

    //instantiate 4 registers  
    register R0 (.D(I), .Q(Q_0), .clk(clk), .en(en[0]), .reset(reset)); 
    register R1 (.D(I), .Q(Q_1), .clk(clk), .en(en[1]), .reset(reset)); 
    register R2 (.D(I), .Q(Q_2), .clk(clk), .en(en[2]), .reset(reset)); 
    register R3 (.D(I), .Q(Q_3), .clk(clk), .en(en[3]), .reset(reset)); 

    //instantiate two 16:4 mux (read operation)
    mux ReadA (.Q_0(Q_0), .Q_1(Q_1), .Q_2(Q_2), .Q_3(Q_3), .Sel(Read_A), .Y(A));
    mux ReadB (.Q_0(Q_0), .Q_1(Q_1), .Q_2(Q_2), .Q_3(Q_3), .Sel(Read_B), .Y(B));

endmodule