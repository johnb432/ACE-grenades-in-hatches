#include "..\script_component.hpp"

/*
 * Author: johnb43
 * Makes vehicle crew dismount when they are conscious.
 *
 * Arguments:
 * 0: Target <OBJECT> (default: objNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * cursorObject call grenades_hatches_main_fnc_dismountCrew;
 *
 * Public: No
 */

params [["_target", objNull, [objNull]]];

if (isNull _target) exitWith {};

if (!isServer) exitWith {
    [QGVAR(dismountCrew), _this] call CBA_fnc_serverEvent;
};

private _cfgWeapons = configFile >> "CfgWeapons";

// Monitor living crew members
{
    // Force unit to dismount, whevever possible, and stay out of vehicle
    [_x] allowGetIn false;
    _x doWatch objNull;

    // If unit is conscious, force them to dismount
    if (!(_x getVariable ["ACE_isUnconscious", false]) && {(lifeState _x) != "INCAPACITATED"}) then {
        // If unit is player or has access to weapons, force them to dismount immediately
        if (isPlayer _x || {((_target weaponsTurret (_target unitTurret _x)) select {!(_x isKindOf ["CarHorn", _cfgWeapons]) && {!(_x isKindOf ["SmokeLauncher", _cfgWeapons])} && {!(_x isKindOf ["Laserdesignator_vehicle", _cfgWeapons])}}) isNotEqualTo []}) then {
            moveOut _x;
        };

        _x remoteExecCall ["unassignVehicle", _x];

        continue;
    };

    // Don't add a unit twice to the list
    if ((GVAR(monitorUnits) pushBackUnique _x) == -1) then {
        continue;
    };

    _x addEventHandler ["GetOutMan", {
        params ["_unit"];

        _unit removeEventHandler [_thisEvent, _thisEventHandler];

        // If unit has been deleted from the list, it means it's either dead or deleted
        if (isNil {GVAR(monitorUnits) deleteAt (GVAR(monitorUnits) find _unit)}) exitWith {};

        // If unit has dismounted and is alive, set combat mode and behaviour
        private _group = group _unit;

        // Set combat mode and behaviour for group
        if (combatMode _group != "RED") then {
            [_group, "RED"] remoteExecCall ["setCombatMode", _group];
        };

        if (combatBehaviour _group != "COMBAT") then {
            [_group, "COMBAT"] remoteExecCall ["setCombatBehaviour", _group];
        };

        // Set combat mode and behaviour for unit
        [_unit, "RED"] remoteExecCall ["setUnitCombatMode", _unit];
        [_unit, "COMBAT"] remoteExecCall ["setCombatBehaviour", _unit];

        // Stop unit from remounting again
        [_unit] allowGetIn false;
    }];

    _x addEventHandler ["Deleted", {
        GVAR(monitorUnits) deleteAt (GVAR(monitorUnits) find (_this select 0));
    }];

    _x addMPEventHandler ["MPKilled", {
        params ["_unit"];

        // 'removeMPEventHandler' must be used where unit is local
        if (local _unit) then {
            _unit removeMPEventHandler [_thisEvent, _thisEventHandler];
        };

        if (!isServer) exitWith {};

        GVAR(monitorUnits) deleteAt (GVAR(monitorUnits) find _unit);
    }];
} forEach ((crew _target) select {alive _x});

// Don't look for consciousness change if ace medical is loaded
if (!isNil "ace_medical" || {!isNil QGVAR(monitorUnitsPFH)}) exitWith {};

GVAR(monitorUnitsPFH) = [{
    // If there are no more units to monitor, stop
    if (GVAR(monitorUnits) isEqualTo []) exitWith {
        GVAR(monitorUnitsPFH) call CBA_fnc_removePerFrameHandler;
        GVAR(monitorUnitsPFH) = nil;
    };

    // Force units to dismount if they are conscious
    {
        if ((lifeState _x) != "INCAPACITATED") then {
            moveOut _x;
        };
    } forEach GVAR(monitorUnits);
}, 0.25] call CBA_fnc_addPerFrameHandler;
