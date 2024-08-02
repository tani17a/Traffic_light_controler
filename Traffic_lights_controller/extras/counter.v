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
