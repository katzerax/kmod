# KMod
Small collection of Webfishing features.

## Current features as of 1.6.0:
### **SizeChanger**  
  - Allows you to change your size by holding `,` (comma) or `.` (period).  
  - Reset your size with `/` (slash).  
  - Saves player size 6 seconds after the last size change.  
  - Automatically loads player size when connecting to a lobby.  
  - **UPDATE (Game Version 1.09)**  
    - Due to new in-game limitations, size can only shrink to **0.6** or grow to **1.4** using GDScript.  
    - This range is beyond what you can achieve with sodas but smaller than the original size-changing range.  
    - Support for the mod [SizeUnlocker](https://github.com/Nowaha/SizeUnlocker) was added in **[v1.5.0](https://github.com/katzerax/kmod/releases/tag/1.5.0)** to bypass these limitations.
      - SizeUnlocker is required if you wish to see other players beyond these sizes.  
### **KeybindFix**
  - Automatically opens and closes the Options Menu on game boot.
  - This ensures custom keybinds load, which the game otherwise delays until the Options Menu is manually opened.  

## Configuration
You can enable or disable any feature using the configuration file located at:  
`GDWeave/configs/KMod.json`.  

- The configuration file is generated automatically on the first game launch with the mod installed.  
- You can edit the configuration manually or use any of the following tools:  
  - [Hook Line & Sinker](https://github.com/pyoidzzz/HLSRewritten)'s config editor.  
  - [TackleBox](https://github.com/puppy-girl/TackleBox)'s in-game mod menu.  
  - [r2modman](https://github.com/ebkr/r2modmanPlus/releases/latest)'s config editor.  

**Note**: Modifying the configuration requires a game restart to apply changes.  

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
