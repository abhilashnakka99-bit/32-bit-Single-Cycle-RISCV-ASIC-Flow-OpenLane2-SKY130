module alu(
output reg [31:0] alu_out,
output reg cout,
output zero,
input [31:0] alu_in1,
input [31:0] alu_in2,
input [1:0] alu_sel
);

always @(*) begin
 cout = 1'b0;
 case (alu_sel)
    2'b00: begin
        {cout, alu_out} = alu_in1 + alu_in2;
    end
    2'b01: begin
        alu_out = alu_in1 - alu_in2;
    end
    2'b10: begin
        alu_out = alu_in1 & alu_in2;
    end
    2'b11: begin
        alu_out = alu_in1 | alu_in2;
    end
    default: begin
        alu_out = 32'd0;
    end
 endcase
end
assign zero = (alu_out == 32'd0);
endmodule