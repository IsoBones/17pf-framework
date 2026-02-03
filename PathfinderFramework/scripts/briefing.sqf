// Should contain:
// Platoon roster 
// General Information

// ===================================================================================================
/* Platoon Roster
	Adds squads to the map screen
	Full credits CPC-Skippy
	Modified for B|Tac by Jace, then further by Bones for the 17th Pathfinders
		(optional) Mission Maker can change groups name using :
		(group this) setGroupID ["Group Name"];
		on all units in the group
		(optional) Mission Maker can change groups color using :
		(group this) setVariable ["color",'#000000']; where 000000 can be changed to whatever hexa code
		You can set a custom name on one unit by doing
		this setVariable ["displayName","Noob #1"];
*/

private["_strRole","_strGrp","_strFinal","_oldGrp","_newGrp","_unitsArr"];

if (player diarySubjectExists "fp_squads") then {
	// systemChat "Diary Subject detected!";
	player removeDiarySubject "fp_squads";
};

// _strRank        = "";//will contain unit's rank
_strRole        = "";//will contain unit's role
_strGrp         = "";//will contain unit's group name
_strFinal       = "";//will contain final string to be displayed
_oldGrp         = grpNull;//group of last checked unit
_newGrp         = grpNull;//group of current unit
_unitsArr       = [];//will contain all units that have to be processed


_unitsArr = call CBA_fnc_players;

{
    if(side _x == side player) then {
        _newGrp = group _x;
        _strGrp = "";

		// switch(rankID _x) do {
		// 	case 0:{ _strRank = "Pvt. "; };
		// 	case 1:{ _strRank = "Cpl. "; };
		// 	case 2:{ _strRank = "Sgt. "; };
		// 	case 3:{ _strRank = "Lt.  "; };
		// 	case 4:{ _strRank = "Cpt. "; };
		// 	case 5:{ _strRank = "Maj. "; };
		// 	case 6:{ _strRank = "Col. "; };
		// 	default{ _strRank = "Pvt. "; };
		// };

		_strRole = " - " + (roleDescription _x);
		_strRole = _strRole splitString "@" select 0;

        if(_newGrp != _oldGrp) then {
            _strGrp = "<br/>" + (groupID(group _x)) + "<br/>";
        };

		

		// removed _strRank
        _strFinal =  _strFinal + "<font color='#FFFF9400'>"+_strGrp+"</font>" + 
		format ["%1%2",if (leader group _x == _x) then {" "}else{"   "}, name _x] + 
		_strRole + "<br/>";
        _oldGrp = group _x;
    };
} forEach _unitsArr;

// manual update button | To remove, just comment out the two lines beneath
_strUpdateButton = "<br/> <execute expression='call Pathfinder_fnc_briefing'>Update Roster</execute>";
_strFinal = _strFinal + _strUpdateButton;

player createDiarySubject ["fp_squads","Platoon Roster"];
player createDiaryRecord ["fp_squads",["Squads",_strFinal]];
