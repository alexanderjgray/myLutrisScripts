WIP

GOG Tropico with dxwrapper, tropico edit and .evt files required to fix the doubled hotel income bug.

Dxwrapper should be installed and working without any intervension.

Tropico edit and the hotel fix can be found in the extras folder present in the root of the wine prefix.

tropico-auto-scenario-fix.sh is a script for fixing all the premade scenarios post intall.

tropico-auto-hotel-fix.sh is a script that watches Tropico's "game" folder for new saves with the prefix "s-" (s for scenario) and automatically applys the hotel fix. You'll find the patched scenario in the premade scenario list.

INSTRUCTIONS:

To use the installer download "tropico-local.yml"

Open a terminal where you downloaded it.

Enter: "lutris -i <path_to_tropico-local.yml>"

example: "lutris -i ~/Downloads/tropico-local.yml"

When prompted where you want to install the game to enter: "/home/<your_user>/Games/gog/tropico"
You can change this but you'll have to edit the .sh scripts paths to match.

After the lutris installer will patch all the premade scenarios automatically. Let it finish and you should be good to go.

To automatically patch random map games:

You can either run* "tropico-auto-hotel-fix.sh" from the extras folder** in the prefixes root or you can add it to Tropico's pre launch script setting under the "System Options" tab (check the advanced settings check box to find it)***

*Run it from the terminal by entering "./tropico-auto-hotel-fix.sh"
**The extras folder should be found in "/home/<your_user>/Games/gog/tropico/extras"
***Note, if you add it to the pre-launch scripts it'll keep running after you close tropico, just tell lutris to stop Tropico and you'll be good

Setup your random map game as you normally would.

Make sure you make your presedente as you want because you can't change them later.

Once in game, hold "CTRL" and type "editor".

To confirm you are in editor mode you can press "p". It should bring up a paint menu.

Save your game with a "s-" prefix. So: "s-banana-time" for example. I would avoid spaces, special characters etc. Just keep it simple.

Hold "CTRL" and type "editor" again to disable editor mode.

If you don't do this, when you enter any other scenario or random map game editor mode will still be on.

Tropico will probally lose focus and you'll see some junk in the terminal, and a window will briefly pop up.

Exit your game to the main menu and head to the premade scenarios, you should see a scenario of the same name.

You've now made your own, custom patched scenario. Enjoy!

****Note, "tropico-auto-hotel-fix.sh" needs inotify-tools. You should be able to get it form your linux's repo.
