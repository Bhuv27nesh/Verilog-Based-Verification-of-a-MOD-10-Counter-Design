`timescale 1ns/1ns

module mod10counter_test();
    reg clk;
    reg rst;
    reg load;
    reg [3:0]din;
    wire [3:0]count;    
    
    //Variables used for scoreboard:
    integer error;
    integer correct;
    //error=0;
    //correct=0;

    //Model instantioation
    mod10counter dut(.clk(clk), .rst(rst), .count(count), .load(load), .din(din));

    //clock generation :
    always #5 clk = ~clk;

    //Stimulus generation :
    initial begin
        error = 0;
        correct = 0;
        clk = 0;
        rst = 1'b0;
        load = 1'b0;
        din = 4'd10;
        #20; rst = 1'b1;
        //Count upto 9 and then fall back to count value to 0:
        #130; rst = 1'b0;
        //varing load value to check all worst cases of output:
        repeat(150)begin
            #30; load = ~load;
            #10; din = din + 1'b1;
        end
        //Randomize the input signal:
        repeat(200)begin
            rst = $random;
            load = $random;
            din = $random;
            #20;
        end
        #20; rst = 1'b0;
        #10;$finish;
    end

    //Simulation waveform:
    initial begin
        $dumpfile("mod10counter_wave.vcd");
        $dumpvars(0,mod10counter_test);
    end

    //Scoreboard evaluation :
        always@(posedge clk or negedge rst) begin
            //Testcase 1 : Reset high check count equal to zero
            if (rst == 1'b0)begin
			    if(count == 4'b0)
				    correct=correct+1;
			    else begin
                		error=error+1;
                		$display("ERROR!!! Testcase 1 : Reset high check count equal to zero");
            	end
    	    end
            //Testcase 2: Check count value (greater than or equal to 0) or (less than 10) 
            if (count >=4'd0) begin
			    if(count < 4'd10)
				    correct=correct+1;
			    else begin
              			error=error+1;
                		$display("ERROR!!! Testcase 2: Check count value (greater than or equal to 0) or (less than 10)");
            	end
	        end
            //Testcase 3: Load high or Low, din>10 or din<10, count == 4'b0 or count<4'd10
            if(load == 1'b1 && din>=4'd10)begin
			    if(count==4'd0)
				    correct=correct+1;
			    else begin
                		error=error+1;
                		$display("ERROR!!! Testcase 3_1: Load high , din>10, count == 4'b0");
            	end
	        end
	        else if(load == 1'b1 && din<4'd10)begin
			    if(count<4'd10)
				    correct=correct+1;
			    else begin
                		error=error+1;
                		$display("ERROR!!! Testcase 3_2: Load high , din<10, count < 4'b10");
            	end			
	        end
	        else begin
			    if(load == 1'b0)begin
				    if(count<4'd10)
					    correct=correct+1;
				    else begin
                			error=error+1;
                			$display("ERROR!!! Testcase 3_3: Load low ,count < 4'b10");
            	    end
			    end	
	        end
        end

    //Display output:
    initial begin
        $monitor("Rst=%b|Load=%b|Count=%d ||| Correct=%d | Error = %d",rst,load,count,correct,error); 
    end    

    endmodule 
