module RAM
(
	CLK,

	EN1,
	WR1,
	DIN1,
	DOUT1,
	ADDR1,

	EN2,
	WR2,
	DIN2,
	DOUT2,
	ADDR2
);

parameter	WIDTH	=32;	//WITH of the RAM blocks
parameter	SIZE	=4096;	//SIZE of the RAM this case 4K Double Words
parameter	ADDRBITS   =12;	//Number of bits of the address register

input	CLK; 
input	WR1, WR2; 
input	EN1, EN2;

input	        [31:0] DIN1, DIN2;
output	[31:0] DOUT1, DOUT2;
reg	        [31:0] DOUT1, DOUT2;

input	        [ADDRBITS-1:0] ADDR1, ADDR2;

reg	        [WIDTH-1:0] MEM[0:SIZE-1];

integer i;

initial
begin
	MEM[0]=32'h1208_1234;
	for(i=1; i<SIZE; i = i + 1 )
	begin
		MEM[i] = i;
	end
	
	//$readmemh( "ram_contents.hex", MEM);
end

always @ (posedge CLK)
begin
	if(EN1)
	begin
		if(WR1)		
		begin
			MEM[ADDR1]<=DIN1;
		end
		DOUT1<=MEM[ADDR1];
		
		//DOUT<=32'hDEADCAFE;
	end
end

always @ (posedge CLK)
begin
	if(EN2)
	begin
		if(WR2)		
		begin
			MEM[ADDR2]<=DIN2;
		end
		DOUT2<=MEM[ADDR2];
		
		//DOUT<=32'hDEADCAFE;
	end
end

endmodule