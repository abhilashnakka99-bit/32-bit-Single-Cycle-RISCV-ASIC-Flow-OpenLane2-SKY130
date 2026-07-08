module register_file(
output [31:0] read_data1 , read_data2 ,
input clk ,
input [4:0] rd , rs1 , rs2 ,
input [31:0] write_data ,
input reg_write  
);
reg [31:0] registers [31:0];
assign read_data1 = (rs1 == 5'd0) ? 32'b0 : registers[rs1];
assign read_data2 = (rs2 == 5'd0) ? 32'b0 : registers[rs2];

always@(posedge clk)
begin 
if (reg_write && rd != 5'd0)
begin 
registers[rd] <= write_data;
end 
end 
endmodule 