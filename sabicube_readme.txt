SabiCube
********
A single-player total conversion of Cube2-Sauerbraten with focus on adding rpg/adventure elements.
This package includes the first three levels of the game ZetaProject, and a test-map for the new features.
The goal is to make the gamebuilding process as fun as playing a game, with intuitive menus and guides to help anyone make their own open-source rpg/adventure game, without prior knowledge of programming or 3D-modeling.
This is a work in progress so editor-workflow might change in future releases as we add features to the engine, but maps from the original sauerbraten (or compatible engines) will be able to load with minor adjustment, and we have no plans to change the map-format.
SabiCube is tested on 64-bit (Kubuntu) and 32-bit (KXStudio), and we have provided a binary for both, so it should work, if you are lucky, If not... please follow the installguide below.
To get the latest version of this document, or SabiCube, please visit http://github.com/sandsound/sabicube

TODO/FIXME:
*****
Expand the skill-tree. health and energy-regeneration are the only skills working atm.
Need more custom hudguns like magic (fire, ice, slime and poison) and a bow to replace the crossbow
dynamic texture and model packs for editor, I have a proof of concept under "Create new map"
npc's should get angry when hit and first attack on second hit (like monster-anger). team?
finish the default item list (missing 55-79)
guiskin-selector, mostly working example in main editmenu, need more guiskins to choose from
save/load game, atm I have a simple halflife-like savegame system (without ammo and inventory)
Cleanup... I tend to comment every change I make in the source-code, sometimes I just ramble on...

Quick-start:
************
1. From the main menu select "Create new map".
2. Name your map.
3. select default inventory and triggers
3. select a texture package
4. once loaded, click F1 for edit-mode, F2 for textures and/or F3 for editing menu
5. and last but not least, remember to save your map!

For now all mapmodels are included autocratically, but I plan to include a way to remove and/or add models inside the editor.
For a more in-depth explanation of the individual components, please follow the guide below or have a look at the cfg-files for the included game ZetaProject.

Editing:
********
Once you have loaded a map click [F1] for editmode (edit can be disabled when starting a game).
Use your mouse to look around and WASD to move, just like when playing the game, and althou there's no "speedrun" in editmode, you can set floatspeed in the main editing menu.
When you click on the ground, your cursor will select a square (hold down G and scroll to enlarge/minimize the size of the square), if you scroll, the selected part will follow, up to make a solid cube and down to make a hole.
For a full list of available editing hotkeys, use the keys/scroll-tab in the main editing menu (F3).
Editing of mapmodels and textures are mostly done as in the original cube, but in SabiCube you'll be able to dynamically load textures and models inside the editor, there will be sets of textures and models, so if you are making a map and suddenly decide you need some kitchenware, you can load a mappackage called kitchenware without having to leave the editor. You'll also be able to scan a folder for models/textures and preview them inside the editor in 3D, until it is fully implemented, you can select "Create new map" from the main menu, here you can select one of the predefined texture-packs, and other script basic stuff like inventory and other essential variables.
We are trying to make as many textures and models available as possible, but of course you can also use your own repository.

Scripting:
**********
Whenever a map is loaded it executes a configuration-file. If your map is called foo, your cfg will be called foo.cfg, if no foo.cfg file is found, the map will use the default mapmodels and textures.
If you create your own cfg-file, remember that the first 100 items of your mapmodels are used for pickups.
You can call other cfg files from your foo.cfg, so if you want to script a npc or item, you can do so in a separate file.
The path to the cfg file is /packages/base/foo.cfg, and from that file you can point to any file you want inside the SabiCube folder. If you want to use the default inventory in your game, you simply add the following line to your foo.cfg:
exec /packages/base/inventory.cfg

Hotkeys:
********
ESC: menu
CTRL: crouch
SHIFT: run
LMB: attack
RMB: zoom
E: Activate/pickup
TAB: playermenu amd inventory
1-8: weapons
F12: Take screenshot

Edit Hotkeys:
********
F1 : edittoggle
F2 : Textures menu
F3 : Main editing menu
F3 : Mapmodels menu
For a full list of available editing hotkeys, use the keys/scroll-tab in the main editing menu (F3).

