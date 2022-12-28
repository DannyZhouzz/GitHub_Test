FUNCTION_BLOCK ClientReceiveData_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR
serial_read  : NDC8_SERIAL_READ;
TcpPort_CRC : TcpPort_CRC_FB;
MasterVehicleID : dint;
MasterTravelDir : dint;
MasterTractionEncSpeed : dint;
MasterPositionX : dint;
MasterPositionY : dint;
MasterDistOpPoint : dint;
MasterOpCode : dint;
ClientDistOpPoint : dint;
DevDist: dint;
SpeedScale : real; 
TestValue: dint;
Count,CountValue : dint;
SpeedTemp : dint;
PreMasterPositionX : dint;
MasterRemainDis : dint;
PreDevDist : dint;
P_Scale,D_Scale : real;
MasterFlag : dint;
PreMasterPositionY : dint;
MasterAngle : dint;
IdevDist : dint;
I_Scale : real;
PI : real;
PP : real;
VirX : dint;
PP_DINT,PI_DINT : dint;
Flag : bool;
OverCount : dint;
Icount : dint;
ClientRemainDis : dint;
PreClientPositionX : dint;
PreClientPositionY : dint;
DevPercent,P_DevPercent_Scale,PP_DevPercent : real;
DevRemainDis : dint;
PP_Curve,P_Curve_Scale,PI_Curve,I_Curve_Scale : real;
PP_Curve_DINT,PI_Curve_DINT : dint;
CalSetAddSpeed : dint;
MasterTractionSetSpeed : dint;
ShouldRemainDis : dint;
PreMasterRemainDis,PreClientRemainDis : dint;
TxtValue : real;
PreDevRemainDis,DdevDist,PD_Curve_DINT : dint;
PD_Curve,D_Curve_Scale : real;

PreHeartBeatClient : dint;
NoHeartBeat : bool;
HeartBeatTimeOut : ton;
ClientX,DevX,PreDevX,V1,T2,ClientY,DevY,DevAngle : dint;
T1,HuDu : REAL;

SendData : Array[1..32] of Byte;
tempHigh_X,tempHigh_Y,tempHigh_MX,tempHigh_MY,tempHigh_CX,tempHigh_CY : dint;
serial_write  : NDC8_SERIAL_WRITE;
FlagCount : dint;
AngleScale : real;
MasterAngle2 : dint;
VV1 : real;
END_VAR

serial_read(Port:='COM5');

TcpPort_CRC(cBuffer:=serial_read.Data,CrcLength:=28);

if serial_read.Data[1]=16#4A and serial_read.Data[2]=16#54 
	and serial_read.Data[29]=TcpPort_CRC.CrcLow and serial_read.Data[30]=TcpPort_CRC.CrcHigh then

	MasterVehicleID := byte_to_dint(serial_read.Data[3]);

	MasterTravelDir := byte_to_dint(serial_read.Data[4]);

	MasterTractionEncSpeed := byte_to_dint(serial_read.Data[5])*256 + byte_to_dint(serial_read.Data[6]) ;

	MasterPositionX := byte_to_dint(serial_read.Data[7])*167777216 + byte_to_dint(serial_read.Data[8])*65536 
						+ byte_to_dint(serial_read.Data[9])*256 + byte_to_dint(serial_read.Data[10]) + VirX;

	MasterPositionY := byte_to_dint(serial_read.Data[11])*167777216 + byte_to_dint(serial_read.Data[12])*65536 
						+ byte_to_dint(serial_read.Data[13])*256 + byte_to_dint(serial_read.Data[14]) ;
					
	MasterDistOpPoint := byte_to_dint(serial_read.Data[15])*256 + byte_to_dint(serial_read.Data[16]) ;

	MasterOpCode  := byte_to_dint(serial_read.Data[17]);
	
	MasterRemainDis := byte_to_dint(serial_read.Data[18])*256 + byte_to_dint(serial_read.Data[19]) ;
	
	MasterFlag := byte_to_dint(serial_read.Data[20]);
	
	MasterTractionSetSpeed := byte_to_dint(serial_read.Data[21])*256 + byte_to_dint(serial_read.Data[22]) ;
	
	HeartBeatClient := byte_to_dint(serial_read.Data[23]);
	
	AErrorStop := byte_to_bool(serial_read.Data[24]);
	
	MasterAngle := byte_to_dint(serial_read.Data[25])*256 + byte_to_dint(serial_read.Data[26]) ;

	MasterAngle2 := byte_to_dint(serial_read.Data[27])*256 + byte_to_dint(serial_read.Data[28]) ;	
end_if;

