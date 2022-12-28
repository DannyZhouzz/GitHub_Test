FUNCTION_BLOCK VirDriverSendData_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
DriverSend_ValueByte:ARRAY[1..500] OF Byte;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT
Finish : bool;
END_VAR

VAR
HighDint : dint;
LowDint : dint;
END_VAR

if NDC8.Vehicle.VehicleID= 2 then (* Master Vehicle *)
	HighDint := abs(NDC8.UserDefined.VirFrontSetSpeed)/256;
	LowDint :=  abs(NDC8.UserDefined.VirFrontSetSpeed) - (HighDint*256);
	DriverSend_ValueByte[5] := dint_to_byte(HighDint);
	DriverSend_ValueByte[6] := dint_to_byte(LowDint);

	HighDint := abs(NDC8.UserDefined.VirFrontSetAngle)/256;
	LowDint :=  abs(NDC8.UserDefined.VirFrontSetAngle) - (HighDint*256);
	DriverSend_ValueByte[7] := dint_to_byte(HighDint);
	DriverSend_ValueByte[8] := dint_to_byte(LowDint);

	HighDint := abs(NDC8.UserDefined.VirRearSetSpeed)/256;
	LowDint :=  abs(NDC8.UserDefined.VirRearSetSpeed) - (HighDint*256);
	DriverSend_ValueByte[9] := dint_to_byte(HighDint);
	DriverSend_ValueByte[10] := dint_to_byte(LowDint);

	HighDint := abs(NDC8.UserDefined.VirRearSetAngle)/256;
	LowDint :=  abs(NDC8.UserDefined.VirRearSetAngle) - (HighDint*256);
	DriverSend_ValueByte[11] := dint_to_byte(HighDint);
	DriverSend_ValueByte[12] := dint_to_byte(LowDint);
	
	if NDC8.UserDefined.VirFrontSetSpeed<0 then
		DriverSend_ValueByte[13] := 1;
	else
		DriverSend_ValueByte[13] := 0;
	end_if;
	if NDC8.UserDefined.VirFrontSetAngle<0 then
		DriverSend_ValueByte[14] := 1;
	else
		DriverSend_ValueByte[14] := 0;
	end_if;
	if NDC8.UserDefined.VirRearSetSpeed<0 then
		DriverSend_ValueByte[15] := 1;
	else
		DriverSend_ValueByte[15] := 0;
	end_if;
	if NDC8.UserDefined.VirRearSetAngle<0 then
		DriverSend_ValueByte[16] := 1;
	else
		DriverSend_ValueByte[16] := 0;
	end_if;
	
elsif NDC8.Vehicle.VehicleID= 3 then (* Client Vehicle *)
	HighDint := abs(NDC8.UserDefined.FrontEncSpeed)/256;
	LowDint :=  abs(NDC8.UserDefined.FrontEncSpeed) - (HighDint*256);
	DriverSend_ValueByte[5] := dint_to_byte(HighDint);
	DriverSend_ValueByte[6] := dint_to_byte(LowDint);
	
	HighDint := abs(NDC8.UserDefined.FrontEncAngle)/256;
	LowDint :=  abs(NDC8.UserDefined.FrontEncAngle) - (HighDint*256);
	DriverSend_ValueByte[7] := dint_to_byte(HighDint);
	DriverSend_ValueByte[8] := dint_to_byte(LowDint);
	
	HighDint := abs(NDC8.UserDefined.RearEncSpeed)/256;
	LowDint :=  abs(NDC8.UserDefined.RearEncSpeed) - (HighDint*256);
	DriverSend_ValueByte[9] := dint_to_byte(HighDint);
	DriverSend_ValueByte[10] := dint_to_byte(LowDint);

	HighDint := abs(NDC8.UserDefined.RearEncAngle)/256;
	LowDint :=  abs(NDC8.UserDefined.RearEncAngle) - (HighDint*256);
	DriverSend_ValueByte[11] := dint_to_byte(HighDint);
	DriverSend_ValueByte[12] := dint_to_byte(LowDint);
	
	if NDC8.UserDefined.FrontEncSpeed<0 then
		DriverSend_ValueByte[13] := 1;
	else
		DriverSend_ValueByte[13] := 0;
	end_if;
	if NDC8.UserDefined.FrontEncAngle<0 then
		DriverSend_ValueByte[14] := 1;
	else
		DriverSend_ValueByte[14] := 0;
	end_if;
	if NDC8.UserDefined.RearEncSpeed<0 then
		DriverSend_ValueByte[15] := 1;
	else
		DriverSend_ValueByte[15] := 0;
	end_if;
	if NDC8.UserDefined.RearEncAngle<0 then
		DriverSend_ValueByte[16] := 1;
	else
		DriverSend_ValueByte[16] := 0;
	end_if;
	
end_if;

	Finish := true;


END_FUNCTION_BLOCK