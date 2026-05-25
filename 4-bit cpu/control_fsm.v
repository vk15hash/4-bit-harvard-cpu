//control unit FSM module

module FSM ( 
    input [15:0]commands,   //16 bit command line
    output jump_en,         //jump enable
    output [7:0]jump,       //8 bit jump code
    output [3:0]S,          //4 bit Select line for ALU
    output M,               //Logic or arithmatic operation mode
    output Cn,              //carry in
    output [1:0]W,          //2 bit WRITE signal to register
    output [1:0]Read_A,     //2 bit READ signal to register
    output [1:0]Read_B,     //2 bit READ signal to register
    output w_en             //write enable
);
    //slicing the 16-bit command line in desired variables
    assign S = commands[11:8];
    assign M = commands[7];
    assign Cn = commands[6];
    assign W = commands[5:4];
    assign Read_A = commands[3:2];
    assign Read_B = commands[1:0];

    //8bit jump address
    assign jump = {4'b0000,commands[15:12]};
    //if jump != 00000000 jump_en HIGH
    assign jump_en = jump[3] | jump[2] | jump[1] | jump[0]; 

    //when operation is not to jump we save the output
    assign w_en = ~jump_en;

endmodule


