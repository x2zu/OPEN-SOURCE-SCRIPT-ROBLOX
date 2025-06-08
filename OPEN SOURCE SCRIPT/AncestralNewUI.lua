-- Services
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CoreGui = game:GetService("StarterGui")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

-- Locals
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
local UserPlayer = HumanoidRootPart:WaitForChild("user")
local ActiveFolder = Workspace:FindFirstChild("active")
local FishingZonesFolder = Workspace:FindFirstChild("zones"):WaitForChild("fishing")
local TpSpotsFolder = Workspace:FindFirstChild("world"):WaitForChild("spawns"):WaitForChild("TpSpots")
local NpcFolder = Workspace:FindFirstChild("world"):WaitForChild("npcs")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", PlayerGui)
local Backpack = LocalPlayer:WaitForChild("Backpack")

-- Variables
local CastMode = "Legit"
local ShakeMode = "Navigation"
local ReelMode = "Blatant"
local CollectMode = "Teleports"
local teleportSpots = {}
local FreezeChar = false
local DayOnlyLoop = nil
local BypassGpsLoop = nil
local Noclip = false
local RunCount = false
local autoCastEnabled = false
local autoShakeEnabled = false
local autoShakeConnection
local autoReelEnabled = false
local PerfectCatchEnabled = false
local autoReelConnection

-- Load Luna Interface
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

-- Create Window
local Window = Luna:CreateWindow({
    Name = "Ancestral",
    Subtitle = ".gg/ancestral",
    LogoID = "138057967505611",
    LoadingEnabled = true,
    LoadingTitle = "Ancestral Dev",
    LoadingSubtitle = ".gg/ancestral",
    ConfigSettings = {
        RootFolder = "BillDevHub", 
        ConfigFolder = "Configs", 
        AutoLoadConfig = true 
    },
})

Window:CreateHomeTab({
    SupportedExecutors = {"Delta", "Fluxus", "Codex", "Cryptic", "Vegax", "Trigon", "Synapse X", "Script-Ware", "KRNL", "Seliware", "Solara", "Xeno", "ZORARA", "Luna", "Nihon", "JJsploit", "AWP", "Wave", "Ronix"},
    DiscordInvite = "",
    Icon = 138057967505611,
})
-- Create Tabs
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "home_filled",
    ImageSource = "Material",
    ShowTitle = true
})

local CharacterTab = Window:CreateTab({
    Name = "Local Player",
    Icon = "account_circle",
    ImageSource = "Material",
    ShowTitle = true
})

local MarketTab = Window:CreateTab({
    Name = "Market",
    Icon = "shopping_cart",
    ImageSource = "Material",
    ShowTitle = true
})

local ForgeTab = Window:CreateTab({
    Name = "Forge",
    Icon = "group_work",
    ImageSource = "Material",
    ShowTitle = true
})

local TeleportTab = Window:CreateTab({
    Name = "Teleport",
    Icon = "brush",
    ImageSource = "Material",
    ShowTitle = true
})

local EventTab = Window:CreateTab({
    Name = "Event",
    Icon = "waves",
    ImageSource = "Material",
    ShowTitle = true
})

local ExclusivesTab = Window:CreateTab({
    Name = "Exclusives",
    Icon = "stars",
    ImageSource = "Material",
    ShowTitle = true
})

local UITab = Window:CreateTab({
    Name = "UI Settings",
    Icon = "settings_applications",
    ImageSource = "Material",
    ShowTitle = true
})

-- Contoh Createnya
Main:CreateToggle({
    Name = "Auto Equip Rod",
    Description = "Title",
    Default = false,
})
Main:CreateInput({
    Name = "Title",
})
Main:CreateDropdown({
    Name = "Title",
})
Main:CreateSection({
    Name = "Title",
})
Main:CreateDropdown({
    Name = "Title",
})
Main:CreateButton({
    Name = "Title",
})
Main:CreateDivider({
    Name = "Title",
})


-- UI Settings
UITab:CreateButton({
    Name = "Destroy GUI",
    Description = "Close the GUI",
    Callback = function()
        for _, connection in pairs(getconnections(game:GetService("CoreGui").ChildAdded)) do
            connection:Disable()
        end
        game:GetService("CoreGui").Luna:Destroy()
    end
})

UITab:CreateButton({
    Name = "Rejoin Game",
    Description = "Rejoin the current game",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end
})
UITab:BuildThemeSection()


UITab:BuildConfigSection()
Luna:Notification({
    Title = "Config Loaded",
    Content = "Your saved configuration has been automatically loaded.",
    Icon = "check_circle",
    ImageSource = "Material"
})
