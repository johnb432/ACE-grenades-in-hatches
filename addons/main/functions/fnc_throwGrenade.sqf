#include "script_component.hpp"

/*
 * Author: Launchman, johnb43
 * "Throws" a grenade inside of an armored vehicle.
 *
 * Arguments:
 * 0: Target vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * call grenades_hatches_main_fnc_throwGrenade;
 *
 * Public: No
 */

params ["_target"];

[GVAR(delayInteraction), _target, {
    params ["_target"];

    playSound3D ["A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss", _target];

    _player removeMagazine ((GVAR(allowedGrenades) arrayIntersect (magazines _player)) select 0);

    [{
       params ["_player", "_target"];

       private _explosion = "APERSTripMine_Wire_Ammo" createVehicle (getPosATL _target);
       _explosion attachTo [_target, [0, 0, -1]];
       _explosion setShotParents [_player, _player];
       _explosion setDamage 1;

       _target setHitPointDamage ["hitEngine", (GVAR(damageDealtEngine) max (_target getHitPointDamage "hitEngine"))];
       _target setHitPointDamage ["hitHull", (GVAR(damageDealtHull) max (_target getHitPointDamage "hitHull"))];
       _target setHitPointDamage ["hitTurret", (GVAR(damageDealtTurret) max (_target getHitPointDamage "hitTurret"))];

       if (GVAR(damageDealtCrew) isEqualTo 0) exitWith {};

       private _allBodyParts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];

       {
           private _bodyPart = selectRandom _allBodyParts;

           if (local _x) then {
               [_x, GVAR(damageDealtCrew), _bodyPart, "grenade"] call ace_medical_fnc_addDamageToUnit;
           } else {
               [_x, GVAR(damageDealtCrew), _bodyPart, "grenade"] remoteExecCall ["ace_medical_fnc_addDamageToUnit", _x];
           };
       } forEach (crew _target);
    }, [_player, _target], GVAR(delayExplosion)] call CBA_fnc_waitAndExecute;
}, {}, "Dropping Grenade"] call ace_common_fnc_progressBar;
