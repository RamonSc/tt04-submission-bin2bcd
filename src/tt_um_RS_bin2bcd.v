`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module tt_um_RS_bin2bcd(    
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to 
    );
    
    wire reset = !rst_n; //use a positive logic reset
    wire [6:0] bin;
    reg [11:0] bcd;
    
    assign uio_oe[7:0] = 8'b11111111; //all bidirectional path used as outputs
    assign uo_out[1:0] = 2'd0; //no 7-segment used
    assign uo_out[7:6] = 1'd0;
    assign uo_out[5:2] = bcd[11:8]; //used in case of overflow  
    assign uio_out[7:0] = bcd[7:0];
    assign bin[6:0] = ui_in[6:0]; //only 7 bits are used
    
integer i;
	
always @(bin) begin
    bcd=0;		 	
    for (i=0;i<7;i=i+1) begin					//Iterate once for each bit in input number
        if (bcd[3:0] >= 5) 
            bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
        if (bcd[7:4] >= 5) 
            bcd[7:4] = bcd[7:4] + 3;
        if (bcd[11:8] >= 5) 
            bcd[11:8] = bcd[11:8] + 3;
        bcd = {bcd[10:0],bin[6-i]};				//Shift one bit, and shift in proper bit from input 
    end
end
endmodule
