#include "script_component.hpp"

/*
 * Author: johnb43
 * Applies damage to a unit, saving who did the damage.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Killer <OBJECT> (Optional)
 * 2: Instigator <OBJECT> (Optional)
 * 3: Damage <NUMBER> (Optional)
 * 4: Type of damage <STRING> (Optional)
 * 5: Guarantee death? <BOOLEAN> (Optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call grenades_hatches_main_fnc_medicalDamage;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_killer", objNull, [objNull]], ["_instigator", objNull, [objNull]], "_damage", ["_woundType", "grenade", [""]], ["_guaranteeDeath", false, [false]]];

if (isNull _unit) exitWith {};

if (!local _unit) exitWith {
    [QGVAR(medicalDamage), _this, _unit] call CBA_fnc_targetEvent;
};

// Check if unit is invulnerable
if !(isDamageAllowed _unit && {_unit getVariable ["ace_medical_allowDamage", true]}) exitWith {};

// If ACE is loaded on the client, use that to do damage
if (GVAR(damageType) && {!isNil "ace_medical"}) then {
    if (isNil "_damage") then {
        _damage = GVAR(damageDealtCrew);
    };

    ["ace_medical_woundReceived", [_unit, ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"] apply {[(random [0.5, 0.75, 1]) * _damage, _x, 0]}, _instigator, _woundType]] call CBA_fnc_localEvent;

    // Update last damage source
    _unit setVariable ["ace_medical_lastDamageSource", _killer];
    _unit setVariable ["ace_medical_lastInstigator", _instigator];
} else {
    if (isNil "_damage") then {
        _damage = GVAR(damageDealtCrewVanilla);
    };

    {
        _unit setHitPointDamage [_x, (_unit getHitPointDamage _x) + (random [0.5, 0.75, 1]) * _damage, true, _killer, _instigator];
    } forEach ["HitFace", "HitNeck", "HitHead", "HitPelvis", "HitAbdomen", "HitDiaphragm", "HitChest", "HitBody", "HitArms", "HitHands", "HitLegs"];
};

// If guaranteed death is wished
if (_guaranteeDeath && {alive _unit}) then {
    // From 'ace_medical_status_fnc_setDead': Kill the unit without changing visual apperance
    private _currentDamage = _unit getHitPointDamage "HitHead";

    _unit setHitPointDamage ["HitHead", 1, true, _killer, _instigator];

    _unit setHitPointDamage ["HitHead", _currentDamage, true, _killer, _instigator];
};
