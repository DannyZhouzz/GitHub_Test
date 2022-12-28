PROGRAM ReplaceMe
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_GLOBAL
END_VAR

VAR
TcpPortSend : TcpPortSend_FB;
TcpPortReceive : TcpPortReceive_FB;
END_VAR


if NDC8.CanOpenMaster.NMTState=5 and NDC8.CanOpenMaster.State=0 then
	TcpPortReceive();
	TcpPortSend();
end_if;
END_PROGRAM