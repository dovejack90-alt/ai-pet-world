-- AI PET WORLD
-- Server-authoritative pet interactions.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Pets = require(ReplicatedStorage.Config.Pets)
local Economy = require(ReplicatedStorage.Config.Economy)

local PetService = {}

local function clampStat(name, value)
    local limits = Economy.StatLimits[name]
    if not limits then
        return value
    end

    return math.clamp(value, limits.Min, limits.Max)
end

function PetService:GetDefinition(petId)
    for _, definition in pairs(Pets) do
        if definition.Id == petId then
            return definition
        end
    end

    return nil
end

function PetService:Feed(petState)
    if not petState then
        return false
    end

    local reward = Economy.InteractionRewards.Feed

    petState.Hunger = clampStat("Hunger", petState.Hunger + 20)
    petState.Happiness = clampStat("Happiness", petState.Happiness + 5)
    petState.Friendship = clampStat("Friendship", petState.Friendship + reward.Friendship)

    return true, reward
end

function PetService:Play(petState)
    if not petState then
        return false
    end

    local reward = Economy.InteractionRewards.Play

    petState.Energy = clampStat("Energy", petState.Energy - 10)
    petState.Happiness = clampStat("Happiness", petState.Happiness + 15)
    petState.Friendship = clampStat("Friendship", petState.Friendship + reward.Friendship)

    return true, reward
end

return PetService
