# ACE Grenades in hatches - Tweaked

[Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2418896377)<br/>
[GitHub](https://github.com/johnb432/ACE-grenades-in-hatches)

## Content

This mod is required on all clients.
This addon allows the user to throw grenades into armored vehicles with hatches. The interaction point is the main interaction point of the vehicle.

Multiple CBA settings for customization:
* **Allowed Grenades:** Allows the user to define which grenades can be used for the action.
* **Blacklist Vehicles (no inheritance):** Any vehicle in this list will not have the action enabled. It will only disable the vehicle itself and not its children (which means any classes that inherit from that class).
* **Blacklist Vehicles (with inheritance):** Any vehicle and their children in this list will not have the action enabled. You can use this setting to more easily blacklist a family of vehicles.
* **Target awareness:** The target's crew must be in one of the behaviour states defined in the array in order to be able to use the interaction.
* **Disable player controlled targets to be attacked:** If this setting is set to true, any target that has at least 1 player in it will not be able to be ambushed.
* **Interaction range:** Sets the maximum interaction range. This can be used to prevent throwing a grenade in a vehicle that has moved 100m away during the time you started the interaction.
* **Damage dealt to units:** Allows the setting of the ACE damage applied to the crew of the target vehicle. The damage is applied randomly by both the function and the ACE damage function.
* **Damage dealt to hull:** Sets the amount of damage the hull will take from one grenade.
* **Damage dealt to engine:** Sets the amount of damage the engine will take from one grenade.
* **Damage dealt to turret:** Sets the amount of damage the turret will take from one grenade.
* **Maximum hull damage allowed:** Sets the maximum amount of damage to the hull that can be made by multiple interactions.
* **Maximum engine damage allowed:** Sets the maximum amount of damage to the engine that can be made by multiple interactions.
* **Maximum turret damage allowed:** Sets the maximum amount of damage to the turret that can be made by multiple interactions.
* **Delay to explosion:** This is the time it will take for an explosion to occur after having successfully used the action.
* **Interaction time:** This is time it requires to perform a successful action.

## Credit

<b>Launchman</b> for making the [original mod](https://steamcommunity.com/sharedfiles/filedetails/?id=2398240266) and allowing me to edit his version, many thanks!
