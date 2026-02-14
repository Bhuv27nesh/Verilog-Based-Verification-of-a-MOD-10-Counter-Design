//GIVEN CODE OF MOD10COUNTER : 
/*
//four bit mod 10 counter with load//
module mod10counter (clk,rst,count,load,din);
    input clk,rst,load;
    input [0:3]din;
    output [0:3]count;
    reg[0:3]count;

        always@(posedge clk or negedge rst)begin
                if(rst)
                    count <= 4'd0;
                else if(load)
                    count <= din;
                else if(count < 4'd10)
                    count <= count + 4'd1;
        end

endmodule
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
Bugs :
    1) The msb and lsb representation of din and count is reveresed i.e. [0:3]din and [0:3]count, 
       must be changed to [3:0]din and [3:0]count
    2) Incomplete logic of mod10 counter i.e. if the count value is greater than 10,
       then the count output must be set to zero 
    3) Incorrect logic of negedge reset which should be corrected to: if(!rst) then count<=4'd0
    4) Incorrect condition for increment logic of count : count<4'd9
    5) Here, when load is high din can be given in the range 0 to 15, 
       as it is a mod10 counter the count value is valid to hold value from 0 to 9, hence load logic is incorrect  
*/

//MODIFIED CODE OF MOD10COUNTER:
module mod10counter (clk,rst,count,load,din);
    input clk,rst,load;
    input [3:0]din;             //Corrected
    output [3:0]count;          //Corrected
    reg[3:0]count;              //Corrected

        always@(posedge clk or negedge rst)begin
                if(!rst)          //Corrected
                    count <= 4'd0;
                else if(load)begin     //Corrected
                    if(din < 4'd10)
                        count <= din;
                    else
                        count <=4'd0;
                end
                else if(count < 4'd9)  //Corrected
                    count <= count + 4'd1;
                else                    //Introduced
                    count <=4'd0;       //Introduced
        end

endmodule


