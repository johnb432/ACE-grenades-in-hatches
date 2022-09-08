[
    QGVAR(damageType),
    "LIST",
    [LLSTRING(damageType), LLSTRING(damageType_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [[true, false], ["ACE", "Vanilla"], 0]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtCrew),
    "SLIDER",
    [LLSTRING(damageDealtCrew), LLSTRING(damageDealtCrew_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 30, 5, 2]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtCrewVanilla),
    "SLIDER",
    [LLSTRING(damageDealtCrewVanilla), LLSTRING(damageDealtCrewVanilla_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 0.25, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(forceCrewDismount),
    "CHECKBOX",
    [LLSTRING(forceCrewDismount), LLSTRING(forceCrewDismount_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtHull),
    "SLIDER",
    [LLSTRING(damageDealtHull), LLSTRING(damageDealtHull_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 0.75, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtEngine),
    "SLIDER",
    [LLSTRING(damageDealtEngine), LLSTRING(damageDealtEngine_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtTurret),
    "SLIDER",
    [LLSTRING(damageDealtTurret), LLSTRING(damageDealtTurret_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtHullMax),
    "SLIDER",
    [LLSTRING(damageDealtHullMax), LLSTRING(damageDealtHullMax_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 0.75, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtEngineMax),
    "SLIDER",
    [LLSTRING(damageDealtEngineMax), LLSTRING(damageDealtEngineMax_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtTurretMax),
    "SLIDER",
    [LLSTRING(damageDealtTurretMax), LLSTRING(damageDealtTurretMax_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(allowedGrenadesSetting),
    "EDITBOX",
    [LLSTRING(allowedGrenadesSetting), LLSTRING(allowedGrenadesSetting_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    "['HandGrenade','MiniGrenade']",
    false,
    {
        if (_this isEqualTo "") exitWith {
            GVAR(allowedGrenades) = [];
            GVAR(allowedGrenadesSetting) = "[]";
        };

        // Make sure to remove invalid entries
        GVAR(allowedGrenades) = ((parseSimpleArray _this) apply {configName (_x call CBA_fnc_getItemConfig)}) - [""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(blacklistVehiclesSetting),
    "EDITBOX",
    [LLSTRING(blacklistVehiclesSetting), LLSTRING(blacklistVehiclesSetting_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    "[]",
    false,
    {
        if (_this isEqualTo "") exitWith {
            GVAR(blacklistVehicles) = [];
            GVAR(blacklistVehiclesSetting) = "[]";
        };

        // Make sure to remove invalid entries
        GVAR(blacklistVehicles) = ((parseSimpleArray _this) apply {configName (_x call CBA_fnc_getObjectConfig)}) - [""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(blacklistVehiclesInheritanceSetting),
    "EDITBOX",
    [LLSTRING(blacklistVehiclesInheritanceSetting), LLSTRING(blacklistVehiclesInheritanceSetting_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    "[]",
    false,
    {
        if (_this isEqualTo "") exitWith {
            GVAR(blacklistVehiclesInheritance) = [];
            GVAR(blacklistVehiclesInheritanceSetting) = "[]";
        };

        // Make sure to remove invalid entries
        GVAR(blacklistVehiclesInheritance) = ((parseSimpleArray _this) apply {configName (_x call CBA_fnc_getObjectConfig)}) - [""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(whitelistVehiclesSetting),
    "EDITBOX",
    [LLSTRING(whitelistVehiclesSetting), LLSTRING(whitelistVehiclesSetting_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    "[]",
    false,
    {
        if (_this isEqualTo "") exitWith {
            GVAR(whitelistVehicles) = [];
            GVAR(whitelistVehiclesSetting) = "[]";
        };

        // Make sure to remove invalid entries
        GVAR(whitelistVehicles) = ((parseSimpleArray _this) apply {configName (_x call CBA_fnc_getObjectConfig)}) - [""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(whitelistVehiclesInheritanceSetting),
    "EDITBOX",
    [LLSTRING(whitelistVehiclesInheritanceSetting), LLSTRING(whitelistVehiclesInheritanceSetting_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    "['Tank','Wheeled_Apc_F']",
    false,
    {
        // Make config case and remove invalid entries
        private _setting = ((if (_this isEqualTo "") then { GVAR(whitelistVehiclesInheritanceSetting) = "[]"; [] } else { parseSimpleArray _this }) apply {configName (_x call CBA_fnc_getObjectConfig)}) - [""];

        // Add classes
        {
            [_x, 0, ["ACE_MainActions"], GVAR(actionACE), true] call ace_interact_menu_fnc_addActionToClass;
        } forEach (_setting - GVAR(whitelistVehiclesInheritance));

        private _type = "";

        // Remove classes
        {
            _type = _x;

            ace_interact_menu_inheritedActionsAll deleteAt (ace_interact_menu_inheritedActionsAll find [_type, 0, ["ACE_MainActions"], GVAR(actionACE)]);

            {
                if (_x isKindOf _type) then {
                    [_x, 0, ["ACE_MainActions", QGVAR(dropGrenade)]] call ace_interact_menu_fnc_removeActionFromClass;
                };
            } forEach ace_interact_menu_inheritedClassesAll;
        } forEach (GVAR(whitelistVehiclesInheritance) - _setting);

        GVAR(whitelistVehiclesInheritance) = _setting;
    }
] call CBA_fnc_addSetting;

[
    QGVAR(allowedBehaviorSetting),
    "EDITBOX",
    [LLSTRING(allowedBehaviorSetting), LLSTRING(allowedBehaviorSetting_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    "['CARELESS','SAFE','AWARE','COMBAT','STEALTH']",
    false,
    {
        if (_this isEqualTo "") exitWith {
            GVAR(allowedBehavior) = [];
            GVAR(allowedBehaviorSetting) = "[]";
        };

        GVAR(allowedBehavior) = (parseSimpleArray _this) apply {toUpperANSI _x};
    }
] call CBA_fnc_addSetting;

[
    QGVAR(disablePlayerAmbush),
    "CHECKBOX",
    [LLSTRING(disablePlayerAmbush), LLSTRING(disablePlayerAmbush_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(player)],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(distanceInteraction),
    "SLIDER",
    [LLSTRING(distanceInteraction), LLSTRING(distanceInteraction_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(player)],
    [2, 100, 10, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(delayExplosion),
    "SLIDER",
    [LLSTRING(delayExplosion), LLSTRING(delayExplosion_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(timings)],
    [0, 20, 5, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(delayInteraction),
    "SLIDER",
    [LLSTRING(delayInteraction), LLSTRING(delayInteraction_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(timings)],
    [0.5, 10, 3, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(enableKnowledgeMultiplier),
    "CHECKBOX",
    [LLSTRING(enableKnowledgeMultiplier), LLSTRING(enableKnowledgeMultiplier_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(timings)],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(knowledgeMultiplier),
    "SLIDER",
    [LLSTRING(knowledgeMultiplier), LLSTRING(knowledgeMultiplier_ToolTip)],
    [LLSTRING(nameMod), LLSTRING(timings)],
    [1, 30, 5, 2]
] call CBA_fnc_addSetting;
