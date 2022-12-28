FUNCTION_BLOCK TCP_DriverTrasfer_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
DriverSend_ValueByte:ARRAY[1..500] OF Byte;
DriverReceive_ValueByte:ARRAY[1..500] OF Byte;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR
serial_read : NDC8_SERIAL_READ;
serial_write : NDC8_SERIAL_WRITE;
StartDelayTon : TON;
StartDelay : BOOL;
init : BOOL;
TcpPortState : DINT;
ConvWord:WORD;			(*Sum of the two first bytes*)
ConvByteL:int;			(*Low byte*)
ConvByteH:int;			(*High byte*)
start_adress : int;
num_words : dint;
X: INT;
Y: INT;
Z: INT;
Index:DINT;
SendLength : int;
Function_Code : dint;
StartWriteTON : ton;
StartWrite : bool;
TcpPort_CRC : TcpPort_CRC_FB;
ReadData : ARRAY[1..32] OF BYTE;
ReadLength : int;
crclow : int;
crchigh : int;
CheckLength : uint;
initite : bool;
WriteData : Array[1..32] of Byte;
count : dint;

VirDriverSendData : VirDriverSendData_FB;
VirDriverReceiveData : VirDriverReceiveData_FB;
END_VAR

StartDelayTon(IN:=StartDelay,PT:=t#100ms);
StartWriteTON(IN:=StartWrite,PT:=t#50ms);

if not NDC8.UserDefined.Boolean_25 then
	TcpPortState := 0;
	TCP_OK := false;
end_if;

(* Always read COM7 to check if some information from Host *)
(*serial_read(port := 'COM7');*)

if not Init then
	serial_write.port := 'COM7';
	serial_read.port := 'COM7';
(*	serial_write.port := 'COM8';
	serial_read.port := 'COM8';*)
	Init := true;
end_if;

case TcpPortState of
0:
(*	StartDelay := true;
	if StartDelayTon.Q then
	TcpPortState := 50;
	StartDelay := false;
	end_if;*)
	TcpPortState := 50;

50:
	if NDC8.Vehicle.VehicleID=2 then
		TcpPortState := 1;
	elsif NDC8.Vehicle.VehicleID=3 then
		TcpPortState := 2;
	end_if;
	
1:   	
	WriteData[1] := 16#4A;
	WriteData[2] := 16#54;
	WriteData[3] := 16#03; (* Virtual Vehicle ID *)
	WriteData[4] := 16#03; (* Function Code *)
	VirDriverSendData();   (* Vir Vehicle speed and angle , data[5] to data[12] *)
	if VirDriverSendData.Finish then	
		Y := 5;
		X := 5;
		For Index:=1 to 6 By 1 Do
			WriteData[Y] := DriverSend_ValueByte[X];
			Y:=Y+1;
			X:=X+1;
			WriteData[Y] := DriverSend_ValueByte[X];
			Y:=Y+1;
			X:=X+1;
		end_for;
		CheckLength := 16;
		crclow := 17;
		crchigh := 18;
		TcpPort_CRC(cBuffer:=WriteData,CrcLength:=CheckLength);
		WriteData[crclow]:=TcpPort_CRC.CrcLow;
		WriteData[crchigh]:=TcpPort_CRC.CrcHigh;
		SendLength := 18;
		StartWrite := true;
		TcpPortState := 80;
	end_if;
	
80:
	(*serial_write(port := 'COM7');
	serial_write.length := dint_to_int(SendLength);*)
	if NDC8.UserDefined.Boolean_25 then	
		if StartWriteTON.Q then
			serial_write( port:='COM7',data:=WriteData,length:=SendLength );
			serial_write( port:='COM7',data:=WriteData,length:=0 );
			StartWrite := false;
			TcpPortState:=2;
		else
			TcpPortState:=2;
		end_if;
	else
		TcpPortState:=0;
	end_if;	
(*	if serial_write.sent<>0 then
		TcpPortState:=2;			
	end_if;	*)

2:
	serial_read(port := 'COM7');
	(* check data valid?is it matchs the vehicle? *)
	ReadLength := serial_read.length;
	ReadData := serial_read.data;
	if ReadLength >0 and ReadData[1]=16#4A and ReadData[2]=16#54
		and (NDC8.Vehicle.VehicleID = byte_to_dint(ReadData[3])) then
		if (byte_to_dint(ReadData[3])=3 or byte_to_dint(ReadData[3])=2) then
		TCP_OK := true;
		Count := 0;
		TcpPortState := 3;
		else
		Count := 0;
		TcpPortState := 3;
		end_if;
	else
		Count := Count + 1;
		if Count>10 or not NDC8.UserDefined.Boolean_25 then
			TCP_OK := false;
			Count := 0;
		end_if;
		TcpPortState := 0;
	end_if;
(*
30:
	serial_read(port := 'COM7');
	ReadLength := serial_read.length;
	ReadData := serial_read.data;
	if ReadLength >0 and ReadData[1]=16#4A and ReadData[2]=16#54
		and (NDC8.Vehicle.VehicleID = byte_to_dint(ReadData[3])) then
		TcpPortState := 3;
		TCP_OK := true;
	else
		TcpPortState := 0;
		TCP_OK := false;
	end_if;
*)
3:
	(* check the data read from Tcp Port is right or not *)
	crclow := ReadLength - 1;
	crchigh := ReadLength;
	CheckLength := int_to_uint(ReadLength - 2);
	TcpPort_CRC(cBuffer:=ReadData,CrcLength:=CheckLength);
	if ReadData[crclow]=TcpPort_CRC.CrcLow and ReadData[crchigh]=TcpPort_CRC.CrcHigh then
		TcpPortState := 4;
	else
		TcpPortState := 0;
	end_if;

4:
	Function_Code := byte_to_dint(ReadData[4]);
	case Function_Code of
	3: 
	(*	ISD_ValueByte_Read();
		if ISD_ValueByte_Read.finish then
		TcpPortState := 10;
		end_if;*)
		TcpPortState := 11;
   16:   						
  		TcpPortState := 20;
end_case;

20:
	(* reveive vie vehicle speed and angle *)
	Y := 5;
	X := 5;
	For Index:=1 to 6 By 1 Do
	DriverReceive_ValueByte[Y] := ReadData[X];
	Y:=Y+1;
	X:=X+1;
	DriverReceive_ValueByte[Y] := ReadData[X];
	Y:=Y+1;
	X:=X+1;
	end_for;
	VirDriverReceiveData();
	if VirDriverReceiveData.Finish then
		TcpPortState := 0;
	end_if;


11:
	Y := 5;
	X := 5;
	For Index:=1 to 6 By 1 Do
	DriverReceive_ValueByte[Y] := ReadData[X];
	Y:=Y+1;
	X:=X+1;
	DriverReceive_ValueByte[Y] := ReadData[X];
	Y:=Y+1;
	X:=X+1;
	end_for;
	VirDriverReceiveData();
	if VirDriverReceiveData.Finish then
		TcpPortState := 12;
	end_if;

12:
	WriteData[1] := 16#4A;
	WriteData[2] := 16#54;
	WriteData[3] := 16#02; (* Master Vehicle ID *)
	WriteData[4] := 16#10; (* Function Code, Virtual Vehicle return data to Master Vehicle *)
	VirDriverSendData();   (* Vir Vehicle speed and angle , data[5] to data[12] *)
	if VirDriverSendData.Finish then
		Y := 5;
		X := 5;
		For Index:=1 to 6 By 1 Do
			WriteData[Y] := DriverSend_ValueByte[X];
			Y:=Y+1;
			X:=X+1;
			WriteData[Y] := DriverSend_ValueByte[X];
			Y:=Y+1;
			X:=X+1;
		end_for;
		CheckLength := 16;
		crclow := 17;
		crchigh := 18;
		TcpPort_CRC(cBuffer:=WriteData,CrcLength:=CheckLength);
		WriteData[crclow]:=TcpPort_CRC.CrcLow;
		WriteData[crchigh]:=TcpPort_CRC.CrcHigh;
		SendLength := 18;
		StartWrite := true;
		TcpPortState := 81;
	end_if;
	
81:
	(*serial_write(port := 'COM7');
	serial_write.length := dint_to_int(SendLength);*)
	if StartWriteTON.Q then
		serial_write( port:='COM7',data:=WriteData,length:=SendLength );
		serial_write( port:='COM7',data:=WriteData,length:=0 );
		StartWrite := false;
		TcpPortState:=0;
	end_if;	
(*	if serial_write.sent<>0 then
		TcpPortState:=0;			
	end_if;*)
				
end_case;





















END_FUNCTION_BLOCK