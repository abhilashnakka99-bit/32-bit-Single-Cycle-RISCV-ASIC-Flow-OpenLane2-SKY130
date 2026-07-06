module imm_generator(
input [31:0] instruction ,
output reg [31:0] immediate_value 
    );
wire [6:0] opcode;
assign opcode = instruction[6:0];
always@(*)
 begin 
  case(opcode)
    7'b0000011: //LW 
     begin 
      immediate_value = {{20{instruction[31]}},instruction[31:20]};
     end 
    7'b0100011: //SW 
    begin 
     immediate_value = {{20{instruction[31]}},{instruction[31:25],instruction[11:7]}};
    end 
    7'b1100011: //BEQ 
    begin 
     immediate_value = {{19{instruction[31]}},instruction[31],{instruction[7]},{instruction[30:25]},{instruction[11:8]},1'b0};
    end 
    default:
    immediate_value = 32'd0;
  endcase  
 end   
endmodule