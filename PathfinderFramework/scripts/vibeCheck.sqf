//vibeCheck.sqf
[]spawn {
// List of [CfgPatches name, Human-readable name] pairs
private _blacklistedMods = [
    ["diwako_dui_main", "DUI Squad Radar"],
    ["BaBe_EM", "Enhanced Movement"],
    ["STUI_Core", "ShackTac UI"],
    ["SNHud", "SN Hud"],
	["emr_main", "Enhanced Movement Reworked"],
	["ESL_Core_E","Echo's Sandbox Everywhere"],
	["PA_arsenal","Personal Arsenal"],
	["Revo_NoWeaponSway","No Weapon Sway"],
	["HZ_enemy_tagging","Enemy Tagging System"],
	["WBK_TwoWeaponsOnBack","WebKnight's Two Primary Weapons"],
	["PLP_MapTools","Simple MapTools"],
	["",""],
	["",""],
	["",""],
	["",""]
];

// Scan and collect any offending mods
private _foundMods = [];

{
    private _cfgName = _x select 0;
    private _displayName = _x select 1;

    if (isClass (configFile >> "CfgPatches" >> _cfgName)) then {
        _foundMods pushBack _displayName;
    };
} forEach _blacklistedMods;


	if (!(_foundMods isEqualTo [])) then {
		private _modList = _foundMods apply { "- " + _x } joinString "<br/>";
		private _message = format [
		"
		<t>Blacklisted mod(s) detected:</t><br/>
		<t><t color='#FFFF9400'>%1</t></t><br/><br/>
		<t>These are <t color='#cc1a0c'>not</t> permitted on 17th Pathfinders servers.</t><br/><br/>
		<t>Please unload them and reconnect. :^)</t>",
		_modList
		];
	
		private _guiMessage = [_message, "Vibe Check Failed", true, false] call BIS_fnc_guiMessage;
		if (_guiMessage) then {
			endMission "LOSER";
			};
	};
};