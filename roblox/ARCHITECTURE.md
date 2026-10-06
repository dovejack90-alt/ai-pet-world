# Roblox Architecture

## Target structure

ReplicatedStorage
- Shared
  - Constants
  - Types
  - Utilities
- Config
  - Pets
  - Quests
  - Items
  - Economy
- Remotes
- Assets

ServerScriptService
- Server
  - PlayerDataService
  - PetService
  - QuestService
  - EconomyService
  - InventoryService
  - AnalyticsService
  - PurchaseService

StarterPlayer
- StarterPlayerScripts
  - Controllers
    - PetController
    - UIController
    - InteractionController

StarterGui
- Screens
  - PetStatus
  - Quest
  - Shop
  - Inventory
  - StarterPet

Workspace
- Map
- Interactables
- Spawns

## Server authority

The server owns:

- Currency
- XP
- Inventory
- Pet ownership
- Friendship
- Quest completion
- Purchases
- Persistent progression

The client requests actions. The server validates and applies them.

## Data model

Initial player profile:

- Version
- Coins
- XP
- Level
- SelectedPet
- OwnedPets
- PetProgress
- Inventory
- House
- DailyReward
- QuestState
- Settings

Every saved profile must have a version so future migrations are possible.

## Pet data

Pet definition should contain:

- Id
- DisplayName
- Rarity
- Model reference
- Base stats
- Personality traits
- Preferred activities
- Approved reaction/dialogue keys

Avoid storing arbitrary AI-generated child-facing text directly in player data.

## Development rule

One responsibility per service.

Do not create a single script containing all game logic.