Adding pickup-able items: mapmodels 0 - 79
*************************
mapitems are numbered from 0 and up, where 0 (default) is a spinning question-mark, 1 is the next mapmodel in the list, in this case a brawndo-plant (I had to call it something).
To place a Brawndo-plant on your map, you first enter edit mode (F1) click where you want it to appear, open the edit menu (F3) and select consumables/brawndo, this will get you a brawndo-plant that player can pick up. Every item player picks up, will be available in the inventory, eatable items can be eaten when clicked and weapons can be equipped (if you have ammo for it).
If you want to change the name or model, these are defined in data/default_map_models.cfg and the inventory description in packages/base/inventory.cfg just remember these rules:
mapmodel 0-79 are reserved for pickupable items.
mapmodel 80-99 are reserved for ammo and guns.
mapmodel 100 is an exploding barrel (can be changed to another exploding item).
mapmodel 101 is a platform/elevator.

When picking up an item, it sends a item_pickup_x (where x is the mapmodel), so if you want to script what to do when a player pick up a model nr 4, it could look something like this:
item_pickup_4 [
    // item nr 4 add 1
    inventorywrite 4 1
    // and echo a message to the screen
    echo "you found a item nr 4"
]
If you just want to use the existing inventory-items, you don't have to script pickup-able items

Weapons: mapmodels 80-99
********
Weapons are no longer being picked up autocratically, the players mouse have to be hovering over them and clicking them like any other pickup-able item. Default weapon (crowbar) is the replacement of the original fist from Sauerbraten and will be equipped whenever a map is loaded.
placing a weapon or ammo is just like a normal pickup-able item (BOX).
You can't equip a weapon without having the appropriate ammo.

barrel: mapmodel 100
*******
Enter edit mode (F1) click where you want it to appear, open the edit menu (F3) and select Explodable barrel. Once you have placed it, you can click it, and then use your scroll-wheel to select any model from the mapmodel-list, if you want an explodable gas-canister or fuel-truck.

platform: mapmodel 101
*********
Enter edit mode (F1) click where you want it to appear, open the edit menu (F3) and select Platform.

Adding executabale items: mapmodels 102 - ?
*************************
Keypads npc's and other items that shouldn't be picked up when a player activates them, are defined the same way as pickup-able items.
So if you want a npc, you first enter edit mode (F1) click where you want your npc to appear, open the edit menu (F3) and select npc. Scripting an executable item, is very similar to a pickup-item:
item_activate_166 = [
    showgui npc166
]
newgui npc166 [
    guitext "Hi there"
    guibar
    guibutton "Hi" [closegui]
]

You can make a very simple quest, by combining items, npc and gui:
item_activate_166 = [
    showgui npc166
]
newgui npc166 [
    guitext "Do you have any brawndo leafs?"
    guibar
    // if player have brawndo (inventory item 1)
    if (> (inventory1read) 1) [
        guibutton "sure... here you are" [
            // subtract 1 from inventory item 1
            inventorywrite 1 -1
            // player gain 25 expirience points
            setplayerexp 25
            cleargui
        ]
        guibutton "Sorry, but I need them all" [
            cleargui
        ]
    // if player doesn't have any
    ] [
        guibutton "sorry... I dont have any" [
            cleargui
        ]
    ]
]


Monsters:
*********
There are currently 16 types of monsters (start counting at 0). to place a monster, first enter edit mode (F1) click where you want it to appear, open the edit menu (F3) and select monsters. type 10 is a wooden crate that player can destroy.
When a monster is killed, it sends a monster_dead_x (where x is the type), so if you want to script what to do when a player kills a type 12, it could look something like this:
monster_dead_11 = [
    // killing a rat will give the player 10 points exp.
    setplayerexp 10
    // either echo a statement or a sound (or both)
    sound 72 // Damn I'm good...
    echo "You have killed a rat"
]
If you simply want to use the existing monsters and their default values, you just have to include the file packages/base/triggers.cfg, or select triggers in the "Create new map" menu.

Wooden-crate:
*************
Monster type 10 is a wooden crate that doesn't move or do damage, but player can destroy it, very useful for removing planks barring a door, or a crate that gives you ammo or similar items when destroyed.
Scripting a wooden crate is done like this:
monster_dead_10 = [
    // first we make a random number from 1-11
    x = (+ (rnd 10) 1)
    // then we add x amount pistolammo to players inventory
    getpistolammo $x
    // last thing is echoing a message to the player via text or sound
    echo (concatword "you found " $x " pistol-ammo")
]

