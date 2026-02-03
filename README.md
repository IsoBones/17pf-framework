# 17th Pathfinders Mission Framework

A drop-in mission framework for Arma 3, built by the 17th Pathfinders and Borderline Tactical. Handles briefing phase management, ORBAT overlay, platoon roster, and mod blacklisting — so mission makers can focus on the actual mission.
This is a variant of Saxaphonejason's original [Borderline Tactical framework](https://github.com/Jason-Carruthers/BTacMissionFramework)

## What it does

- **Safe-start / Briefing Phase** — Locks players in briefing with an ORBAT overlay showing squad info, assigned comms channel, squad leader, and a live timer. Zeus can end it manually or it can be scripted.
- **Platoon Roster** — Populates the in-game diary with a live squad roster, auto-updating every 20 seconds.
- **Mod Blacklist (Vibe Check)** — Kicks players running blacklisted mods on join. Edit the list in `vibeCheck.sqf` to suit your unit.
- **Zeus Modules** — Adds "End Briefing Phase" and "Start Manual OCAP Recording" as custom Zeus modules.

## Requirements

- CBA_A3
- ACE3

## Usage

1. Drop the `PathfinderFramework/` folder into your mission folder.
2. Use the preemade `description.ext`, `initPlayerLocal.sqf` & `initServer.sqf` files if starting on a fresh mission, otherwise ↓↓↓
3. Add this line to the top of your `description.ext`:
   ```
   #include "PathfinderFramework\17PFFunctions.hpp"
   ```
4. Add to `initServer.sqf`:
   ```
   call Pathfinder_fnc_orbat;
   ```
5. Add to `initPlayerLocal.sqf`:
   ```
   null = execVM "PathfinderFramework\scripts\vibeCheck.sqf";
   call Pathfinder_fnc_briefing;
   null = execVM "PathfinderFramework\scripts\orbatLocal.sqf";
   ```

That's it. The framework handles the rest.

## Customisation

- **Comms channels** — Change `_radioSetting` in `orbatLocal.sqf` (1, 2, or 3 — see comments).
- **Mod blacklist** — Edit the `_blacklistedMods` array in `vibeCheck.sqf`.
- **Roster colours/names** — Set per-group via `setGroupID` and the `color` variable. See comments in `briefing.sqf`.

## License

See [LICENSE](LICENSE). You're free to use and modify this for your own missions — just credit the original authors.