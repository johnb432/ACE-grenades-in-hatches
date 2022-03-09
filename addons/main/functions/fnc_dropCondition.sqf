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
if ((GVAR(allowedBehavior) findIf {(behaviour _target) == _x}) isEqualTo -1) exitWith {false};

// See if player has required grenades, whether sides are not the same and whether vehicle is in blacklist
if !([side _unit, side _target] call BIS_fnc_sideIsEnemy && {((GVAR(allowedGrenades) apply {toLower _x}) arrayIntersect (magazines _unit apply {toLower _x})) isNotEqualTo []} && {(GVAR(blacklistVehicles) findIf {(typeOf _target) == _x}) isEqualTo -1}) exitWith {false};

// Check if vehicle is in whitelist, if whitelist is not empty
if (GVAR(whitelistVehicles) isNotEqualTo [] && {(GVAR(whitelistVehicles) findIf {(typeOf _target) == _x}) isEqualTo -1}) exitWith {false};

// Checks for player ambush setting and whether vehicle is in vehicle inheritance blacklist
!(GVAR(disablePlayerAmbush) && {((crew _target) findIf {isPlayer _x}) isNotEqualTo -1}) && {!(GVAR(blacklistVehiclesInheritance) isNotEqualTo [] && {(GVAR(blacklistVehiclesInheritance) findIf {_target isKindOf _x}) isNotEqualTo -1})};
