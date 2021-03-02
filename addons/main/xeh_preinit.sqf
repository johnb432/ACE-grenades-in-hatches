[
    "Grenade_Drop_Types", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "EDITBOX", // setting type
    ["Compatible Grenades","The array of classnames of grenades that can be used. Can be added to and modified. Format is: <classname1,classname2,classname3>"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Grenades in Tank Hatches", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    "HandGrenade,MiniGrenade", // data for this setting: <string>
    true // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;
