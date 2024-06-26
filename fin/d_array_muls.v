module array_mul #(parameter N=2) (
  input clk,
  input inp,
  input [N - 1:0] a,
  input [N - 1:0] b,
  inout [2 * N - 1:0] y
);

wire [N - 1:0] pp [N - 1:0]; // Partial products
wire [2 * N - 1:0] pp1 [N - 1:0]; // Shifted partial products

reg [2 * N - 1:0] from_reg = 4'd0; // Feed from output register

reg [N - 1:0] ct = 0; // Counter

genvar i;

// Partial products
for (i = 0; i < N; i = i + 1) begin
  ands #(N) u1({N{a[i]}}, b, pp[i]); // Creating partial products
  assign pp1[i] = {{N{1'b0}},pp[i]} << i; // Shifting partial products
end

// Interrupts
always @(posedge inp) begin
  from_reg <= 0;
  ct <= 0;
end

// Summing of partial products
always @(posedge clk) begin
  if(ct < N) begin
    from_reg <= from_reg + pp1[ct];
    ct <= ct + 1;
  end
end
assign y = from_reg;

endmodule
