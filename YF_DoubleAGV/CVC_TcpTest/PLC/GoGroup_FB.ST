FUNCTION_BLOCK GoGroup_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR
 NAVINIT : NAVINIT_FB;
 LocalOrder : LocalOrder_FB;
 GroupRtrig : r_trig;
 MasterOnPoint : bool;
 ClientOnPoint : bool;
 state : dint;
 MasterFlag : bool;
 ClientFlag : bool;
END_VAR
(*
GroupRtrig(CLK:=NDC8.UserDefined.Boolean_25);

if GoGroup then

case state of
0:
	if NDC8.Vehicle.VehicleID=2 then
		state := 1;
		MasterFlag := false;
	end_if;
	if NDC8.Vehicle.VehicleID=3 then
		ClientFlag := false;
		state := 2;
	end_if;
	
1:
	if NDC8.Vehicle.VehicleID=2 and NDC8.LayoutPosition.InSystem and NDC8.VehicleControl.OperationMode=0 and NDC8.LayoutPosition.Point<>1 
		and not MasterFlag then
		NDC8.LocalOrder.DestPoint:=1;
		NDC8.LocalOrder.OpCode:=0;
		LocalOrder();
		if LocalOrder.Finished then
			MasterOnPoint := true;
			MasterFlag := true;	
			state := 3;		
		end_if;	
	elsif NDC8.Vehicle.VehicleID=2 and NDC8.LayoutPosition.InSystem and NDC8.VehicleControl.OperationMode=0 and NDC8.LayoutPosition.Point=1 then
		MasterOnPoint := true;
		state := 3;
	end_if;
	
2:	
	if NDC8.Vehicle.VehicleID=3 and NDC8.LayoutPosition.InSystem and NDC8.VehicleControl.OperationMode=0 and NDC8.LayoutPosition.Point<>3
		and not ClientFlag then
		NDC8.LocalOrder.DestPoint:=3;
		NDC8.LocalOrder.OpCode:=0;
		LocalOrder();
		if LocalOrder.Finished then
			ClientOnPoint := true;
			ClientFlag := true;
		end_if;	
	end_if;


end_case;
end_if;
*)


hhh'
;
END_FUNCTION_BLOCK