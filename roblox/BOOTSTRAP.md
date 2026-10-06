# AI PET WORLD - Roblox Studio Bootstrap

## Goal

This bootstrap creates the first playable vertical slice:

Join -> pet appears -> pet follows -> Feed/Play -> stats and coins change.

## Studio setup

1. Open Roblox Studio.
2. Create a Baseplate experience called AI PET WORLD.
3. Open View -> Explorer and View -> Output.
4. Create a Script under ServerScriptService.
5. Copy roblox/ServerScriptService/Bootstrap.server.lua into that Script.
6. Press Play.

The bootstrap creates the required RemoteEvent and temporary pet automatically.

## What you should see

- Player spawns.
- A temporary Dog appears beside them.
- The Dog follows the player.
- A simple pet panel appears.
- Feed and Play modify stats.
- Coins and friendship increase.

## Development note

This is a development bootstrap, not the final production architecture. The next pass will split this into the modular services already documented in ARCHITECTURE.md, add proper DataStore persistence, pet selection, real pet models, quests, analytics and production validation.

If Studio shows a red error, copy the Output error into the chat and I will fix it.
