-- Ensure you have the necessary services
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- Locals
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
local ActiveFolder = Workspace:FindFirstChild("active")
local FishingZonesFolder = Workspace:FindFirstChild("zones"):WaitForChild("fishing")
local TpSpotsFolder = Workspace:FindFirstChild("world"):WaitForChild("spawns"):WaitForChild("TpSpots")
local NpcFolder = Workspace:FindFirstChild("world"):WaitForChild("npcs")
local PlayerGUI = LocalPlayer:FindFirstChildOfClass("PlayerGui")
local safePart = Instance.new("Part")
safePart.Name = "SafeZoneAnchor"
safePart.Size = Vector3.new(10, 2, 10)
safePart.CFrame = CFrame.new(0, 1000, 0)
safePart.Anchored = true
safePart.CanCollide = true
safePart.Parent = Workspace

-- Load the Orion library from the correct URL
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Chaosscripter/Riotscripter/refs/heads/main/Orion%20Library%203"))()

local Window = OrionLib:MakeWindow({
    Name = "Midnight Hub 🌙",
    HidePremium = false,
    IntroText = "Midnight Hub 🌙",
    SaveConfig = true,
    ConfigFolder = "MidnightHub",
    ConfigName = "Fisch"
})

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local autoCast = false
local autoCastDelay = 2
local autoCastConnection, autoCastConnection2

MainTab:AddToggle({
    Name = "Auto Cast",
    Default = false,
    Callback = function(Value)
        autoCast = Value
        if autoCast then
            autoCastConnection = LocalCharacter.ChildAdded:Connect(function(child)
                if child:IsA("Tool") and child:FindFirstChild("events"):WaitForChild("cast") and autoCast then
                    wait(autoCastDelay)
                    child.events.cast:FireServer(100)
                end
            end)

            autoCastConnection2 = PlayerGUI.ChildRemoved:Connect(function(GUI)
                local Tool = LocalCharacter:FindFirstChildOfClass("Tool")
                if GUI.Name == "reel" and autoCast and Tool and Tool:FindFirstChild("events"):WaitForChild("cast") then
                    wait(autoCastDelay)
                    Tool.events.cast:FireServer(100)
                end
            end)
        else
            if autoCastConnection then
                autoCastConnection:Disconnect()
                autoCastConnection = nil
            end
            if autoCastConnection2 then
                autoCastConnection2:Disconnect()
                autoCastConnection2 = nil
            end
        end
    end,
})

MainTab:AddSlider({
    Name = "Auto Cast Cooldown",
    Min = 1,
    Max = 10,
    Increment = 0.1,
    Default = 2,
    Callback = function(Value)
        autoCastDelay = Value
    end,
})

-- Initialize ZoneCast settings
local ZoneCast = false
local SelectedZone = nil
local ZonesList = {}

-- Fill ZonesList with unique fishing zones based on names
for _, zone in pairs(FishingZonesFolder:GetChildren()) do
    if not table.find(ZonesList, zone.Name) then
        table.insert(ZonesList, zone.Name)
    end
end