(*if NDC8.OMPLC.Data91=1 and MasterFlag=1 then
	if HeartBeatClient=1 then
		HeartBeatMaster := 0;
	elsif HeartBeatClient=0 then
		HeartBeatMaster := 1;
	end_if;

	PreHeartBeatClient := HeartBeatClient;

	NoHeartBeat := (PreHeartBeatClient=HeartBeatClient);
	HeartBeatTimeOut(IN:=NoHeartBeat,PT:=t#1s);
	StopHeartBeatTimeOut := HeartBeatTimeOut.Q;
end_if;*)


if NDC8.OMPLC.Data91=1 and MasterFlag=1 then

	if NDC8.SegmentTrigger.LeftTurn or NDC8.SegmentTrigger.RightTurn then
		FlagCount := 1;
		
		if dint_to_real(MasterAngle2)/100.0>=(180.0-VV1) and dint_to_real(MasterAngle2)/100.0<=(180.0+VV1) then
			AngleScale := (9496.0/5752.0 - 1.0)/VV1 * abs(abs((dint_to_real(MasterAngle2)/100.0-180.0))-VV1);
		elsif dint_to_real(MasterAngle2)/100.0>=(270.0-VV1) and dint_to_real(MasterAngle2)/100.0<=(270.0+VV1) then
			AngleScale := (9496.0/5752.0 - 1.0)/VV1 * abs(abs((dint_to_real(MasterAngle2)/100.0-270.0))-VV1);
		else
			AngleScale := 0.0;
		end_if;
							
		SetAddSpeed := real_to_dint(dint_to_real(MasterTractionSetSpeed)*9496.0/5752.0/(1.0+AngleScale));			
								
		ClientX := real_to_dint(sin(dint_to_real(MasterAngle)*3.14159/180.0)*2367.0) + MasterPositionX;
		
		if MasterAngle>=90 and MasterAngle<=270 and NDC8.VehicleControl.TravelDir=1 then			
			DevX := NDC8.Position.X - ClientX;
		elsif MasterAngle>=90 and MasterAngle<=270 and NDC8.VehicleControl.TravelDir=0 then
			DevX := ClientX - NDC8.Position.X;
		elsif (MasterAngle<90 or MasterAngle>270) and NDC8.VehicleControl.TravelDir=1 then
			DevX := ClientX - NDC8.Position.X;
		elsif (MasterAngle<90 or MasterAngle>270) and NDC8.VehicleControl.TravelDir=0 then
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
		
		SetAddSpeed := SetAddSpeed + real_to_dint(PP_Curve+PI_Curve+PD_Curve) ;
		SetAddSpeed := MIN(NDC8.Vehicle.MaxSpeed,SetAddSpeed);
						
						
		SendData[1] := 16#4A;
		SendData[2] := 16#54;				
		tempHigh_X := NDC8.Position.X / 65536;
		SendData[3] := word_to_byte(SHR(dint_to_word(tempHigh_X),8));
		SendData[4] := dint_to_byte(tempHigh_X);
		SendData[5] := word_to_byte(SHR(dint_to_word(NDC8.Position.X),8));
		SendData[6] := dint_to_byte(NDC8.Position.X);

		tempHigh_Y := NDC8.Position.Y / 65536;
		SendData[7] := word_to_byte(SHR(dint_to_word(tempHigh_Y),8));
		SendData[8] := dint_to_byte(tempHigh_Y);
		SendData[9] := word_to_byte(SHR(dint_to_word(NDC8.Position.Y),8));
		SendData[10] := dint_to_byte(NDC8.Position.Y);				
						
		tempHigh_MX := MasterPositionX / 65536;
		SendData[11] := word_to_byte(SHR(dint_to_word(tempHigh_MX),8));
		SendData[12] := dint_to_byte(tempHigh_MX);
		SendData[13] := word_to_byte(SHR(dint_to_word(MasterPositionX),8));
		SendData[14] := dint_to_byte(MasterPositionX);

		tempHigh_MY := MasterPositionY / 65536;
		SendData[15] := word_to_byte(SHR(dint_to_word(tempHigh_MY),8));
		SendData[16] := dint_to_byte(tempHigh_MY);
		SendData[17] := word_to_byte(SHR(dint_to_word(MasterPositionY),8));
		SendData[18] := dint_to_byte(MasterPositionY);	
		
		tempHigh_CX := ClientX / 65536;
		SendData[19] := word_to_byte(SHR(dint_to_word(tempHigh_CX),8));
		SendData[20] := dint_to_byte(tempHigh_CX);
		SendData[21] := word_to_byte(SHR(dint_to_word(ClientX),8));
		SendData[22] := dint_to_byte(ClientX);

	(*	tempHigh_CY := ClientY / 65536;
		SendData[23] := word_to_byte(SHR(dint_to_word(tempHigh_CY),8));
		SendData[24] := dint_to_byte(tempHigh_CY);
		SendData[25] := word_to_byte(SHR(dint_to_word(ClientY),8));
		SendData[26] := dint_to_byte(ClientY);			*)
		SendData[23] := word_to_byte(SHR(dint_to_word(MasterAngle),8));
		SendData[24] := dint_to_byte(MasterAngle);
		SendData[25] := word_to_byte(SHR(dint_to_word(NDC8.Position.Angle),8));
		SendData[26] := dint_to_byte(NDC8.Position.Angle);
			
		
		SendData[27] := word_to_byte(SHR(dint_to_word(DevX),8));
		SendData[28] := dint_to_byte(DevX);
		
		SendData[29] := word_to_byte(SHR(dint_to_word(SetAddSpeed),8));
		SendData[30] := dint_to_byte(SetAddSpeed);
						
		serial_write( port:='COM5',data:=SendData,length:=30 );		
						
					
	(*	a:= TRACE_DINT('DevX',DevX);	
		a:= TRACE_DINT('ClientX',ClientX);
		a:= TRACE_DINT('ClientY',ClientY);
		a:= TRACE_DINT('NDC8.Position.X',NDC8.Position.X);
		a:= TRACE_DINT('NDC8.Position.Y',NDC8.Position.Y);
		a:= TRACE_DINT('NDC8.Position.Angle',NDC8.Position.Angle);
		a:= TRACE_DINT('MasterPositionX',MasterPositionX);
		a:= TRACE_DINT('MasterPositionY',MasterPositionY);		
		a:= TRACE_DINT('MasterAngle',MasterAngle);
		a:= TRACE_DINT('ClientRemainDis',NDC8.LayoutPosition.RemainingDistance);
		a:= TRACE_DINT('MasterRemainDis',MasterRemainDis);
		a:= TRACE_DINT('DevRemainDis',DevRemainDis);
		a:= TRACE_DINT('ShouldRemainDis',ShouldRemainDis);
		a:= TRACE_DINT('PP_Curve_DINT',PP_Curve_DINT);
		a:= TRACE_DINT('PI_Curve_DINT',PI_Curve_DINT);
		a:= TRACE_DINT('SetAddSpeed',SetAddSpeed);
		a:= TRACE_DINT('CalSetAddSpeed',CalSetAddSpeed);
		a:= TRACE_DINT('MasterTractionSetSpeed',MasterTractionSetSpeed);
		a:= TRACE_DINT('MasterTractionEncSpeed',MasterTractionEncSpeed);
		a:= TRACE_DINT('ClientEncSpeed',NDC8.UserDefined.TractionEncSpeed);
		a:= TRACE_DINT('ClientSetSpeed',NDC8.UserDefined.TractionSetSpeed);*)
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
		
		if NDC8.SegmentTrigger.GateOpen then
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
		
		else	
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
		
(*	a:= TRACE_DINT('OverCount',OverCount);	
	a:= TRACE_DINT('PreDevDist',PreDevDist);
	a:= TRACE_DINT('DevDist',DevDist);
	a:= TRACE_DINT('NDC8.Position.X',NDC8.Position.X);
	a:= TRACE_DINT('MasterPositionX',MasterPositionX);
	a:= TRACE_DINT('NDC8.Position.Y',NDC8.Position.Y);
	a:= TRACE_DINT('MasterPositionY',MasterPositionY);	*)
	
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

	SetAddSpeed := real_to_dint(PP + PI) ;
	
(*	PP_DINT := real_to_dint(PP);
	PI_DINT := real_to_dint(PI);
	a:= TRACE_DINT('PP',PP_DINT);
	a:= TRACE_DINT('PI',PI_DINT);*)
(*	SetAddSpeed := real_to_dint(P_Scale*dint_to_real(DevDist) + D_Scale*dint_to_real(DevDist - PreDevDist) );*)	
(*	SetAddSpeed := real_to_dint(P_Scale*dint_to_real(DevDist) + D_Scale*dint_to_real(DevDist - PreDevDist)  + PI  );*)

(*	SetAddSpeed := MasterTractionEncSpeed + real_to_dint(P_Scale*dint_to_real(DevDist) + D_Scale*dint_to_real(DevDist - PreDevDist) );*)

	
(*	a:= TRACE_DINT('MasterTractionEncSpeed',MasterTractionEncSpeed);
	a:= TRACE_DINT('ClientEncSpeed',NDC8.UserDefined.TractionEncSpeed);
	a:= TRACE_DINT('SetAddSpeed',SetAddSpeed);*)	
		
	end_if;
else
	Flag := false;
	Icount := 0;
	OverCount := 0;
	PreDevDist := 0;
	DevDist := 0;
	DevRemainDis := 0;
	SetAddSpeed := 0;
end_if;















END_FUNCTION_BLOCK