`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module sim_bcd();

    reg clk, rst;
    reg [7:0] bin;
    wire [7:0] uo_out;
    wire [7:0] uio_in;
    wire [7:0] uio_oe,uio_out;
    
    tt_um_RS_bin2bcd bin2bcd (
        .clk(clk),
        .ui_in(bin),
        .rst_n(rst),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(1'd1)
    );
    
    always begin
        #5 
        clk = ~clk;
    end
    
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #1
        bin = 8'd3;
        #2
        bin = 8'd10;
        #2;
        bin = 8'd32;
        #2;
        bin = 8'd56;
        #2;
        bin = 8'd100;
        #2;
        bin = 8'd120;
    end
endmodule
