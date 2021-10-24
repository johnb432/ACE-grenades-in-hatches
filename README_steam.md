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
[*] [b]Target Awareness:[/b] The target's crew must be in one of the behaviour states defined in the array in order to be able to use the interaction.
[*] [b]Disable Player controlled Targets to be attacked:[/b] If this setting is set to true, any target that has at least 1 player in it will not be able to be ambushed.
[*] [b]Interaction Range:[/b] Sets the maximum interaction range. This can be used to prevent throwing a grenade in a vehicle that has moved 100m away during the time you started the interaction.
[*] [b]Delay to Explosion:[/b] This is the time it will take for an explosion to occur after having successfully used the action.
[*] [b]Interaction Time:[/b] This is time it requires to perform a successful action. It's the minimum if 'Enable Knowledge Multiplier' is enabled.
[*] [b]Enable Knowledge Multiplier:[/b] If this is enabled, it will apply the setting's multiplier that is below.
[*] [b]Knowledge Multiplier:[/b] This is the upper limit to a linear conversion. 'knowsAbout' returns values in [0, 4] which are then converted to [1, this setting]. The resulting value of the linear conversion is multiplied with the interaction time setting to give the final interaction time.
[/list]

[h2]Links[/h2]
[list]
[*] [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2418896377]Steam Workshop[/url]
[*] [url=https://github.com/johnb432/ACE-grenades-in-hatches]GitHub[/url]
[/list]

[h2]Credit[/h2]

Launchman for making the [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2398240266]original mod[/url] and allowing me to edit his version, many thanks!

[h2]How to create PBOs[/h2]
[list]
[*] Download and install hemtt from [url=https://github.com/BrettMayson/HEMTT]here[/url]
[*] Open command terminal, navigate to said folder (Windows: cd 'insert path')
[*] Type "hemtt build" for pbo, "hemtt build --release" for entire release
[/list]
