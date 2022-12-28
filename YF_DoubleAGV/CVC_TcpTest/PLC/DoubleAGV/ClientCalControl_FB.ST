FUNCTION_BLOCK ClientCalControl_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR
DevDist,IdevDist,Icount,PreDevDist: dint;
P_Scale,I_Scale,D_Scale : real;
PP,PI,PD : real;
P_Curve_Scale,I_Curve_Scale,D_Curve_Scale : real;
PP_Curve,PI_Curve,PD_Curve : real;
FlagCount,OverCount : dint;
Flag : bool;
DevX,PreDevX,DdevDist,ClientX : dint;
PreMasterPositionX,PreMasterPositionY,PreClientPositionX,PreClientPositionY : dint;
AngleScale : real;
END_VAR


if NDC8.OMPLC.GroupFlag=1 and MasterFlag=1 then

	if NDC8.SegmentTrigger.LeftTurn or NDC8.SegmentTrigger.RightTurn then
		FlagCount := 1;
		
	(*	if dint_to_real(MasterAngle2)/100.0>=(180.0-VV1) and dint_to_real(MasterAngle2)/100.0<=(180.0+VV1) then
			AngleScale := (9496.0/5752.0 - 1.0)/VV1 * abs(abs((dint_to_real(MasterAngle2)/100.0-180.0))-VV1);
		elsif dint_to_real(MasterAngle2)/100.0>=(270.0-VV1) and dint_to_real(MasterAngle2)/100.0<=(270.0+VV1) then
			AngleScale := (9496.0/5752.0 - 1.0)/VV1 * abs(abs((dint_to_real(MasterAngle2)/100.0-270.0))-VV1);
		else
			AngleScale := 0.0;
		end_if;
		
		if NDC8.SegmentTrigger.Value=1 then
			SegmentAngle := 0;
			if dint_to_real(MasterAngle2)/100.0>=(360.0-VV1) and dint_to_real(MasterAngle2)/100.0<=(0.0+VV1) then
				AngleScale := (9496.0/5752.0 - 1.0)/VV1 * abs(abs((dint_to_real(MasterAngle2)/100.0-180.0))-VV1);
			elsif dint_to_real(MasterAngle2)/100.0>=(90.0-VV1) and dint_to_real(MasterAngle2)/100.0<=(90.0+VV1) then
				AngleScale := (9496.0/5752.0 - 1.0)/VV1 * abs(abs((dint_to_real(MasterAngle2)/100.0-270.0))-VV1);
			else
				AngleScale := 0.0;
			end_if;
		elsif NDC8.SegmentTrigger.Value=2 then
			SegmentAngle := 90;
		elsif NDC8.SegmentTrigger.Value=3 then
			SegmentAngle := 180;
		elsif NDC8.SegmentTrigger.Value=4 then
			SegmentAngle := 270;
		end_if;
		
		if dint_to_real(MasterAngle2)/100.0>=(180.0-VV1) and dint_to_real(MasterAngle2)/100.0<=(180.0+VV1) then
			AngleScale := (9496.0/5752.0 - 1.0)/VV1 * abs(abs((dint_to_real(MasterAngle2)/100.0-180.0))-VV1);
		elsif dint_to_real(MasterAngle2)/100.0>=(270.0-VV1) and dint_to_real(MasterAngle2)/100.0<=(270.0+VV1) then
			AngleScale := (9496.0/5752.0 - 1.0)/VV1 * abs(abs((dint_to_real(MasterAngle2)/100.0-270.0))-VV1);
		else
			AngleScale := 0.0;
		end_if;*)
		
							
		CalculateSpeed := real_to_dint(dint_to_real(MasterSetSpeed)*9496.0/5752.0/(1.0+AngleScale));			
								
		ClientX := real_to_dint(sin(dint_to_real(MasterAngle2)/100.0*3.14159/180.0)*2367.0) + MasterPositionX;
		
		if MasterAngle2>=9000 and MasterAngle2<=27000 and NDC8.VehicleControl.TravelDir=1 then			
			DevX := NDC8.Position.X - ClientX;
		elsif MasterAngle2>=9000 and MasterAngle2<=27000 and NDC8.VehicleControl.TravelDir=0 then
			DevX := ClientX - NDC8.Position.X;
		elsif (MasterAngle2<9000 or MasterAngle2>27000) and NDC8.VehicleControl.TravelDir=1 then
			DevX := ClientX - NDC8.Position.X;
		elsif (MasterAngle2<9000 or MasterAngle2>27000) and NDC8.VehicleControl.TravelDir=0 then
			DevX := NDC8.Position.X - ClientX;
		end_if;
		
