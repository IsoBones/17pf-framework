// Order of Battle and Safe-Start Script 
// using structured text to achieve the intended effect 

// server handles orbat state 
if (isDedicated) then {
	briefingPhase = true;
	publicVariable "briefingPhase";
	briefingStartTime = time;
	publicVariable "briefingStartTime";
};
