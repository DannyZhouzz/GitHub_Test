FUNCTION_BLOCK ClientVehicleControl_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR

END_VAR

(* 两车组合信号起效且车辆ID等于系统写入的副车ID时，该车变为副车，响应主车的控制 *)
if NDC8.Vehicle.VehicleID=int_to_dint(NDC8.OMPLC.Data10) and MasterFlag=1 and NDC8.OMPLC.GroupFlag=1 then
	(* 使能驱动轮 *)
	NDC8.VehicleControl.PlcSelect := 1;
	NDC8.VehicleControl.PlcSelectMask := 15;
	NDC8.VehicleControl.PlcSetSteerEnable := 1;
	NDC8.VehicleControl.PlcSetDriveEnable := 1;	
	(* 关闭LS2000导航 *)
	NDC8.LS2000.NavActive := 0;

	if not HeartBeatTimeOut then (* 确保主副车通讯正常 *)
		NDC8.FrontWheel.PlcSetSpeed := MasterVirFrontSetSpeed;	(* 副车的两轮子速度/角度等于主车的虚拟两轮速度/角度 *)
		NDC8.FrontWheel.PlcSetAngle := MasterVirFrontSetAngle;
		NDC8.RearWheel.PlcSetSpeed  := MasterVirRearSetSpeed;
		NDC8.RearWheel.PlcSetAngle  := MasterVirRearSetAngle;
	else
		NDC8.FrontWheel.PlcSetSpeed := 0;
		NDC8.RearWheel.PlcSetSpeed  := 0;
	end_if;
	
else
	NDC8.VehicleControl.PlcSelect := 0;
	NDC8.VehicleControl.PlcSelectMask := 0;
	NDC8.VehicleControl.PlcSetSteerEnable := 0;
	NDC8.VehicleControl.PlcSetDriveEnable := 0;
	
	NDC8.LS2000.NavActive := 1;

	NDC8.UserDefined.VirFrontEncSpeed := NDC8.UserDefined.VirFrontSetSpeed - NDC8.UserDefined.VirFFeedbackSpeed;
	NDC8.UserDefined.VirFrontEncAngle := NDC8.UserDefined.VirFrontSetAngle - NDC8.UserDefined.VirFFeedbackAngle;
	NDC8.UserDefined.VirRearEncSpeed  := NDC8.UserDefined.VirRearSetSpeed - NDC8.UserDefined.VirRFeedbackSpeed;
	NDC8.UserDefined.VirRearEncAngle  := NDC8.UserDefined.VirRearSetAngle - NDC8.UserDefined.VirRFeedbackAngle;
end_if;
END_FUNCTION_BLOCK