module Hamm_enc_dec(e,Cout,Cdata,r,d,clk);
	input clk;
	input [2:0]d;
	input [5:0]r;
	output [5:0]e, Cout,Cdata;
	parameter [2:0]I0 = 4,I1 = 2, I2 = 1,P0 = 3'b101, P1 = 3'b011, P2 = 3'b110;
	wire [5:0] H3,H2,H1;

	assign H3 = {P0[2],P1[2],P2[2],I0};
	assign H2 = {P0[1],P1[1],P2[1],I1};
	assign H1 = {P0[0],P1[0],P2[0],I2};
	
		enc(Cdata,d,I0,I1,I2,P0,P1,P2,clk);
		dec(S, e, Cout, r, H3,H2,H1,clk);
	
	 
endmodule

	module enc(Cen,d,I0,I1,I2,P0,P1,P2,clk);
		input clk;
		input [2:0]d,I0,I1,I2,P0,P1,P2;
		output [5:0]Cen;
		reg [5:0]c;
		
		always@(posedge clk)
		begin
			c = {^(d&I0),^(d&I1),^(d&I2),^(d&P0),^(d&P1),^(d&P2)};
		end
		assign Cen = c;
	endmodule


	module dec(S, error, c, r, H3,H2,H1, clk);
		input clk;
		input [5:0]r, H3, H2, H1;
		output reg [2:0]S;
		output [5:0]error, c;
		reg [5:0]e = 6'b000000;

		always@(posedge clk)
		begin
			S = {^(r & H3),^(r & H2),^(r & H1)};

			if(S == {H3[0],H2[0],H1[0]}) e = 6'b000001;
			else if(S == {H3[1],H2[1],H1[1]}) e = 6'b000010;
			else if(S == {H3[2],H2[2],H1[2]}) e = 6'b000100;  
			else if(S == {H3[3],H2[3],H1[3]}) e = 6'b001000;
			else if(S == {H3[4],H2[4],H1[4]}) e = 6'b010000;	
			else if(S == {H3[5],H2[5],H1[5]}) e = 6'b100000;
			else if (S == 3'b111) e = 6'b100010;
			
		end

		assign error = e;
		assign c = e^r;
	endmodule
