FUNCTION_BLOCK VirWheelControl_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR
TCP_DriverTrasfer : TCP_DriverTrasfer_FB;
END_VAR

if NDC8.UserDefined.Boolean_25 then
	TCP_DriverTrasfer();
	if NDC8.Vehicle.VehicleID=3 then
		NDC8.VehicleControl.PlcSelect := 1;
		NDC8.VehicleControl.PlcSelectMask := 15;
		NDC8.VehicleControl.PlcSetSteerEnable := 1;
		NDC8.VehicleControl.PlcSetDriveEnable := 1;
		
		NDC8.LS2000.NavActive := 0;
	(*	NDC8.Manual.PlcSelect := 1;
		NDC8.Manual.PlcSelectMask := 4;
		NDC8.Manual.PlcSetOperationMode := 1;*)
	(*	if NDC8.UserDefined.FrontSetAngle>11500 then
			NDC8.UserDefined.FrontSetAngle := NDC8.UserDefined.FrontSetAngle - 65792;
		end_if;
		if NDC8.UserDefined.RearSetAngle>11500 then
			NDC8.UserDefined.RearSetAngle := NDC8.UserDefined.RearSetAngle - 65792;
		end_if;
		if NDC8.UserDefined.FrontSetSpeed>1500 then
			NDC8.UserDefined.FrontSetSpeed := NDC8.UserDefined.FrontSetSpeed - 65792;
		end_if;
		if NDC8.UserDefined.RearSetSpeed>1500 then
			NDC8.UserDefined.RearSetSpeed := NDC8.UserDefined.RearSetSpeed - 65792;
		end_if;*)
		if TCP_OK then
			NDC8.FrontWheel.PlcSetSpeed := NDC8.UserDefined.FrontSetSpeed;
			NDC8.FrontWheel.PlcSetAngle := NDC8.UserDefined.FrontSetAngle;
			NDC8.RearWheel.PlcSetSpeed  := NDC8.UserDefined.RearSetSpeed;
			NDC8.RearWheel.PlcSetAngle  := NDC8.UserDefined.RearSetAngle;
		else
			NDC8.FrontWheel.PlcSetSpeed := 0;
			NDC8.RearWheel.PlcSetSpeed  := 0;
		end_if;
	end_if;
else
	NDC8.VehicleControl.PlcSelect := 0;
	NDC8.VehicleControl.PlcSelectMask := 0;
	NDC8.VehicleControl.PlcSetSteerEnable := 0;
	NDC8.VehicleControl.PlcSetDriveEnable := 0;
	
(*	NDC8.Manual.PlcSelect := 1;
	NDC8.Manual.PlcSelectMask := 4;
	NDC8.Manual.PlcSetOperationMode := 1;*)
	NDC8.LS2000.NavActive := 1;

	NDC8.UserDefined.VirFrontEncSpeed := NDC8.UserDefined.VirFrontSetSpeed - NDC8.UserDefined.VirFFeedbackSpeed;
	NDC8.UserDefined.VirFrontEncAngle := NDC8.UserDefined.VirFrontSetAngle - NDC8.UserDefined.VirFFeedbackAngle;
	NDC8.UserDefined.VirRearEncSpeed  := NDC8.UserDefined.VirRearSetSpeed - NDC8.UserDefined.VirRFeedbackSpeed;
	NDC8.UserDefined.VirRearEncAngle  := NDC8.UserDefined.VirRearSetAngle - NDC8.UserDefined.VirRFeedbackAngle;
end_if;









END_FUNCTION_BLOCK