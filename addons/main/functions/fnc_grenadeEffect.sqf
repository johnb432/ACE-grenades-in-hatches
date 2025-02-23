#include "..\script_component.hpp"
/*
 * Author: Larrow, johnb43
 * Spawns a grenade's visual effects.
 * https://forums.bohemia.net/forums/topic/199056-need-to-make-a-small-explosion-on-trigger/?do=findComment&comment=3123988
 *
 * Arguments:
 * 0: Position AGL where to spawn visual effect at <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * (ASLToAGL getPosASL cursorObject) call grenades_hatches_main_fnc_grenadeEffect;
 *
 * Public: No
 */

// Create blast effect
private _source1 = "#particlesource" createVehicleLocal _this;
_source1 setParticleClass "AmmoExpSparks";
_source1 setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 0, 32, 0],
    "",
    "Billboard",
    0.3,
    0.3,
    [0, 0, 0],
    [0, 1, 0],
    0,
    10,
    7.9,
    0.1,
    [0.0125 * 0.3 + 4, 0.0125 * 0.3 + 1],
    [[1, 1, 1, -6], [1, 1, 1, 0]],
    [1],
    0.2,
    0.2,
    "",
    "",
    "",
    0,
    false,
    0.6,
    [[30, 30, 30, 0], [0, 0, 0, 0]]
];
_source1 setParticleRandom [
    0,
    [0.4, 0.1, 0.4],
    [0.2, 0.5, 0.2],
    90,
    0.5,
    [0, 0, 0, 0],
    0,
    0,
    1,
    0.0
];
_source1 setParticleCircle [0, [0, 0, 0]];

// Create smoke effect
private _source2 = "#particlesource" createVehicleLocal _this;
_source2 setParticleClass "AmmoLightSmokeParticles";
_source2 setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 9, 1, 0],
    "",
    "Billboard",
    1,
    8,
    [0, 0, 0],
    [0, 1.5, 0],
    0,
    0.0522,
    0.04,
    0.24,
    [0.013 * 8 + 3, 0.0125 * 8 + 6, 0.013 * 8 + 8, 0.013 * 8 + 10],
    [[0.7, 0.7, 0.7, 0.36], [0.8, 0.8, 0.8, 0.24], [0.85, 0.85, 0.85, 0.14], [0.9, 0.9, 0.9, 0.08], [0.9, 0.9, 0.9, 0.04], [1, 1, 1, 0.01]],
    [1000],
    0.2,
    0.2,
    "",
    "",
    "",
    0,
    false,
    0.6,
    [[30, 30, 30, 0], [0, 0, 0, 0]]
];
_source2 setParticleRandom [
    2,
    [0.8, 0.2, 0.8],
    [2.5, 3.5, 2.5],
    3,
    0.4,
    [0, 0, 0, 0],
    0.5,
    0.02,
    1,
    0.0
];
_source2 setParticleCircle [0, [0, 0, 0]];
_source2 setDropInterval 0.08;

// Create lighting change
private _light = "#lightPoint" createVehicleLocal _this;
_light setLightAmbient [0, 0, 0];
_light setLightBrightness 10;
_light setLightColor [1, 0.6, 0.4];
_light setLightIntensity 10000;
_light setLightAttenuation [0, 0, 0, 2.2, 500, 1000];

// Delete objects after set amount of time
[{deleteVehicle _this}, [_source1, _light], 0.3] call CBA_fnc_waitAndExecute;
[{deleteVehicle _this}, _source2, 5] call CBA_fnc_waitAndExecute;
