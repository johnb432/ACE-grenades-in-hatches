#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Applies damage to vehicle.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Instigator <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call grenades_hatches_main_fnc_vehicleDamage;
 *
 * Public: No
 */

params ["_target", "_instigator"];

// Add grenade explosion effect; Must be done on each client
[QGVAR(playSound), [format ["A3\Sounds_F\arsenal\explosives\grenades\Explosion_HE_grenade_0%1.wss", floor (random 4) + 1], _target]] call CBA_fnc_globalEvent;
[QGVAR(grenadeEffect), ASLToAGL getPosASL _target] call CBA_fnc_globalEvent;

if (isDamageAllowed _target) then {
    private _arrayDamages = [GVAR(damageDealtEngine), GVAR(damageDealtHull), GVAR(damageDealtTurret)];
    private _arrayMaxDamages = [GVAR(damageDealtEngineMax), GVAR(damageDealtHullMax), GVAR(damageDealtTurretMax)];
    private _currentDamage = 0;

    // Apply damage to vehicle
    {
        _currentDamage = _target getHitPointDamage _x;

        _target setHitPointDamage [_x, ((_arrayMaxDamages select _forEachIndex) max _currentDamage) min (_currentDamage + (_arrayDamages select _forEachIndex)), true, _instigator, _instigator];
    } forEach ["HitEngine", "HitHull", "HitTurret"];
};

// Use event in case the crew isn't local; e.g, 2+ players in one vehicle
{
    [QGVAR(medicalDamage), [_x, _instigator, _instigator], _x] call CBA_fnc_targetEvent;
} forEach (crew _target);

// If vehicle is mobile and forceCrewDismount is false, let units handle themselves, so exit
if (!GVAR(forceCrewDismount) && {canMove _target}) exitWith {};

// Let server handle the damaging of the crew
[QGVAR(dismountCrew), _target] call CBA_fnc_serverEvent;
