FUNCTION_BLOCK TcpPort_CRC_FB
VAR_EXTERNAL

END_VAR

VAR_INPUT
cBuffer : ARRAY[1..100] of byte;
CrcLength : uint;
END_VAR

VAR_OUTPUT
CrcHigh: Byte;
CrcLow: Byte;
END_VAR

VAR
i,j : uint ;
wCrc : word ;
wPolynom : word ;
END_VAR
(**************************************************)
wCrc := 16#ffff;
wPolynom := 16#A001;

For I:=3 to CrcLength by 1 do
	wCrc := wCrc xor byte_to_word(cBuffer[I]);
	For J:=0 to 7 by 1 do
	
		if word_to_bool(wCrc and 16#0001) then
		(*if ROL(wCrc ,15) then*)
			wCrc := SHR(wCrc,1) xor wPolynom;
		else
			wCrc := SHR(wCrc,1);
		end_if;
		
	end_for;
end_for;
CrcLow := word_to_byte(wCrc);
CrcHigh := word_to_byte( SHR(wCrc,8)  );





END_FUNCTION_BLOCK