module top(
 input clk , rst ,
 output [31:0] pc_out,
 output [31:0] alu_out_obs,
 output reg_write_obs
    );
   //pc
   wire [31:0] current_pc ;
   wire [31:0] next_pc ;
   
   //instruction memory
   wire [31:0] instruction ;
   
   //control unit 
   wire reg_write ;
   wire mem_read ;
   wire mem_write ;
   wire alu_src ;
   wire [1:0] alu_op ;
   
   //immediate generator 
   wire [31:0] immediate_value ;
   
   //register_file
   wire [31:0] read_data1 , read_data2 ;
   
   //ALU 
   wire [31:0] alu_out ;
   wire cout ;
   wire [1:0] alu_sel ;
   wire [31:0] alu_in2 ;
   wire zero ; 
   //MUX 
   wire [31:0] y ;
   
   //data memory 
   
   wire [31:0] write_back_data ;
   wire [31:0] memory_read_data ;
   wire branch_taken ;
   
   wire [6:0] opcode;
   wire [4:0] rd ;
   wire [2:0] func3 ;
   wire [6:0] func7 ;
   wire [4:0] rs1 , rs2 ;
   
   assign opcode = instruction[6:0] ;
   assign func3 = instruction[14:12] ;
   assign func7 = instruction[31:25] ;
   assign rs1 = instruction[19:15] ;
   assign rs2 = instruction[24:20] ;
   assign rd = instruction[11:7] ;
   
   
   pc uut_pc(
    .clk(clk),
    .rst(rst),
    .pc(current_pc),
    .next_pc(next_pc)
   );
   
   inst_mem uut_inst_mem(
    .instruction(instruction),
    .address(current_pc)
   );
   
   control_unit uut_control_unit(
   .reg_write(reg_write),
   .mem_read(mem_read),
   .mem_write(mem_write),
   .alu_src(alu_src),
   .alu_op(alu_op),
   .opcode(opcode)
   );
   
   imm_generator uut_imm_generator(
   .immediate_value(immediate_value),
   .instruction(instruction)
   );
   
   register_file uut_register_file(
   .read_data1(read_data1),
   .read_data2(read_data2),
   .clk(clk),
   .write_data(write_back_data),
   .reg_write(reg_write),
   .rs1(rs1),
   .rs2(rs2),
   .rd(rd)
   );
   
   alu_control uut_alu_control(
   .alu_op(alu_op),
   .alu_sel(alu_sel),
   .func3(func3),
   .func7(func7)
   );  
   
   mux2to1 uut_mux2to1(
   .y(alu_in2),
   .a(read_data2),
   .b(immediate_value),
   .sel(alu_src)
   );

   alu uut_alu(
   .alu_out(alu_out),
   .cout(cout),
   .zero(zero),
   .alu_in1(read_data1),
   .alu_in2(alu_in2),
   .alu_sel(alu_sel)
   );
   
   data_mem uut_data_mem(
   .clk(clk),
   .read_data(memory_read_data),
   .mem_read(mem_read),
   .mem_write(mem_write),
   .write_data(read_data2),
   .address(alu_out)
   );
   
   assign write_back_data = mem_read ? memory_read_data : alu_out ;
   assign branch_taken = ((alu_op == 2'b01) && zero) ;
   assign next_pc = (branch_taken) ? (current_pc + immediate_value) : (current_pc + 32'd4) ;
   
   
   assign pc_out       = current_pc;
   assign alu_out_obs  = alu_out;
   assign reg_write_obs = reg_write;
   
endmodule