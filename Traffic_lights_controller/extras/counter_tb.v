module counter_tb();
	reg clk,T,reset;
	wire R,G,O,next;
	counter count(T,clk,reset,R,G,O,next);
 	
	initial begin
	clk=0;
	repeat(1300) #5 clk=~clk;
end
	initial begin
	reset=1;
	T=0;
 	#4 T=1;
	#3 reset=0;
	#1000 T=0;
   	#11 T=1;
end
endmodule