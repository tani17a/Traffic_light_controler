module top_module_tb();
	reg T1,T2,T3,T4,clk,reset;
	wire [3:0] R,O,G;
	
	Top_module tp (T1,T2,T3,T4,clk,reset,R,G,O);
	initial begin
		clk=1;
		repeat(15010) #2 clk=~clk;
	end
	integer j;
	initial begin
		#5{T1,T2,T3,T4}=4'b1111;
		for(j=14;j>0;j=j-1)begin
			#500 {T1,T2,T3,T4} =j[3:0];
		end
	end
	initial begin
		reset=1;
		#10 reset=0;
	end
endmodule