triggers and doors:
*******************
Can be controlled by a executabale item or by proximity.
To place a proximity trigger, you just place a trigger/door and choose "auto-close" (or "once"). This will place a door that opens autocratically when the player approach it.
To use a switch or other model to control the trigger/door, follow the guide "Adding executabale items".
A closed door with tag 3, can be opened with "trigger 3 1", and closed again with "trigger 2 0".

Game-building
*************
Inventory is reset when starting a new game, but is transferred between maps in the same game, ammo is not autocratically transferred, but if you update the inventory with the current ammo, you can reassign it when the next map is loaded. Have a look at the way ZetaProject use triggers to transfer ammo from map to map:
level_trigger_4 = [ // exit first map
    inventoryoverwrite 87 (getpistolstat)
    inventoryoverwrite 88 (getshotgunstat)
    inventoryoverwrite 89 (getriflestat)
    inventoryoverwrite 90 (getglstat)
    inventoryoverwrite 91 (getchaingunstat)
    inventoryoverwrite 92 (getrlstat)
    writegameprogress 1 zetaproject
    map sewer
]
level_trigger_13 = [ // enter second map
    getpistolammo (inventory87read)
    getshotgunammo (inventory88read)
    getrifleammo (inventory89read)
    getglammo (inventory90read)
    getchaingunammo (inventory91read)
    getrlammo (inventory92read)
]

Savegames are not fully implemented yet, but you can make a simple halflife-like menu where completed maps are listed, just add the following to the exit trigger:
writegameprogress x y // where x = mapnumber (int) and y = gamename (char)

To list your completed maps, and a possibility to replay them, place something like this in either autoexec.cfg or menu.cfg (replace "gamename" with your game's name):
newgui gamename [
    guibutton "Start new game" [mode -3;map first] // this button will always be shown
    exec packages/savegame/gamename.cfg
    if (>= ($gameprogress) 1) [
        guibutton "First map" [mode -3;map first] // these buttons will only be shown
        guibutton "Second map" [mode -3;map second] // when map 1 is completed
    ]
    if (>= ($gameprogress) 2) [
        guibutton "Third map" [mode -3;map third] // this one, second map complete... and so on...
    ]
]

If you want to attach this menu to the main menu, add the line to the data/menus.cfg:
guibutton "gamename" [showgui gamename]

Cubescript:
***********


Installing:
***********
I have tested on 64-bit (Kubuntu) and 32-bit (KXStudio), and have provided a binary for both, so it should work, if you are lucky :-)
If you need to compile it, remember to install sdl-image/dev and sdl-mixer/dev, you'll most likely find them in your package-manager.

then open a terminal, cd into the src dir and run the following:
make && make install

You might need to configure enet, and install some additional packages before you compile SabiCube:
sudo apt-get install autoconf libtool libsdl1.2-dev libsdl-image1.2-dev  libsdl-mixer1.2-dev build-essentials
cd enet
autoreconf -vfi
cd ..
make && make install

I highly recommend placing the sabicube-folder in your home-dir. if you want to place it somewhere else than in your home-dir, you have to update the file sabicube_unix line 12. so if you place it in /home/myawesomegame, the line should read:
SAUER_OPTIONS="-q${HOME}/myawesomegame"

To run the game, execute the script sabicube_unix

If you are having problems, try launching the program from the terminal by cd-ing into the correct dir and execute the script with:
./sabicube_unix

Compiling on win and osx, should be possible, but since I use neither, I can't help you there.
If you manage to compile it for either of the above systems, please send me the binary so I might include it in the next release.

If you want to convert your existing map, your platforms, barrels, ammo and monsters will need to be adjusted to fit the additions to the engine.
As of now, barrel-model are on 100 and platform-model on 101. Normal mapmodels start at 102.
The first 100 items will be pickup-able.

If you use Kdevelop, feel free to try the kdev4 project in the src-dir, just remember that the binary will be placed in the src-dir, and you have to copy it to bin_unix. I use the install.sh script in the main folder to do this.


