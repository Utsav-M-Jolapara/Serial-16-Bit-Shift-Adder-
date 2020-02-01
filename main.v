`resetall
`timescale 1ns/1ns

//shift register to store the two inputs a and b to be added
module shift(y,d,clk);
input [15:0] d;
input clk;
output [15:0] y;
reg [15:0] y;
initial begin
assign y=d;
end
always @(posedge clk)
begin
assign y=y>>1;
end
endmodule

//serial in parallel out register to store the 4 bit sum
module sipo(y,s,clk);
input  s;
input clk;
output [15:0] y;
reg [15:0] y;
always @(posedge clk)
begin
assign y={s,y[15:1]};
end
endmodule

//1 bit full adder
module fa(s,cout,a,b,cin);
input a,b,cin;
output s,cout;
assign {cout,s}=a+b+cin;
endmodule

//d flipflop to store the carry of each stage
module dff(q,d,clk);
input d,clk;
output q;
reg q;
initial begin
q=1'b0;
end
always @(posedge clk)
begin
q=d;
end
endmodule

//main module serial adder//
module serial(sum,cout,a,b,clk);
input [15:0] a,b;
input clk;
wire [15:0] x,z;
output [15:0] sum; 
output cout;
wire s,cin;
//input cin;
//initial begin
//cin=cinp;
//end
fa k(s,cout,x[0],z[0],cin);              //1 bit full adder
dff q(cin,cout,clk);                     //d flipflop to store the cout value after each 1 bit full adder operation
sipo m(sum,s,clk);                        //serial sum(s) converted to parallel output(4 bit sum)///
shift g(x,a,clk);                      //shifts the input a
shift h(z,b,clk);                      //shifts the input b
endmodule