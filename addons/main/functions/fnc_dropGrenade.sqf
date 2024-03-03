#include "..\script_component.hpp"
/*
 * Author: johnb43, Launchman
 * Plays progress bar for dropping a grenade in an armored vehicle.
 *
 * Arguments:
 * 0: Target vehicle <OBJECT>
 * 1: Unit dropping grenade <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call grenades_hatches_main_fnc_dropGrenade;
 *
 * Public: No
 */

params ["_target", "_instigator"];

[GVAR(delayInteraction) * (if (GVAR(enableKnowledgeMultiplier)) then {linearConversion [0, 4, _target knowsAbout _instigator, 1, GVAR(knowledgeMultiplier)]} else {1}), _this, QGVAR(grenadeDropped), {}, LLSTRING(interactionNameProgress), {
    (_this select 0) params ["_target", "_instigator"];

    // If the target has moved too far away from the player since the start of the interaction, stop the interaction
    _instigator distance _target <= GVAR(distanceInteraction)
}] call ace_common_fnc_progressBar;
