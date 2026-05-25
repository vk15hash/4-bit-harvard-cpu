//ROM module
module rom (
    input [7:0] address_lines,      //8-bit address lines or 8 address lines
    output reg [15:0] commands      //16 bit command line
);
    always @(*) begin
        case (address_lines)
            // [0000]-[0000]-[0]-[0]-[00]-[00]-[00]
            // [jump]-[SSSS]-[M]-[c]-[WR]-[RA]-[RB]

            //when counter = 0
            8'd0 : commands = 16'b0000_0000_0_0_00_00_00; 

            //(add) A + B arithmatic with no carry_in store in R2, A from R0, B from R1
            //when counter = 1
            8'd1 : commands = 16'b0000_1001_0_1_10_00_01; 

            //(sub) A - B arithmatic with carry_in store in R3, A from R2, B from R1  
            //when counter = 2
            8'd2 : commands = 16'b0000_0110_0_0_11_10_01; //resulting in initial value of A


            //when counter = 3
            8'd3 : commands = 16'b0000_1001_0_0_11_00_10;            

            //we can write upto a total of 255 command lines of 16 bits each

            default : commands = 16'b0000_0000_0_1_00_00_00;
        endcase
    end
endmodule