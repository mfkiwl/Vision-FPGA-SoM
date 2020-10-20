/****************************************************************************
 Copyright (c) 2020 tinyVision.ai Inc.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice,
 this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its contributors
 may be used to endorse or promote products derived from this software
 without specific prior written permission.

 4. The Software/Firmware is used solely in conjunction with devices provided by
 tinyVision.ai Inc.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.

 For a license to use on non-tinyVision.ai Inc. hardware, please contact license@tinyvision.ai
*/

    /*
     Send out a single frame of known data for verification
     Assumes ROWS, COLS as defined constants
     */
task send_incr_frame;
    
        begin
            
            frame_vld = '0;
            line_vld = '0;
            pixel_dat = '0;
            $display("Starting image transfer");
            
            repeat (10) @(posedge pixel_clk);
            frame_vld = '1;
            
            repeat (5) @(posedge pixel_clk);
            
            repeat (ROWS) begin
                line_vld = '0;
                repeat (5) @(posedge pixel_clk);
                line_vld = '1;
                repeat (COLS) begin
                    pixel_dat = pixel_dat + 'd1;
                    @(posedge pixel_clk);
                end
                
                line_vld = '0;
                
            end
            repeat (10) @(posedge pixel_clk);
            frame_vld = '0;
        end
        
endtask // send_incr_frame