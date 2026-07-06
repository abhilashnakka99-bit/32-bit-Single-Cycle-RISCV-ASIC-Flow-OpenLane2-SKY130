module top_tb();
reg clk , rst ;
top uut_top (
.clk(clk),
.rst(rst)
);
initial clk = 0 ;
always #10 clk = ~clk ;

initial begin 
rst = 1 ;
#40 ;
rst =0 ;
#200 ;

if (uut_top.uut_register_file.registers[3] !== 32'd8)
         $display("Fail : x3 expected 8 , got %d" , uut_top.uut_register_file.registers[3]);
else 
         $display("Pass : x3 = 8");
if (uut_top.uut_register_file.registers[4] !== 32'd2)
         $display("FAIL: x4 expected 2, got %d", uut_top.uut_register_file.registers[4]);
else
         $display("PASS: x4 = 2");     
if (uut_top.uut_register_file.registers[5] !== 32'd1)
         $display("FAIL: x5 expected 1, got %d", uut_top.uut_register_file.registers[5]);
else
         $display("PASS: x5 = 1");     
if (uut_top.uut_register_file.registers[6] !== 32'd7)
         $display("FAIL: x6 expected 7, got %d", uut_top.uut_register_file.registers[6]);
else
         $display("PASS: x6 = 7");     
if (uut_top.uut_data_mem.memory[0] !== 32'd8)
         $display("FAIL: mem[0] expected 8, got %d", uut_top.uut_data_mem.memory[0]);
else
         $display("PASS: mem[0] = 8");          
if (uut_top.uut_register_file.registers[7] !== 32'd8)
         $display("FAIL: x7 expected 8, got %d", uut_top.uut_register_file.registers[7]);
else
         $display("PASS: x7 = 8");     
     
     
$finish;
end  
endmodule
