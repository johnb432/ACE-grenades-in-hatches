#include "script_component.hpp"

class CfgPatches {
				class ADDON {
								name = COMPONENT_NAME;
								units[] = {};
								weapons[] = {};
								requiredVersion = REQUIRED_VERSION;
								requiredAddons[] = {
												"cba_main",
												"ace_common",
												"ace_interact_menu",
												"ace_medical"
								};
								authors[] = {"Launchman", "johnb43"};
				};
};

class CfgMods {
				class Mod_Base;
				class ADDON: Mod_Base {
								logo = "\x\grenades_hatches\addons\main\data\launch_icon.paa";
				};
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
