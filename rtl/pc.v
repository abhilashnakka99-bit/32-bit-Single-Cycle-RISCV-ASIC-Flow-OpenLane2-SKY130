module pc(
output reg [31:0]pc ,
input clk , rst ,
input [31:0] next_pc 
    );
always@(posedge clk)
begin 
if(rst)
begin
pc <= 32'd0 ;
end
else
begin 
pc <= next_pc ;
end
end 
endmodule