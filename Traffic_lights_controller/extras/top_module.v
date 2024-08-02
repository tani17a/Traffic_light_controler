module Top_module(input T1,T2,T3,T4,clk,reset,
	output reg [3:0] Ri, Oi, Gi);
	
	wire R,G,O,next;
	wire [3:0] side;
	
	always@(*)begin
		if(G) Gi=side;
		else Gi=0;
		
		if(O) Oi=side;
		else Oi=0;
		
		if(O||G) Ri=4'b1111^side;
		if(R) Ri=4'b1111;
		
	end
	
	counter count(T1|T2|T3|T4 ,clk,reset,R,G,O,next);
	side direction(T1,T2,T3,T4,next,reset,clk,side);
endmodule
