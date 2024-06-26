module tb_mul;
parameter N = 4; 
reg [N - 1:0] a,b;
reg clk, en;
wire [2 * N - 1:0] p;

array_mul #(N) uut(clk, en, a, b, p);

initial begin
  $dumpfile("play.vcd");
  $dumpvars(0,tb_mul);

  clk = 0;
  #1;

  a = 4'd1; b = 4'd1; en = 1'b0; #1; en = 1'b1;
  #(2 * N)
  $display("%b * %b = %d", a, b, p);

  a = 4'd2; b = 4'd2; en = 1'b0; #1; en = 1'b1;
  #(4 * N)
  $display("%b * %b = %d", a, b, p);

  a = 4'd3; b = 4'd2; en = 1'b0; #1; en = 1'b1;
  #(4 * N)
  $display("%b * %b = %d", a, b, p);

  a = 4'd15; b = 4'd14; en = 1'b0; #1; en = 1'b1;
  #(4 * N)
  $display("%b * %b = %d", a, b, p);

  #4;
  $display("%b * %b = %d", a, b, p);

  #4;
  $finish;
end

always begin
  clk = ~clk;
  #2;
end
endmodule
