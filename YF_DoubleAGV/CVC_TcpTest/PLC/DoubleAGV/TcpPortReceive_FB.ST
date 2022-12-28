FUNCTION_BLOCK TcpPortReceive_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR
serial_read  : NDC8_SERIAL_READ;
TcpPort_CRC : TcpPort_CRC_FB;
PreMasterHeartBeat : dint;
NoHeartBeat : bool;
NoHeartBeatTon : ton;
Count1,index,Count2,TempIndex2,Count3,TempIndex3 : dint;
FirstLength,SecondLength,ThridLength : int;
END_VAR


serial_read(Port:='COM5');
if serial_read.Length>0 then
	Count1 := Count1 + 1;
	FirstLength := serial_read.Length;
	for index:=1 to 32 by 1 do
		TcpPortReceiveDataBytesAll[index] := serial_read.data[index];
	end_for;
end_if;

serial_read(Port:='COM5');
if serial_read.Length>0 then
	Count2 := Count2 + 1;
	SecondLength := serial_read.Length;
	for index:=1 to 32 by 1 do
		TempIndex2 := index + 32;
		TcpPortReceiveDataBytesAll[TempIndex2] := serial_read.data[index];
	end_for;
end_if;

TcpPort_CRC(cBuffer:=TcpPortReceiveDataBytesAll,CrcLength:=53);

if TcpPortReceiveDataBytesAll[1]=16#4A and TcpPortReceiveDataBytesAll[2]=16#54 
	and TcpPortReceiveDataBytesAll[54]=TcpPort_CRC.CrcLow and TcpPortReceiveDataBytesAll[55]=TcpPort_CRC.CrcHigh then
	
	MasterVehicleID := byte_to_dint(TcpPortReceiveDataBytesAll[3]);
	MasterTravelDir := byte_to_dint(TcpPortReceiveDataBytesAll[4]);

	MasterFrontSetSpeed	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[5])*256 + byte_to_int(TcpPortReceiveDataBytesAll[6]) );
	
	MasterFrontEncSpeed	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[7])*256 + byte_to_int(TcpPortReceiveDataBytesAll[8]) );
	
	MasterFrontSetAngle	:= int_to_dint( byte_to_int(TcpPortReceiveDataBytesAll[9])*256 + byte_to_int(TcpPortReceiveDataBytesAll[10]) );
	MasterFrontEncAngle	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[11])*256 + byte_to_int(TcpPortReceiveDataBytesAll[12]) );

	MasterRearSetSpeed	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[13])*256 + byte_to_int(TcpPortReceiveDataBytesAll[14]) );
	MasterRearEncSpeed	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[15])*256 + byte_to_int(TcpPortReceiveDataBytesAll[16]) );
	
	MasterRearSetAngle	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[17])*256 + byte_to_int(TcpPortReceiveDataBytesAll[18]) );
	MasterRearEncAngle	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[19])*256 + byte_to_int(TcpPortReceiveDataBytesAll[20]) );
	
	MasterVirFrontSetSpeed	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[21])*256 + byte_to_int(TcpPortReceiveDataBytesAll[22]) );
	MasterVirFrontEncSpeed	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[23])*256 + byte_to_int(TcpPortReceiveDataBytesAll[24]) );
	
	MasterVirFrontSetAngle	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[25])*256 + byte_to_int(TcpPortReceiveDataBytesAll[26]) );
	MasterVirFrontEncAngle	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[27])*256 + byte_to_int(TcpPortReceiveDataBytesAll[28]) );

	MasterVirRearSetSpeed	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[29])*256 + byte_to_int(TcpPortReceiveDataBytesAll[30]) );
	MasterVirRearEncSpeed	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[31])*256 + byte_to_int(TcpPortReceiveDataBytesAll[32]) );
	
	MasterVirRearSetAngle	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[33])*256 + byte_to_int(TcpPortReceiveDataBytesAll[34]) );
	MasterVirRearEncAngle	:= int_to_dint(byte_to_int(TcpPortReceiveDataBytesAll[35])*256 + byte_to_int(TcpPortReceiveDataBytesAll[36]) );
	
	MasterPositionX := byte_to_dint(TcpPortReceiveDataBytesAll[37])*167777216 + byte_to_dint(TcpPortReceiveDataBytesAll[38])*65536 
						+ byte_to_dint(TcpPortReceiveDataBytesAll[39])*256 + byte_to_dint(TcpPortReceiveDataBytesAll[40]) ;

	MasterPositionY := byte_to_dint(TcpPortReceiveDataBytesAll[41])*167777216 + byte_to_dint(TcpPortReceiveDataBytesAll[42])*65536 
						+ byte_to_dint(TcpPortReceiveDataBytesAll[43])*256 + byte_to_dint(TcpPortReceiveDataBytesAll[44]) ;
					
	MasterAngle2 := byte_to_dint(TcpPortReceiveDataBytesAll[45])*256 + byte_to_dint(TcpPortReceiveDataBytesAll[46]) ;				
					
	MasterOpCode  := byte_to_dint(TcpPortReceiveDataBytesAll[47]);
	MasterOpWorking  := byte_to_bool(TcpPortReceiveDataBytesAll[48]);
	
	MasterSetSpeed := byte_to_dint(TcpPortReceiveDataBytesAll[49])*256 + byte_to_dint(TcpPortReceiveDataBytesAll[50]) ;
	
	MasterFlag := byte_to_dint(TcpPortReceiveDataBytesAll[51]);
	
	MasterHeartBeat := byte_to_dint(TcpPortReceiveDataBytesAll[52]);
	
	MasterErrorStop := byte_to_bool(TcpPortReceiveDataBytesAll[53]);
		
end_if;

NoHeartBeat := MasterHeartBeat=PreMasterHeartBeat and MasterFlag=1 and NDC8.OMPLC.GroupFlag=1;
NoHeartBeatTon(IN:=NoHeartBeat,PT:=t#2s);
if NoHeartBeatTon.Q then
	HeartBeatTimeOut := true;
else
	HeartBeatTimeOut := false;
end_if;

PreMasterHeartBeat := MasterHeartBeat;

NDC8.UserDefined.HeartBeatTimeOut := HeartBeatTimeOut;
NDC8.UserDefined.MasterErrorStop := MasterErrorStop;


END_FUNCTION_BLOCK