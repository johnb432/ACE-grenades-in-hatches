#include "script_component.hpp"

// Injures a unit only if allowDamage is true
[QGVAR(medicalDamage), {
    params ["_unit", "_bodyPart"];

    if (isDamageAllowed _unit) then {
        [_unit, GVAR(damageDealtCrew), _bodyPart, "grenade"] call ace_medical_fnc_addDamageToUnit;
    };
}] call CBA_fnc_addEventHandler;

// Has to be done using an event, because setHitPointDamage isn't working as described on the wiki page
[QGVAR(vehicleDamage), {
    params ["_target"];

    private _players = [];

    {
        if (isPlayer _x) then {_players pushBack _x};
    } forEach (crew _target);

    if (_players isNotEqualTo []) then {
        ["Someone threw a grenades into the hatch!!!", true, GVAR(delayExplosion), 10] remoteExecCall ["ace_common_fnc_displayText", _players];
    };

    playSound3D ["A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss", _target];

    _player removeMagazine ((GVAR(allowedGrenades) arrayIntersect (magazines _player)) select 0);

    [{
       params ["_player", "_target"];

       private _explosion = "mini_Grenade" createVehicle (getPosATL _target);
       _explosion attachTo [_target, [0, 0, -1]];
       _explosion setShotParents [_player, _player];
       _explosion setDamage 1;

       [{
           (_this select 0) isEqualTo objNull
       }, {
           params ["_explosion", "_player", "_target"];

           private _arrayDamages = [GVAR(damageDealtEngine), GVAR(damageDealtHull), GVAR(damageDealtTurret)];
           private _arrayMaxDamages = [GVAR(damageDealtEngineMax), GVAR(damageDealtHullMax), GVAR(damageDealtTurretMax)];
           private _currentDamage;
           private _calculatedDamage;
           private _maxDamage;

           {
               _currentDamage = _target getHitPointDamage _x;
               _calculatedDamage = _currentDamage + (_arrayDamages select _forEachIndex);
               _maxDamage = _arrayMaxDamages select _forEachIndex;

               if (_currentDamage > _maxDamage) then {
                   _calculatedDamage = _currentDamage;
               };

               _target setHitPointDamage [_x, (_maxDamage min _calculatedDamage)];
           } forEach ["hitEngine", "hitHull", "hitTurret"];

           if (GVAR(damageDealtCrew) isEqualTo 0) exitWith {};

           private _allBodyParts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];

           // Use event in case the crew isn't local; e.g, 2+ players in one vehicle
           {
               [QGVAR(medicalDamage), [_x, (selectRandom _allBodyParts)], _x] call CBA_fnc_targetEvent;
           } forEach (crew _target);
       }, [_explosion, _player, _target]] call CBA_fnc_waitUntilAndExecute;
    }, [_player, _target], GVAR(delayExplosion) - 2.5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