Gameplay:
*********
Pressing [CTRL] will cause the player to crouch, player will un-crouch when releasing it.
To interact with a door, npc or console use the [E] button on your keyboard
Your crosshair will show a hand when hovering over an item or npc that can be activated or otherwise engaged
Use [TAB] to view the playermenu with inventory, stats and log.
When clicking an eatable item in the inventory, you eat one, some have healing properties, some poison.
When clicking a weapon in the inventory, you equip it.
Killing monsters gains experience, and when you have enough experience, you get skill-points to assign.
Combustible things can be blown up (from barrels to fuel-trucks) and wooden crates can be destroyed (some have loot)
The left corner of the hud is a health-bar(red) and a energy-bar (green). While holding down [SHIFT] and moving, the player will run. Running requires energy, energy slowly regenerates while not running.
Traders are found on some maps (from third map and on)
You can trade your loot for more ammo, bandages or other essential equipment (quest-items can not be sold)


License:
Everything I make is GPL. You should have received a copy of the license, if not, you can view it online here: http://www.gnu.org/licenses/gpl.html
I have done my best to make sure that textures and models in SabiCube doesn't infringe on any copyright, but in the case that any does, please let me know, and I'll remove them.

Contributers:
Sandie Sandgreen: coding/scripting, maps, models, textures, hud and documentation
Bill H. Soerensen: coding

Artwork:
Gui cursor from Sauerbraten Enhanced Edition
Milky-way background by NASA
player/npc-models by TiZeta (animations by Sandie)
skeleton model by ScoutingNinja (animations and sword by Sandie)
Clippy by Sandie
Textures by PhilipK, Trak, Noctuna, Nieb, Lunaran, Luckystrike, Johnston, ikbase, blikjebier

Original Cube 2 Sauerbraten by:
by Wouter "Aardappel" van Oortmerssen
Lee "eihrul" Salzman
Mike "Gilt" Dysart
Robert "baby-rabbit" Pointon
John "geartrooper" Siar
Quinton "Quin" Reeves and others
www.sauerbraten.org

For a full list contributers, please view the readme.

////////////////////////////////////////////////////////////////////////////////////////////////

modding notes:
**************
tools: Blender / Gimp / MisfitModel3D / KDevelop / Kate

Blender weights: Select the armature, go into pose mode then select the mesh and go into weight paint mode

MD5 export from Blender: select action, select mesh then armature in objectmode.

make list of jpg's:
ls *.jpg > package.cfg
texture 0 "path" x y z q (x=rotate y=offset? z=offset? q=size)

convert folder with bmp into jpg. (add " && rm *.bmp" to remove source):
mogrify -format jpg *.bmp

loopfiles f packages/fonts png [
	font $f (concatword "packages/fonts/" $f ".png") 32 64 //define and load the font using default presets
	exec (concatword "packages/fonts/" $f ".cfg") //load the constants
]

record movie in cube2:
/movie YourFileName

Find and Remove backupfiles, Linux Command Line:
find -name "*.BAK" -exec rm -rf {} \;

Search for a text string recursively with -r option:
grep -r "barrel" ./*

git status
git add -A
git commit --all
git push origin master


possible items, ideas and other stuff:
**************************** Weapons / ammo
old-style coat-rack
sonic weapon
samurai sword
baseball bat
spear
crossbow
bow and arrow
Molotov cocktails
plastic explosives
Jet pack
flame thrower
remote control/detonator
binoculars
**************************** Consumables
mre or ration pack
lunchbox (health bonus?)
coffee thermos
canteen
drugs / aspirin
more booze
pipe / waterpipe
gum
**************************** Electronics etc.
key
battery
boombox
cd player
data diskette
thumb drive (filled with secret data?)
scroll
gold or silver coins or bars
watch
necklace, bracelet, rings, Pearls, diamonds, emeralds, rubies, gold nuggets
backpack (filled with ammo, food or other items?)
stopwatch
cellphone
tablet
electronic code breaker (for getting past security doors or security alarms?)
walkie talkie or radio (for monitoring enemy communications?)
scanner, camera, video camera
special boots (to get you past say a lava pit?)
jump boots, (make you jump twice as high to get you past an obstacle?)
Heart shaped box of chocolates
box of flowers
violin
balloons
solar cells
keychain
spray paint, paint, gasoline, gasoline tank
fire extinguisher
fishing pole
inflatable raft or boat
dogfood or dogtreats (get past attack dogs in an area?)
newspaper
calculator
skateboard
wanted posters
