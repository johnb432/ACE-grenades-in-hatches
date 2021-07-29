[
    QGVAR(damageType),
    "LIST",
    ["Damage type applied to Crew", "Applies either ACE or Vanilla damage to crew.\nIf ACE is not loaded, it will not apply ACE damage."],
    [COMPONENT_NAME, "Damages"],
    [[true, false], ["ACE", "Vanilla"], 0]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtCrew),
    "SLIDER",
    ["ACE Damage dealt to Crew", "0 for no damage, 0-0.5 for minor, 0.5-0.75 for medium and 0.75+ for large wounds."],
    [COMPONENT_NAME, "Damages"],
    [0, 30, 5, 2]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtCrewVanilla),
    "SLIDER",
    ["Vanilla Damage dealt to Crew", "If ACE Medical is not loaded or the setting 'Damage Type' is set to 'Vanilla', this number will be chosen."],
    [COMPONENT_NAME, "Damages"],
    [0, 1, 0.25, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(forceCrewDismount),
    "CHECKBOX",
    ["Force Crew dismount", "Forces the crew to dismount, regardless of vehicle damage."],
    [COMPONENT_NAME, "Damages"],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtHull),
    "SLIDER",
    ["Damage dealt to vehicle's Hull", "Damage dealt with one interaction. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0, 1, 0.75, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtEngine),
    "SLIDER",
    ["Damage dealt to vehicle's Engine", "Damage dealt with one interaction. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtTurret),
    "SLIDER",
    ["Damage dealt to vehicle's Turret", "Damage dealt with one interaction. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtHullMax),
    "SLIDER",
    ["Maximum Hull Damage allowed", "Maximum damage that can be dealt to vehicle's hull with multiple interactions. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0, 1, 0.75, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtEngineMax),
    "SLIDER",
    ["Maximum Engine Damage allowed", "Maximum damage that can be dealt to vehicle's engine with multiple interactions. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtTurretMax),
    "SLIDER",
    ["Maximum Turret Damage allowed", "Maximum damage that can be dealt to vehicle's turret with multiple interactions. Percentage value."],
    [COMPONENT_NAME, "Damages"],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

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
    ["Vehicle Blacklist (no Inheritance)", "A blacklist for specific object types."],
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
    ["Vehicle Blacklist (with Inheritance)", "A blacklist for an object and all of it's children."],
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
    ["Target Awareness", "The array of allowed behavior types that the target crew must have in order to throw in a grenade. Format is an array of strings. Default contains all behavior possibilities."],
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
    ["Disable Player controlled Targets to be attacked", "If a player is part of the target's crew, then disable the usage of this interaction."],
    [COMPONENT_NAME, "Player"],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(distanceInteraction),
    "SLIDER",
    ["Interaction Range", "Sets the maximum interaction range."],
    [COMPONENT_NAME, "Player"],
    [2, 100, 10, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(delayExplosion),
    "SLIDER",
    ["Delay to Explosion", "Sets the delay of explosion after the explosive has been used."],
    [COMPONENT_NAME, "Timings"],
    [0, 20, 5, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(delayInteraction),
    "SLIDER",
    ["Interaction Time", "Sets the length of the interaction. It's the minimum if 'Enable Knowledge Multiplier' is enabled."],
    [COMPONENT_NAME, "Timings"],
    [0.5, 10, 3, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(enableKnowledgeMultiplier),
    "CHECKBOX",
    ["Enable Knowledge Multiplier", "Enables the setting below.\nIf the target 'knowsAbout' a unit, it will take longer according to the the result of 'knowsAbout'."],
    [COMPONENT_NAME, "Timings"],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(knowledgeMultiplier),
    "SLIDER",
    ["Knowledge Multiplier", "This will set the upper limit of the linear conversion.\nThe conversion is: [0, 4] -> [1, this setting]."],
    [COMPONENT_NAME, "Timings"],
    [1, 30, 5, 2]
] call CBA_fnc_addSetting;
