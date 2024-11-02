# KMod
Small collection of Webfishing features

### Current features as of 1.4.0:
- **SizeChanger**: Change size by holding comma or period. Reset with slash. Saves player size after 6 seconds have passed after changing size. Loads player size on lobby connect.
- **KeybindFix**: Open and Close OptionsMenu on boot. This loads in custom key binds that the game otherwise waits for you to open your options menu to initialize. Not impactful to performance.

You can enable or disable any of the features using the config file located under ```GDWeave/configs/KMod.json```. This will only generate after the first time launching the game with this mod installed. This can be done manually by editing the json, or through [Hook Line & Sinker](https://github.com/pyoidzzz/HLSRewritten) through the config editor, or through [TackleBox](https://github.com/puppy-girl/TackleBox)'s in game mod menu (requires restart to apply). 

## Installation Method 1: Hook Line & Sinker
Download Hook Line & Sinker: https://github.com/pyoidzzz/HLSRewritten

Follow the steps to set game installation path, install .NET 8.0 and then install GDWeave. 

Navigate to Available Mods in HLS, click on KMod (search for KMod if necessary), click install. This will install the mod correctly and you do not need to do anything further. It takes the latest release from the Thunderstore page.

## Installation Method 2: Manual
Requires GDWeave https://github.com/NotNite/GDWeave

Download the latest release KMod.zip file: https://github.com/katzerax/kmod/releases/latest/download/KMod.zip

Navigate to your GDWeave installation, under GDWeave/mods/ place the unzipped folder containing the KMod.pck and manifest.json file within it.

File structure should look like
```GDWeave/mods/KMod/KMod.pck```

**Make sure you didn't download the source code if installing manually, but the release. I gave you a link to the release above for a reason.**

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
