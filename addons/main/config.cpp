#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "ace_interact_menu"
        };
        author = "johnb43, Launchman";
        authors[] = {"johnb43", "Launchman"};
        url = "https://github.com/johnb432/ACE-grenades-in-hatches";
        skipWhenMissingDependencies = 1;
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
