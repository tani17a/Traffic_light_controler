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

module counter(input T,clk,reset,
	output R,G,O,next);

	reg [5:0] count;
	parameter [1:0] s0=2'b00, s1=2'b01, s2=2'b11;
	reg [1:0] state, next_state;
	
	always@(posedge clk,posedge reset)begin
		if (reset)begin 
			state<=s0; 
			count<=60;
			end
		else begin if(~T) begin
			count<=15; 
			state<=s1;
		     end
		 else  begin 
			 state<=next_state;
			 if(state==s0 | state==s1) begin
			      if (count!=0) count=count-1;end
		    else count<=60;
			 end
		end
	end
	
	always@(*)begin
		case(state)
			s0:begin if (count==6'd5) next_state=s1;
				 else next_state=s0; 
		        end
			s1:begin if (count==6'd0) next_state=s2;
			   else next_state=s1; 
		        end
			s2:begin
				next_state=s0;
			end
			default: next_state=s0;
		endcase
	end
	
	
	assign R=(state==s2);
	assign O=(state==s1);
	assign G=(state==s0);
	assign next=(state==s2);

endmodule


module side(input T1, T2,T3, T4, Next, reset, clk,
	output [3:0] Side);
		
		parameter [3:0] s1=4'b0001, s2=4'b0010, s3=4'b0100, s4=4'b1000;
		reg [3:0] next_state, state;
		
		always@(*)begin
			case(state)
				s1: begin
					if (Next) begin if (T2) next_state=s2;
				        else next_state=s3; end
					else next_state=s1;
				end
				s2: begin
					if (Next) begin if (T3) next_state=s3; 
					else next_state=s4; end
					else next_state=s2;
				end
				s3: begin
					if (Next)begin  if (T4) next_state=s4;
					else next_state=s1; end
					else next_state=s3;
				end
				s4: begin
					if (Next) begin if (T1) next_state=s1; 
					else next_state=s2; end
					else next_state=s4;
				end
				default: next_state=s1;
			endcase
		end
		
		always@(posedge clk, posedge reset)begin
			if (reset) state<=s1;
			else state<=next_state;
		end
		
		assign Side=state;
		
endmodule
