FUNCTION_BLOCK UPDATEFEEDBACK_FB
VAR_EXTERNAL
NDC8 : NDC8_T;
END_VAR

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR
TimerBlink : blink;
END_VAR


TimerBlink(CYCLE :=t#100ms,RUN:=true);

NDC8.UserDefined.VirFFeedbackSpeed := bool_to_dint(TimerBlink.Q1) + 1;
NDC8.UserDefined.VirRFeedbackSpeed := bool_to_dint(TimerBlink.Q1) + 1;
NDC8.UserDefined.VirFFeedbackAngle := bool_to_dint(TimerBlink.Q1) + 1;
NDC8.UserDefined.VirRFeedbackAngle := bool_to_dint(TimerBlink.Q1) + 1;

END_FUNCTION_BLOCK