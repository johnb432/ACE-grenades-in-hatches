// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp
#define MAINPREFIX x
#define PREFIX grenades_hatches

#include "script_version.hpp"

#define VERSION     MAJOR.MINOR
#define VERSION_STR MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR  MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 2.02
#define REQUIRED_CBA_VERSION {3,12,2}

#define COMPONENT_NAME QUOTE(ACE Grenades in hatches - Tweaked)
