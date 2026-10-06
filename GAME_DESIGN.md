# Game Design

## Core loop

The core loop must remain understandable within the first minute:

**Pet care → activity → reward → progression → unlock**

Players manage three immediate needs:

- Hunger
- Energy
- Happiness

Friendship is the long-term relationship stat.

## MVP world

Pet Town contains:

- Spawn / starter area
- Pet Shop
- Park
- Player house area
- Cafe
- Clinic
- Competition / activity area
- Small forest path

The MVP does not require a huge map. Density and useful interactions matter more than acreage.

## Starter pets

Initial roster:

- Dog
- Cat
- Bunny
- Fox
- Panda

Each pet shares the same core systems but has controlled personality traits and cosmetic identity.

## Personality system

Personality is data-driven rather than an unrestricted chatbot.

Example traits:

- Playful
- Shy
- Brave
- Curious
- Lazy
- Friendly
- Mischievous

Personality can influence:

- Idle animations
- Approved dialogue variants
- Quest flavour text
- Preferred activities
- Reaction animations
- Friendship progression

All child-facing text should come from approved templates/content tables and be reviewed for safety.

## Progression

Player progression uses:

- Coins
- XP
- Pet friendship
- Pet collection
- Cosmetics
- House decoration
- Daily rewards

## MVP quests

Quest categories:

- Feed your pet
- Play with your pet
- Visit the park
- Visit the cafe
- Collect an item
- Complete a minigame
- Earn coins
- Spend coins
- Raise friendship

Quest definitions should be data-driven so new variations can be added without rewriting the quest engine.

## MVP minigame

Start with one simple repeatable minigame.

Requirements:

- 30–90 seconds
- Easy to understand
- Mobile friendly
- Gives coins/XP
- Can be reskinned for future events

## Retention hooks

- Daily reward
- Daily quests
- Daily adventure
- Pet friendship milestones
- Collection goals
- Weekly festival
- Rotating cosmetics

Do not overload the first release. Retention features should support the core loop rather than bury it.

## Technical principles

- Server authoritative for currency and progression.
- RemoteEvents/RemoteFunctions validated on the server.
- Persistent data handled centrally.
- Client handles presentation/input, server owns important state.
- Config/data modules separate content from logic.
- Systems communicate through clear APIs/events.
- Avoid giant monolithic scripts.
