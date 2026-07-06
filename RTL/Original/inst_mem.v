module inst_mem(
output [31:0] instruction,
input [31:0] address
    );
 reg [31:0] memory [0:31];
 initial begin 
 memory[0] = 32'h002081B3; // ADD x3, x1, x2
 memory[1] = 32'h40208233; // SUB x4, x1, x2
 memory[2] = 32'h0020F2B3; // AND x5, x1, x2
 memory[3] = 32'h0020E333; // OR  x6, x1, x2
 memory[4] = 32'h00302023; // SW  x3, 0(x0)
 memory[5] = 32'h00002383; // LW  x7, 0(x0)
 memory[6] = 32'h00318463; // BEQ x3, x3, +8
 memory[9] = 32'h00208463; // BEQ x1, x2, +8
 end 
 assign instruction = memory[address >> 2];
endmodule