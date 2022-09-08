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

// See if player has required grenades, whether sides are not the same and whether vehicle is in blacklist
if (!([side _unit, side _target] call BIS_fnc_sideIsEnemy) || {(GVAR(allowedGrenades) findAny (magazines _unit)) == -1} || {_targetType in GVAR(blacklistVehicles)}) exitWith {false};

// Check if vehicle is in whitelist, if whitelist is not empty
if (GVAR(whitelistVehicles) isNotEqualTo [] && {!(_targetType in GVAR(whitelistVehicles))}) exitWith {false};

// Checks for player ambush setting and whether vehicle is in vehicle inheritance blacklist
!(GVAR(disablePlayerAmbush) && {((crew _target) findIf {isPlayer _x}) != -1}) && {!(GVAR(blacklistVehiclesInheritance) isNotEqualTo [] && {(GVAR(blacklistVehiclesInheritance) findIf {_target isKindOf _x}) != -1})};
