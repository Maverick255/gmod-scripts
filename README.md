# gmod-scripts
Some scripts for Server Functionality

For Addons:

recent_death_locator is a locator addon that finds your most recent death, shows your name(steam name if sandbox, or all other gamemodes whatever your assigned nickname is.) and is set to make the text disappear after approx: 15 seconds. This script is typically good for those that do militarp style gamemodes and want to help their medics out, finding exact locations of where someone died. It also stops tracking the location when you get a certain distance away (Default set to 1000 units away.)

For Autorun:

entity_cleanup serves as a timer based cleanup system that removes all props with physics and any recognized weapon not owned by the player that is dropped to the ground. For example a combine npc drops an AR-2, unless picked up by player, it will be deleted by next cleanup. All props spawned by player will be deleted per cleanup. It operates on a 10 second timer which can be modified however you like.

spawn_combine serves as hotkey based spawner utilizing the H button to spawn a combine npc with assigned weapon AR-2 and 500 health.
