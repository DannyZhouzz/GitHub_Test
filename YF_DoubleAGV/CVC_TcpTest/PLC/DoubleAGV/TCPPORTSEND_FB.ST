FUNCTION_BLOCK TCPPORTSEND_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR
serial_write  : NDC8_SERIAL_WRITE;
TcpPort_CRC : TcpPort_CRC_FB;
tempHigh_X,tempHigh_Y,HeartBeat : dint;
ErrorStop,OperationWorking : bool;
index,index1,index2 : dint;
END_VAR


TcpPortSendDataBytesHead[1] := 16#4A;
TcpPortSendDataBytesHead[2] := 16#54;

TcpPortSendDataBytes1[1] := dint_to_byte(NDC8.Vehicle.VehicleID);

TcpPortSendDataBytes1[2] := dint_to_byte(NDC8.VehicleControl.TravelDir);

TcpPortSendDataBytes1[3] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.FrontSetSpeed),8));
TcpPortSendDataBytes1[4] := dint_to_byte(NDC8.UserDefined.FrontSetSpeed);

TcpPortSendDataBytes1[5] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.FrontEncSpeed),8));
TcpPortSendDataBytes1[6] := dint_to_byte(NDC8.UserDefined.FrontEncSpeed);

TcpPortSendDataBytes1[7] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.FrontSetAngle),8));
TcpPortSendDataBytes1[8] := dint_to_byte(NDC8.UserDefined.FrontSetAngle);

TcpPortSendDataBytes1[9] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.FrontEncAngle),8));
TcpPortSendDataBytes1[10] := dint_to_byte(NDC8.UserDefined.FrontEncAngle);

TcpPortSendDataBytes1[11] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.RearSetSpeed),8));
TcpPortSendDataBytes1[12] := dint_to_byte(NDC8.UserDefined.RearSetSpeed);

TcpPortSendDataBytes1[13] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.RearEncSpeed),8));
TcpPortSendDataBytes1[14] := dint_to_byte(NDC8.UserDefined.RearEncSpeed);

TcpPortSendDataBytes1[15] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.RearSetAngle),8));
TcpPortSendDataBytes1[16] := dint_to_byte(NDC8.UserDefined.RearSetAngle);

TcpPortSendDataBytes1[17] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.RearEncAngle),8));
TcpPortSendDataBytes1[18] := dint_to_byte(NDC8.UserDefined.RearEncAngle);

TcpPortSendDataBytes1[19] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.VirFrontSetSpeed),8));
TcpPortSendDataBytes1[20] := dint_to_byte(NDC8.UserDefined.VirFrontSetSpeed);

TcpPortSendDataBytes1[21] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.VirFrontEncSpeed),8));
TcpPortSendDataBytes1[22] := dint_to_byte(NDC8.UserDefined.VirFrontEncSpeed);

TcpPortSendDataBytes1[23] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.VirFrontSetAngle),8));
TcpPortSendDataBytes1[24] := dint_to_byte(NDC8.UserDefined.VirFrontSetAngle);

TcpPortSendDataBytes1[25] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.VirFrontEncAngle),8));
TcpPortSendDataBytes1[26] := dint_to_byte(NDC8.UserDefined.VirFrontEncAngle);

TcpPortSendDataBytes1[27] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.VirRearSetSpeed),8));
TcpPortSendDataBytes1[28] := dint_to_byte(NDC8.UserDefined.VirRearSetSpeed);

TcpPortSendDataBytes1[29] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.VirRearEncSpeed),8));
TcpPortSendDataBytes1[30] := dint_to_byte(NDC8.UserDefined.VirRearEncSpeed);

TcpPortSendDataBytes1[31] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.VirRearSetAngle),8));
TcpPortSendDataBytes1[32] := dint_to_byte(NDC8.UserDefined.VirRearSetAngle);


