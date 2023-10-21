module hazardunit(IFIDWrite,PCWrite,HazardMux, RegWrite, MemRead);

	output reg	IFIDWrite, PCWrite, HazardMux;
	input   RegWrite, MemRead;
	
	initial
	begin
		IFIDWrite = 1;
		PCWrite = 1;
		HazardMux = 0;
	end
	
	always@(RegWrite, MemRead)
	begin
	    if (RegWrite && MemRead)
	    begin
            IFIDWrite = 0;
            PCWrite = 0;
            HazardMux = 1;
	    end
	    else
	    begin
            IFIDWrite = 1;
            PCWrite = 1;
            HazardMux = 0;
	    end
	end

endmodule
