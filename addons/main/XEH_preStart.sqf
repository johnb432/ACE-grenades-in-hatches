#include "script_component.hpp"

#include "XEH_PREP.hpp"

// From ace_weaponselect
private _grenadesFrag = createHashMap;

private _throw = configFile >> "CfgWeapons" >> "Throw";
private _cfgAmmo = configFile >> "CfgAmmo";
private _cfgMagazines = configFile >> "CfgMagazines";

{
    {
        if (getNumber (_cfgAmmo >> getText (_cfgMagazines >> _x >> "ammo") >> "explosive") != 0) then {
            _grenadesFrag set [_x, nil];
        };
    } forEach getArray (_throw >> _x >> "magazines");
} forEach getArray (_throw >> "muzzles");

uiNamespace setVariable [QGVAR(grenadesFrag), compileFinal _grenadesFrag];
