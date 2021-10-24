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
            "ace_interact_menu"
        };
        author = "johnb43";
        authors[] = {"Launchman", "johnb43"};
        VERSION_CONFIG;
    };
};

class CfgMods {
    class PREFIX {
        name = "ACE Grenades in hatches - Tweaked";
        author = "johnb43, Launchman";
        tooltipOwned = "ACE Grenades in hatches - Tweaked";
        hideName = 0;
        hidePicture = 0;
        actionName = "Github";
        action = "https://github.com/johnb432/ACE-grenades-in-hatches";
        description = "A small mod that allows users to drop grenades into armored vehicles.";
        overview = "A small mod that allows users to drop grenades into armored vehicles.";
        overviewPicture = "\x\grenades_hatches\addons\main\ui\logo_ace_grenades_in_hatches_tweaked.paa"; // http://www.clipartbest.com/clipart-LTKkM9pxc
        logo = "\x\grenades_hatches\addons\main\ui\logo_ace_grenades_in_hatches_tweaked.paa";
        picture = "\x\grenades_hatches\addons\main\ui\logo_ace_grenades_in_hatches_tweaked.paa";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
