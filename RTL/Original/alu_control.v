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
        if(func3 == 3'b000 && func7 == 7'b0000000)
          begin 
           alu_sel = 2'b00; 
          end
        else if (func3 == 3'b000 && func7 == 7'b0100000) 
          begin 
           alu_sel = 2'b01; 
          end
        else if (func3 == 3'b111 && func7 == 7'b0000000)
         begin 
          alu_sel = 2'b10;
         end
         else if (func3 == 3'b110 && func7 == 7'b0000000)
          begin 
           alu_sel = 2'b11;
          end  
       end
     default : alu_sel = 2'b00;
   endcase 
 end 
endmodule 