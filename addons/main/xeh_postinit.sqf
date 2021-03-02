Grenade_Drop_Types =Grenade_Drop_Types splitString ",";
compatibleGrenades = [];
compatibleGrenades = Grenade_Drop_Types;

_condition = {
  (_target knowsAbout _player < 1) && (count (compatibleGrenades arrayIntersect magazines _player) > 0) && (side _target != side _player) && ((vectorMagnitude velocity _target) < 1);
};

_progressbar = {
  playSound3D ["A3\Sounds_F\weapons\Grenades\handgrenade_drops\handg_drop_Metal_2.wss", _target];
  [4, _target, {
  params ["_target"];
  bomb = "APERSTripMine_Wire_Ammo" createVehicle (getPos _target);
  bomb attachTo [_target, [0,0,-1]];
  bomb setDamage 1;
  _target setHitPointDamage ["hitEngine", 1];
  _target setHitPointDamage ["hitHull", 0.75];
  _target setHitPointDamage ["hitTurret", 1];
  { _x setDamage 1 } forEach crew _target;
  _player removeItem ((compatibleGrenades arrayIntersect magazines _player) select 0);
}, {}, "Dropping Grenade", {true}] call ace_common_fnc_progressBar ;
};

_action = ["Drop Grenade", "Drop Grenade", "",_progressbar,_condition] call ace_interact_menu_fnc_createAction;
["Tank", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
