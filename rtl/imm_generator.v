module imm_generator(
    input [31:0] instruction,
    output [31:0] immediate_value 
);
    wire [6:0] opcode = instruction[6:0];

    wire [31:0] imm_i = {{20{instruction[31]}}, instruction[31:20]};
    wire [31:0] imm_s = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
    wire [31:0] imm_b = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};

    assign immediate_value = (opcode == 7'b0000011) ? imm_i : 
                             (opcode == 7'b0100011) ? imm_s : 
                             (opcode == 7'b1100011) ? imm_b : 
                             32'd0;
endmodule