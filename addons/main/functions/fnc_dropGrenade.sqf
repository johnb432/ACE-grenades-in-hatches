#include "script_component.hpp"

/*
 * Author: johnb43, Launchman
 * Drops a grenade inside of an armored vehicle.
 *
 * Arguments:
 * 0: Target vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call grenades_hatches_main_fnc_dropGrenade;
 *
 * Public: No
 */

params ["_target"];

[GVAR(delayInteraction), _target, {
    params ["_target"];
    [QGVAR(vehicleDamage), [_target], _target] call CBA_fnc_targetEvent;
}, {}, "Dropping Grenade in hatch"] call ace_common_fnc_progressBar;
