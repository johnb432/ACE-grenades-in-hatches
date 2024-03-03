#include "script_component.hpp"

// Let server handle crew dismounting
if (!isServer || {isNil "ace_medical"}) exitWith {};

// Add event to listen for consciousness change
["ace_unconscious", {
    params ["_unit", "_isUnconscious"];

    // Force unit to dismount if they are conscious
    if !(!_isUnconscious && {_unit in GVAR(monitorUnits)}) exitWith {};

    private _vehicle = objectParent _unit;

    if (isNull _vehicle) exitWith {};

    private _cfgWeapons = configFile >> "CfgWeapons";

    // If unit is player or has access to weapons, force them to dismount immediately
    if (isPlayer _unit || {((_vehicle weaponsTurret (_vehicle unitTurret _unit)) select {!(_x isKindOf ["CarHorn", _cfgWeapons]) && {!(_x isKindOf ["SmokeLauncher", _cfgWeapons])} && {!(_x isKindOf ["Laserdesignator_vehicle", _cfgWeapons])}}) isNotEqualTo []}) then {
        moveOut _unit;
    };

    [QGVAR(unassignVehicle), _unit, _unit] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;
