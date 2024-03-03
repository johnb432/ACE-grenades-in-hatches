[
    QGVAR(damageType),
    "LIST",
    [LLSTRING(damageType), LLSTRING(damageTypeDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [[true, false], ["ACE", "Vanilla"], 0]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtCrew),
    "SLIDER",
    [LLSTRING(damageDealtCrew), LLSTRING(damageDealtCrewDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 30, 5, 2]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtCrewVanilla),
    "SLIDER",
    [LLSTRING(damageDealtCrewVanilla), LLSTRING(damageDealtCrewVanillaDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 0.25, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(forceCrewDismount),
    "CHECKBOX",
    [LLSTRING(forceCrewDismount), LLSTRING(forceCrewDismountDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtHull),
    "SLIDER",
    [LLSTRING(damageDealtHull), LLSTRING(damageDealtHullDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 0.75, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtEngine),
    "SLIDER",
    [LLSTRING(damageDealtEngine), LLSTRING(damageDealtEngineDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtTurret),
    "SLIDER",
    [LLSTRING(damageDealtTurret), LLSTRING(damageDealtTurretDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtHullMax),
    "SLIDER",
    [LLSTRING(damageDealtHullMax), LLSTRING(damageDealtHullMaxDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 0.75, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtEngineMax),
    "SLIDER",
    [LLSTRING(damageDealtEngineMax), LLSTRING(damageDealtEngineMaxDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(damageDealtTurretMax),
    "SLIDER",
    [LLSTRING(damageDealtTurretMax), LLSTRING(damageDealtTurretMaxDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    [0, 1, 1, 2, true]
] call CBA_fnc_addSetting;

[
    QGVAR(killCrewIfVehicleExplodes),
    "CHECKBOX",
    [LLSTRING(killCrewIfVehicleExplodes), LLSTRING(killCrewIfVehicleExplodesDesc)],
    [LLSTRING(nameMod), LLSTRING(damages)],
    false,
    0,
    {
        if (_this) then {
            if (!isNil QGVAR(killedEhID)) exitWith {};

            GVAR(killedEhID) = addMissionEventHandler ["EntityKilled", {
                params ["_vehicle", "_killer", "_instigator", "_useEffects"];

                // If run on server only, it doesn't always fire before the crew has dismounted
                if (!local _vehicle) exitWith {};

                // Check if 'vehicle' is an actual vehicle (look for a driver position)
                if ((fullCrew [_vehicle, "driver", true]) isEqualTo []) exitWith {};

                // Don't kill UAV crews
                if (unitIsUAV _vehicle) exitWith {};

                // Inspired by ACE - medical_engine - XEH_postInit.sqf
                // Check if destruction effects are enabled
                if (!_useEffects || {(getText (configOf _vehicle >> "destrType")) == ""}) exitWith {};

                // Don't kill units in parachutes
                if (_vehicle isKindOf "ParachuteBase") exitWith {};

                // Damage units a lot and make sure they die
                {
                    [QGVAR(medicalDamage), [_x, _killer, _instigator, 10, "explosive", true], _x] call CBA_fnc_targetEvent;
                } forEach (crew _vehicle);
            }];
        } else {
            if (isNil QGVAR(killedEhID)) exitWith {};

            removeMissionEventHandler ["EntityKilled", GVAR(killedEhID)];
            GVAR(killedEhID) = nil;
        };
    }
] call CBA_fnc_addSetting;

[
    QGVAR(autodetectGrenadesSetting),
    "CHECKBOX",
    [LLSTRING(autodetectGrenadesSetting), LLSTRING(autodetectGrenadesSettingDesc)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    true,
    0,
    {
        GVAR(allowedGrenades) = if (_this) then {
            keys (uiNamespace getVariable QGVAR(grenadesFrag))
        } else {
            private _string = trim GVAR(allowedGrenadesSetting);

            // Check if it's a parsable array
            if !(_string regexMatch "\[[^\]]*(\])") exitWith {
                [format [LLSTRING(failedParsing), QGVAR(allowedGrenadesSetting)], 4] call ace_common_fnc_displayTextStructured;

            	[]
            };

            // Make sure to remove invalid entries
            ((parseSimpleArray _string) apply {configName (_x call CBA_fnc_getItemConfig)}) - [""]
        };
    }
] call CBA_fnc_addSetting;

[
    QGVAR(allowedGrenadesSetting),
    "EDITBOX",
    [LLSTRING(allowedGrenadesSetting), LLSTRING(allowedGrenadesSettingDesc)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    '["HandGrenade","MiniGrenade"]',
    0,
    {
        if (GVAR(autodetectGrenadesSetting)) exitWith {};

        private _string = trim _this;

        // Check if it's a parsable array
        if !(_string regexMatch "\[[^\]]*(\])") exitWith {
            [format [LLSTRING(failedParsing), QGVAR(allowedGrenadesSetting)], 4] call ace_common_fnc_displayTextStructured;

        	GVAR(allowedGrenades) = [];
        };

        // Make sure to remove invalid entries
        GVAR(allowedGrenades) = ((parseSimpleArray _string) apply {configName (_x call CBA_fnc_getItemConfig)}) - [""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(whitelistVehiclesSetting),
    "EDITBOX",
    [LLSTRING(whitelistVehiclesSetting), LLSTRING(whitelistVehiclesSettingDesc)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    '[]',
    0,
    {
        private _string = trim _this;

        // Check if it's a parsable array
        if !(_string regexMatch "\[[^\]]*(\])") exitWith {
            [format [LLSTRING(failedParsing), QGVAR(whitelistVehiclesSetting)], 4] call ace_common_fnc_displayTextStructured;

        	GVAR(whitelistVehicles) = [];
        };

        // Make sure to remove invalid entries
        GVAR(whitelistVehicles) = ((parseSimpleArray _string) apply {configName (_x call CBA_fnc_getObjectConfig)}) - [""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(whitelistVehiclesInheritanceSetting),
    "EDITBOX",
    [LLSTRING(whitelistVehiclesInheritanceSetting), LLSTRING(whitelistVehiclesInheritanceSettingDesc)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    '["Tank","Wheeled_Apc_F"]',
    0,
    {
        private _string = trim _this;

        // Make config case and remove invalid entries
        private _setting = ((if !(_string regexMatch "\[[^\]]*(\])") then {
            [format [LLSTRING(failedParsing), QGVAR(whitelistVehiclesInheritanceSetting)], 4] call ace_common_fnc_displayTextStructured;

            []
        } else {
            parseSimpleArray _string
        }) apply {configName (_x call CBA_fnc_getObjectConfig)}) - [""];

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
    QGVAR(blacklistVehiclesSetting),
    "EDITBOX",
    [LLSTRING(blacklistVehiclesSetting), LLSTRING(blacklistVehiclesSettingDesc)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    '[]',
    0,
    {
        private _string = trim _this;

        // Check if it's a parsable array
        if !(_string regexMatch "\[[^\]]*(\])") exitWith {
            [format [LLSTRING(failedParsing), QGVAR(blacklistVehiclesSetting)], 4] call ace_common_fnc_displayTextStructured;

        	GVAR(blacklistVehicles) = [];
        };

        // Make sure to remove invalid entries
        GVAR(blacklistVehicles) = ((parseSimpleArray _string) apply {configName (_x call CBA_fnc_getObjectConfig)}) - [""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(blacklistVehiclesInheritanceSetting),
    "EDITBOX",
    [LLSTRING(blacklistVehiclesInheritanceSetting), LLSTRING(blacklistVehiclesInheritanceSettingDesc)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    '[]',
    0,
    {
        private _string = trim _this;

        // Check if it's a parsable array
        if !(_string regexMatch "\[[^\]]*(\])") exitWith {
            [format [LLSTRING(failedParsing), QGVAR(blacklistVehiclesInheritanceSetting)], 4] call ace_common_fnc_displayTextStructured;

        	GVAR(blacklistVehiclesInheritance) = [];
        };

        // Make sure to remove invalid entries
        GVAR(blacklistVehiclesInheritance) = ((parseSimpleArray _string) apply {configName (_x call CBA_fnc_getObjectConfig)}) - [""];
    }
] call CBA_fnc_addSetting;

[
    QGVAR(allowedBehaviorSetting),
    "EDITBOX",
    [LLSTRING(allowedBehaviorSetting), LLSTRING(allowedBehaviorSettingDesc)],
    [LLSTRING(nameMod), LLSTRING(lists)],
    '["CARELESS","SAFE","AWARE","COMBAT","STEALTH"]',
    0,
    {
        private _string = trim _this;

        // Check if it's a parsable array
        if !(_string regexMatch "\[[^\]]*(\])") exitWith {
            [format [LLSTRING(failedParsing), QGVAR(allowedBehaviorSetting)], 4] call ace_common_fnc_displayTextStructured;

        	GVAR(allowedBehavior) = [];
        };

        GVAR(allowedBehavior) = (parseSimpleArray _string) apply {toUpperANSI _x};
    }
] call CBA_fnc_addSetting;

[
    QGVAR(disablePlayerAmbush),
    "CHECKBOX",
    [LLSTRING(disablePlayerAmbush), LLSTRING(disablePlayerAmbushDesc)],
    [LLSTRING(nameMod), LLSTRING(player)],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(distanceInteraction),
    "SLIDER",
    [LLSTRING(distanceInteraction), LLSTRING(distanceInteractionDesc)],
    [LLSTRING(nameMod), LLSTRING(player)],
    [2, 100, 10, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(delayExplosion),
    "SLIDER",
    [LLSTRING(delayExplosion), LLSTRING(delayExplosionDesc)],
    [LLSTRING(nameMod), LLSTRING(timings)],
    [0, 20, 5, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(delayInteraction),
    "SLIDER",
    [LLSTRING(delayInteraction), LLSTRING(delayInteractionDesc)],
    [LLSTRING(nameMod), LLSTRING(timings)],
    [0.5, 10, 3, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(enableKnowledgeMultiplier),
    "CHECKBOX",
    [LLSTRING(enableKnowledgeMultiplier), LLSTRING(enableKnowledgeMultiplierDesc)],
    [LLSTRING(nameMod), LLSTRING(timings)],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(knowledgeMultiplier),
    "SLIDER",
    [LLSTRING(knowledgeMultiplier), LLSTRING(knowledgeMultiplierDesc)],
    [LLSTRING(nameMod), LLSTRING(timings)],
    [1, 30, 5, 2]
] call CBA_fnc_addSetting;
