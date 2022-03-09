**ACE Grenades in hatches - Tweaked** is required on all clients.
This addon allows the user to throw grenades into armored vehicles with hatches. The interaction point is the main interaction point of the vehicle.

The search for a compatible grenade will start by looking at the currently chosen grenade (the one you would throw if you would press the grenade key). If that one is in the list of compatible grenades, it will use that. Otherwise, it will go through a player's uniform first, then vest and finally backpack. On the way it will check starting from the first item on the list of compatible grenades to the end whether a compatible item is found. It will choose the first one found.

<h2>CBA Settings</h2>

* **Damage type applied to Crew:** Adds the option to choose between vanilla and ACE damage.
* **ACE Damage dealt to Crew:** Allows the setting of the ACE damage applied to the crew of the target vehicle. The damage is applied randomly by both the function and the ACE damage function.
* **Vanilla Damage dealt to Crew:** Allows the setting of Vanilla damage applied to the crew of the target vehicle. This will be applied either if the setting above is set to 'Vanilla' or if ACE Medical isn't loaded.
* **Force Crew dismount:** Forces the crew to dismount, regardless of the vehicle damage. This option allows the vehicle to not have to be disabled in order for AI to dismount.
* **Damage dealt to vehicle's Hull:** Sets the amount of damage the hull will take from one grenade.
* **Damage dealt to vehicle's Engine:** Sets the amount of damage the engine will take from one grenade.
* **Damage dealt to vehicle's Turret:** Sets the amount of damage the turret will take from one grenade.
* **Maximum Hull Damage allowed:** Sets the maximum amount of damage to the hull that can be made by multiple interactions.
* **Maximum Engine Damage allowed:** Sets the maximum amount of damage to the engine that can be made by multiple interactions.
* **Maximum Turret Damage allowed:** Sets the maximum amount of damage to the turret that can be made by multiple interactions.
* **Allowed Grenades:** Allows the user to define which grenades can be used for the action.
* **Vehicle Blacklist (no Inheritance):** Any vehicle in this list will not have the action enabled. It will only disable the vehicle itself and not its children (which means any classes that inherit from that class).
* **Vehicle Blacklist (with Inheritance):** Any vehicle and their children in this list will not have the action enabled. You can use this setting to more easily blacklist a family of vehicles.
* **Vehicle Whitelist (no Inheritance):** Any vehicle in this list will have the action enabled, if the setting below has added the interaction to that class (see whitelist examples). It will only enable the vehicle itself and not its children.
* **Vehicle Whitelist (with Inheritance):** Any vehicle and their children in this list will have the action enabled. You can use this setting to more easily whitelist a family of vehicles.
* **Target Awareness:** The target's crew must be in one of the behaviour states defined in the array in order to be able to use the interaction.
* **Disable Player controlled Targets to be attacked:** If this setting is set to true, any target that has at least 1 player in it will not be able to be ambushed.
* **Interaction Range:** Sets the maximum interaction range. This can be used to prevent throwing a grenade in a vehicle that has moved 100m away during the time you started the interaction.
* **Delay to Explosion:** This is the time it will take for an explosion to occur after having successfully used the action.
* **Interaction Time:** This is time it requires to perform a successful action. It's the minimum if 'Enable Knowledge Multiplier' is enabled.
* **Enable Knowledge Multiplier:** If this is enabled, it will apply the setting's multiplier that is below.
* **Knowledge Multiplier:** This is the upper limit to a linear conversion. 'knowsAbout' returns values in [0, 4] which are then converted to [1, this setting]. The resulting value of the linear conversion is multiplied with the interaction time setting to give the final interaction time.

<h2>Whitelist Examples</h2>

If you want to just whitelist e.g. `["B_APC_Wheeled_01_cannon_F"]`.:
- Set both CBA whitelist settings to `["B_APC_Wheeled_01_cannon_F"]`.

If you want to whitelist multiple vehicles e.g `["B_APC_Wheeled_01_cannon_F","B_MBT_01_TUSK_F"]`:
- Set "no Inheritance" to `["B_APC_Wheeled_01_cannon_F","B_MBT_01_TUSK_F"]`
- Set "with Inheritance" to either the above aswell or `["AllVehicles"]` (or the lowest common parent - which would be `"LandVehicle"` in this case)

<h2>Grenade List Examples</h2>
- Vanilla: ["HandGrenade","MiniGrenade"]
- RHS: ["rhs_mag_rgd5","rhs_mag_rgn","rhs_mag_rgo","rhs_grenade_m1939e_mag","rhs_grenade_m1939l_mag","rhs_grenade_m1939e_f_mag","rhs_grenade_m1939l_f_mag","rhs_mag_f1","rhs_grenade_mkii_mag","rhsgref_mag_rkg3em","rhs_charge_sb3kg_mag","rhs_grenade_sthgr24_mag","rhs_grenade_sthgr24_heerfrag_mag","rhs_grenade_sthgr24_SSfrag_mag","rhs_grenade_sthgr24_x7bundle_mag","rhs_grenade_sthgr43_mag","rhs_grenade_sthgr43_heerfrag_mag","rhs_grenade_sthgr43_SSfrag_mag","rhs_charge_tnt_x2_mag","rhs_grenade_khattabka_vog17_mag","rhs_grenade_khattabka_vog25_mag","rhssaf_mag_br_m75","rhssaf_mag_br_m84","rhssaf_mag_brk_m79","rhs_mag_m67"]
- BWA: ["BWA3_DM51A1"]
- FOW: ["fow_e_mk2","fow_e_m24K_spli","fow_e_m24_at","fow_e_m24_spli","fow_e_m24","fow_e_m24K","fow_e_no36mk1","fow_e_no69","fow_e_no73","fow_e_no82","fow_e_tnt_halfpound","fow_e_type97","fow_e_type99","fow_e_type99_at"]
- IFA: ["LIB_F1","LIB_Shg24","LIB_Shg24x7","LIB_M39","LIB_US_Mk_2","LIB_MillsBomb","LIB_No82","LIB_Pwm","LIB_Rg42","LIB_Rpg6"]
- CSA: ["CSA38_eh39","CSA38_eh392","CSA38_eh393","CSA38_F1","CSA38_rg21","CSA38_rg34","CSA38_rg38","CSA38_shg24","CSA38_shg24t"]
- EAW: ["EAW_Chinese_Grenade_Mag","EAW_Type91_Mag","EAW_Type91_Trans_Mag","EAW_Type97_Mag"]

<h2>Links</h2>

* [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2418896377)
* [GitHub](https://github.com/johnb432/ACE-grenades-in-hatches)

<h2>Credit</h2>

Launchman for making the [original mod](https://steamcommunity.com/sharedfiles/filedetails/?id=2398240266) and allowing me to edit his version, many thanks!

<h2>How to create PBOs</h2>

* Download and install hemtt from [here](https://github.com/BrettMayson/HEMTT)
* Open command terminal, navigate to said folder (Windows: cd 'insert path')
* Type "hemtt build" for pbo, "hemtt build --release" for entire release
