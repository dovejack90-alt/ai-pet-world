-- AI PET WORLD
-- Development bootstrap for the first playable vertical slice.
-- This script is intentionally self-contained so the first Studio test is easy.
-- Production systems will be split into services/modules as the project grows.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local root = ReplicatedStorage:FindFirstChild("AIPetWorld")
if not root then
    root = Instance.new("Folder")
    root.Name = "AIPetWorld"
    root.Parent = ReplicatedStorage
end

local remotes = root:FindFirstChild("Remotes")
if not remotes then
    remotes = Instance.new("Folder")
    remotes.Name = "Remotes"
    remotes.Parent = root
end

local interactRemote = remotes:FindFirstChild("PetInteract")
if not interactRemote then
    interactRemote = Instance.new("RemoteEvent")
    interactRemote.Name = "PetInteract"
    interactRemote.Parent = remotes
end

local profiles = {}
local pets = {}

local function clamp(value)
    return math.clamp(value, 0, 100)
end

local function createPetModel(player, petName)
    local character = player.Character
    if not character then return end

    if pets[player] then
        pets[player]:Destroy()
    end

    local model = Instance.new("Model")
    model.Name = player.Name .. "_Pet"

    local body = Instance.new("Part")
    body.Name = "Body"
    body.Shape = Enum.PartType.Ball
    body.Size = Vector3.new(3, 3, 3)
    body.Material = Enum.Material.SmoothPlastic
    body.Anchored = true
    body.CanCollide = false
    body.Parent = model

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.fromOffset(160, 40)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = body

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = petName
    label.Parent = billboard

    model.PrimaryPart = body
    model.Parent = workspace
    pets[player] = model
end

local function createPlayerUI(player)
    local playerGui = player:WaitForChild("PlayerGui")
    local existing = playerGui:FindFirstChild("AIPetWorldUI")
    if existing then existing:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "AIPetWorldUI"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    local panel = Instance.new("Frame")
    panel.Name = "PetPanel"
    panel.Size = UDim2.fromOffset(240, 210)
    panel.Position = UDim2.new(0, 20, 1, -230)
    panel.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundTransparency = 1
    title.Text = "AI PET WORLD"
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = panel

    local stats = Instance.new("TextLabel")
    stats.Name = "Stats"
    stats.Size = UDim2.new(1, -20, 0, 75)
    stats.Position = UDim2.fromOffset(10, 40)
    stats.BackgroundTransparency = 1
    stats.TextSize = 16
    stats.TextXAlignment = Enum.TextXAlignment.Left
    stats.Font = Enum.Font.Gotham
    stats.Parent = panel

    local function makeButton(name, text, x)
        local button = Instance.new("TextButton")
        button.Name = name
        button.Text = text
        button.TextScaled = true
        button.Font = Enum.Font.GothamBold
        button.Size = UDim2.fromOffset(100, 42)
        button.Position = UDim2.fromOffset(x, 125)
        button.Parent = panel
        return button
    end

    local feed = makeButton("Feed", "Feed", 10)
    local play = makeButton("Play", "Play", 125)

    local coins = Instance.new("TextLabel")
    coins.Name = "Coins"
    coins.Size = UDim2.new(1, -20, 0, 25)
    coins.Position = UDim2.fromOffset(10, 175)
    coins.BackgroundTransparency = 1
    coins.TextScaled = true
    coins.Font = Enum.Font.GothamBold
    coins.Parent = panel

    feed.MouseButton1Click:Connect(function()
        interactRemote:FireServer("Feed")
    end)

    play.MouseButton1Click:Connect(function()
        interactRemote:FireServer("Play")
    end)
end

local function updateUI(player)
    local profile = profiles[player]
    if not profile then return end

    local gui = player:FindFirstChild("PlayerGui")
    local screen = gui and gui:FindFirstChild("AIPetWorldUI")
    local panel = screen and screen:FindFirstChild("PetPanel")
    if not panel then return end

    local stats = panel:FindFirstChild("Stats")
    local coins = panel:FindFirstChild("Coins")

    if stats then
        stats.Text = string.format(
            "Hunger: %d\nEnergy: %d\nHappiness: %d\nFriendship: %d",
            profile.Hunger,
            profile.Energy,
            profile.Happiness,
            profile.Friendship
        )
    end

    if coins then
        coins.Text = "Coins: " .. profile.Coins
    end
end

interactRemote.OnServerEvent:Connect(function(player, action)
    local profile = profiles[player]
    if not profile then return end

    if action == "Feed" then
        profile.Hunger = clamp(profile.Hunger + 20)
        profile.Happiness = clamp(profile.Happiness + 5)
        profile.Friendship = clamp(profile.Friendship + 2)
        profile.Coins += 5
    elseif action == "Play" then
        if profile.Energy < 10 then return end
        profile.Energy = clamp(profile.Energy - 10)
        profile.Happiness = clamp(profile.Happiness + 15)
        profile.Friendship = clamp(profile.Friendship + 3)
        profile.Coins += 8
    else
        return
    end

    updateUI(player)
end)

local function setupPlayer(player)
    profiles[player] = {
        PetName = "Dog",
        Hunger = 80,
        Energy = 80,
        Happiness = 80,
        Friendship = 0,
        Coins = 100,
    }

    local function initialise()
        task.wait(1)
        createPetModel(player, profiles[player].PetName)
        createPlayerUI(player)
        updateUI(player)
    end

    player.CharacterAdded:Connect(initialise)

    if player.Character then
        initialise()
    end
end

Players.PlayerAdded:Connect(setupPlayer)

Players.PlayerRemoving:Connect(function(player)
    if pets[player] then pets[player]:Destroy() end
    pets[player] = nil
    profiles[player] = nil
end)

RunService.Heartbeat:Connect(function()
    for player, pet in pairs(pets) do
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

        if pet and pet.Parent and rootPart then
            local target = rootPart.CFrame * CFrame.new(3, 0, 3)
            local current = pet:GetPivot()
            local position = current.Position:Lerp(target.Position, 0.08)
            pet:PivotTo(CFrame.new(position, rootPart.Position))
        end
    end
end)

print("AI PET WORLD bootstrap loaded.")