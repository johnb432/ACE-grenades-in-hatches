#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(actionACE) = [QGVAR(dropGrenade), LLSTRING(interactionName), "", {
    [_player, _target] call FUNC(dropGrenade);
}, {
    [_player, _target] call FUNC(dropCondition);
}] call ace_interact_menu_fnc_createAction;

GVAR(whitelistVehiclesInheritance) = [];

#include "initSettings.sqf"

ADDON = true;
