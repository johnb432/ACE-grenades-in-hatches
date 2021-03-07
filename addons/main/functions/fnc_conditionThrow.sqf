#include "script_component.hpp"

/*
 * Author: johnb43
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
 * [player, cursorObject] call grenades_hatches_main_fnc_conditionThrow;
 *
 * Public: No
 */

params ["_player", "_target"];

if (count(GVAR(allowedGrenades) arrayIntersect (magazines _player)) isEqualTo 0 || {(side _target) isEqualTo (side _player)} || {(typeOf _target) in GVAR(blacklistVehicles)}) exitWith {false};

private _check = true;

{
    if (_target isKindOf _x) exitWith {_check = false};
} forEach GVAR(blacklistVehiclesInheritance);

_check
