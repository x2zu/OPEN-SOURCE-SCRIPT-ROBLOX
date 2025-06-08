-- Load Luna UI safely
local lunaSource = game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true)
local LunaFunc, err = loadstring(lunaSource)
if not LunaFunc then error("Failed to load Luna UI: ".. tostring(err)) end

local Luna = LunaFunc()
if not Luna then error("Luna UI returned nil") end

-- Create Window
local Window = Luna:CreateWindow({
    Name = "Digging Script",
    Subtitle = "x2zu",
    LoadingEnabled = true,
    LoadingTitle = "Loading x2zu!",
    LoadingSubtitle = "Powered by x2zu",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "DiggingScriptConfigs"
    },
    KeySystem = false,
})

-- Main Tab
local DigTab = Window:CreateTab({ Name = "Main" })

-- Auto Dig Logic
local AutoDig = false
DigTab:CreateToggle({
    Name = "Auto Dig",
    CurrentValue = false,
    Flag = "AutoDigToggle",
    Callback = function(value)
        AutoDig = value
        if AutoDig then
            spawn(function()
                while AutoDig do
                    local digArgs = { "hello" }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DigEvent"):FireServer(unpack(digArgs))
                    wait(0.5)
                end
            end)
            spawn(function()
                while AutoDig do
                    local gemArgs = { 14, "bye" }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("GemEvent"):FireServer(unpack(gemArgs))
                    wait(0.2)
                end
            end)
        end
    end
})

-- Insane Tab
local InsaneTab = Window:CreateTab({ Name = "Insane" })

-- Infinite Spins (Chest)
local Spinning = false
InsaneTab:CreateToggle({
    Name = "Infinite Spins",
    CurrentValue = false,
    Callback = function(value)
        Spinning = value
        if Spinning then
            spawn(function()
                while Spinning do
                    local args = { "Chest" }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TreasureEvent"):FireServer(unpack(args))
                    wait(0.1)
                end
            end)
        end
    end
})

-- Upgrades Tab
local UpgradesTab = Window:CreateTab({ Name = "Upgrades" })

-- Upgrade spam toggles
local upgrades = {
    "Speed",
    "Power",
    "Bag",
    "Sell",
    "Luck",
    "Multiplier",
    "GemMultiplier"
}
local upgradeLoops = {}

for _, upgradeName in ipairs(upgrades) do
    upgradeLoops[upgradeName] = false

    UpgradesTab:CreateToggle({
        Name = "Spam " .. upgradeName,
        CurrentValue = false,
        Callback = function(value)
            upgradeLoops[upgradeName] = value
            if value then
                spawn(function()
                    while upgradeLoops[upgradeName] do
                        local args = { 1, upgradeName }
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpgradeEvent"):FireServer(unpack(args))
                        wait(0.1)
                    end
                end)
            end
        end
    })
end

-- Show UI
Window:Ready()