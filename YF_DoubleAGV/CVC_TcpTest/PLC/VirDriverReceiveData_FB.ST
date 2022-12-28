FUNCTION_BLOCK VirDriverReceiveData_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
DriverReceive_ValueByte:ARRAY[1..500] OF Byte;
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
if NDC8.Vehicle.VehicleID=2 then (* Master Vehicle *)
	HighDint := byte_to_dint(DriverReceive_ValueByte[5]);
	LowDint  := byte_to_dint(DriverReceive_ValueByte[6]);
	if DriverReceive_ValueByte[13]=1 then
		NDC8.UserDefined.VirFrontEncSpeed := (HighDint*256 + LowDint) - NDC8.UserDefined.VirFFeedbackSpeed;
	else
		NDC8.UserDefined.VirFrontEncSpeed := -(HighDint*256 + LowDint) - NDC8.UserDefined.VirFFeedbackSpeed;
	end_if;

	HighDint := byte_to_dint(DriverReceive_ValueByte[7]);
	LowDint  := byte_to_dint(DriverReceive_ValueByte[8]);
	if DriverReceive_ValueByte[14]=1 then
		NDC8.UserDefined.VirFrontEncAngle := -(HighDint*256 + LowDint) - NDC8.UserDefined.VirFFeedbackAngle;
	else
		NDC8.UserDefined.VirFrontEncAngle := HighDint*256 + LowDint - NDC8.UserDefined.VirFFeedbackAngle;
	end_if;

	HighDint := byte_to_dint(DriverReceive_ValueByte[9]);
	LowDint  := byte_to_dint(DriverReceive_ValueByte[10]);
	if DriverReceive_ValueByte[15]=1 then
		NDC8.UserDefined.VirRearEncSpeed := HighDint*256 + LowDint - NDC8.UserDefined.VirRFeedbackSpeed;
	else
		NDC8.UserDefined.VirRearEncSpeed := -(HighDint*256 + LowDint) - NDC8.UserDefined.VirRFeedbackSpeed;
	end_if;

	HighDint := byte_to_dint(DriverReceive_ValueByte[11]);
	LowDint  := byte_to_dint(DriverReceive_ValueByte[12]);
	if DriverReceive_ValueByte[16]=1 then
		NDC8.UserDefined.VirRearEncAngle := -(HighDint*256 + LowDint) - NDC8.UserDefined.VirRFeedbackAngle;
	else
		NDC8.UserDefined.VirRearEncAngle := HighDint*256 + LowDint - NDC8.UserDefined.VirRFeedbackAngle;
	end_if;

elsif NDC8.Vehicle.VehicleID=3 then  (* Client Vehicle *)
	HighDint := byte_to_dint(DriverReceive_ValueByte[5]);
	LowDint  := byte_to_dint(DriverReceive_ValueByte[6]);
	if DriverReceive_ValueByte[13]=1 then
		NDC8.UserDefined.FrontSetSpeed := HighDint*256 + LowDint;
	else
		NDC8.UserDefined.FrontSetSpeed := -(HighDint*256 + LowDint);
	end_if;
	
	HighDint := byte_to_dint(DriverReceive_ValueByte[7]);
	LowDint  := byte_to_dint(DriverReceive_ValueByte[8]);
	if DriverReceive_ValueByte[14]=1 then
		NDC8.UserDefined.FrontSetAngle := -(HighDint*256 + LowDint);
	else
		NDC8.UserDefined.FrontSetAngle := HighDint*256 + LowDint;
	end_if;
	
	HighDint := byte_to_dint(DriverReceive_ValueByte[9]);
	LowDint  := byte_to_dint(DriverReceive_ValueByte[10]);
	if DriverReceive_ValueByte[15]=1 then
		NDC8.UserDefined.RearSetSpeed := HighDint*256 + LowDint;
	else
		NDC8.UserDefined.RearSetSpeed := -(HighDint*256 + LowDint);
	end_if;
	
	HighDint := byte_to_dint(DriverReceive_ValueByte[11]);
	LowDint  := byte_to_dint(DriverReceive_ValueByte[12]);
	if DriverReceive_ValueByte[16]=1 then
		NDC8.UserDefined.RearSetAngle := -(HighDint*256 + LowDint);
	else
		NDC8.UserDefined.RearSetAngle := HighDint*256 + LowDint;
	end_if;
end_if;

Finish := true;



END_FUNCTION_BLOCK