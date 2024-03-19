module lab6 (input logic [3:0] num, 
        input [2:0] sel,
        input logic write, reset, clk,
        output logic an0, an1, an2, an3, an4, an5, an6, an7,
        output logic segA, segB, segC, segD, segE, segF, segG);

logic en0, en1, en2, en3, en4, en5, en6, en7;
logic [3:0] q0, q1, q2, q3, q4, q5, q6, q7;
logic a, b, c, d;
logic A, B, C, D;

always_comb
begin
    A = sel[2];
    B = sel[1];
    C = sel[0];
end

//COMB FOR DFF SELECTION
assign en0 = write & (!A) & (!B) & (!C);
assign en1 = write & (!A) & (!B) & C;
assign en2 = write & (!A) & B & (!C);
assign en3 = write & (!A) & B & C;
assign en4 = write & A & (!B) & (!C);
assign en5 = write & A & (!B) & C;
assign en6 = write & A & B & (!C);
assign en7 = write & A & B & C;

//D_FFs
d_ff ff0 (
    .q (q0),
    .clk (clk),
    .reset (reset),
    .enable (en0),
    .d (num)
);
d_ff ff1 (
    .q (q1),
    .clk (clk),
    .reset (reset),
    .enable (en1),
    .d (num)
);
d_ff ff2 (
    .q (q2),
    .clk (clk),
    .reset (reset),
    .enable (en2),
    .d (num)
);
d_ff ff3 (
    .q (q3),
    .clk (clk),
    .reset (reset),
    .enable (en3),
    .d (num)
);
d_ff ff4 (
    .q (q4),
    .clk (clk),
    .reset (reset),
    .enable (en4),
    .d (num)
);
d_ff ff5 (
    .q (q5),
    .clk (clk),
    .reset (reset),
    .enable (en5),
    .d (num)
);
d_ff ff6 (
    .q (q6),
    .clk (clk),
    .reset (reset),
    .enable (en6),
    .d (num)
);
d_ff ff7 (
    .q (q7),
    .clk (clk),
    .reset (reset),
    .enable (en7),
    .d (num)
);
logic [3:0] y;
always_comb begin
    case (sel)
        3'b000:y = q0;
        3'b001:y = q1;
        3'b010:y = q2;
        3'b011:y = q3;
        3'b100:y = q4;
        3'b101:y = q5;
        3'b110:y = q6;
        3'b111:y = q7;
    endcase
end

logic [6:0] m;
always_comb begin
    case (y)
        4'b0000: m = 7'b0000001;
        4'b0001: m = 7'b1001111;
        4'b0010: m = 7'b0010010;
        4'b0011: m = 7'b0000110;
        4'b0100: m = 7'b1001100;
        4'b0101: m = 7'b0100100;
        4'b0110: m = 7'b0100000;
        4'b0111: m = 7'b0001111;
        4'b1000: m = 7'b0000000;
        4'b1001: m = 7'b0000100;
        4'b1010: m = 7'b0001000;
        4'b1011: m = 7'b1100000;
        4'b1100: m = 7'b0110001;
        4'b1101: m = 7'b1000010;
        4'b1110: m = 7'b0110000;
        4'b1111: m = 7'b0111000;
    endcase
end

always_comb
begin
    segA = m[6];
    segB = m[5];
    segC = m[4];
    segD = m[3];
    segE = m[2];
    segF = m[1];
    segG = m[0];
end

logic [7:0] n;
always_comb begin
    case (sel)
        3'b000: n = 8'b01111111;
        3'b001: n = 8'b10111111;
        3'b010: n = 8'b11011111;
        3'b011: n = 8'b11101111;
        3'b100: n = 8'b11110111;
        3'b101: n = 8'b11111011;
        3'b110: n = 8'b11111101;
        3'b111: n = 8'b11111110;
    endcase
end

always_comb
begin
    an0 = n[7];
    an1 = n[6];
    an2 = n[5];
    an3 = n[4];
    an4 = n[3];
    an5 = n[2];
    an6 = n[1];
    an7 = n[0];
end

endmodule