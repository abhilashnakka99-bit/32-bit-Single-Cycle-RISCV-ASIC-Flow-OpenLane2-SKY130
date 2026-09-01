module alu(
    output reg [31:0] alu_out,
    output reg cout,
    output zero,
    input [31:0] alu_in1,
    input [31:0] alu_in2,
    input [1:0] alu_sel
);
    wire [31:0] b_mux;
    wire sub_flag;
    wire [32:0] add_result;

    // Shared single adder for ADD and SUB
    assign sub_flag   = (alu_sel == 2'b01);
    assign b_mux      = sub_flag ? ~alu_in2 : alu_in2;
    assign add_result = alu_in1 + b_mux + sub_flag;

    always @(*) begin
        cout = 1'b0;
        case (alu_sel)
            2'b00, 2'b01: begin 
                alu_out = add_result[31:0];
                cout    = add_result[32];
            end
            2'b10: alu_out = alu_in1 & alu_in2;
            2'b11: alu_out = alu_in1 | alu_in2;
            default: alu_out = 32'd0;
        endcase
    end

    assign zero = (alu_out == 32'd0);
endmodule