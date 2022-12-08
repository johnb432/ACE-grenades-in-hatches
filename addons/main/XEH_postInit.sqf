#include "script_component.hpp"

// Injures a unit only if allowDamage is true
[QGVAR(medicalDamage), {
    params ["_unit", "_bodyPart", "_instigator"];

    // If ACE is loaded on the client, use that to do damage
    if (GVAR(damageType) && {isClass (configFile >> "CfgPatches" >> "ace_medical")}) then {
        [_unit, GVAR(damageDealtCrew), _bodyPart, "grenade", _instigator, [], false] call ace_medical_fnc_addDamageToUnit;
    } else {
        {
            _unit setHitPointDamage [_x, (_unit getHitPointDamage _x) + GVAR(damageDealtCrewVanilla), true, _instigator/*, 2.12 _instigator*/];
        } forEach (switch (toLowerANSI _bodyPart) do {
            case "head": {["hitface", "hitneck", "hithead"]};
            case "body": {["hitpelvis", "hitabdomen", "hitdiaphragm", "hitchest", "hitbody"]};
            case "leftarm";
            case "rightarm": {["hitarms", "hithands"]};
            case "leftleg";
            case "rightleg": {["hitlegs"]};
            default {[]};
        });
    };
}] call CBA_fnc_addEventHandler;

// Local event raised when progressbar is done
[QGVAR(dropGrenadeEvent), {
    scopeName "main";

    (_this select 0) params ["_unit", "_target"];

    private _currentThrowable = (currentThrowable _unit) param [0, ""];

    // Remove the selected grenade if it's in the list, otherwise find a compatible one; 'removeMagazine' makes UI buggy
    if (_currentThrowable != "" && {_currentThrowable in GVAR(allowedGrenades)}) then {
        _unit removeItem _currentThrowable;
    } else {
        private _grenadeIndex = GVAR(allowedGrenades) findAny (magazines _unit);

        // Make sure a compatible grenade is still available; If not, quit
        if (_grenadeIndex == -1) exitWith {
            [LLSTRING(grenadeNotFoundHint), false, 10, 2] call ace_common_fnc_displayText;
            breakOut "main";
        };

        _unit removeItem (GVAR(allowedGrenades) select _grenadeIndex);
    };

    private _players = (crew _target) select {isPlayer _x};

    // If a player amoung the crew, inform them of the grenade
    if (_players isNotEqualTo []) then {
        [LLSTRING(grenadeThrownInHatchHint), true, GVAR(delayExplosion) min 5, 10] remoteExecCall ["ace_common_fnc_displayText", _players];
    };

    // Play grenade pin pulling sound
    playSound3D ["A3\sounds_f\weapons\grenades\Grenade_PullPin.wss", _target, false, getPosASL _target, 5, 1, 20];

    // Play grenade falling into hatch sound, if delay allows it
    if (GVAR(delayExplosion) >= 1) then {
        [{
            playSound3D ["A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss", _this, false, getPosASL _this, 5, 1, 20];
        }, _target, 1] call CBA_fnc_waitAndExecute;
    };

    [QGVAR(vehicleDamage), [_target, _unit], _target] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

// Has to be done using an event, because setHitPointDamage needs to be executed locally
[QGVAR(vehicleDamage), {
    [{
        (_this select 0) params ["_target", "_instigator"];

        // Play grenade explosion sound globally
        playSound3D ["A3\Sounds_F\arsenal\explosives\grenades\Explosion_HE_grenade_01.wss", _target];

        // Add grenade blowing up effect; Must be done on each client
        (ASLToAGL getPosASL _target) remoteExecCall [QFUNC(grenadeEffect), call CBA_fnc_players];

        private _arrayDamages = [GVAR(damageDealtEngine), GVAR(damageDealtHull), GVAR(damageDealtTurret)];
        private _arrayMaxDamages = [GVAR(damageDealtEngineMax), GVAR(damageDealtHullMax), GVAR(damageDealtTurretMax)];
        private _currentDamage = 0;
        private _calculatedDamage = 0;
        private _maxDamage = 0;

        // Apply damage
        {
            _currentDamage = _target getHitPointDamage _x;
            _calculatedDamage = _currentDamage + (_arrayDamages select _forEachIndex);
            _maxDamage = _arrayMaxDamages select _forEachIndex;

            if (_currentDamage > _maxDamage) then {
                _maxDamage = _currentDamage;
            };

            _target setHitPointDamage [_x, _maxDamage min _calculatedDamage, true, _instigator/*, 2.12 _instigator*/];
        } forEach ["hitEngine", "hitHull", "hitTurret"];

        private _crew = crew _target;
        private _allBodyParts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];

        // Use event in case the crew isn't local; e.g, 2+ players in one vehicle
        {
            [QGVAR(medicalDamage), [_x, selectRandom _allBodyParts, _instigator], _x] call CBA_fnc_targetEvent;
        } forEach _crew;

        // If vehicle is immobile or forceCrewDismount is true, set units to hold fire
        if (!GVAR(forceCrewDismount) && {canMove _target}) exitWith {};

        _crew = _crew select {alive _x};

        // Make a separate group and get team colors; This is to enforce no firing until dismounted
        private _group = group _target;
        private _tempGroup = grpNull;
        private _teamColors = _crew apply {assignedTeam _x};

        // If crew is part of a larger group, then create new group
        if (count _crew != count ((units _target) select {alive _x})) then {
            _tempGroup = createGroup [side _group, true];
            _crew joinSilent _tempGroup;
            _tempGroup setCombatMode "BLUE";

            // Reassign colors
            {
                _x assignTeam (_teamColors select _forEachIndex);
            } forEach _crew;
        };

        _crew doWatch objNull;

        // Force them to dismount and stay out of vehicle
        _crew allowGetIn false;

        {
            [{
                params ["_args", "_handleID"];
                _args params ["_unit", "_group", "_tempGroup", "_teamColor"];

                // If unit has dismounted, is dead or has been deleted
                if (isNull objectParent _unit || {!alive _unit}) exitWith {
                    _handleID call CBA_fnc_removePerFrameHandler;

                    if (isNull _unit) exitWith {};

                    // If unit has dismounted, set combat mode and rejoin group if possible
                    [{
                        params ["_unit", "_group", "_tempGroup", "_teamColor"];

                        // Set unit back to "normal"; This command does not work with setting units to "BLUE"
                        "YELLOW" remoteExecCall ["setUnitCombatMode", _unit];

                        // Rejoin old group if it still exists and reassign color
                        if (!isNull _group && {!isNull _tempGroup}) then {
                            [_unit] joinSilent _group;
                            _unit assignTeam _teamColor;
                        };

                        // Stop unit from remounting again
                        [_unit] allowGetIn false;
                    }, _args, [3, 0] select (!alive _unit)] call CBA_fnc_waitAndExecute;
                };

                // Force crew to dismount if they are conscious
                if (_unit getVariable ["ACE_isUnconscious", false] || {(lifeState _unit) == "INCAPACITATED"}) exitWith {};

                // Eject unit from vehicle
                moveOut _unit;
            }, 0.5, [_x, _group, _tempGroup, _teamColors select _forEachIndex]] call CBA_fnc_addPerFrameHandler;
        } forEach _crew;
    }, _this, GVAR(delayExplosion)] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
