#include "script_component.hpp"

/*
 * Author: johnb43
 * Drops a grenade in a vehicle.
 * Local event that is raised when progressbar is done.
 *
 * Arguments:
 * 0: Args from progressbar <ARRAY>
 *  0: Target vehicle <OBJECT> (default: objNull)
 *  1: Unit dropping grenade <OBJECT> (default: objNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * [[cursorObject, player]] call grenades_hatches_main_fnc_grenadeDropped;
 *
 * Public: No
 */

(_this select 0) params [["_target", objNull, [objNull]], ["_instigator", objNull, [objNull]]];

if (isNull _target) exitWith {};

scopeName "main";

private _currentThrowable = (currentThrowable _instigator) param [0, ""];

// Remove the selected grenade if it's in the list, otherwise find a compatible one; 'removeMagazine' makes UI buggy
if (!(_currentThrowable in GVAR(allowedGrenades))) then {
    private _grenadeIndex = GVAR(allowedGrenades) findAny (magazines _instigator);

    // Make sure a compatible grenade is still available; If not, quit
    if (_grenadeIndex == -1) exitWith {
        [LLSTRING(grenadeNotFoundHint), false, 10, 2] call ace_common_fnc_displayText;

        breakOut "main";
    };

    _currentThrowable = GVAR(allowedGrenades) select _grenadeIndex;
};

_instigator removeItem _currentThrowable;

private _players = (crew _target) select {isPlayer _x};

// If a player is amoungst the crew, inform them of the grenade
if (_players isNotEqualTo []) then {
    [LLSTRING(grenadeThrownInHatchHint), true, GVAR(delayExplosion) min 5, 10] remoteExecCall ["ace_common_fnc_displayText", _players];
};

// Play grenade pin pulling sound
[QGVAR(playSound), ["A3\sounds_f\weapons\grenades\Grenade_PullPin.wss", _target, [2.5, 5], 20]] call CBA_fnc_globalEvent;

// Play grenade falling inside hatch sound, if delay allows it
if (GVAR(delayExplosion) >= 1) then {
    [{
        [QGVAR(playSound), [format ["A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_%1.wss", floor (random 5) + 1], _target, [3, 3]]] call CBA_fnc_globalEvent;
    }, _target, 1] call CBA_fnc_waitAndExecute;
};

// Damage vehicle
[{
    [QGVAR(vehicleDamage), _this, _this select 0] call CBA_fnc_targetEvent;
}, [_target, _instigator], GVAR(delayExplosion)] call CBA_fnc_waitAndExecute;
