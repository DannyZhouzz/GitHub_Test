FUNCTION_BLOCK WheelXYControl_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR

END_VAR

if NDC8.UserDefined.Boolean_25 then
	if NDC8.Vehicle.VehicleID=2 then
		NDC8.FrontWheel.X := 1590;
		NDC8.FrontWheel.Y := 300;
		NDC8.RearWheel.X := 810;
		NDC8.RearWheel.Y := 300;
		NDC8.VirFrontWheel.X := -1590;
		NDC8.VirFrontWheel.Y := -300;
		NDC8.VirRearWheel.X := -810;
		NDC8.VirRearWheel.Y := -300;
		NDC8.LS2000.X := 1860;
	end_if;
else
	NDC8.FrontWheel.X := 390;
	NDC8.FrontWheel.Y := 300;
	NDC8.RearWheel.X := -390;
	NDC8.RearWheel.Y := 300;
	NDC8.VirFrontWheel.X := -1590;
	NDC8.VirFrontWheel.Y := -300;
	NDC8.VirRearWheel.X := -810;
	NDC8.VirRearWheel.Y := -300;
	NDC8.LS2000.X := 660;
end_if;



END_FUNCTION_BLOCK