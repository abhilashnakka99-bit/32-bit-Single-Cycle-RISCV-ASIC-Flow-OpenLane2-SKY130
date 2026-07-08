module alu_control(
input [1:0] alu_op ,
input [2:0] func3 ,
input [6:0] func7 , 
output reg [1:0] alu_sel 
);
always@(*)
 begin 
   case(alu_op)
     2'b00: //LW SW 
     alu_sel = 2'b00;
     
     2'b01: //BEQ 
     alu_sel = 2'b01;
     
     2'b10: //ADD SUB AND OR 
       begin 
        case (func3)
              3'b000:
                alu_sel = (func7[5]) ? 2'b01 : 2'b00;

              3'b111:
                alu_sel = 2'b10;

              3'b110:
                alu_sel = 2'b11;

              default:
                alu_sel = 2'b00;
        endcase
       end
     default : alu_sel = 2'b00;
   endcase 
 end 
endmodule 