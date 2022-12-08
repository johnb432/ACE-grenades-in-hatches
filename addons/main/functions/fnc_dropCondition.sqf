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

params ["_unit", "_target"];

// Checks behaviour for behaviour whitelist
if !((behaviour _target) in GVAR(allowedBehavior)) exitWith {false};

private _targetType = typeOf _target;

// See if player has required grenades and whether sides are not the same
if (!([side _unit, side _target] call BIS_fnc_sideIsEnemy) || {(GVAR(allowedGrenades) findAny (magazines _unit)) == -1}) exitWith {false};

// Checks for player ambush setting
if (GVAR(disablePlayerAmbush) && {((crew _target) findIf {isPlayer _x}) != -1}) exitWith {false};

// Go through vehicle whitelists and blacklists
(
	(GVAR(whitelistVehicles) isNotEqualTo [] && {_targetType in GVAR(whitelistVehicles)}) ||
	{GVAR(whitelistVehiclesInheritance) findIf {_target isKindOf _x} != -1}
) && {
	(GVAR(blacklistVehicles) isEqualTo [] || {!(_targetType in GVAR(blacklistVehicles))}) &&
	{GVAR(blacklistVehiclesInheritance) findIf {_target isKindOf _x} == -1}
}
