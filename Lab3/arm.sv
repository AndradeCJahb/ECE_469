//	Christopher Andrade, Brayden Lam
// 5/3/2024
// EE/CSE 469
// Lab 3
	
/* arm is the spotlight of the show and contains the bulk of the datapath and control logic. This module is split into two parts, the datapath and control. 
*/

// clk - system clock
// rst - system reset
// InstrD - incoming 32 bit InstrDuction from imem, contains opcode, condition, addresses and or immediates
// ReadData - data read out of the dmem
// WriteData - data to be written to the dmem
// MemWrite - write enable to allowed WriteData to overwrite an existing dmem word
// PC - the current program count value, goes to imem to fetch InstrDuciton
// ALUResultE - result of the ALU operation, sent as address to the dmem

module arm (
    input  logic        clk, rst,
    input  logic [31:0] Instr,
    input  logic [31:0] ReadData,
    output logic [31:0] WriteData, 
    output logic [31:0] PCF, ALUResult,
    output logic        MemWrite
);

// datapath buses and signals
    logic [31:0] PCPrime, PCPlus4F, PCPlus8D, PCTrack; // pc signals
    logic [ 3:0] RA1D, RA2D, RA1E, RA2E;                  // regfile input addresses
    logic [31:0] RD1D, RD2D, RD1E, RD2E, RD1DPrime, RD2DPrime;                  // raw regfile outputs
    logic [ 3:0] ALUFlags;                  // alu combinational flag outputs
    logic [31:0] ExtImmD, ExtImmE, SrcAE, SrcBE;        // immediate and alu inputs 
    logic [31:0] ResultW;                    // computed or fetched value to be written into regfile or pc
	 logic [31:0] InstrF, InstrD;
	 logic [31:0] WriteDataE, WriteDataM;
	 logic [3:0] WA3D, WA3E, WA3M, WA3W;
	 logic [31:0] ALUResultE;
	 logic [31:0] ALUOutM, ALUOutW;
	 logic [31:0] ReadDataM, ReadDataW;

    // control signals
    logic PCSrcD, PCSrcE, PCSrcM, PCSrcW;
	 logic MemtoRegD, MemtoRegE, MemtoRegM, MemtoRegW; 
	 logic ALUSrcD, ALUSrcE;
	 logic RegWriteD, RegWriteE, RegWriteM, RegWriteW;
	 logic MemWriteD, MemWriteE, MemWriteM;
    logic [1:0] RegSrcD, ImmSrcD, ALUControlD, ALUControlE;
	 
	 logic [3:0] FlagsReg, FlagsE;
	 logic FlagWriteD, FlagWriteE;
	 logic BranchD, BranchE, BranchTakenE, CondExE;
	 logic [3:0] CondE;
	 
	 // Hazard Unit Signals
	 logic Match_1E_M, Match_2E_M, Match_1E_W, Match_2E_W;
	 logic Match_12D_E, ldrstallD, StallF, StallD;
	 logic FlushD, FlushE;
	 logic PCWrPendingF;
	 logic [1:0] ForwardAE, ForwardBE;
	 
    /* The datapath consists of a PC as well as a series of muxes to make decisions about which data words to pass forward and operate on. It is 
    ** noticeably missing the register file and alu, which you will fill in using the modules made in lab 1. To correctly match up signals to the 
    ** ports of the register file and alu take some time to study and understand the logic and flow of the datapath.
    */
    //-------------------------------------------------------------------------------
    //                                      DATAPATH
    //-------------------------------------------------------------------------------

	 assign InstrF = Instr; // updated for lab 3
    assign PCPrime = BranchTakenE ? ALUResultE : PCTrack;	// mux, use either default or newly computed value
    assign PCPlus4F = PCF + 'd4;                 	// default value to access next InstrDuction
    assign PCPlus8D = PCPlus4F;							// value read when reading from reg[15]
	 assign PCTrack = PCSrcW ? ResultW : PCPlus4F;
	 assign WA3D = InstrD[15:12];
	 
    // update the PC, at rst initialize to 0
    always_ff @(posedge clk) begin
        if (rst) PCF <= '0;
		  else if (StallF) PCF <= PCF;
        else     PCF <= PCPrime;
    end

    // determine the register addresses based on control signals
    // RegSrc[0] is set if doing a branch Instruction
    // RefSrc[1] is set when doing memory Instructions
    assign RA1D = RegSrcD[0] ? 4'd15        : InstrD[19:16];
    assign RA2D = RegSrcD[1] ? WA3D : InstrD[ 3: 0];
	 
    // Instantiation of RegFile which contains different registers manipulated by Assembly InstrDuctions.
    reg_file u_reg_file (
        .clk       (~clk), 
        .wr_en     (RegWriteW),
        .write_data(ResultW),
        .write_addr(WA3W),
        .read_addr1(RA1D), 
        .read_addr2(RA2D),
        .read_data1(RD1D), 
        .read_data2(RD2D)
    );

    // two muxes, put together into an always_comb for clarity
    // determines which set of InstrDuction bits are used for the immediate
    always_comb begin
        if      (ImmSrcD == 'b00) 	ExtImmD = {{24{InstrD[7]}},InstrD[7:0]};          // 8 bit immediate - reg operations
        else if (ImmSrcD == 'b01) 	ExtImmD = {20'b0, InstrD[11:0]};                 // 12 bit immediate - mem operations
        else                     	ExtImmD = {{6{InstrD[23]}}, InstrD[23:0], 2'b00}; // 24 bit immediate - branch operation
    end

	 assign RD1DPrime = (RA1D == 'd15) ? PCPlus8D : RD1D; // substitute the 15th regfile register for PC
	 assign RD2DPrime = (RA2D == 'd15) ? PCPlus8D : RD2D; // substitute the 15th regfile register for PC 

    // WriteData and SrcA are direct outputs of the register file, wheras SrcB is chosen between reg file output and the immediate
//    assign RD2D 		= (RA2D == 'd15) 		? PCPlus8D : RD2D;           // substitute the 15th regfile register for PC 
//    assign RD1D     	= (RA1D == 'd15)		? PCPlus8D : RD1D;           // substitute the 15th regfile register for PC 
//    assign SrcBE     = ALUSrcE       	 	? ExtImmE : WriteDataE;     // determine alu operand to be either from reg file or from immediate

    // instantiation of an ALU implementation
    alu u_alu (
        .a          (SrcAE), 
        .b          (SrcBE),
        .ALUControl (ALUControlE),
        .Result     (ALUResultE),
        .ALUFlags   (ALUFlags)
    );

	 // MUX Selection
	 
    // determine the result to run back to PC or the register file based on whether we used a memory InstrDuction
    assign ResultW = MemtoRegW ? ReadDataW : ALUOutW;    // determine whether final writeback result is from dmemory or alu
	 
	 always_comb begin 
			FlagsReg = ALUFlags;
			BranchTakenE = (BranchE & CondExE);
	 end
	 
	 // Output signals for data memory 
	 always_comb begin 
			WriteData = WriteDataM;
			ReadDataM = ReadData;
			MemWrite = MemWriteM;
			ALUResult = ALUOutM;
	 end
	 
	 // F -> D 
    always_ff @(posedge clk) begin
		  if (rst | FlushD) InstrD <= 'b?;
        else if (StallD & FlushD) InstrD <= 'b?;
		  else if (StallD & ~FlushD) InstrD <= InstrD;
		  else InstrD <= InstrF;
    end
	 
	 // D -> E 
    always_ff @(posedge clk) begin
		  if (rst | FlushE) begin 
			   RA1E <= 0;
				RA2E <= 0;
				RD1E <= 0;
				RD2E <= 0;
				ExtImmE <= 0;
				WA3E <= 0;
				PCSrcE <= 0;
				MemtoRegE <= 0;
				MemWriteE <= 0;
				RegWriteE <= 0;
				ALUControlE <= 0;
				ALUSrcE <= 0;
				FlagWriteE <= 0;
				FlagsE <= 0;
				CondE <= 0;
				BranchE <= 0;
		  end
		 else begin
				RA1E <= RA1D;
				RA2E <= RA2D;
				RD1E <= RD1DPrime;
				RD2E <= RD2DPrime;
				ExtImmE <= ExtImmD;
				WA3E <= WA3D;
				PCSrcE <= PCSrcD;
				MemtoRegE <= MemtoRegD;
				MemWriteE <= MemWriteD;
				RegWriteE <= RegWriteD;
				ALUControlE <= ALUControlD;
				ALUSrcE <= ALUSrcD;
				FlagWriteE <= FlagWriteD;
				CondE <= InstrD[31:28];
				BranchE <= BranchD;
				if (FlagWriteE) FlagsE <= FlagsReg;
				end
		  end
		
	 
	 // E -> M 
    always_ff @(posedge clk) begin
		  if (rst) begin 
				ALUOutM <= 0;
				WriteDataM <= 0;
				WA3M <= 0;
				PCSrcM <= 0;
				MemtoRegM <= 0;
				MemWriteM <= 0;
				RegWriteM <= 0;
		  end 
		  else begin 
				ALUOutM <= ALUResultE;
				WriteDataM <= WriteDataE;
				WA3M <= WA3E;
				PCSrcM <= (PCSrcE & CondExE);
				MemtoRegM <= MemtoRegE;
				MemWriteM <= (MemWriteE & CondExE);
				RegWriteM <= (RegWriteE & CondExE);
		  end
	 end
	 
	 // M -> W 
    always_ff @(posedge clk) begin
		  if (rst) begin 
				WA3W <= 0;
				ALUOutW <= 0;
				ReadDataW <= 0;
				PCSrcW <= 0;
				MemtoRegW <= 0;
				RegWriteW <= 0;
		  end 
		  else begin 
				WA3W <= WA3M;
				ALUOutW <= ALUOutM;
				ReadDataW <= ReadDataM;
				PCSrcW <= PCSrcM;
				MemtoRegW <= MemtoRegM;
				RegWriteW <= RegWriteM;
    end
	end
	
	 // Forwarding logic based off of muxes and looks at two outputs, 
	 // SrcAE, and WriteDataE, which come from register file, and 
	 // SrcBE is either from reg file or immediate
	 always_comb begin 
			if (ForwardAE == 'b00) SrcAE = RD1E;
			else if (ForwardAE == 'b01) SrcAE = ResultW;
			else SrcAE = ALUOutM;
			
			if (ForwardBE == 'b00) WriteDataE = RD2E;
			else if (ForwardBE == 'b01) WriteDataE = ResultW;
			else WriteDataE = ALUOutM;
			SrcBE = ALUSrcE ? ExtImmE : WriteDataE;
	 end
	 
    /* The control conists of a large decoder, which evaluates the top bits of the InstrDuction and produces the control bits 
    ** which become the select bits and write enables of the system. The write enables (RegWrite, MemWrite and PCSrc) are 
    ** especially important because they are representative of your processors current state. 
    */
    //-------------------------------------------------------------------------------
    //                                      CONTROL
    //-------------------------------------------------------------------------------
	 
    always_comb begin
		// Case to determine if conditional is true based on previously Stored ALU flags and first 4 bits of InstrDuction.
	 	case ( CondE )
			4'b1110 : CondExE = 1'b1;
			4'b0000 : CondExE = FlagsE[2];
			4'b0001 : CondExE = !FlagsE[2];
			4'b1010 : CondExE = !(FlagsE[3] ^ FlagsE[0]);
			4'b1100 : CondExE = !FlagsE[2] & !(FlagsE[3] ^ FlagsE[0]);
			4'b1101 : CondExE = FlagsE[2] | (FlagsE[3] ^ FlagsE[0]);
			4'b1011 : CondExE = FlagsE[3] ^ FlagsE[0];
			default : CondExE = 1'b0;
		endcase
		
      casez (InstrD[27:20])
            // ADD (Imm or Reg)
            8'b00?_0100_0 : begin   // note that we use wildcard "?" in bit 25. That bit decides whether we use immediate or reg, but regardless we add
                PCSrcD    		= 0;
                MemtoRegD 		= 0; 
                MemWriteD 		= 0; 
                ALUSrcD   		= InstrD[25]; // may use immediate
                RegWriteD 		= 	1;
                RegSrcD   		= 'b00;
                ImmSrcD   		= 'b00; 
                ALUControlD	= 'b00;
					 FlagWriteD		= 0;
					 BranchD = 0;
            end

            // SUB (Imm or Reg)
            8'b00?_0010_? : begin   // note that we use wildcard "?" in bit 25. That bit decides whether we use immediate or reg, but regardless we sub
                PCSrcD    		= 0; 
                MemtoRegD 		= 0; 
                MemWriteD 		= 0; 
                ALUSrcD   		= InstrD[25]; // may use immediate
                RegWriteD 		= 1;
                RegSrcD   		= 'b00;
                ImmSrcD   		= 'b00; 
                ALUControlD 	= 'b01;
					 FlagWriteD 	= InstrD[20];
					 BranchD = 0;
            end

            // AND
            8'b000_0000_0 : begin
                PCSrcD    		= 0; 
                MemtoRegD 		= 0; 
                MemWriteD 		= 0; 
                ALUSrcD   		= 0; 
                RegWriteD 		= 1;
                RegSrcD   		= 'b00;
                ImmSrcD   		= 'b00;    // doesn't matter
                ALUControlD	= 'b10;  
					 FlagWriteD 	= 0;
					 BranchD = 0;
            end

            // ORR
            8'b000_1100_0 : begin
                PCSrcD    		= 0; 
                MemtoRegD 		= 0; 
                MemWriteD 		= 0; 
                ALUSrcD   		= 0; 
                RegWriteD 		= 1;
                RegSrcD   		= 'b00;
                ImmSrcD   		= 'b00;    // doesn't matter
                ALUControlD 	= 'b11;
					 FlagWriteD 	= 0;
					 BranchD = 0;
            end

            // LDR
            8'b010_1100_1 : begin
                PCSrcD    		= 0; 
                MemtoRegD 		= 1; 
                MemWriteD 		= 0; 
                ALUSrcD   		= 1;
                RegWriteD 		= 1;
                RegSrcD   		= 'b10;    // msb doesn't matter
                ImmSrcD   		= 'b01; 
                ALUControlD 	= 'b00;  // do an add
					 FlagWriteD		= 0;
					 BranchD = 0;
            end

            // STR
            8'b010_1100_0 : begin
                PCSrcD    		= 0; 
                MemtoRegD 		= 0; // doesn't matter
                MemWriteD 		= 1; 
                ALUSrcD   		= 1;
                RegWriteD		= 0;
                RegSrcD   		= 'b10;    // msb doesn't matter
                ImmSrcD   		= 'b01; 
                ALUControlD 	= 'b00;  // do an add
					 FlagWriteD 	= 0;
					 BranchD = 0;
            end

            // B
            8'b1010_???? : begin
					// Successful Branch
					if ( CondExE ) begin
						PCSrcD    		= 1; 
                  MemtoRegD 		= 0;
                  MemWriteD 		= 0; 
                  ALUSrcD   		= 1;
                  RegWriteD 		= 0;
                  RegSrcD   		= 'b01;
                  ImmSrcD   		= 'b10; 
                  ALUControlD		= 'b00;  // do an add		
						FlagWriteD 		= 0;
						BranchD = 1;
					end
					// Unsuccessful Branch
               else begin
						// Unasserting Logic to ignore InstrDuction
						MemWriteD 	= 0;
						RegWriteD 	= 0;
						PCSrcD 		= 0;
						FlagWriteD 	= 0;
						
						ALUSrcD   	= 1;
						MemtoRegD 	= 0;
						RegSrcD   	= 'b01;
                  ImmSrcD   	= 'b10; 
                  ALUControlD = 'b00;	// do an add
						BranchD = 0;
					end
				end
			default: begin
						  PCSrcD    	= 0; 
                    MemtoRegD 	= 0; // doesn't matter
                    MemWriteD 	= 0; 
                    ALUSrcD   	= 0;
                    RegWriteD 	= 0;
                    RegSrcD   	= 'b00;
                    ImmSrcD   	= 'b00; 
                    ALUControlD 	= 'b00;  // do an add
						  FlagWriteD	= 0;
						  BranchD 		= 0;
			end
        endcase
    end
	 
	 // Hazard Unit
	 always_comb begin 
			Match_1E_M = (RA1E == WA3M);
			Match_2E_M = (RA2E == WA3M);
			Match_1E_W = (RA1E == WA3W);
			Match_2E_W = (RA2E == WA3W);
			Match_12D_E = (RA1D == WA3E) | (RA2D == WA3E);
			
		   ldrstallD = Match_12D_E & MemtoRegE;
			PCWrPendingF = PCSrcD | PCSrcE | PCSrcM;
			
			StallF = ldrstallD | PCWrPendingF;
			StallD = ldrstallD;
			
			FlushD = PCWrPendingF | PCSrcW | BranchTakenE;
			FlushE = ldrstallD | BranchTakenE;
			
			if (Match_1E_M & RegWriteM) ForwardAE = 'b10;
			else if (Match_1E_W & RegWriteW) ForwardAE = 'b01;
			else ForwardAE = 'b00;
			
			if (Match_2E_M & RegWriteM) ForwardBE = 'b10;
			else if (Match_2E_W & RegWriteW) ForwardBE = 'b01;
			else ForwardBE = 'b00;
	 end
endmodule
