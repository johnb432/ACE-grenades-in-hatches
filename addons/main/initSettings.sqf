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
    QGVAR(allowedBehaviorSetting),
    "EDITBOX",
    ["Target awareness", "The array of allowed behavior types that the target crew must have in order to throw in a grenade. Format is an array of strings. Default contains all behavior possibilities."],
    [COMPONENT_NAME, "Lists"],
    "['CARELESS','SAFE','AWARE','COMBAT','STEALTH']",
    false,
    {
        if (GVAR(allowedBehaviorSetting) isEqualTo "") exitWith {
            GVAR(allowedBehavior) = [];
            GVAR(allowedBehaviorSetting) = "[]";
        };

        GVAR(allowedBehavior) = parseSimpleArray GVAR(allowedBehaviorSetting);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(disablePlayerAmbush),
    "CHECKBOX",
    ["Disable player controlled targets to be attacked", "If a player is part of the target's crew, then disable the usage of this interaction."],
    [COMPONENT_NAME, "Player"],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(distanceInteraction),
    "SLIDER",
    ["Interaction range", "Sets the maximum interaction range."],
    [COMPONENT_NAME, "Player"],
    [2, 30, 10, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtCrew),
    "SLIDER",
    ["Damage dealt to crew", "0 for no damage, 0-0.5 for minor, 0.5-0.75 for medium and 0.75+ for large wounds"],
    [COMPONENT_NAME, "Damages"],
    [0, 30, 5, 2]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtHull),
    "SLIDER",
    ["Damage dealt to vehicle's hull", "Damage dealt with one interaction. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0.25, 1, 0.75, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtEngine),
    "SLIDER",
    ["Damage dealt to vehicle's engine", "Damage dealt with one interaction. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0.25, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtTurret),
    "SLIDER",
    ["Damage dealt to vehicle's turret", "Damage dealt with one interaction. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0.25, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtHullMax),
    "SLIDER",
    ["Maximum hull damage allowed", "Maximum damage that can be dealt to vehicle's hull with multiple interactions. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0.25, 1, 0.75, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtEngineMax),
    "SLIDER",
    ["Maximum engine damage allowed", "Maximum damage that can be dealt to vehicle's engine with multiple interactions. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0.25, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtTurretMax),
    "SLIDER",
    ["Maximum turret damage allowed", "Maximum damage that can be dealt to vehicle's turret with multiple interactions. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0.25, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(delayExplosion),
    "SLIDER",
    ["Delay to explosion", "Sets the delay of explosion after the explosive has been used."],
    [COMPONENT_NAME, "Timings"],
    [5, 20, 5, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(delayInteraction),
    "SLIDER",
    ["Interaction time", "Sets the length of the interaction."],
    [COMPONENT_NAME, "Timings"],
    [0.5, 10, 3, 1]
] call CBA_fnc_addSetting;
