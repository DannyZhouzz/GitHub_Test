FUNCTION_BLOCK SMControl_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR

END_VAR

if NDC8.OMPLC.Data1=1 then
	NDC8.UserDefined.Boolean_25 := true;
	if NDC8.Vehicle.VehicleID=2 then
		if TCP_OK and MasterOnInitOK then
			NDC8.OMPLC.Data3 := 1;
		else
			NDC8.OMPLC.Data3 := 0;
		end_if;
	elsif NDC8.Vehicle.VehicleID=3 then
		if TCP_OK then
			NDC8.OMPLC.Data3 := 1;
		else
			NDC8.OMPLC.Data3 := 0;
		end_if;
	end_if;
elsif NDC8.OMPLC.Data1=2 then
	NDC8.UserDefined.Boolean_25 := false;
	if NDC8.Vehicle.VehicleID=2 then
		if not NDC8.UserDefined.Boolean_25 and MasterOffInitOK then
			NDC8.OMPLC.Data3 := 1;
		else
			NDC8.OMPLC.Data3 := 0;
		end_if;
	elsif NDC8.Vehicle.VehicleID=3 then
		if not TCP_OK and ClientOffInitOK then
			NDC8.OMPLC.Data3 := 1;
		else
			NDC8.OMPLC.Data3 := 0;
		end_if;
	end_if;
end_if;




END_FUNCTION_BLOCK