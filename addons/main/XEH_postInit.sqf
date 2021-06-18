#include "script_component.hpp"

// Injures a unit only if allowDamage is true
[QGVAR(medicalDamage), {
    params ["_unit", "_bodyPart"];

    // Don't apply damage to unit if invulnerable
    if (!isDamageAllowed _unit) exitWith {};

    [_unit, GVAR(damageDealtCrew), _bodyPart, "grenade"] call ace_medical_fnc_addDamageToUnit;
}] call CBA_fnc_addEventHandler;

// Local event raised when progressbar is done
[QGVAR(dropGrenadeEvent), {
    (_this select 0) params ["_player", "_target"];

    private _players = (crew _target) select {isPlayer _x};

    // If a player amoung the crew, inform them of the grenade
    if (_players isNotEqualTo []) then {
        ["Someone threw a grenade into the hatch!!!", true, GVAR(delayExplosion) min 5, 10] remoteExecCall ["ace_common_fnc_displayText", _players];
    };

    // Play grenade pin pulling sound
    playSound3D ["A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss", _target, false, getPos _target, 5, 1, 20];

    // removeMagazine makes UI buggy
    _player removeItem ((GVAR(allowedGrenades) arrayIntersect (magazines _player)) select 0);

    [QGVAR(vehicleDamage), [_player, _target], _target] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

// Has to be done using an event, because setHitPointDamage isn't working as described on the wiki page
[QGVAR(vehicleDamage), {
    params ["_player", "_target"];

    [{
        params ["_player", "_target"];

        private _explosion = "mini_Grenade" createVehicle [0, 0, 0];
        _explosion attachTo [_target, [0, 0, -1]];
        _explosion setShotParents [_player, _player];
        _explosion setDamage 1;

        [{
            (_this select 0) isEqualTo objNull
        }, {
            params ["_explosion", "_target"];

            private _arrayDamages = [GVAR(damageDealtEngine), GVAR(damageDealtHull), GVAR(damageDealtTurret)];
            private _arrayMaxDamages = [GVAR(damageDealtEngineMax), GVAR(damageDealtHullMax), GVAR(damageDealtTurretMax)];
            private _currentDamage;
            private _calculatedDamage;
            private _maxDamage;

            // Apply damage
            {
                _currentDamage = _target getHitPointDamage _x;
                _calculatedDamage = _currentDamage + (_arrayDamages select _forEachIndex);
                _maxDamage = _arrayMaxDamages select _forEachIndex;

                if (_currentDamage > _maxDamage) then {
                    _calculatedDamage = _currentDamage;
                };

                _target setHitPointDamage [_x, (_maxDamage min _calculatedDamage)];
            } forEach ["hitEngine", "hitHull", "hitTurret"];

            private _crew = crew _target;

            if (GVAR(damageDealtCrew) isNotEqualTo 0) then {
                private _allBodyParts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];

                // Use event in case the crew isn't local; e.g, 2+ players in one vehicle
                {
                    [QGVAR(medicalDamage), [_x, selectRandom _allBodyParts], _x] call CBA_fnc_targetEvent;
                } forEach _crew;
            };

            // If vehicle is immobile or forceCrewDismount is true, continue and do stuff with weapons
            if (canMove _target && !GVAR(forceCrewDismount)) exitWith {};

            // Get rid of weapons in vehicles, so that AI stop shooting
            private _turretWeapons;

            {
                _x params ["_unit", "_role", "", "_turretPath"];

                // Don't include driver position
                if (_role isEqualTo "driver") then {
                     continue;
                };

                // Get the unit's turret's weapons
                _turretWeapons = _target weaponsTurret _turretPath;
                _unit setVariable [QGVAR(turretPath), _turretPath, true];
                _unit setVariable [QGVAR(turretWeapons), _turretWeapons, true];

                // Remove all weapons from unit's turret
                {
                    _target removeWeaponTurret [_x, _turretPath];
                } forEach _turretWeapons;
            } forEach fullCrew [_target, "", false];

            [{
                params ["_crew", "_target"];

                // Forces the crew to dismount and stay dismounted, if option is enabled
                {
                    [{
                        params ["_args", "_handleid"];
                        _args params ["_unit", "_target"];

                        // If crew member died, dismounted or if vehicle has been destroyed, stop checking
                        if (!alive _unit || isNull objectParent _unit || isNull _target) exitWith {
                            // Remove PFH
                            _handleid call CBA_fnc_removePerFrameHandler;

                            // Get weapons and role
                            private _turretPath = _unit getVariable [QGVAR(turretPath), []];
                            private _turretWeapons = _unit getVariable [QGVAR(turretWeapons), []];

                            // Delete variables
                            _unit setVariable [QGVAR(turretPath), nil, true];
                            _unit setVariable [QGVAR(turretWeapons), nil, true];

                            // If not in a turret, don't add weapons back
                            if (_turretPath isEqualTo [] || _turretWeapons isEqualTo []) exitWith {};

                            // Add all weapons back to unit's turret
                            {
                                _target addWeaponTurret [_x, _turretPath];
                            } forEach _turretWeapons;
                        };

                        // If unconscious, do not eject
                        if (_unit getVariable ["ACE_isUnconscious", false]) exitWith {};

                        // Remove PFH
                        _handleid call CBA_fnc_removePerFrameHandler;

                        // Eject unit from vehicle
                        _unit action ["Eject", _target];

                        // Enable the weapons after 3 seconds again. Prevents AI from firing while dismounting.
                        [{
                            params ["_unit", "_target"];

                            // Get weapons and role
                            private _turretPath = _unit getVariable [QGVAR(turretPath), []];
                            private _turretWeapons = _unit getVariable [QGVAR(turretWeapons), []];

                            // Delete variables
                            _unit setVariable [QGVAR(turretPath), nil, true];
                            _unit setVariable [QGVAR(turretWeapons), nil, true];

                            // If not in a turret, don't add weapons back
                            if (_turretPath isEqualTo [] || _turretWeapons isEqualTo []) exitWith {};

                            // Add all weapons back to unit's turret
                            {
                                _target addWeaponTurret [_x, _turretPath];
                            } forEach _turretWeapons;
                        }, [_unit, _target], 3] call CBA_fnc_waitAndExecute;
                    }, 1, [_x, _target]] call CBA_fnc_addPerFrameHandler;
                } forEach _crew;

                _crew allowGetIn false;
            }, [_crew, _target], 3] call CBA_fnc_waitAndExecute;
        }, [_explosion, _target]] call CBA_fnc_waitUntilAndExecute;
    }, [_player, _target], GVAR(delayExplosion) - 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
