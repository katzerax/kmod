# KMod
Small collection of Webfishing features

### Current features as of 1.6.0:
- **SizeChanger**: Change size by holding comma or period. Reset with slash. Saves player size after 6 seconds have passed after changing size. Loads player size on lobby connect.
   - **UPDATE AS OF GAME VERSION 1.09**: Because of newly built in game limitations on size, the player can only shrink to a player size of 0.6 or grow to a player size of 1.4 just using gdscript. This is still outside of the range you can get with sodas, but is not close to the original range of size changing. I added support in 1.5.0 for the mod [SizeUnlocker](https://github.com/Nowaha/SizeUnlocker). This will let you go beyond the current vanilla limitations, and is required if you want to see other players beyond those sizes.

- **KeybindFix**: Open and Close OptionsMenu on boot. This loads in custom key binds that the game otherwise waits for you to open your options menu to initialize. Not impactful to performance.

You can enable or disable any of the features using the config file located under ```GDWeave/configs/KMod.json```. This will only generate after the first time launching the game with this mod installed. This can be done manually by editing the json, or through [Hook Line & Sinker](https://github.com/pyoidzzz/HLSRewritten) through the config editor, or through [TackleBox](https://github.com/puppy-girl/TackleBox)'s in game mod menu, or through [r2modman](https://github.com/ebkr/r2modmanPlus/releases/latest)'s config editor. 

Modifying the config requires a game restart to apply changes. 

## Installing:
- [Installation Guide](https://github.com/katzerax/kmod/wiki/Installation)
    - [r2modman](https://github.com/katzerax/kmod/wiki/Installation#r2modman)
    - [Gale Mod Manager](https://github.com/katzerax/kmod/wiki/Installation#gale-mod-manager)
    - [Hook Line & Sinker](https://github.com/katzerax/kmod/wiki/Installation#hook-line--sinker)
    - [Manual](https://github.com/katzerax/kmod/wiki/Installation#manual)
- [Optional Dependencies](https://github.com/katzerax/kmod/wiki/Installation#optional-dependencies)

## Contributing:
- [Setting up a Developer Environment](https://github.com/katzerax/kmod/wiki/Contributing#setting-up-a-developer-environment)
- [Inserting KMod into the Developer Environment](https://github.com/katzerax/kmod/wiki/Contributing#inserting-kmod-into-the-developer-environment)
- [Exporting Cleanly](https://github.com/katzerax/kmod/wiki/Contributing#exporting-cleanly)
- [Contributing to this GitHub repository](https://github.com/katzerax/kmod/wiki/Contributing#contributing-to-this-github-repository)
