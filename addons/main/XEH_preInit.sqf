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

[QGVAR(unassignVehicle), {unassignVehicle _this}] call CBA_fnc_addEventHandler;
[QGVAR(setCombatMode), {(_this select 0) setCombatMode (_this select 1)}] call CBA_fnc_addEventHandler;
[QGVAR(setCombatBehaviour), {(_this select 0) setCombatBehaviour (_this select 1)}] call CBA_fnc_addEventHandler;
[QGVAR(setUnitCombatMode), {(_this select 0) setUnitCombatMode (_this select 1)}] call CBA_fnc_addEventHandler;

[QGVAR(playSound), {
    params ["_sound", "_object", ["_volume", []], ["_distance", 0]];
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