-- Zone Cast Toggle
MainTab:AddToggle({
    Name = "Zone Cast",
    Default = false,
    Callback = function(Value)
        ZoneCast = Value
        if ZoneCast then
            -- Start teleporting the 'blehh' part when ZoneCast is enabled
            ZoneConnection = LocalCharacter.ChildAdded:Connect(function(child)
                if ZoneCast and child:IsA("Tool") and SelectedZone then
                    child.ChildAdded:Connect(function(blehh)
                        if blehh.Name == "bobber" then
                            local RopeConstraint = blehh:FindFirstChildOfClass("RopeConstraint")

                            -- Ensure RopeConstraint length is set correctly even after teleportation
                            if RopeConstraint then
                                RopeConstraint.Length = math.huge
                                RopeConstraint.Changed:Connect(function(property)
                                    if property == "Length" then
                                        RopeConstraint.Length = math.huge
                                    end
                                end)
                            end

                            -- Immediately move 'blehh' to the selected zone's position
                            wait(1)
                            while ZoneCast and blehh.Parent do
                                -- Find the zone by its name in FishingZonesFolder
                                local zoneObject = FishingZonesFolder:FindFirstChild(SelectedZone)
                                if zoneObject then
                                    -- Teleport the bobber (blehh) to the zone
                                    -- Add an offset for Z-axis if necessary, here adding 5 studs in the Y-axis
                                    blehh.CFrame = zoneObject.CFrame * CFrame.new(0, 5, 0)
                                end
                                wait()
                            end

                            -- Lock the player in place using BodyPosition
                            local humanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                -- Create a BodyPosition to lock the position
                                local bodyPosition = Instance.new("BodyPosition")
                                bodyPosition.MaxForce = Vector3.new(100000, 100000, 100000)  -- Max force for all axes
                                bodyPosition.D = 1000  -- Damping (how quickly it stops oscillation)
                                bodyPosition.P = 10000  -- Power (how strong the force is applied)
                                bodyPosition.Position = humanoidRootPart.Position  -- Lock to the current position
                                bodyPosition.Parent = humanoidRootPart  -- Attach it to the root part

                                -- Wait before unfreezing the player (give time for fishing to start)
                                wait(1)

                                -- Remove the BodyPosition to allow movement again
                                bodyPosition:Destroy()
                            end
                        end
                    end)
                end
            end)
        else
            -- Disconnect the ZoneCast when the toggle is off
            if ZoneConnection then
                ZoneConnection:Disconnect()
                ZoneConnection = nil
            end
        end
    end,
})

-- Fishing Zone Dropdown for selection
MainTab:AddDropdown({
    Name = "Select Fishing Zone",
    Options = ZonesList,
    Callback = function(Selected)
        SelectedZone = Selected  -- Store the selected zone name
    end,
})

-- Variables to hold the state and configurations
local autoReel = false
local autoReelDelay = 1
local autoShake = false
local autoShakeDelay = 1
local autoShakeMethod = "ClickEvent"

-- Auto Reel
MainTab:AddToggle({
    Name = "Auto Reel",
    Default = false,
    Callback = function(Value)
        autoReel = Value
        if autoReel then
            autoreelandshakeConnection = PlayerGUI.ChildAdded:Connect(function(GUI)
                if GUI:IsA("ScreenGui") and GUI.Name == "reel" then
                    repeat
                        wait(autoReelDelay)
                        local args = {
                            [1] = 100,
                            [2] = false
                        }
                        ReplicatedStorage.events:WaitForChild("reelfinished"):FireServer(unpack(args))
                    until GUI == nil
                end
            end)
        else
            if autoreelandshakeConnection then
                autoreelandshakeConnection:Disconnect()
            end
        end
    end,
})

MainTab:AddSlider({
    Name = "Auto Reel Cooldown",
    Min = 0,
    Max = 10,
    Increment = 0.1,
    Default = 1,
    Callback = function(Value)
        autoReelDelay = Value
    end,
})

