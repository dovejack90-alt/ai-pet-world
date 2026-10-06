-- AI PET WORLD
-- Initial server-side profile shape.
-- This module intentionally separates the data contract from the persistence implementation.

local PlayerDataService = {}

local DEFAULT_PROFILE = {
    Version = 1,
    Coins = 100,
    XP = 0,
    Level = 1,
    SelectedPet = nil,
    OwnedPets = {},
    PetProgress = {},
    Inventory = {},
    House = {},
    DailyReward = {
        LastClaimUnix = 0,
        Streak = 0,
    },
    QuestState = {},
    Settings = {},
}

local profiles = {}

local function clone(value)
    if type(value) ~= "table" then
        return value
    end

    local copy = {}
    for key, child in pairs(value) do
        copy[key] = clone(child)
    end
    return copy
end

function PlayerDataService:GetDefaultProfile()
    return clone(DEFAULT_PROFILE)
end

function PlayerDataService:Get(player)
    return profiles[player]
end

function PlayerDataService:Set(player, profile)
    profiles[player] = profile
end

function PlayerDataService:Remove(player)
    profiles[player] = nil
end

return PlayerDataService
