module control_unit(

input [6:0] opcode,

output reg reg_write,
output reg mem_read,
output reg mem_write,
output reg alu_src,
output reg [1:0] alu_op

);

always @(*)
begin

    reg_write = 0;
    mem_read  = 0;
    mem_write = 0;
    alu_src   = 0;
    alu_op    = 2'b00;

    case(opcode)

// R-Type (ADD, SUB, AND, OR)
7'b0110011:
 begin
  reg_write = 1;
  mem_read  = 0;
  mem_write = 0;
  alu_src   = 0;
  alu_op    = 2'b10;
 end

// LW
7'b0000011:
 begin
  reg_write = 1;
  mem_read  = 1;
  mem_write = 0;
  alu_src   = 1;
  alu_op    = 2'b00;
 end

// SW
7'b0100011:
 begin
  reg_write = 0;
  mem_read  = 0;
  mem_write = 1;
  alu_src   = 1;
  alu_op    = 2'b00;
 end

// BEQ
7'b1100011:
 begin
  reg_write = 0;
  mem_read  = 0;
  mem_write = 0;
  alu_src   = 0;
  alu_op    = 2'b01;
 end
endcase

end

endmodule