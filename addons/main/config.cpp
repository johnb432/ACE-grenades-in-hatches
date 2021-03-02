class CfgPatches
{
	class launch_grenade_dropper
	{
		name="Grenades In Tank Hatches for ACE";
		units[]={};
		weapons[]={};
		requiredVersion=1;
		requiredAddons[]=
		{
			"ace_interact_menu"
		};
		author="Launchman";
		authorUrl="https://steamcommunity.com/app/107410/discussions/10/1743394388078194502/";
	};
};
class Extended_PreInit_EventHandlers
{
	class launch_grenade_dropper
	{
		init="call compile preProcessFileLineNumbers '\launch\launch_grenade_dropper\XEH_preInit.sqf'";
	};
};
class Extended_PostInit_EventHandlers
{
	class launch_grenade_dropper
	{
		init="call compile preProcessFileLineNumbers '\launch\launch_grenade_dropper\XEH_postInit.sqf'";
	};
};
class CfgMods
{
	class Mod_Base;
	class launch_grenade_dropper: Mod_Base
	{
		logo="\launch\launch_grenade_dropper\data\Launch_Icon.paa";
	};
};
