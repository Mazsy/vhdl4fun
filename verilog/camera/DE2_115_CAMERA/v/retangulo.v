module retangulo (clock, VGA_R, VGA_G, VGA_B, out1, out2, out3);

input [9:0] VGA_R, VGA_G, VGA_B;
input clock;
output [9:0] out1, out2, out3;

parameter SIZE_X = 800,
         SIZE_Y = 600; 
			
reg [9:0] aux1[SIZE_X:0], aux2[SIZE_X:0], aux3[SIZE_X:0];

integer i;



endmodule
