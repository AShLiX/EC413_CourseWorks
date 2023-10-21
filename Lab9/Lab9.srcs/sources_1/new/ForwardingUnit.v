`timescale 1ns / 1ps
module ForwardingUnit(OperandOneControl, OperandTwoControl, ID_EX_RegDest, ID_EX_MemWrite, ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd, EX_MEM_WB, MEM_WB_WB);

    output reg [1:0] OperandOneControl, OperandTwoControl;
    input ID_EX_RegDest, ID_EX_MemWrite;
    input [4:0] ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd;
    input EX_MEM_WB, MEM_WB_WB;
    
    initial begin
        OperandOneControl = 2'b00;
        OperandTwoControl = 2'b00;
    end
    
    always@(ID_EX_Rs or ID_EX_Rt or EX_MEM_Rd or MEM_WB_Rd or EX_MEM_WB or MEM_WB_WB)begin
        if (EX_MEM_Rd != 0 && EX_MEM_Rd == ID_EX_Rs && EX_MEM_WB) OperandOneControl = 2'b01;
        else if (MEM_WB_Rd != 0 && MEM_WB_Rd == ID_EX_Rs && MEM_WB_WB) OperandOneControl = 2'b10;
        else OperandOneControl = 2'b00;
        
        if (EX_MEM_Rd != 0 && EX_MEM_Rd == ID_EX_Rt)
        begin
            if (ID_EX_MemWrite || EX_MEM_WB) OperandTwoControl = 2'b01;
            else OperandTwoControl = 2'b00;
        end
        else if (MEM_WB_Rd != 0 && MEM_WB_Rd == ID_EX_Rt)
        begin
            if (ID_EX_MemWrite || MEM_WB_WB) OperandTwoControl = 2'b10;
            else OperandTwoControl = 2'b00;
        end
        else OperandTwoControl = 2'b00;
    end

endmodule
