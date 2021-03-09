#include "script_component.hpp"

/*
 * Author: johnb43, Launchman
 * Checks if the interaction can be used.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call grenades_hatches_main_fnc_dropCondition;
 *
 * Public: No
 */

params ["_player", "_target"];

if (count(GVAR(allowedGrenades) arrayIntersect (magazines _player)) isEqualTo 0 || {(side _target) isEqualTo (side _player)} || {(typeOf _target) in GVAR(blacklistVehicles)}) exitWith {false};
if !(behaviour _target in GVAR(allowedBehavior)) exitWith {false};

private _checkPlayer = true;
if (GVAR(disablePlayerAmbush)) then {
    {
        if (isPlayer _x) exitWith {_checkPlayer = false};
    } forEach (crew _target);
};

private _checkBlacklist = true;
if (GVAR(blacklistVehiclesInheritance) isNotEqualTo []) then {
    {
        if (_target isKindOf _x) exitWith {_checkBlacklist = false};
    } forEach GVAR(blacklistVehiclesInheritance);
};

_checkBlacklist && _checkPlayer
