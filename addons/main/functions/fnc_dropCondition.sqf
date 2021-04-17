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

// See if player has required grenades, whether sides are not the same and whether vehicle is in blacklist
if (count (GVAR(allowedGrenades) arrayIntersect (magazines _player)) isEqualTo 0 || {!([side _player, side _target] call BIS_fnc_sideIsEnemy)} || {(typeOf _target) in GVAR(blacklistVehicles)}) exitWith {false};
// Checks behaviour for behaviour whitelist
if !(behaviour _target in GVAR(allowedBehavior)) exitWith {false};

// Checks for player ambush setting and whether vehicle is in vehicle inheritance blacklist
!(GVAR(disablePlayerAmbush) && {(crew _target findIf {isPlayer _x}) isNotEqualTo -1}) && {!(GVAR(blacklistVehiclesInheritance) isNotEqualTo [] && {(GVAR(blacklistVehiclesInheritance) findIf {_target isKindOf _x}) isNotEqualTo -1})}
