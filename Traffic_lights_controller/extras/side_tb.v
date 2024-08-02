module side_tb();
	reg T1,T2,T3,T4,Next,reset,clk;
	wire [4:0] side;
	
	side s(T1,T2,T3,T4,Next,reset,clk,side);
	initial begin
		clk=1;
		repeat(80) #2 clk=~clk;
        end
	integer i,j;

	assign Next=1;
 	initial begin
		for (j=15;j>0; j=j-1)begin
			#16 {T1,T2,T3,T4}=j[3:0];
		end
	end
	initial begin
		reset=1;
		#10 reset=0;       end
endmodule