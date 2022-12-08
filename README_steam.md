[b]ACE Grenades in hatches - Tweaked[/b] is required on all clients.
This addon allows the user to throw grenades into armored vehicles with hatches. The interaction point is the main interaction point of the vehicle.

The search for a compatible grenade will start by looking at the currently chosen grenade (the one you would throw if you would press the grenade key). If that one is in the list of compatible grenades, it will use that. Otherwise, it will go through a player's uniform first, then vest and finally backpack. On the way it will check starting from the first item on the list of compatible grenades to the end whether a compatible item is found. It will choose the first one found.

[h2]CBA Settings[/h2]
[list]
[*] [b]Damage type applied to Crew:[/b] Adds the option to choose between vanilla and ACE damage.
[*] [b]ACE Damage dealt to Crew:[/b] Allows the setting of the ACE damage applied to the crew of the target vehicle. The damage is applied randomly by both the function and the ACE damage function.
[*] [b]Vanilla Damage dealt to Crew:[/b] Allows the setting of Vanilla damage applied to the crew of the target vehicle. This will be applied either if the setting above is set to 'Vanilla' or if ACE Medical isn't loaded.
[*] [b]Force Crew dismount:[/b] Forces the crew to dismount, regardless of the vehicle damage. This option allows the vehicle to not have to be disabled in order for AI to dismount.
[*] [b]Damage dealt to Vehicle's Hull:[/b] Sets the amount of damage the hull will take from one grenade.
[*] [b]Damage dealt to Vehicle's Engine:[/b] Sets the amount of damage the engine will take from one grenade.
[*] [b]Damage dealt to Vehicle's Turret:[/b] Sets the amount of damage the turret will take from one grenade.
[*] [b]Maximum Hull Damage allowed:[/b] Sets the maximum amount of damage to the hull that can be made by multiple interactions.
[*] [b]Maximum Engine Damage allowed:[/b] Sets the maximum amount of damage to the engine that can be made by multiple interactions.
[*] [b]Maximum Turret Damage allowed:[/b] Sets the maximum amount of damage to the turret that can be made by multiple interactions.
[*] [b]Allowed Grenades:[/b] Allows the user to define which grenades can be used for the action.
[*] [b]Vehicle Blacklist (no Inheritance):[/b] Any vehicle in this list will not have the action enabled. It will only disable the vehicle itself and not its children (which means any classes that inherit from that class).
[*] [b]Vehicle Blacklist (with Inheritance):[/b] Any vehicle and their children in this list will not have the action enabled. You can use this setting to more easily blacklist a family of vehicles.
[*] [b]Vehicle Whitelist (no Inheritance):[/b] Any vehicle in this list will have the action enabled, if the setting below has added the interaction to that class (see whitelist examples). It will only enable the vehicle itself and not its children.
[*] [b]Vehicle Whitelist (with Inheritance):[/b] Any vehicle and their children in this list will have the action enabled. You can use this setting to more easily whitelist a family of vehicles.
[*] [b]Target Awareness:[/b] The target's crew must be in one of the behaviour states defined in the array in order to be able to use the interaction.
[*] [b]Disable Player controlled Targets to be attacked:[/b] If this setting is set to true, any target that has at least 1 player in it will not be able to be ambushed.
[*] [b]Interaction Range:[/b] Sets the maximum interaction range. This can be used to prevent throwing a grenade in a vehicle that has moved 100m away during the time you started the interaction.
[*] [b]Delay to Explosion:[/b] This is the time it will take for an explosion to occur after having successfully used the action.
[*] [b]Interaction Time:[/b] This is time it requires to perform a successful action. It's the minimum if 'Enable Knowledge Multiplier' is enabled.
[*] [b]Enable Knowledge Multiplier:[/b] If this is enabled, it will apply the setting's multiplier that is below.
[*] [b]Knowledge Multiplier:[/b] This is the upper limit to a linear conversion. 'knowsAbout' returns values in [0, 4] which are then converted to [1, this setting]. The resulting value of the linear conversion is multiplied with the interaction time setting to give the final interaction time.
[/list]

[h2]Whitelist Examples[/h2]
If you want to just whitelist e.g. [code]"B_APC_Wheeled_01_cannon_F"[/code]
[list]
[*] Set "no Inheritance" to [code]["B_APC_Wheeled_01_cannon_F"][/code]
[*] Don't change "with Inheritance"
[/list]

