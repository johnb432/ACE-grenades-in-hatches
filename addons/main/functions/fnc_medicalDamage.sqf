#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Applies medical damage to a unit, saving who did the damage.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Source <OBJECT>
 * 2: Instigator <OBJECT>
 * 3: Damage <NUMBER> (default: nil)
 * 4: Type of damage <STRING> (default: "grenade")
 * 5: Guarantee death? <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call grenades_hatches_main_fnc_medicalDamage;
 *
 * Public: No
 */

params ["_unit", "_source", "_instigator", "_damage", ["_woundType", "grenade"], ["_guaranteeDeath", false]];

// Check if unit is invulnerable
if !(isDamageAllowed _unit && {_unit getVariable ["ace_medical_allowDamage", true]}) exitWith {};

// If ACE is loaded on the client, use that to do damage
if (GVAR(damageType) && {!isNil "ace_medical"}) then {
    if (isNil "_damage") then {
        _damage = GVAR(damageDealtCrew);
    };

    // Update last damage source
    _unit setVariable ["ace_medical_lastDamageSource", _source];
    _unit setVariable ["ace_medical_lastInstigator", _instigator];

    ["ace_medical_woundReceived", [_unit, ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"] apply {[(random [0.5, 0.75, 1]) * _damage, _x, 0]}, _instigator, _woundType]] call CBA_fnc_localEvent;
} else {
    if (isNil "_damage") then {
        _damage = GVAR(damageDealtCrewVanilla);
    };

    {
        _unit setHitPointDamage [_x, (_unit getHitPointDamage _x) + (random [0.5, 0.75, 1]) * _damage, true, _source, _instigator];
    } forEach ["HitFace", "HitNeck", "HitHead", "HitPelvis", "HitAbdomen", "HitDiaphragm", "HitChest", "HitBody", "HitArms", "HitHands", "HitLegs"];
};

// If guaranteed death is wished
if (_guaranteeDeath && {alive _unit}) then {
    // From 'ace_medical_status_fnc_setDead': Kill the unit without changing visual appearance
    private _currentDamage = _unit getHitPointDamage "HitHead";

    _unit setHitPointDamage ["HitHead", 1, true, _source, _instigator];

    _unit setHitPointDamage ["HitHead", _currentDamage, true, _source, _instigator];
};