TcpPortSendDataBytes2[1] := word_to_byte(SHR(dint_to_word(NDC8.UserDefined.VirRearEncAngle),8));
TcpPortSendDataBytes2[2] := dint_to_byte(NDC8.UserDefined.VirRearEncAngle);


tempHigh_X := NDC8.Position.X / 65536;
TcpPortSendDataBytes2[3] := word_to_byte(SHR(dint_to_word(tempHigh_X),8));
TcpPortSendDataBytes2[4] := dint_to_byte(tempHigh_X);
TcpPortSendDataBytes2[5] := word_to_byte(SHR(dint_to_word(NDC8.Position.X),8));
TcpPortSendDataBytes2[6] := dint_to_byte(NDC8.Position.X);

tempHigh_Y := NDC8.Position.Y / 65536;
TcpPortSendDataBytes2[7] := word_to_byte(SHR(dint_to_word(tempHigh_Y),8));
TcpPortSendDataBytes2[8] := dint_to_byte(tempHigh_Y);
TcpPortSendDataBytes2[9] := word_to_byte(SHR(dint_to_word(NDC8.Position.Y),8));
TcpPortSendDataBytes2[10] := dint_to_byte(NDC8.Position.Y);

TcpPortSendDataBytes2[11] := word_to_byte(SHR(dint_to_word(NDC8.Position.Angle2),8));
TcpPortSendDataBytes2[12] := dint_to_byte(NDC8.Position.Angle2);

TcpPortSendDataBytes2[13] := dint_to_byte(NDC8.LoadOperation.OperationCode);
TcpPortSendDataBytes2[14] := bool_to_byte(OperationWorking);

TcpPortSendDataBytes2[15] := word_to_byte(SHR(dint_to_word(NDC8.VehicleControl.SetSpeed),8));
TcpPortSendDataBytes2[16] := dint_to_byte(NDC8.VehicleControl.SetSpeed);

TcpPortSendDataBytes2[17] := int_to_byte(NDC8.OMPLC.GroupFlag);

TcpPortSendDataBytes2[18] := dint_to_byte(HeartBeat);

TcpPortSendDataBytes2[19] := bool_to_byte(ErrorStop);


For index:=1 to 2 by 1 do
	TcpPortSendDataBytesAll[index] := TcpPortSendDataBytesHead[index];
end_for;

For index:=3 to 34 by 1 do
	index1 := index - 2 ;
	TcpPortSendDataBytesAll[index] := TcpPortSendDataBytes1[index1];
end_for;

For index:=35 to 53 by 1 do
	index2 := index - 34 ;
	TcpPortSendDataBytesAll[index] := TcpPortSendDataBytes2[index2];
end_for;


TcpPort_CRC(cBuffer:=TcpPortSendDataBytesAll,CrcLength:=53);
TcpPortSendDataBytesCrc[1] := TcpPort_CRC.CrcLow;
TcpPortSendDataBytesCrc[2] := TcpPort_CRC.CrcHigh;

serial_write( port:='COM5',data:=TcpPortSendDataBytesHead,length:=2 );
serial_write( port:='COM5',data:=TcpPortSendDataBytes1,length:=32 );
serial_write( port:='COM5',data:=TcpPortSendDataBytes2,length:=19 );
serial_write( port:='COM5',data:=TcpPortSendDataBytesCrc,length:=2 );
serial_write( port:='COM5',data:=TcpPortSendDataBytesHead,length:=0 );


if HeartBeat=0 then
	HeartBeat := 1;
elsif HeartBeat=1 then
	HeartBeat := 0;
end_if;

ErrorStop := NDC8.VehicleControl.Stop or NDC8.VehicleControl.EStop or NDC8.VehicleControl.QuickStop
				or NDC8.CanOpenMaster.NMTState<>5 or NDC8.CanOpenMaster.State<>0 ;

(*OperationWorking := OUTPUT.PlatRaise and NDC8.VehicleControl.OperationMode=0;*)





END_FUNCTION_BLOCK