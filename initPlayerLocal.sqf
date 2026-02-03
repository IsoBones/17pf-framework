sleep 1; //ensures players are not looking at the black screen still and allows the scheduled enviroment to keep up.
null = execVM "PathfinderFramework\scripts\vibeCheck.sqf"; // Blacklist mod checker
_updateBriefing = true;
call Pathfinder_fnc_briefing; // Will add mission info and platoon roster to player's map and diary.
null = execVM "PathfinderFramework\scripts\orbatLocal.sqf"; // Orbat runs locally to display unique info on each player's screen
[] spawn {
	while {true} do {
	call Pathfinder_fnc_briefing;
	
	sleep 20;
	};
};
// DO NOT TOUCH!
// ===================================================================================================
// add Zeus modules
["17PF Framework Functions", "End Briefing Phase", {missionNamespace setVariable ["briefingPhase", false, true];}] call zen_custom_modules_fnc_register;
["17PF Framework Functions", "Start Manual OCAP Recording", {["ocap_record"] call CBA_fnc_serverEvent;}] call zen_custom_modules_fnc_register;

// OTHER INITPLAYERLOCAL STUFF GOES UNDER THIS LINE
