# gmod-scripts
Some scripts for Server Functionality

entity_cleanup serves as a timer based cleanup system that removes all props with physics and any recognized weapon not owned by the player that is dropped to the ground. For example a combine npc drops an AR-2, unless picked up by player, it will be deleted by next cleanup. All props spawned by player will be deleted per cleanup. It operates on a 10 second timer which can be modified however you like.

spawn_combine serves as hotkey based spawner utilizing the H base to spawn a combine npc with assigned weapon AR-2 and 500 health.
