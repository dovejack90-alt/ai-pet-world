-- AI PET WORLD economy constants.
-- Balance values should be changed here rather than scattered through scripts.

return {
    StartingCoins = 100,
    StartingXP = 0,

    InteractionRewards = {
        Feed = {
            Coins = 5,
            XP = 5,
            Friendship = 2,
        },

        Play = {
            Coins = 8,
            XP = 8,
            Friendship = 3,
        },
    },

    StatLimits = {
        Hunger = {Min = 0, Max = 100},
        Energy = {Min = 0, Max = 100},
        Happiness = {Min = 0, Max = 100},
        Friendship = {Min = 0, Max = 100},
    },
}
