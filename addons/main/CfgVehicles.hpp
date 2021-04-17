class CfgVehicles {
    class LandVehicle;
    class Tank: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(dropGrenade) {
                    condition = QUOTE([ARR_2(_player,_target)] call FUNC(dropCondition));
                    displayName = "Drop Grenade in hatch";
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(dropGrenade));
                };
            };
        };
    };

    class Car: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {};
        };
    };
    class Car_F: Car {
        class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {};
        };
    };
    class Wheeled_Apc_F: Car_F {
        class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {
                class GVAR(dropGrenade) {
                    condition = QUOTE([ARR_2(_player,_target)] call FUNC(dropCondition));
                    displayName = "Drop Grenade in hatch";
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(dropGrenade));
                };
            };
        };
    };
};
