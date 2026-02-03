// Order of Battle and Safe-Start Script 
// using structured text to achieve the intended effect 

//exits if Orbat is disabled in init.sqf or briefing phase is done
sleep 1;
if (isServer) exitWith {systemChat "Orbat is functioning, but disabled for singleplayer testing and non-dedicated servers."};
if (isNil "briefingPhase" || briefingPhase == false) exitWith {};

[ACE_player, currentWeapon ACE_player, true] call ace_safemode_fnc_setWeaponSafety;

[] spawn {
	// SET THE RADIO SETTING HERE | 1 = First squad is last channel in list. 2 = First squad is CH1. 3 = No CH set for any squad.
	_radioSetting = 1;
	/////////////////////////////////////
	_radioFreq = "Not Set"; // Debug value
	_initialRole = (roleDescription player) splitString "@" select 0;
	player setVariable ["loadoutRole", _initialRole];
	while {briefingPhase} do {
		// recalc every 5 seconds to adjust for updates/changes 
		private _playerName = name player;
		private _playerGroup = group player;
		private _groupName = groupId _playerGroup;
		private _squadLeader = name leader group player; 
		private _role = player getVariable ["loadoutRole","Not Set"]; 
		private _opName = briefingName; 
		private _terrain = worldName;
		private _currentTime = systemTime apply {if (_x < 10) then {"0" + str _x} else {str _x}};
		private _hours = _currentTime select 3; _minutes = _currentTime select 4;
		private _timeSys = _hours + ":" + _minutes;
		private _timeSinceBriefingStart = time - briefingStartTime;
		private _briefTime = (_timeSinceBriefingStart / 60) toFixed 0;
		private _gameHour = floor daytime;
		private _gameMinute = floor ((daytime - _gameHour) * 60);
		private _gameTime = format ["%1:%2", _gameHour, _gameMinute];


		switch (_radioSetting) do {
			case 1: { // Sets first squad to be last channel
				_playableGroups = [];        
				{
				_group = group _x;
				if !(_group in _playableGroups) then {
					_playableGroups set [count _playableGroups,_group];
				}
				} foreach playableunits;
				
				private _groupNum = _playableGroups find _playerGroup;
				if (_groupNum == 0) then {
				_groupNum = (count _playableGroups);
				};
				_radioFreq = _groupNum;
			};
			case 2: { // Set the radio freq based on the literal group number
				_playableGroups = [];        
				{
				_group = group _x;
				if !(_group in _playableGroups) then {
					_playableGroups set [count _playableGroups,_group];
				}
				} foreach playableunits;
				
				private _groupNum = _playableGroups find _playerGroup;
				_radioFreq = _groupNum + 1;
			};
			case 3: { // Does not set a frequency
				_radioFreq = "TBA";
				};
		};
		

		private _orbatString = "
<t font='PuristaBold'><t size='1.1'>BRIEF - %1 </t></t><br/>
<t font='PuristaMedium'><t align='left'>
Welcome, <t color='#FFFF9400'>%2</t>, to %3.<br/><br/>


<t align='center'><t size='1.1'>Briefing phase is underway!<br/></t></t>
<t align='center'><t size='1.0'>Your local time is <t color='#FFFF9400'>%4</t>. <br/></t>
<t align='center'><t size='1.0'>In-mission local time is <t color='#FFFF9400'>%10</t>. <br/></t>
<t size='0.8'>It has been <t color='#FFFF9400'>%5 minutes</t> since briefing began.<br/><br/></t>

Your Squad Leader is <t color='#FFFF9400'>%6</t>, listen to their instructions.<br/><br/>

<t font='PuristaBold'>Squad Callsign:
<t color='#FFFF9400'><t align='right'>%7 </t></t><br/>
<t align='left'>Your Role:</t>
<t color='#FFFF9400'><t align='right'>%8 </t></t><br/>
<t align='left'>Assigned Channel:</t>
<t align='right'><t color='#FFFF9400'>Ch: %9 </t></t><br/>
</t><br/><br/>

<t font='PuristaLight'><t size='0.7'>Mission Framework V0.4 - 01/07/2025</t></t><br/>
<t font='PuristaLight'><t size='0.6'>Original shared with the 17th Pathfinders by Jace at B|Tac!</t></t>
";

// 		private _situationBrief = "<br/><br/>
// <t font='PuristaBold'><t align='centre'><t size='1.2'SITUATION</t></t>
// <t font='PuristaMedium'>
// <t align='left'>Date:</t>
// <t color='#FFFF9400'><t align='right'>%10</t></t><br/>

// </t>";

// 		if (_includeSituation) then {
// 			_orbatString = _orbatString + _situationBrief;
// 		};

		hintSilent parseText format [
			_orbatString, 
			_opName, //%1
			_playerName, //%2
			_terrain, //%3
			_timeSys, //%4
			_briefTime, //%5
			_squadLeader, //%6
			_groupName, //%7
			_role, //%8
			_radioFreq, //%9
			_gameTime //%10
			//_date, //%10
			//_bluforFaction, //%11
			//_opforFaction //%12
			
		];

		sleep 5;
	};

	hint parseText "<t font='PuristaBold'><t size='1.2'><t color='#FFFF9400'>BRIEFING COMPLETE</t><br/></t>
	<t font='PuristaMedium'>Operation Starting!</t></t></t>";

	[ACE_player, currentWeapon ACE_player, false] call ace_safemode_fnc_setWeaponSafety;
};
