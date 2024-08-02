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
