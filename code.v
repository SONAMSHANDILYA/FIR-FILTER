module fir_filter (
  input wire clk,
  input wire [7:0] x, // 8-bit input sample
  output reg [15:0] y // 16-bit output sample
);

  // Filter coefficients (example coefficients for a low-pass filter)
 reg [7:0] h [3:0];

initial begin
  h[0] = 8'b00000001;
  h[1] = 8'b00000100;
  h[2] = 8'b00001011;
  h[3] = 8'b00000100;
end

  // Internal signals
  reg [15:0] acc; // Accumulator for the weighted sum
  reg [7:0] input_delay [3:0]; // Delay line for input samples

  always @(posedge clk) begin
    // Shift input samples into the delay line
    input_delay[0] <= x;
    input_delay[1] <= input_delay[0];
    input_delay[2] <= input_delay[1];
    input_delay[3] <= input_delay[2];

    // FIR filter equation
    acc <= (input_delay[0] * h[0]) + (input_delay[1] * h[1]) + (input_delay[2] * h[2]) + (input_delay[3] * h[3]);
    y <= acc[15:0]; // Take the 16 MSBs of the accumulator as the output
  end

endmodule