If you want to just whitelist multiple vehicles e.g. [code]["B_APC_Wheeled_01_cannon_F","B_MBT_01_TUSK_F"][/code]
[list]
[*] Set "no Inheritance" to [code]["B_APC_Wheeled_01_cannon_F","B_MBT_01_TUSK_F"][/code]
[*] Don't change "with Inheritance"
[/list]

[h2]Grenade List Examples[/h2]
[list]
[*] Vanilla: [code]["HandGrenade","MiniGrenade"][/code]
[*] RHS: [code]["rhs_mag_rgd5","rhs_mag_rgn","rhs_mag_rgo","rhs_grenade_m1939e_mag","rhs_grenade_m1939l_mag","rhs_grenade_m1939e_f_mag","rhs_grenade_m1939l_f_mag","rhs_mag_f1","rhs_grenade_mkii_mag","rhsgref_mag_rkg3em","rhs_charge_sb3kg_mag","rhs_grenade_sthgr24_mag","rhs_grenade_sthgr24_heerfrag_mag","rhs_grenade_sthgr24_SSfrag_mag","rhs_grenade_sthgr24_x7bundle_mag","rhs_grenade_sthgr43_mag","rhs_grenade_sthgr43_heerfrag_mag","rhs_grenade_sthgr43_SSfrag_mag","rhs_charge_tnt_x2_mag","rhs_grenade_khattabka_vog17_mag","rhs_grenade_khattabka_vog25_mag","rhssaf_mag_br_m75","rhssaf_mag_br_m84","rhssaf_mag_brk_m79","rhs_mag_m67"][/code]
[*] CUP: [code]["CUP_HandGrenade_L109A1_HE","CUP_HandGrenade_L109A2_HE","CUP_HandGrenade_M67","CUP_HandGrenade_RGD5","CUP_HandGrenade_RGO"][/code]
[*] BWA: [code]["BWA3_DM51A1"][/code]
[*] FOW: [code]["fow_e_mk2","fow_e_m24K_spli","fow_e_m24_at","fow_e_m24_spli","fow_e_m24","fow_e_m24K","fow_e_no36mk1","fow_e_no69","fow_e_no73","fow_e_no82","fow_e_tnt_halfpound","fow_e_type97","fow_e_type99","fow_e_type99_at"][/code]
[*] IFA: [code]["LIB_F1","LIB_Shg24","LIB_Shg24x7","LIB_M39","LIB_US_Mk_2","LIB_MillsBomb","LIB_No82","LIB_Pwm","LIB_Rg42","LIB_Rpg6"][/code]
[*] CSA: [code]["CSA38_eh39","CSA38_eh392","CSA38_eh393","CSA38_F1","CSA38_rg21","CSA38_rg34","CSA38_rg38","CSA38_shg24","CSA38_shg24t"][/code]
[*] EAW: [code]["EAW_Chinese_Grenade_Mag","EAW_Type91_Mag","EAW_Type91_Trans_Mag","EAW_Type97_Mag"][/code]
[*] Unsung: [code]["uns_f1gren","uns_m61gren","uns_m67gren","uns_mk2gren","uns_mk3a2gren","uns_mk40gren","uns_rg42gren","uns_rgd33gren","uns_rgd5gren","uns_rkg3gren","uns_t67gren","uns_v40gren"][/code]
[*] SOG: [code]["vn_chicom_grenade_mag","vn_f1_grenade_mag","vn_m61_grenade_mag","vn_m67_grenade_mag","vn_rg42_grenade_mag","vn_rgd33_grenade_mag","vn_rgd5_grenade_mag","vn_rkg3_grenade_mag","vn_t67_grenade_mag","vn_v40_grenade_mag","vn_satchelcharge_02_throw_mag"][/code]
[*] Global Mobilization: [code]["gm_handgrenade_conc_dm51","gm_handgrenade_conc_dm51a1","gm_handgrenade_frag_dm51","gm_handgrenade_frag_dm51a1","gm_handgrenade_frag_rgd5"][/code]
[*] CSLA: [code]["CSLA_F1","US85_M67","CSLA_RG4o","CSLA_RG4u","CSLA_URG86u","CSLA_URG86o"][/code]
[/list]

[h2]Links[/h2]
[list]
[*] [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2418896377]Steam Workshop[/url]
[*] [url=https://github.com/johnb432/ACE-grenades-in-hatches]GitHub[/url]
[/list]

[h2]Credit[/h2]

Launchman for making the [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2398240266]original mod[/url] and allowing me to edit his version, many thanks!
