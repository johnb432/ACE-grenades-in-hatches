#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(allowedGrenadesSetting),
    "EDITBOX",
    ["Compatible Grenades", "The array of classnames of grenades that can be used. Can be added to and modified. Format is an array of strings."],
    [COMPONENT_NAME, "Lists"],
    "['HandGrenade','MiniGrenade']",
    false,
    {
        if (GVAR(allowedGrenadesSetting) isEqualTo "") exitWith {
            GVAR(allowedGrenades) = [];
            GVAR(allowedGrenadesSetting) = "[]";
        };

        GVAR(allowedGrenades) = parseSimpleArray GVAR(allowedGrenadesSetting);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(blacklistVehiclesSetting),
    "EDITBOX",
    ["Vehicle blacklist (no inheritance)", "A blacklist for specific object types."],
    [COMPONENT_NAME, "Lists"],
    "[]",
    false,
    {
        if (GVAR(blacklistVehiclesSetting) isEqualTo "") exitWith {
            GVAR(blacklistVehicles) = [];
            GVAR(blacklistVehiclesSetting) = "[]";
        };

        GVAR(blacklistVehicles) = parseSimpleArray GVAR(blacklistVehiclesSetting);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(blacklistVehiclesInheritanceSetting),
    "EDITBOX",
    ["Vehicle blacklist (with inheritance)", "A blacklist for an object and all of it's children."],
    [COMPONENT_NAME, "Lists"],
    "[]",
    false,
    {
        if (GVAR(blacklistVehiclesInheritanceSetting) isEqualTo "") exitWith {
            GVAR(blacklistVehiclesInheritance) = [];
            GVAR(blacklistVehiclesInheritanceSetting) = "[]";
        };

        GVAR(blacklistVehiclesInheritance) = parseSimpleArray GVAR(blacklistVehiclesInheritanceSetting);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtCrew),
    "SLIDER",
    ["Damage dealt to crew", "0 for no damage, 0-0.5 for minor, 0.5-0.75 for medium and 0.75+ for large wounds"],
    [COMPONENT_NAME, "Damages"],
    [0, 10, 3, 2]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtHull),
    "SLIDER",
    ["Damage dealt to vehicle's hull", "Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0.25, 1, 0.75, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtEngine),
    "SLIDER",
    ["Damage dealt to vehicle's engine", "Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0.25, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtTurret),
    "SLIDER",
    ["Damage dealt to vehicle's turret", "Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0.25, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(delayExplosion),
    "SLIDER",
    ["Delay to explosion", "Sets the delay of explosion after the explosive has been used."],
    [COMPONENT_NAME, "Timings"],
    [0, 10, 3, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(delayInteraction),
    "SLIDER",
    ["Interaction time", "Sets the length of the interaction."],
    [COMPONENT_NAME, "Timings"],
    [0.5, 10, 3, 1]
] call CBA_fnc_addSetting;

ADDON = true;
