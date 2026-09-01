module register_file(
    output [31:0] read_data1, read_data2,
    input clk, rst,
    input [4:0] rd, rs1, rs2,
    input [31:0] write_data,
    input reg_write  
);
    reg [31:0] registers [0:31];
    integer i;

    assign read_data1 = (rs1 == 5'd0) ? 32'b0 : registers[rs1];
    assign read_data2 = (rs2 == 5'd0) ? 32'b0 : registers[rs2];

    always @(posedge clk) begin 
        if (rst) begin 
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'd0; 
        end 
        else if (reg_write && (rd != 5'd0)) begin 
            registers[rd] <= write_data;
        end 
    end 
endmodule