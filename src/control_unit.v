module control_unit(
    input [6:0] opcode,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg alu_src,
    output reg [1:0] alu_op
);
    always @(*) begin
        reg_write = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        alu_src   = 1'b0;
        alu_op    = 2'b00;

        case (opcode)
            7'b0110011: begin // R-Type
                reg_write = 1'b1;
                alu_op    = 2'b10;
            end
            7'b0000011: begin // LW
                reg_write = 1'b1;
                mem_read  = 1'b1;
                alu_src   = 1'b1;
            end
            7'b0100011: begin // SW
                mem_write = 1'b1;
                alu_src   = 1'b1;
            end
            7'b1100011: begin // BEQ
                alu_op    = 2'b01;
            end
            default: ;
        endcase
    end
endmodule