(* --------------------------------PID Adjustment------------------------------------------------- *)
		(* P Adjust *)
		P_Curve_Scale := 0.65;
		PP_Curve := P_Curve_Scale * dint_to_real(DevX);
		if PP_Curve<-150.0 then
			PP_Curve := -150.0;
		elsif PP_Curve>150.0 then
			PP_Curve := 150.0;
		end_if;
		(* I Adjust *)								
		if (abs(DevX) > 30)  or Icount > 10 then			
			IdevDist := 0;		
			Icount := 0;
		else
			IdevDist := DevX + IdevDist;	
			Icount := Icount + 1;
		end_if;
		I_Curve_Scale := 0.1;				
  		PI_Curve := I_Curve_Scale*dint_to_real(IdevDist);
		if PI_Curve<-20.0 then
			PI_Curve := -20.0;
		elsif PI_Curve>20.0 then
			PI_Curve := 20.0;
		end_if;
			
		(* D Adjust *)			
		if abs(DevX) < 20 then
			DdevDist := DdevDist + DevX - PreDevX ;
		else
			DdevDist := 0;
		end_if;
		PreDevX := DevX;		
		PD_Curve := D_Curve_Scale*dint_to_real(DdevDist);
(* --------------------------------PID Adjustment------------------------------------------------- *)	
		
		CalculateSpeed := CalculateSpeed + real_to_dint(PP_Curve+PI_Curve+PD_Curve) ;
		CalculateSpeed := MIN(NDC8.Vehicle.MaxSpeed,CalculateSpeed);
									
	else
	
(*	if NDC8.SegmentTrigger.GateOpen then
		if MasterPositionY=PreMasterPositionY then
			;
		else	
	 		DevDist := NDC8.Position.Y - MasterPositionY + 4367;
			PreMasterPositionY := MasterPositionY;
		end_if;
	else
		if MasterPositionX=PreMasterPositionX then
			;
		else	
	 		DevDist := NDC8.Position.X - MasterPositionX;
			PreMasterPositionX := MasterPositionX;
		end_if;
	end_if;*)
		
		if NDC8.SegmentTrigger.DirectionY then	(* 两车Y轴方向行驶 *)
			FlagCount := 2;
			if MasterPositionY=PreMasterPositionY then
				;
			else	
				if (NDC8.Position.Y-PreClientPositionY)<=0 and (MasterPositionY-PreMasterPositionY)<0 then					
			 		DevDist := NDC8.Position.Y - MasterPositionY;
				elsif (NDC8.Position.Y-PreClientPositionY)>=0 and (MasterPositionY-PreMasterPositionY)>0 then
					DevDist := MasterPositionY - NDC8.Position.Y;
				end_if;

				if not Flag then
					Flag := true;
				else
					if abs(DevDist-PreDevDist) > 10 then
						if OverCount > 0 then
							;
						else
					  		DevDist := PreDevDist;
					   	    OverCount := OverCount + 1;
						end_if;
					else
						OverCount := 0;
					end_if;
				end_if;
				PreMasterPositionY := MasterPositionY;
				PreClientPositionY := NDC8.Position.Y;
			end_if;			
		else (* 两车X轴方向行驶 *)	
			FlagCount := 3;
			if MasterPositionX=PreMasterPositionX then
				;
			else	
				if (NDC8.Position.X-PreClientPositionX)<=0 and (MasterPositionX-PreMasterPositionX)<0 then					
			 		DevDist := NDC8.Position.X - MasterPositionX;
				elsif (NDC8.Position.X-PreClientPositionX)>=0 and (MasterPositionX-PreMasterPositionX)>0 then
					DevDist := MasterPositionX - NDC8.Position.X;
				end_if;
		
				if not Flag then
					Flag := true;
				else
					if abs(DevDist-PreDevDist) > 10 then
						if OverCount > 0 then
							;
						else
						   DevDist := PreDevDist;
						   OverCount := OverCount + 1;
						end_if;
					else
						OverCount := 0;
					end_if;
				end_if;
		
				PreMasterPositionX := MasterPositionX;
				PreClientPositionX := NDC8.Position.X;
			end_if;	
	end_if;
	PreDevDist := DevDist;
	
(* --------------------------------PID Adjustment------------------------------------------------- *)	
	(* P Adjust *)
	P_Scale := 0.55;
	PP := P_Scale*dint_to_real(DevDist);
	if PP<-150.0 then
		PP := -150.0;
	elsif PP>150.0 then
		PP := 150.0;
	end_if;
	(* I Adjust *)
	if abs(DevDist) > 10 or Icount > 10 then			
		IdevDist := 0;		
		Icount := 0;
	else
		IdevDist := DevDist + IdevDist;	
		Icount := Icount + 1;
	end_if;
	I_Scale := 0.1;
	PI := I_Scale*dint_to_real(IdevDist);
	if PI<-10.0 then
		PI := -10.0;
	elsif PI>10.0 then
		PI := 10.0;
	end_if;
(* --------------------------------PID Adjustment------------------------------------------------- *)

	CompenstateSpeed := real_to_dint(PP + PI) ;
	end_if;
else
	Flag := false;
	Icount := 0;
	OverCount := 0;
	PreDevDist := 0;
	DevDist := 0;
	DevX := 0;
	CompenstateSpeed := 0;
	CalculateSpeed := 0;
end_if;


















END_FUNCTION_BLOCK