module data_mem(
output reg [31:0] read_data ,
input clk ,
input mem_read , mem_write ,
input [31:0] write_data ,
input [31:0] address 
    );
reg [31:0] memory [0:31];
always@(posedge clk )
begin 
if (mem_write)
memory[address >> 2] <= write_data;
end
always@(*)
begin  
if (mem_read)
read_data = memory[address >> 2];
else 
read_data = 32'd0;
end 
endmodule