-- Auto Shake
MainTab:AddToggle({
    Name = "Auto Shake",
    Default = false,
    Callback = function(Value)
        autoShake = Value
        if autoShake then
            autoreelandshakeConnection = PlayerGUI.ChildAdded:Connect(function(GUI)
                if GUI:IsA("ScreenGui") and GUI.Name == "shakeui" then
                    if GUI:FindFirstChild("safezone") ~= nil then
                        GUI.safezone.ChildAdded:Connect(function(child)
                            if child:IsA("ImageButton") and child.Name == "button" then
                                wait(autoShakeDelay)
                                if child.Visible == true then
                                    if autoShakeMethod == "ClickEvent" then
                                        local pos = child.AbsolutePosition
                                        local size = child.AbsoluteSize
                                        UserInputService:MouseMove(pos.X + size.X / 2, pos.Y + size.Y / 2)
                                        UserInputService:MouseButton1Click()
                                    elseif autoShakeMethod == "KeyCodeEvent" then
                                        GuiService.Changed:Connect(function(property)
                                            GuiService.SelectedObject = child
                                            if property == "SelectedObject" then
                                                if GuiService.SelectedObject == child then
                                                    UserInputService:InputBegan({KeyCode = Enum.KeyCode.Return})
                                                    UserInputService:InputEnded({KeyCode = Enum.KeyCode.Return})
                                                end
                                            end
                                        end)
                                        GuiService.SelectedObject = child
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
        else
            if autoreelandshakeConnection then
                autoreelandshakeConnection:Disconnect()
            end
        end
    end,
})

MainTab:AddDropdown({
    Name = "Auto Shake Mode",
    Options = {"ClickEvent", "KeyCodeEvent"},
    Callback = function(Selected)
        autoShakeMethod = Selected
    end,
})

MainTab:AddSlider({
    Name = "Auto Shake Cooldown",
    Min = 0,
    Max = 10,
    Increment = 0.1,
    Default = 1,
    Callback = function(Value)
        autoShakeDelay = Value
    end,
})

-- Store Tab
local StoreTab = Window:MakeTab({
    Name = "Store",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

StoreTab:AddButton({
    Name = "Sell Fish",
    Callback = function()
        ReplicatedStorage.events:WaitForChild("Sell"):InvokeServer()
    end,
})

StoreTab:AddButton({
    Name = "Sell All Fish",
    Callback = function()
        ReplicatedStorage.events:WaitForChild("SellAll"):InvokeServer()
    end,
})

StoreTab:AddButton({
    Name = "Appraise Fish",
    Callback = function()
        Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Appraiser"):WaitForChild("appraiser"):WaitForChild("appraise"):InvokeServer()
    end,
})

-- Teleports Tab
local TeleportsTab = Window:MakeTab({
    Name = "Teleports",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

TeleportsTab:AddLabel("Places")

local function capitalizeFirstLetter(str)
    return str:sub(1, 1):upper() .. str:sub(2):lower()
end

local teleportOptions = {}
for _, spot in pairs(TpSpotsFolder:GetChildren()) do
    table.insert(teleportOptions, capitalizeFirstLetter(spot.Name))
end

TeleportsTab:AddDropdown({
    Name = "Teleport to Place",
    Options = teleportOptions,
    Callback = function(Selected)
        local actualSpotName = Selected:lower()
        local selectedPlace = TpSpotsFolder:FindFirstChild(actualSpotName)
        if selectedPlace and HumanoidRootPart then
            HumanoidRootPart.CFrame = selectedPlace.CFrame + Vector3.new(0, 5, 0)
        end
    end,
})

local totemSpots = {
    ["Aurora"] = CFrame.new(-3041, 62, -2187),
    ["Smokescreen"] = CFrame.new(-2532, 81, 679),
    ["Windset"] = CFrame.new(1822, 55, -2137),
    ["Tempest"] = CFrame.new(2532, 30, 1176),
    ["Sundial"] = CFrame.new(682, 37, 2532),
    ["Eclipse"] = CFrame.new(-682, 110, -2532),
    ["Meteor"] = CFrame.new(1465, 154, -464),
    ["Blizzard"] = CFrame.new(2056, 112, 187),
    ["Avalanche"] = CFrame.new(-145, 145, 2498),
    ["Zeus' Storm"] = CFrame.new(-756, 324, -122)
}

TeleportsTab:AddLabel("Totems")

TeleportsTab:AddDropdown({
    Name = "Teleport to Totem",
    Options = {"Aurora", "Smokescreen", "Windset", "Tempest", "Sundial", "Eclipse", "Meteor", "Blizzard", "Avalanche", "Zeus' Storm"},
    Callback = function(Selected)
        if HumanoidRootPart and totemSpots[Selected] then
            HumanoidRootPart.CFrame = totemSpots[Selected] + Vector3.new(0, 5, 0)
        end
    end,
})

-- Auto Tab
local AutoTab = Window:MakeTab({
    Name = "Auto",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

AutoTab:AddLabel("Auto Use Totems")

local totemOptions = {
    "Zeus", "Windset", "Tempest", "Sundial", "Smokescreen", "Poseidon", "Meteor", "Eclipse", "Blizzard", "Avalanche", "Aurora"
}

local anytimeTotem = nil
local daytimeTotem = nil
local nighttimeTotem = nil

AutoTab:AddDropdown({
    Name = "Anytime Totem",
    Options = totemOptions,
    Callback = function(Selected)
        anytimeTotem = Selected
    end,
})

AutoTab:AddDropdown({
    Name = "Daytime Totem",
    Options = totemOptions,
    Callback = function(Selected)
        daytimeTotem = Selected
    end,
})

AutoTab:AddDropdown({
    Name = "Nighttime Totem",
    Options = totemOptions,
    Callback = function(Selected)
        nighttimeTotem = Selected
    end,
})

-- Function to determine the time of day
local function getTimeOfDay()
    local time = os.date("!*t")
    local hour = time.hour
    if hour >= 6 and hour < 18 then
        return "Daytime"
    else
        return "Nighttime"
    end
end

-- Function to check if player has a specific totem in inventory
local function hasTotem(totemName)
    for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
        if item.Name == totemName then
            return item
        end
    end

    -- Also check if already equipped
    if LocalCharacter and LocalCharacter:FindFirstChild(totemName) then
        return LocalCharacter:FindFirstChild(totemName)
    end

    return nil
end

-- Function to equip a specific totem
local function equipTotem(totemName)
    local totem = hasTotem(totemName)
    if totem then
        local args = {
            [1] = totem
        }
        ReplicatedStorage.packages.Net.RE.Backpack.Equip:FireServer(unpack(args))
        return true
    end
    return false
end

-- Function to use a specific totem (toggle it)
local function useTotem(totemName)
    local totem = LocalCharacter:FindFirstChild(totemName)
    if totem then
        -- Most Roblox tools use the Activate function to use them
        local toolFunction = totem:FindFirstChild("ToggleFunction") or totem:FindFirstChild("Activate")
        if toolFunction and toolFunction:IsA("RemoteEvent") then
            toolFunction:FireServer()
            return true
        elseif totem:IsA("Tool") then
            totem:Activate()
            return true
        end
    end
    return false
end

-- Function to check if it's day or night in game
local function isNighttime()
    -- Check if TimeOfDay is between evening and morning (6pm to 6am)
    local timeOfDay = Lighting:GetMinutesAfterMidnight() / 60
    return timeOfDay >= 18 or timeOfDay < 6
end

-- Auto Use Totems Toggle
local autoUseTotems = false

AutoTab:AddToggle({
    Name = "Auto Use Totems",
    Default = false,
    Callback = function(Value)
        autoUseTotems = Value
        while autoUseTotems do
            local timeOfDay = getTimeOfDay()
            if timeOfDay == "Daytime" and daytimeTotem then
                useTotem(daytimeTotem)
            elseif timeOfDay == "Nighttime" and nighttimeTotem then
                useTotem(nighttimeTotem)
            elseif anytimeTotem then
                useTotem(anytimeTotem)
            end
            wait(60) -- Check every minute
        end
    end,
})

-- Auto Appraise Fish Toggle
local autoAppraise = false

AutoTab:AddToggle({
    Name = "Auto Appraise Fish",
    Default = false,
    Callback = function(Value)
        autoAppraise = Value
        while autoAppraise do
            Workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Appraiser"):WaitForChild("appraiser"):WaitForChild("appraise"):InvokeServer()
            wait(60) -- Check every minute
        end
    end,
})

-- Auto Sell Fish Toggle
local autoSell = false

AutoTab:AddToggle({
    Name = "Auto Sell Fish",
    Default = false,
    Callback = function(Value)
        autoSell = Value
        while autoSell do
            ReplicatedStorage.events:WaitForChild("SellAll"):InvokeServer()
            wait(60) -- Check every minute
        end
    end,
})

-- Rods for Purchase
local rods = {
    ["Volcanic Rod"] = {Price = 300000, Description = "A rod forged in the heart of molten fury."},
    ["Challenger's Rod"] = {Price = 2500000, Description = "A rod for the most dedicated fishers."},
    ["Rod Of The Zenith"] = {Price = 10000000, Description = "A legendary rod that defies limits."},
    ["Ethereal Prism Rod"] = {Price = 15000000, Description = "A rod infused with spectral essence."},
    ["Leviathan's Fang Rod"] = {Price = 1000000, Description = "A weaponized rod forged to withstand wrath."},
    ["Zeus Rod"] = {Price = 1700000, Description = "A divine rod crackling with Zeus's lightning."},
    ["Poseidon Rod"] = {Price = 1555555, Description = "A rod blessed by the God of the Seas."},
    ["Kraken Rod"] = {Price = 1333333, Description = "A rod crafted from the tentacle of an ancient Kraken."},
    ["Tempest Rod"] = {Price = 1850000, Description = "A rod born from the essence of a perpetual storm."},
    ["Abyssal Specter Rod"] = {Price = 1000000, Description = "A rod forged in the darkest depths of the ocean's trenches."},
    ["Champions Rod"] = {Price = 80000, Description = "A balanced rod embodying competitive excellence."},
    ["Depthseeker Rod"] = {Price = 40000, Description = "A rod engineered with deep-sea technology."},
    ["Flimsy Rod"] = {Price = 0, Description = "A quite weak and unreliable rod."},
    ["Plastic Rod"] = {Price = 900, Description = "A rod made of ABS plastic."},
    ["Carbon Rod"] = {Price = 2000, Description = "A stiff, strong, and easy-to-handle rod."},
    ["Long Rod"] = {Price = 4500, Description = "A rod that is not the strongest but is the longest."},
    ["Training Rod"] = {Price = 300, Description = "A handy fishing rod for honing your fishing skills."},
    ["Fast Rod"] = {Price = 4500, Description = "A quick rod that catches fish at record speeds."},
    ["Lucky Rod"] = {Price = 5250, Description = "A rod that seems to attract a handful of rare fish."},
    ["Magma Rod"] = {Price = math.huge, Description = "A rod enhanced by the spirit of the graceful Phoenix."},
    ["Reinforced Rod"] = {Price = 20000, Description = "A rod crafted by a metal stronger than diamond."},
    ["Stone Rod"] = {Price = 3000, Description = "A rock-hard rod made purely from stone."},
    ["Phoenix Rod"] = {Price = 40000, Description = "A rod embued with the spirit of the graceful Phoenix."},
    ["Midas Rod"] = {Price = 55000, Description = "A rod blessed with the power of Midas."},
    ["Trident Rod"] = {Price = 150000, Description = "A rod that was originally the King of the Sea's way of defending his kingdom."},
    ["Mythical Rod"] = {Price = 110000, Description = "A rod blessed with the power of The Keepers."},
    ["Rapid Rod"] = {Price = 14000, Description = "An extremely fast rod that catches fish at record speeds."},
    ["Magnet Rod"] = {Price = 15000, Description = "A rod with an advanced magnetic field."},
    ["Nocturnal Rod"] = {Price = 11000, Description = "A rod that seems to wake up fish just by throwing the bobber in."},
    ["Fungal Rod"] = {Price = math.huge, Description = "A rod with a 70% chance to sprout suspicious spores."},
}

-- Add dropdown for purchasing rods
local rodOptions = {}
for rodName, rodData in pairs(rods) do
    table.insert(rodOptions, rodName)
end

StoreTab:AddDropdown({
    Name = "Select Rod",
    Options = rodOptions,
    Callback = function(Selected)
        local rodData = rods[Selected]
        if rodData and LocalPlayer:GetAttribute("Money") >= rodData.Price then
            -- Deduct money
            LocalPlayer:SetAttribute("Money", LocalPlayer:GetAttribute("Money") - rodData.Price)
            -- Give the rod to the player
            local rod = Instance.new("Tool")
            rod.Name = Selected
            rod.Parent = LocalPlayer.Backpack
            print("Purchased:", Selected)
        else
            print("Not enough money to purchase:", Selected)
        end
    end,
})

StoreTab:AddButton({
    Name = "Purchase Rod",
    Callback = function()
        local selectedRod = StoreTab:GetDropdown("Select Rod")
        if selectedRod then
            local rodData = rods[selectedRod]
            if rodData and LocalPlayer:GetAttribute("Money") >= rodData.Price then
                -- Deduct money
                LocalPlayer:SetAttribute("Money", LocalPlayer:GetAttribute("Money") - rodData.Price)
                -- Give the rod to the player
                local rod = Instance.new("Tool")
                rod.Name = selectedRod
                rod.Parent = LocalPlayer.Backpack
                print("Purchased:", selectedRod)
            else
                print("Not enough money to purchase:", selectedRod)
            end
        end
    end,
})

-- Misc Tab
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

MiscTab:AddLabel("Credits")
MiscTab:AddLabel("Script made by Midnight Hub")
MiscTab:AddLabel("UI by ChaosScripter")

local FPS = 0
local FrameCounter = 0
local FrameTimer = tick()

local pingLabel = MiscTab:AddLabel("Ping: " .. tostring(math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())))

local fpsLabel = MiscTab:AddLabel("FPS: 0")

coroutine.wrap(function()
    while true do
        FrameCounter += 1

        if (tick() - FrameTimer) >= 1 then
            FPS = FrameCounter
            FrameTimer = tick()
            FrameCounter = 0
        end

        local ping = math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())

        fpsLabel:Set("FPS: " .. tostring(FPS))
        pingLabel:Set("Ping: " .. tostring(ping))

        wait(0.1)
    end
end)()

local AntiDrown = false
local LocalPlayer = game.Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local CharAddedAntiDrownCon

MiscTab:AddToggle({
    Name = "AntiDrown",
    Default = false,
    Callback = function(Value)
        AntiDrown = Value
        if Value == true then
            if LocalCharacter and LocalCharacter:FindFirstChild("client") then
                local oxygen = LocalCharacter.client:FindFirstChild("oxygen")
                if oxygen and oxygen.Enabled == true then
                    oxygen.Enabled = false
                end
            end
            CharAddedAntiDrownCon = LocalPlayer.CharacterAdded:Connect(function()
                LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                if LocalCharacter and LocalCharacter:FindFirstChild("client") then
                    local oxygen = LocalCharacter.client:FindFirstChild("oxygen")
                    if oxygen and oxygen.Enabled == true and AntiDrown == true then
                        oxygen.Enabled = false
                    end
                end
            end)
        else
            if LocalCharacter and LocalCharacter:FindFirstChild("client") then
                local oxygen = LocalCharacter.client:FindFirstChild("oxygen")
                if oxygen and oxygen.Enabled == false then
                    oxygen.Enabled = true
                end
            end
            if CharAddedAntiDrownCon then
                CharAddedAntiDrownCon:Disconnect()
            end
        end
    end,
})

-- Initialize Collar Player settings
local CollarPlayer = false
local SelectedPlayer = nil
local PlayerList = {}

-- Fill PlayerList with the names of all players in the game
for _, player in pairs(game.Players:GetPlayers()) do
    table.insert(PlayerList, player.Name)
end

-- Update PlayerList whenever a player joins or leaves
game.Players.PlayerAdded:Connect(function(player)
    table.insert(PlayerList, player.Name)
end)

game.Players.PlayerRemoving:Connect(function(player)
    for i, name in ipairs(PlayerList) do
        if name == player.Name then
            table.remove(PlayerList, i)
            break
        end
    end
end)

MiscTab:AddToggle({
    Name = "Collar Player",
    Default = false,
    Callback = function(Value)
        CollarPlayer = Value
        if CollarPlayer and SelectedPlayer then
            CollarConnection = LocalCharacter.ChildAdded:Connect(function(child)
                if CollarPlayer and child:IsA("Tool") and SelectedPlayer then
                    child.ChildAdded:Connect(function(blehh)
                        if blehh.Name == "bobber" then
                            local RopeConstraint = blehh:FindFirstChildOfClass("RopeConstraint")

                            if RopeConstraint then
                                RopeConstraint.Length = math.huge
                                RopeConstraint.Changed:Connect(function(property)
                                    if property == "Length" then
                                        RopeConstraint.Length = math.huge
                                    end
                                end)
                            end

                            wait(1)
                            while CollarPlayer and blehh.Parent do
                                local targetPlayer = game.Players:FindFirstChild(SelectedPlayer)
                                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
                                    blehh.CFrame = targetPlayer.Character.Head.CFrame * CFrame.new(0, -0.5, 0) -- Position it slightly below the head
                                end
                                wait()
                            end
                        end
                    end)
                end
            end)
        else
            if CollarConnection then
                CollarConnection:Disconnect()
                CollarConnection = nil
            end
        end
    end,
})

MiscTab:AddDropdown({
    Name = "Select Player",
    Options = PlayerList,
    Callback = function(Selected)
        SelectedPlayer = Selected
    end,
})

MiscTab:AddButton({
    Name = "Boost FPS",
    Callback = function()
        _G.Ignore = {}
        _G.Settings = {
            Players = {
                ["Ignore Me"] = true,
                ["Ignore Others"] = true,
                ["Ignore Tools"] = true
            },
            Meshes = {
                NoMesh = false,
                NoTexture = false,
                Destroy = false
            },
            Images = {
                Invisible = true,
                Destroy = false
            },
            Explosions = {
                Smaller = true,
                Invisible = false,
                Destroy = false
            },
            Particles = {
                Invisible = true,
                Destroy = false
            },
            TextLabels = {
                LowerQuality = true,
                Invisible = false,
                Destroy = false
            },
            MeshParts = {
                LowerQuality = true,
                Invisible = false,
                NoTexture = false,
                NoMesh = false,
                Destroy = false
            },
            Other = {
                ["FPS Cap"] = 360,
                ["No Camera Effects"] = true,
                ["No Clothes"] = true,
                ["Low Water Graphics"] = true,
                ["No Shadows"] = true,
                ["Low Rendering"] = true,
                ["Low Quality Parts"] = true,
                ["Low Quality Models"] = true,
                ["Reset Materials"] = true,
            }
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
    end,
})

MiscTab:AddButton({
    Name = "Destroy GUI",
    Callback = function()
        -- Disable Auto Cast
        autoCast = false
        if autoCastConnection then
            autoCastConnection:Disconnect()
            autoCastConnection = nil
        end
        if autoCastConnection2 then
            autoCastConnection2:Disconnect()
            autoCastConnection2 = nil
        end

        -- Disable Auto Reel
        autoReel = false
        if autoreelandshakeConnection then
            autoreelandshakeConnection:Disconnect()
            autoreelandshakeConnection = nil
        end

        -- Disable Auto Shake
        autoShake = false
        if autoreelandshakeConnection then
            autoreelandshakeConnection:Disconnect()
            autoreelandshakeConnection = nil
        end

        -- Reset Zone Cast
        ZoneCast = false
        if ZoneConnection then
            ZoneConnection:Disconnect()
            ZoneConnection = nil
        end

        -- Disable AntiDrown and re-enable oxygen
        AntiDrown = false
        local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local oxygen = LocalCharacter:FindFirstChild("client") and LocalCharacter.client:FindFirstChild("oxygen")
        if oxygen then
            oxygen.Enabled = true
        end
        if CharAddedAntiDrownCon then
            CharAddedAntiDrownCon:Disconnect()
            CharAddedAntiDrownCon = nil
        end

        -- Remove safe zone part if it exists
        if safePart then
            safePart:Destroy()
            safePart = nil
        end

        -- Destroy the GUI
        OrionLib:Destroy()
    end,
})

OrionLib:Init()