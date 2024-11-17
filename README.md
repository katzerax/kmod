# KMod
Small collection of Webfishing features

### Current features as of 1.6.0:
- **SizeChanger**: Change size by holding comma or period. Reset with slash. Saves player size after 6 seconds have passed after changing size. Loads player size on lobby connect.
   - **UPDATE AS OF GAME VERSION 1.09**: Because of newly built in game limitations on size, the player can only shrink to a player size of 0.6 or grow to a player size of 1.4 just using gdscript. This is still outside of the range you can get with sodas, but is not close to the original range of size changing. I added support in 1.5.0 for the mod [SizeUnlocker](https://github.com/Nowaha/SizeUnlocker). This will let you go beyond the current vanilla limitations, and is required if you want to see other players beyond those sizes.

- **KeybindFix**: Open and Close OptionsMenu on boot. This loads in custom key binds that the game otherwise waits for you to open your options menu to initialize. Not impactful to performance.

You can enable or disable any of the features using the config file located under ```GDWeave/configs/KMod.json```. This will only generate after the first time launching the game with this mod installed. This can be done manually by editing the json, or through [Hook Line & Sinker](https://github.com/pyoidzzz/HLSRewritten) through the config editor, or through [TackleBox](https://github.com/puppy-girl/TackleBox)'s in game mod menu, or through r2modman's config editor. Modifying the config requires a game restart to apply changes. 

## Installing
- [Installation Guide](https://github.com/katzerax/kmod/wiki/Installation)
    - [r2modman](https://github.com/katzerax/kmod/wiki/Installation#r2modman)
    - [Gale Mod Manager](https://github.com/katzerax/kmod/wiki/Installation#gale-mod-manager)
    - [Hook Line & Sinker](https://github.com/katzerax/kmod/wiki/Installation#hook-line--sinker)
    - [Manual](https://github.com/katzerax/kmod/wiki/Installation#manual)
- [Optional Dependencies](https://github.com/katzerax/kmod/wiki/Installation#optional-dependencies)

## Contributing
### Setting up a Developer Instance
Much of this information is copy pasted from a Webfishing Community Server Instruction Thread authored by [Sulayre](https://github.com/Sulayre), creator of [Lure](https://github.com/Sulayre/WebfishingLure).

Download the latest Source Code from GitHub. Unzip contents into a folder named "KMod".

Download GodotSteam 3.5.2: https://github.com/GodotSteam/GodotSteam/releases/tag/v3.21

You need to decompile webfishing: https://github.com/bruvzg/gdsdecomp/releases/latest

- Copy steam_appid.txt from the base game and paste it in the decompiled game's folder (or the folder where you have the godotsteam exe)
- NOTE: Redistributing the decompilation is illegal, don't upload the source assets or code of the game anywhere and decompile your legally owned copy of the game from steam only
- In the decompiled game's folder, create a folder named "mods" if it does not already exist.
- Insert the KMod folder into this mods folder. should follow ```mods/KMod/main.gd``` etc.

Open the decompiled webfishing project through GodotSteam 3.5.2. Give it a minute to load. It will present you with the project for Webfishing. In the file browser under ```res://mods/KMod```, youll see my code.

You need to set some things up before you want to start developing. Firstly, click Project -> Project Settings -> Autoload. Set the path to ```res://mods/KMod/main.gd```. Label it KMod and add it. This makes sure that it loads the mod when you launch this version of the game through Godot. This is where you will want to develop and test the code.

**IMPORTANT: Exporting directly out of a decompiled version of Webfishing will force the game to bundle unecessary dependencies into the mod. This must be avoided if you plan on sharing the export with anyone.**

Set up a new project, in a new folder, and copy/paste the /mods/ folder from your decompiled project into this new, empty project. 
**Only export the mod from this new, mostly empty project.**

Go to Project -> Export. 
- Click Add and then Windows Desktop. 
- Select both Debug and Release export templates from the GodotSteam folder.
- Disable Runnable at the top.
- Go to Resources and in Export Mode select Export selected resources and their dependencies
- Checkmark the mods/ folder (or just the KMod folder)
- Click on Export PCK/Zip...
- in All Recognized (\*.zip, \*.pck) select Godot Project Pack (\*.pck)
- Export

### Contributing to the repository on GitHub
- Create a fork of the repository
- Commit your changes to your fork
- Create a pull request so I can review the changes and merge into the main repository
