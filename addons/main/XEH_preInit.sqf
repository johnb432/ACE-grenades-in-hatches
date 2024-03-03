#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

GVAR(actionACE) = [QGVAR(dropGrenade), LLSTRING(interactionName), "", {
    [_target, _player] call FUNC(dropGrenade);
}, {
    [_target, _player] call FUNC(dropCondition);
}] call ace_interact_menu_fnc_createAction;

GVAR(whitelistVehiclesInheritance) = [];

// Events
[QGVAR(grenadeDropped), LINKFUNC(grenadeDropped)] call CBA_fnc_addEventHandler;
[QGVAR(grenadeEffect), LINKFUNC(grenadeEffect)] call CBA_fnc_addEventHandler;
[QGVAR(medicalDamage), LINKFUNC(medicalDamage)] call CBA_fnc_addEventHandler;
[QGVAR(vehicleDamage), LINKFUNC(vehicleDamage)] call CBA_fnc_addEventHandler;

[QGVAR(unassignVehicle), {
    params ["_unit"];

    unassignVehicle _unit;
}] call CBA_fnc_addEventHandler;

[QGVAR(setCombatMode), {
    params ["_unit", "_mode"];

    _unit setCombatMode _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setCombatBehaviour), {
    params ["_unit", "_mode"];

    _unit setCombatMode _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setUnitCombatMode), {
    params ["_unit", "_mode"];

    _unit setUnitCombatMode _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(playSound), {
    params ["_sound", "_object", ["_volume", [1, 1]], ["_distance", 0]];
    _volume params [["_volumeUI", 1], ["_volume3D", 1]];

    // Bug in first person/gunner view where sound is greatly attenuated
    if ((call CBA_fnc_currentUnit) in _object && {cameraView in ["INTERNAL", "GUNNER"]}) then {
        playSoundUI [_sound, _volumeUI, 1, true];
    } else {
        playSound3D [_sound, objNull, false, getPosASL _object, _volume3D, 1, _distance, 0, true];
    };
}] call CBA_fnc_addEventHandler;

// Let server handle crew dismounting
if (isServer) then {
    GVAR(monitorUnits) = [];

    [QGVAR(dismountCrew), LINKFUNC(dismountCrew)] call CBA_fnc_addEventHandler;
};

// CBA Settings
#include "initSettings.inc.sqf"

ADDON = true;
