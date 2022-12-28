FUNCTION_BLOCK ClientModeSelect_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR
ClientVehicleControl : ClientVehicleControl_FB;
ClientCalControl : ClientCalControl_FB;
VirMode,CalMode : bool;
END_VAR

(* 两车组合信号起效且车辆ID等于系统写入的副车ID时，该车变为副车，响应主车的控制 *)
if NDC8.Vehicle.VehicleID=int_to_dint(NDC8.OMPLC.Data10) and MasterFlag=1 and NDC8.OMPLC.GroupFlag=1 then

	if VirMode then	(* 虚拟合体方式 *)
		ClientVehicleControl();
	elsif CalMode then	(* 独立路线跟随方式 *)
		ClientCalControl();
		NDC8.VehicleControl.SlowDown := true;
		if NDC8.SegmentTrigger.LeftTurn or NDC8.SegmentTrigger.RightTurn then
			if CalculateSpeed<80 then
				NDC8.VehicleControl.SlowDownSpeed:= 80;
			else
				NDC8.VehicleControl.SlowDownSpeed:= CalculateSpeed;
			end_if;
		else
			NDC8.VehicleControl.SlowDownSpeed:= MasterSetSpeed + CompenstateSpeed;
		end_if;
	end_if;
end_if;
END_FUNCTION_BLOCK