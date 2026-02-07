Powerd by [05126619z/ScavTemplate](https://github.com/05126619z/ScavTemplate).

[中文教程](README_ZH.md)

 # BlackMossTemplate

A simple template for creating a new Casualties Unknown mod project.

# How to use?
_This guide is for JetBrains Rider, I don’t like Visual Studio, so I’m not going to write a guide for Visual Studio._

**Maybe Visual Studio can do this, but I don’t know how to do it.**

1. [Clone Template repository](https://github.com/new?template_name=BlackMossTemplate). 
2. Get game’s dll files:
   1. Right-click on the Dependencies folder. 
   2. Select Reference…, select the `Add Froms…`. 
   3. Go to your game directory (be like: `E:/CasualtiesUnknownDemo/CasualtiesUnknown_Data/Managed`). 
   4. Select all .dll files.
3. Rename the `BlackMossTemplate` folders to your project name. 
4. Replace the `BlackMossTemplate` text in the following files with your project name:
   1. [vars.targets](vars.targets)
   2. [Plugin.cs](Plugin.cs)
   3. [BlackMossTemplate.csproj](BlackMossTemplate.csproj)
5. Replace `<BaseGamePath>E:/CasualtiesUnknownDemo</BaseGamePath>` in [vars.targets](vars.targets) with the game directory. Be Like: `<BaseGamePath>E:/CasualtiesUnknownDemo</BaseGamePath>`. 
6. Build the project to test if it runs. If not, retry steps 2–5. 
7. After a successful run, replace the following in [Plugin.cs](Plugin.cs) with the corresponding content:
   1. Change namespace `BlackMossTemplate` to your namespace (it can be the same as your mod name).
   2. Replace `blackmoss.template` with your GUID in the format `yourname.modname`. Case and underscores are allowed, but lowercase without underscores is recommended. 
   3. Replace `BlackMossTemplate` with your mod name. 
   4. Fill in the version `0.0.0` as you like — `114514.1919.810` is also fine. 
   5. The content of the `_harmony` constant should be the same as your GUID. 
   6. `Logger.LogInfo("Here's Black Moss!");` can be anything you want （if someone complains about random log spam, it’s not my fault）.

# About Configuration
Using Rider’s Configuration feature makes development more convenient.

1. Click the small arrow next to the Build button in the `Add Configuration` button. 
2. Click Edit `Configurations…` - `Add new…`. 
3. Section `Native Executable`. 
4. Rename `"Unnamed"` to `"Start"`_(you can actually name it anything)_. 
5. Exe path is your game’s executable file. 
6. Push OK. 
7. Click the green arrow button. 
8. Fun to develop!
