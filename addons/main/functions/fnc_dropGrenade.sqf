#include "script_component.hpp"

/*
 * Author: johnb43, Launchman
 * Drops a grenade inside of an armored vehicle.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Target vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call grenades_hatches_main_fnc_dropGrenade;
 *
 * Public: No
 */

params ["_unit", "_target"];

[GVAR(delayInteraction), [_unit, _target], QGVAR(dropGrenadeEvent), {}, "Dropping Grenade in hatch", {
    (_this select 0) params ["_unit", "_target"];
    
    // If the target has moved too far away from the player since the start of the interaction, stop the interaction
    _unit distance _target < GVAR(distanceInteraction)
}] call ace_common_fnc_progressBar;
