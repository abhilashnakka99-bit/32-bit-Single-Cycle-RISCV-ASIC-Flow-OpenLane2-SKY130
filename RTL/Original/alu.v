module alu(
output [31:0] alu_out ,
output cout , zero ,
input [31:0] alu_in1 , alu_in2,
input [1:0] alu_sel
);
reg [31:0] alu_result ;  
wire [32:0] temp ;
assign alu_out = alu_result ;
assign temp = {1'b0,alu_in1} + {1'b0,alu_in2};
assign cout =temp[32];
assign zero =( alu_result == 32'd0) ;
always@(*)
begin 
case(alu_sel)
2'b00 : alu_result = alu_in1 + alu_in2 ;
2'b01 : alu_result = alu_in1 - alu_in2 ;
2'b10 : alu_result = alu_in1 & alu_in2 ;
2'b11 : alu_result = alu_in1 | alu_in2 ;
default : alu_result = 32'd0;
endcase 
end 
endmodule 