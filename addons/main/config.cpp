#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "A3_Data_F_AoW_Loadorder",
            "ace_common",
            "ace_interact_menu",
            "cba_main",
            "cba_xeh"
        };
        author = "johnb43, Launchman";
        authors[] = {"johnb43", "Launchman"};
        url = "https://github.com/johnb432/ACE-grenades-in-hatches";
        skipWhenMissingDependencies = 1;
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
