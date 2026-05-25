//8-bit program counter module
module counter (
    input clk,          //clock
    output reg [7:0]Q,  //8-bit counter output
    input reset,        //reset
    input jump_en,      //jump enable
    input [7:0]jump     //8-bit jump address
);

    always @(posedge clk) begin
        if (reset) Q <= 8'b00000000;    //reseting the  counter to zero
        else if (jump_en) Q <= jump;    //jumping the counter value to the desired address
        else Q <= Q + 1;                //normal iterations for counter    
    end    
endmodule

