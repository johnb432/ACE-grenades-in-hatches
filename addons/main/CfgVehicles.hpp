class CfgVehicles {
    class LandVehicle;
    class Tank: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(dropGrenade) {
                    condition = QUOTE(ARR2(_player,_target) call FUNC(conditionThrow));
                    displayName = "Drop Grenade";
                    exceptions[] = {"isNotSwimming"};
                    statement = QUOTE(_target call FUNC(throwGrenade));
                };
            };
        };
    };
};
