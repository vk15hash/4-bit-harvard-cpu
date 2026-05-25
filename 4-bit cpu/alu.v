// IC-74181 inspired ALU module
module ALU (
    input [3:0]A,       //4 bit input A
    input [3:0]B,       //4 bit input B
    input [3:0]S,       //4 bit input S
    input M,            //logic input M
    input Cn,           //carry_in
    output reg [3:0]F,  //4 bit output F
    output reg Cn4,     //output carry_out
    output reg eq       //output A = B
);

    always @(*) begin
        F = 4'b0000;    //output value initially 0000
        Cn4 = 1'b0;     //Carry_out = 0
        eq = 1'b0;      //A != B 

        case (S)

            4'b0000: begin
                if (M)
                    F = ~A;
                else 
                    {Cn4,F} = {1'b0,A} + (!Cn);
            end

            4'b0001: begin
                if (M)
                    F = ~(A | B);
                else 
                    {Cn4,F} = ({1'b0,A} | {1'b0,B}) + (!Cn);
            end

            4'b0010: begin
                if (M)
                    F = ~A & B;
                else 
                    {Cn4,F} = ({1'b0,A} | {1'b0,~B}) + (!Cn);
            end

            4'b0011: begin
                if (M)
                    F = 4'b0000;
                else
                    {Cn4,F} = {1'b0,4'b1111} + (!Cn);
            end

            4'b0100: begin
                if (M)
                    F = ~(A & B);
                else
                    {Cn4,F} = {1'b0,A} + ({1'b0,A} & {1'b0,~B}) + (!Cn);
            end

            4'b0101: begin
                if (M)
                    F = ~B;
                else
                    {Cn4,F} = ({1'b0,A} | {1'b0,B}) + ({1'b0,A} & {1'b0,~B}) + (!Cn);
            end

            4'b0110: begin
                if (M)
                    F = A ^ B;
                else
                    {Cn4,F} = {1'b0,A} - {1'b0,B} - 1 + (!Cn);
            end
            4'b0111: begin
                if (M)
                    F = A & ~B;
                else
                    {Cn4,F} = ({1'b0,A} & {1'b0,~B}) - 1 + (!Cn);
            end

            4'b1000: begin
                if (M)
                    F = ~A | B;
                else
                    {Cn4,F} = {1'b0,A} + ({1'b0,A} & {1'b0,B}) + (!Cn);
            end
             

            4'b1001: begin
                if (M)
                    F = A ~^ B;
                else
                    {Cn4,F} = {1'b0,A} + {1'b0,B} + (!Cn);
            end

            4'b1010: begin
                if (M)
                    F = B;
                else
                    {Cn4,F} = ({1'b0,A} | {1'b0,~B}) + ({1'b0,A} & {1'b0,B}) + (!Cn);
            end

            4'b1011: begin
                if (M)
                    F = A & B;
                else
                    {Cn4,F} = ({1'b0,A} & {1'b0,B}) - 1 + (!Cn);
            end

            4'b1100: begin
                if (M)
                    F = 4'b0001;
                else
                    {Cn4,F} = {1'b0,A} + {1'b0,A} + (!Cn);
            end

            4'b1101: begin
                if (M)
                    F = A | ~B;
                else 
                    {Cn4,F} = ({1'b0,A} | {1'b0,B}) + {1'b0,A} + (!Cn);
            end

            4'b1110: begin
                if (M)
                    F = A | B;
                else
                    {Cn4,F} = ({1'b0,A} | {1'b0,~B}) + {1'b0,A} + (!Cn);
            end

            4'b1111: begin
                if (M)
                    F = A;
                else
                    {Cn4,F} = {1'b0,A} - 1 + (!Cn);
            end

            default: begin
                F = 4'b0000;
                Cn4 = 1'b0;
            end
        endcase

        if (A == B)
            eq = 1'b1;
        else
            eq = 1'b0;
    
    end
endmodule
