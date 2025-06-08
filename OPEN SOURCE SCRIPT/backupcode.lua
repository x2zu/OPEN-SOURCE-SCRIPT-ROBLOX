--[[

   ▄████████ ███▄▄▄▄    ▄████████    ▄████████    ▄████████     ███        ▄████████    ▄████████  ▄█       
  ███    ███ ███▀▀▀██▄ ███    ███   ███    ███   ███    ███ ▀█████████▄   ███    ███   ███    ███ ███       
  ███    ███ ███   ███ ███    █▀    ███    █▀    ███    █▀     ▀███▀▀██   ███    ███   ███    ███ ███       
  ███    ███ ███   ███ ███         ▄███▄▄▄       ███            ███   ▀  ▄███▄▄▄▄██▀   ███    ███ ███       
▀███████████ ███   ███ ███        ▀▀███▀▀▀     ▀███████████     ███     ▀▀███▀▀▀▀▀   ▀███████████ ███       
  ███    ███ ███   ███ ███    █▄    ███    █▄           ███     ███     ▀███████████   ███    ███ ███       
  ███    ███ ███   ███ ███    ███   ███    ███    ▄█    ███     ███       ███    ███   ███    ███ ███▌    ▄ 
  ███    █▀   ▀█   █▀  ████████▀    ██████████  ▄████████▀     ▄████▀     ███    ███   ███    █▀  █████▄▄██ 
                                                                          ███    ███              ▀         
]]-- https://discord.gg/eTVvgvRq4s Join please support me with join :D & and get updates faster

```md
# +--===[ NEXT UPDATE ]===---+
```
```yaml
✅ Shop Fireserver Button (DONE) 
✅ Teleport With Button (DONE) 
✅ UI Shop Boat (DONE) 
✅ Inf Oxygen (DONE) 
✅ Save Place Fishing (DONE) 
✅ Auto Event Zone Cast (DONE) MORE EVENT ADDED SOON
✅ Auto Sell While AutoCatch (DONE)
✅ Custom Name (DONE)
✅ Custom Sky (DONE)
✅ Instant Interact (DONE)
✅ ESP (DONE) Maybe BUG
✅ Redeem all Code (DONE)
✅ Hide Indenty Name (DONE)
✅ Improve Autocast (DONE)
✅ Sell Hand/All + Setting (DONE)
✅ Auto Open Bait/Crate (DONE)
✅ Instant Drop Bobber (DONE)
✅ Instant Reel (DONE)
✅ Changer Name (DONE)
✅ Custom Sky (DONE)
✅ Custom Color Rod & Character (DONE)
✅ Random Many Feature (DONE)
✅ Auto Equip Rod (DONE)
❌ Auto Appraise + Type Fish (SOON)
❌ Random Suggestions (SOON)
❌ Auto Totem (SOON)
❌ Auto Spawn Event (SOON)
❌ Webhook (SOON)
❌ Spawn boat Everywhere (SOON)
❌ Auto Favourite Fish/Items (SOON)
❌ Auto Enchant (SOON)
❌ Custom Rod Skin (Client Side)
❌ Change UI
```

local AutoAppraise = false
local SelectedMutation = nil
local SelectedMutationPlus = {}

local AutoAppraiseSection = Tabs.Forge:AddSection("Auto Appraise")

local MutationDropdown = AutoAppraiseSection:AddDropdown("MutationSelection", {
    Title = "Select Mutation Once",
    Description = "Beta Version [BUG]",
    Values = { "Sparkling", "Shiny", "Big", "Giant", "None" },
    Multi = false,
    Default = "None",
    Callback = function(selected)
        SelectedMutation = selected ~= "None" and selected or nil
        print("Selected Mutation: " .. (SelectedMutation or "None"))
    end
})

local MutationPlusDropdown = AutoAppraiseSection:AddDropdown("MutationPlusSelection", {
    Title = "Select Mutation Plus",
    Description = "Beta Version [BUG]",
    Values = { "Sparkling", "Shiny", "Big", "Giant" },
    Multi = true,
    Default = {},
    Callback = function(selected)
        SelectedMutationPlus = selected or {}
        print("Selected Mutation Plus: " .. table.concat(SelectedMutationPlus, ", "))
    end
})

local function MeetsMutationRequirements(inventory)
    if SelectedMutation then
        if not (inventory:FindFirstChild("Mutation") and inventory.Mutation.Value == SelectedMutation) then
            return false
        end
    end
    
    for _, mutation in ipairs(SelectedMutationPlus) do
        if mutation == "Sparkling" and not inventory:FindFirstChild("Sparkling") then
            return false
        elseif mutation == "Shiny" and not inventory:FindFirstChild("Shiny") then
            return false
        elseif mutation == "Big" or mutation == "Giant" then
            local weight = tonumber(inventory:FindFirstChild("Weight") and inventory.Weight.Value or 0)
            local baseWeight = tonumber(data.Fish[inventory.Name] and data.Fish[inventory.Name].WeightPool[2] or 0) / 10

            if mutation == "Giant" and weight <= baseWeight * 1.99 then
                return false
            elseif mutation == "Big" and weight <= baseWeight then
                return false
            end
        end
    end
    return true
end

local function StartAutoAppraise()
    while AutoAppraise do
        local success, validFish = pcall(function()
            return ReplicatedStorage:WaitForChild("packages"):WaitForChild("Net"):WaitForChild("RF/AppraiseAnywhere/HaveValidFish"):InvokeServer()
        end)

        if not success or not validFish then
            Fluent:Notify({
                Title = "Auto Appraise",
                Content = "Not holding fish or invalid fish.",
                Duration = 5
            })
            AutoAppraise = false
            return
        end

        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if not tool or not tool:FindFirstChild("link") then
            Fluent:Notify({
                Title = "Auto Appraise",
                Content = "No valid tool found.",
                Duration = 5
            })
            AutoAppraise = false
            return
        end

        local currentTool = tostring(tool.link.Value)
        local inventory = ReplicatedStorage.playerstats[LocalPlayer.Name].Inventory:FindFirstChild(currentTool)
        if not inventory then
            Fluent:Notify({
                Title = "Auto Appraise",
                Content = "Inventory not found.",
                Duration = 5
            })
            AutoAppraise = false
            return
        end

        if MeetsMutationRequirements(inventory) then
            print("Target mutation obtained. Stopping Auto Appraise.")
            AutoAppraise = false
            return
        end

        task.spawn(function()
            pcall(function()
                workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Appraiser"):WaitForChild("appraiser"):WaitForChild("appraise"):InvokeServer()
            end)
        end)
        
        repeat task.wait() until not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        
        task.wait(0.5)
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local appraisedFish = game.Players.LocalPlayer.Backpack:FindFirstChild(currentTool)
        
        if appraisedFish then
            humanoid:EquipTool(appraisedFish)
        end
    end
end

local AutoAppraiseToggle = AutoAppraiseSection:AddToggle("AutoAppraise", {
    Title = "Auto Appraise",
    Default = false,
    Callback = function(isEnabled)
        AutoAppraise = isEnabled
        if AutoAppraise then
            StartAutoAppraise()
        end
    end
})


-- Fetch enchant data from the website
local EnchantData = loadstring(game:HttpGet("https://raw.githubusercontent.com/isMoons/loader/refs/heads/main/enchant.lua"))()

if type(EnchantData) ~= "table" or type(EnchantData.Enchants) ~= "table" then
    warn("Failed to load enchant data: Invalid format")
    EnchantData = { Enchants = {} } -- Hindari error dengan memastikan tabel ada
end

-- Populate the enchant names for the dropdown
local enchantNames = {}

for enchantName, _ in pairs(EnchantData.Enchants) do
    table.insert(enchantNames, enchantName)
end

if #enchantNames == 0 then
    warn("No enchant data found!")
end
local FluentVars = {}

local autoEnchantTab = Tabs.Forge:AddSection("Auto Enchant")

FluentVars.EnchantSelectDropDown = autoEnchantTab:AddDropdown("EnchantSelectDropDown", {
    Title = "Selected Enchant",
    Description = "",
    Options = enchantNames,
    Default = "",
    PlaceHolder = "Select Enchant",
    Multiple = false,
    Callback = function(selectedEnchant)
        if not selectedEnchant or selectedEnchant == "" then return end
        
        FluentVars.SelectedEnchant = selectedEnchant
        local enchantInfo = EnchantData.Enchants[selectedEnchant] or {}
        
        local enchantDescription = enchantInfo.Description or "No description available"
        local enchantColor = enchantInfo.Color or "1,1,1"

        local coloredText = rgbToRichText(enchantColor, selectedEnchant)
        local richDescription = coloredText .. "\n" .. enchantDescription

        FluentVars.EnchantParagraph:SetDesc(richDescription)
    end,
})

if #enchantNames > 0 then
    FluentVars.EnchantSelectDropDown:SetOptions(enchantNames)
end

FluentVars.AutoEnchantToggle = autoEnchantTab:AddToggle("AutoEnchantToggle", {
    Title = "Auto Enchant",
    Default = false,
    Description = "",
    Callback = function(isEnabled)
        FluentVars.AutoEnchant = isEnabled
        
        if FluentVars.AutoEnchant then
            if not FluentVars.SelectedEnchant or not EnchantData.Enchants[FluentVars.SelectedEnchant] then
                Fluent:Notify({
                    Title = "Auto Enchant",
                    Content = "Invalid enchant selection.",
                    Duration = 5
                })
                FluentVars.AutoEnchantToggle:Set(false)
                return
            end
            
            local selectedEnchantData = EnchantData.Enchants[FluentVars.SelectedEnchant]
            local requiredRelic = selectedEnchantData.IsExalted and "Exalted Relic" or "Enchant Relic"
            
            if not workspace[LocalPlayer.Name]:FindFirstChild(requiredRelic) then
                Fluent:Notify({
                    Title = "Auto Enchant",
                    Content = "Please hold a " .. requiredRelic .. ".",
                    Duration = 5
                })
                FluentVars.AutoEnchantToggle:Set(false)
                return
            end

            if ReplicatedStorage.world.cycle.Value ~= "Night" then
                Fluent:Notify({
                    Title = "Auto Enchant",
                    Content = "It needs to be night time.",
                    Duration = 5
                })
                FluentVars.AutoEnchantToggle:Set(false)
                return 
            end
            
            if ReplicatedStorage.playerstats[LocalPlayer.Name].Rods[getEquippedRod()].Value == FluentVars.SelectedEnchant then
                Fluent:Notify({
                    Title = "Auto Enchant",
                    Content = "You already have this enchant.",
                    Duration = 5
                })
                FluentVars.AutoEnchantToggle:Set(false)
                return 
            end

            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1310, -799, -82)
        end
        
        task.wait(1)
        local startTime = os.clock()
        while FluentVars.AutoEnchant do
            if os.clock() - startTime > 30 then  
                Fluent:Notify({
                    Title = "Auto Enchant",
                    Content = "Auto Enchant timed out.",
                    Duration = 5
                })
                FluentVars.AutoEnchantToggle:Set(false)
                break
            end
            task.wait(0.1)

            local enchantAltar = workspace.world.interactables:FindFirstChild("Enchant Altar")
            local prompt = enchantAltar and enchantAltar:FindFirstChild("ProximityPrompt")

            if prompt and prompt.Enabled and FluentVars.AutoEnchant then
                prompt.Parent = LocalPlayer.Character
                for _, obj in ipairs(LocalPlayer.Character:GetChildren()) do
                    if obj:IsA("ProximityPrompt") then
                        obj.HoldDuration = 0
                        obj:InputHoldBegin()
                        task.wait(0.01)
                        obj:InputHoldEnd()
                        obj.Parent = enchantAltar
                    end
                end              

                task.wait(0.5)
                if LocalPlayer.PlayerGui.over:FindFirstChild("prompt") then
                    local confirmButton = LocalPlayer.PlayerGui.over.prompt.confirm
                    if getconnections and typeof(getconnections) == "function" then
                        for _, v in pairs(getconnections(confirmButton.MouseButton1Click)) do
                            v.Function()
                        end
                    else
                        firesignal(confirmButton.MouseButton1Click)
                    end
                end                
            end
            if ReplicatedStorage.playerstats[LocalPlayer.Name].Rods[getEquippedRod()].Value == FluentVars.SelectedEnchant then
                FluentVars.AutoEnchantToggle:Set(false)
            end
        end
    end,
})

local rainConnection
Tabs.Misc:AddToggle("Rain", {
Title = "Disable Rain [Improve FPS]",
Default = false,
Description = "Hides Raining",
Callback = function(isEnabled)
    genv.hideRainToggle = isEnabled

    -- Disconnect existing connection if it exists
    if rainConnection then
        rainConnection:Disconnect()
        rainConnection = nil
    end

    if isEnabled then
        -- Continuously monitor and disable rain
        rainConnection = game:GetService("RunService").RenderStepped:Connect(function()
            -- Safely handle potential errors
            pcall(function()
                -- Disable rain emitters in the Camera
                local rainEmitter = workspace.Camera:FindFirstChild("__RainEmitter")
                if rainEmitter then
                    if rainEmitter:FindFirstChild("RainStraight") then
                        rainEmitter.RainStraight.Lifetime = NumberRange.new(0, 0)
                    end
                    if rainEmitter:FindFirstChild("RainTopDown") then
                        rainEmitter.RainTopDown.Lifetime = NumberRange.new(0, 0)
                    end
                end
            end)

            -- Disable attachments related to rain in the Terrain
            pcall(function()
                for _, descendant in ipairs(workspace.Terrain:GetDescendants()) do
                    if descendant:IsA("Attachment") and (descendant.Name == "__RainOccludedAttachment" or descendant.Name == "__RainSplashAttachment") then
                        if descendant:FindFirstChild("RainStraight") then
                            descendant.RainStraight.Lifetime = NumberRange.new(0, 0)
                        end
                        if descendant:FindFirstChild("RainTopDown") then
                            descendant.RainTopDown.Lifetime = NumberRange.new(0, 0)
                        end
                        if descendant:FindFirstChild("RainSplash") then
                            descendant.RainSplash.Lifetime = NumberRange.new(0, 0)
                        end
                    end
                end
            end)
        end)
    else
        -- Re-enable rain emitters when toggled off
        pcall(function()
            local rainEmitter = workspace.Camera:FindFirstChild("__RainEmitter")
            if rainEmitter then
                if rainEmitter:FindFirstChild("RainStraight") then
                    rainEmitter.RainStraight.Lifetime = NumberRange.new(0.8, 0.8)
                end
                if rainEmitter:FindFirstChild("RainTopDown") then
                    rainEmitter.RainTopDown.Lifetime = NumberRange.new(0.8, 0.8)
                end
            end
        end)
    end
end,
})

-- code world event
local FishingZonesFolder = game:GetService("Workspace").zones.fishing

local WorldEventTPDropdownUI = Tabs.Event:AddDropdown("WorldEventTPDropdownUI", {
    Title = "World Event [BUG]",
    Values = {
        "Megalodon Default", "Megalodon Ancient", "Great White Shark", "Great Hammerhead Shark", 
        "Whale Shark", "The Kraken Pool", "Ancient Kraken Pool", "Orcas Pool", "Ancient Orcas Pool", 
        "Forsaken Veil - Scylla", "Whales Pool", "Moby", "Rowdy McCharm", "O'Mango Goldgrin", 
        "Sunny O'Coin", "Blarney McBreeze", "Plumrick O'Luck"
    },
    Multi = false,
    Default = nil,
})

local allowedZones = {
    ["Megalodon Default"] = true, ["Megalodon Ancient"] = true, ["Great White Shark"] = false,
    ["Great Hammerhead Shark"] = false, ["Whale Shark"] = false, ["The Kraken Pool"] = false,
    ["Ancient Kraken Pool"] = true, ["Orcas Pool"] = true, ["Ancient Orcas Pool"] = true,
    ["Forsaken Veil - Scylla"] = true, ["Whales Pool"] = false, ["Moby"] = true,
    ["Rowdy McCharm"] = true, ["O'Mango Goldgrin"] = true, ["Sunny O'Coin"] = true,
    ["Blarney McBreeze"] = true, ["Plumrick O'Luck"] = true
}

local zoneList = {}
for _, zone in pairs(FishingZonesFolder:GetChildren()) do
    if allowedZones[zone.Name] then
        zoneList[zone.Name] = allowedZones[zone.Name]
    end
end   
local autoTeleportEnabled = false
local selectedEvent = nil
local originalCFrame = nil -- Simpan posisi awal sebelum teleportasi
local player = game.Players.LocalPlayer

-- Fungsi untuk teleport dan tetap bisa auto cast tanpa gerakan
local function FloatAboveZone()
local character = player.Character or player.CharacterAdded:Wait()
if not character then return end

local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
local Humanoid = character:FindFirstChildOfClass("Humanoid")
if not HumanoidRootPart or not Humanoid then return end

-- Simpan posisi awal sebelum teleport
originalCFrame = HumanoidRootPart.CFrame 

-- Gunakan BodyVelocity agar tidak jatuh, tapi tetap bisa auto cast
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.Velocity = Vector3.new(0, 0.1, 0) -- Efek anti-gravity
BodyVelocity.MaxForce = Vector3.new(0, math.huge, 0) -- Mencegah jatuh
BodyVelocity.Parent = HumanoidRootPart

-- Nonaktifkan gerakan karakter tanpa freeze total
local WalkSpeedBackup = Humanoid.WalkSpeed
local JumpPowerBackup = Humanoid.JumpPower
Humanoid.WalkSpeed = 0
Humanoid.JumpPower = 0

-- Jangan gerakkan karakter ke mana-mana
local originalCFrameNoMove = HumanoidRootPart.CFrame

while autoTeleportEnabled do
    local eventFound = false

    if selectedEvent then
        local eventInfo = EventData[selectedEvent]
        local eventObject = game.Workspace.zones.fishing:FindFirstChild(eventInfo.name)

        if eventObject then
            -- Teleport ke atas zona event
            eventFound = true
            HumanoidRootPart.CFrame = CFrame.new(eventObject.Position + eventInfo.offset)
            
            -- Tunggu sampai event selesai
            repeat
                task.wait(1)
            until not eventObject.Parent

            break -- Setelah event selesai, keluar dari loop
        end
    end

    if not eventFound then
        ShowNotification("No selected event found!")
    end

    task.wait(1) -- Cek setiap 1 detik
end

-- Hapus efek anti-gravity setelah event selesai
BodyVelocity:Destroy()

-- Kembalikan kecepatan gerakan & loncatan karakter
Humanoid.WalkSpeed = WalkSpeedBackup
Humanoid.JumpPower = JumpPowerBackup

-- Kembali ke posisi awal tanpa gerak
if originalCFrame then
    HumanoidRootPart.CFrame = originalCFrameNoMove
end
end

-- Event Selection Dropdown
WorldEventTPDropdownUI:OnChanged(function(Value)
selectedEvent = Value -- Simpan event yang dipilih
end)

-- Auto Teleport Toggle
Tabs.Event:AddToggle("AutoTeleport", {
Title = "Auto Teleport to Event",
Default = false,
Callback = function(value)
    autoTeleportEnabled = value
    if autoTeleportEnabled then
        FloatAboveZone()
    end
end
})

-- SaveZone
    -- Save Zone Code
    local Config = Tabs.Config:AddSection("Save Zone")
    
    -- Table untuk menyimpan zona memancing
    local fishZones = {}
    
    -- UI Dropdown untuk memilih zona memancing
    local fishZoneDropdown = Tabs.Config:AddDropdown("FishZoneDropdown", {
        Title = "Select Fishing Zone",
        Values = {},
        Multi = false,
        Default = nil,
    })
    
    -- Input Box untuk Nama Zona
    local zoneNameInput = Tabs.Config:AddInput("ZoneNameInput", {
        Title = "Zone Name",
        Default = "Fishing Spot",
        Placeholder = "Enter zone name...",
    })
    
    -- Button untuk membuat zona baru
    Tabs.Config:AddButton({
        Title = "Create Fish Zone",
        Description = "Save current location as a Fishing Zone (Will Be Deleted If Rejoin Game)",
        Callback = function()
            local playerPos = LocalPlayer.Character.HumanoidRootPart.CFrame
            local zoneName = zoneNameInput.Value ~= "" and zoneNameInput.Value or "Zone " .. tostring(#fishZones + 1)
    
            -- Simpan zona baru ke table
            fishZones[zoneName] = playerPos
    
            -- Update Dropdown UI
            table.insert(fishZoneDropdown.Values, zoneName)
            fishZoneDropdown:SetValues(fishZoneDropdown.Values)
    
            -- Notify user
            Fluent:Notify({
                Title = "Fishing Zone",
                Content = "Created new zone: " .. zoneName,
                Duration = 5
            })
        end
    })
    
    -- Saat memilih zona, teleport ke lokasi tersebut
    fishZoneDropdown:OnChanged(function(selectedZone)
        if fishZones[selectedZone] and LocalPlayer.Character then
            local targetPos = fishZones[selectedZone] * CFrame.new(0, 3, 0) -- Sedikit di atas agar tetap stabil
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPos
        end
    end)

    -- Auto Aurora
    local autoTotemSection = Tabs.Forge:AddSection("Auto Totems")
local Lighting = game:GetService("Lighting")

-- Function to convert "HH:MM:SS" to total seconds
local function timeToSeconds(timeString)
    local hours, minutes, seconds = timeString:match("(%d+):(%d+):(%d+)")
    return tonumber(hours) * 3600 + tonumber(minutes) * 60 + tonumber(seconds)
end

-- Function to check if TimeOfDay is within a range
local function isTimeBetween(startTime, endTime)
    local currentSeconds = timeToSeconds(Lighting.TimeOfDay)
    return currentSeconds >= timeToSeconds(startTime) and currentSeconds <= timeToSeconds(endTime)
end

-- Function to equip and activate totem
local function equipAndUseTotem(totemName)
    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v.Name == totemName then
            LocalPlayer.Character.Humanoid:EquipTool(v)
            task.wait(0.2)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, LocalPlayer, 0)
            break
        end
    end
end

autoTotemSection:AddToggle({
    Name = "Auto Night Sundial",
    CurrentValue = false,
    Callback = function(Value)
        while Value do
            while isTimeBetween("18:00:00", "06:05:00") do
                task.wait(3)
            end
            equipAndUseTotem("Sundial Totem")
            task.wait(1)
            if not Value then return end
        end
    end,
})

autoTotemSection:AddToggle({
    Name = "Auto Day Sundial",
    CurrentValue = false,
    Callback = function(Value)
        while Value do
            while isTimeBetween("06:00:00", "18:00:00") do
                task.wait(3)
            end
            equipAndUseTotem("Sundial Totem")
            task.wait(1)
            if not Value then return end
        end
    end,
})

autoTotemSection:AddToggle({
    Name = "Auto Aurora Totem",
    CurrentValue = false,
    Callback = function(Value)
        while Value do
            while isTimeBetween("06:20:00", "18:00:00") do
                equipAndUseTotem("Sundial Totem")
                task.wait(1)
            end
            while isTimeBetween("18:00:00", "18:15:00") do
                equipAndUseTotem("Aurora Totem")
                task.wait(1)
            end
            if not Value then return end
        end
    end,
})

-- Windows Dialog 
 Window:Dialog({
                Title = "You sure want sell all fish?",
                Content = "",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            SellFishAndReturnAll()
                            print("Fish Sold.")
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Pidr.")
                        end
                    }
                }
            })
        end
    })
    -- reset rod
    local ResetRodGroup = Tabs.LocalPlayer:AddRightGroupbox('Reset')

local ResetRodButton = ResetRodGroup:AddButton({
    Text = 'Reset rod',
    Func = function()
        local tool = LocalCharacter:FindFirstChildOfClass("Tool")

        if tool:FindFirstChild("events"):WaitForChild("reset") ~= nil then
            tool.events.reset:FireServer()
        end
    end,
    DoubleClick = false,
    Tooltip = 'Resets your rod'
})

-- Esp Fisch
-- ESP Script for fisch
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Mouse = LocalPlayer:GetMouse()

local functionESP()
    local gui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local text = Instance.new("TextLabel")

    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    frame.Parent = gui
    text.Parent = frame

    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1,0,1,0)
    frame.ZIndex = 9999

    text.TextColor3 = Color3.new(1,1,1)
    text.TextSize = 20
    text.Font = Enum.Font.SourceSansBold
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Bottom
    text.BackgroundTransparency = 1
    text.Size = UDim2.new(1,0,1,0)
    text.Text = ""

    local function updateESP()
        local target = nil
        for i, v in pairs(Players:GetPlayers()) do
            if v.Name ~= LocalPlayer.Name then
                target = v
            end
        end

        if target then
            local rootpart = target.Character.HumanoidRootPart
            local screenpos, vis = workspace.CurrentCamera:WorldToScreenPoint(rootpart.Position)
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootpart.Position).Magnitude

            text.Text = target.Name.."\nDistance: "..math.floor(distance).."\nHP: "..target.Health.."%\nLevel: "..target.leaderstats.Level.Value.." Lv."
            text.Position = UDim2.new(0, screenpos.X - text.TextSize.X.Offset/2, 0, screenpos.Y + text.TextSize.Y.Offset + 10)
        else
            text.Text = ""
        end

        -- Auto Open Skin
        Tabs.Forge:AddToggle("AutoOpenSkinCrate", {
            Title = "Auto Open Held Skin Crate",
            Default = false,
            Description = "",
            Callback = function(isEnabled)
                genv.AutoOpenSkinCrate = isEnabled
                if genv.AutoOpenSkinCrate then
                    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    
                    if tool then
                        if tool.Name == "Skin Crate" then
                            local skinLink = tostring(tool.link.Value)
                            local stackValue = tonumber(ReplicatedStorage.playerstats[game.Players.LocalPlayer.Name].Inventory[skinLink].Stack.Value)
        
                            for i = 1, stackValue do
                                ReplicatedStorage.packages.Net["RF/SkinCrates/RequestSpin"]:InvokeServer()
                                task.wait(8)
        
                                if not genv.AutoOpenSkinCrate then
                                    break
                                end
                            end
        
                            Fluent:Notify({Title = "Auto Open Skin Crate", Content = "Completed", Duration = 5})
                        else
                            Fluent:Notify({Title = "Auto Open Skin Crate", Content = "You're not holding a Skin Crate...", Duration = 5})
                        end
                    else
                        Fluent:Notify({Title = "Auto Open Skin Crate", Content = "You're not holding a Skin Crate...", Duration = 5})
                    end
                end
            end,
        })
        local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Knuxy92/Ui-linoria/main/Fluent/Fluent.lua"))()
        local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
        local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
        -- UI utama menggunakan Fluent
    local Window = Fluent:CreateWindow({
        Title = game:GetService("MarketplaceService"):GetProductInfo(16732694052).Name .. " | Ancestral v1.0",
        SubTitle = "discord.gg/ancestral",
        TabWidth = 160,
        Size = UDim2.fromOffset(520, 400), -- Ukuran lebih kecil agar lebih responsif
        Acrylic = false,
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
            -- // // // Tabs Gui // // // --
            local Tabs = { -- https://lucide.dev/icons/
            Information = Window:AddTab({ Title = "Information", Icon = "rbxassetid://10723415903" }),
            Visual = Window:AddTab({ Title = "Visual", Icon = "rbxassetid://97855077268525" }), 
        }
        Tabs.Information:AddButton({
            Title = "Copy Discord link",
            Description = "Join our main Discord for the latest updates!",
            Callback = function()
                setclipboard("https://discord.gg/dJmUxnAfbq")
                Fluent:Notify({
                    Title = "Ancestral",
                    Content = "Link has been copied to clipboard!",
                    Duration = 2
                })
            end
        })    
        Tabs.Information:AddParagraph({
            Title = "CHANGELOGS - Ancestral 1.0",
            Content = "Why i make 2 UI? Because Moonsec suck and can't obf have a limit lol, so wait me buy luarmor/luraph"
        })
        local NameInput = Tabs.Visual:AddInput("Input",
        {
            Title = "Name Changer",
            Default = "",
            Placeholder = "Name",
            Numeric = false, -- Only allows numbers
            Finished = true, -- Only calls callback when you press enter
            Callback = function(Value)
                local new_name = Value
                local new_id = 104867
                local clear_avatar = false
                local flush_body_colors = false
                local rename_instances = false
                local change_id = false
                local deep_scan = true
                local filter_httpget = {
                    enabled = false,
                    result = true,
                    request = true
                }
    
                local Players =
                    assert(
                    assert(game, "game missing?"):FindService("Players") or game:GetService("Players"),
                    "Players missing?"
                )
                local LocalPlayer = assert(Players.LocalPlayer, "LocalPlayer missing?")
                local CoreGui = game:FindService("CoreGui") or game:GetService("CoreGui")
                local PlayerGui = assert(LocalPlayer:FindFirstChild("PlayerGui"), "PlayerGui mising?")
                local RunService =
                    assert(game:FindService("RunService") or game:GetService("RunService"), "RunService missing?")
                local replaces_str = {
                    Players.LocalPlayer.Name
                }
                local replaces_num = {
                    tostring(Players.LocalPlayer.UserId)
                }
                new_name, new_id = tostring(new_name), tostring(new_id)
                local function casepatt(pattern)
                    return string.gsub(
                        pattern,
                        "(%%?)(.)",
                        function(percent, letter)
                            if percent ~= "" or not string.match(letter, "%a") then
                                return percent .. letter
                            else
                                return string.format("[%s%s]", string.lower(letter), string.upper(letter))
                            end
                        end
                    )
                end
                function replace(item, fast)
                    for replacewith, data in pairs(
                        {
                            [new_name] = replaces_str,
                            [new_id] = replaces_num
                        }
                    ) do
                        if not fast then
                            RunService.RenderStepped:Wait()
                        end
                        for _, v in pairs(data) do
                            if not fast then
                                RunService.RenderStepped:Wait()
                            end
                            for _, t in pairs(
                                {
                                    "Text",
                                    "Message",
                                    "ToolTip",
                                    "Value"
                                }
                            ) do
                                pcall(
                                    function()
                                        if string.find(item[t], v, nil, true) then
                                            item[t] = string.gsub(item[t], v, replacewith)
                                        elseif string.find(item[t], string.lower(v), nil, true) then
                                            item[t] = string.gsub(item[v], string.lower(v), string.lower(replacewith))
                                        elseif string.find(item[t], string.upper(v), nil, true) then
                                            item[t] = string.gsub(item[v], string.upper(v), string.upper(replacewith))
                                        elseif string.find(string.lower(item[t]), string.lower(v), nil, true) then
                                            item[t] = string.gsub(item[v], casepatt(v), replacewith)
                                        end
                                    end
                                )
                                if not fast then
                                    RunService.RenderStepped:Wait()
                                end
                            end
                            if not fast then
                                RunService.RenderStepped:Wait()
                            end
                            if rename_instances then
                                pcall(
                                    function()
                                        if string.find(item.Name, v, nil, true) then
                                            item.Name = string.gsub(item.Name, v, replacewith)
                                        elseif string.find(item.Name, string.lower(v), nil, true) then
                                            item.Name = string.gsub(item.Name, string.lower(v), string.lower(replacewith))
                                        elseif string.find(item.Name, string.upper(v), nil, true) then
                                            item.Name = string.gsub(item.Name, string.lower(v), string.upper(replacewith))
                                        elseif string.find(string.lower(item.Name), string.lower(v), nil, true) then
                                            item.Name = string.gsub(item.Name, casepatt(v), replacewith)
                                        end
                                    end
                                )
                            end
                        end
                    end
                end
                shared.rep = replace
                local function scan_and_replace(fast)
                    local scan_que = {
                        CoreGui:GetDescendants(),
                        PlayerGui:GetDescendants(),
                        workspace:GetDescendants()
                    }
                    local last_break = 0
                    for _, items in pairs(scan_que) do
                        if not fast then
                            RunService.RenderStepped:Wait()
                        end
                        for _, gui in pairs(assert(type(items) == "table" and items, "scan_que does not hold a table")) do
                            last_break = 1 + last_break
                            if last_break >= 6000 then
                                RunService.RenderStepped:Wait()
                                last_break = 0
                            end
                            if not fast then
                                RunService.RenderStepped:Wait()
                            end
                            replace(gui, fast)
                        end
                    end
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not fast then
                            RunService.RenderStepped:Wait()
                        end
                        replace(obj)
                    end
                end
                function fixchar(Character)
                    if not Character then
                        return
                    end
                    wait(0.2)
                    RunService.RenderStepped:Wait()
                    if rename_instances then
                        Character.Name = new_name
                    end
                    if clear_avatar then
                        Players.LocalPlayer:ClearCharacterAppearance()
                    end
                    wait(0.1)
                    if flush_body_colors then
                        local bc = Character:FindFirstChildOfClass("BodyColors")
                        if bc then
                            for _, c in pairs(
                                {
                                    "HeadColor",
                                    "LeftArmColor",
                                    "LeftLegColor",
                                    "RightArmColor",
                                    "RightLegColor",
                                    "TorsoColor"
                                }
                            ) do
                                bc[c] = (typeof(bc[c]) == "BrickColor" and BrickColor.Random()) or bc[c]
                            end
                        else
                            local h = Character:FindFirstChildOfClass("Humanoid")
                            if h then
                                for _, limb in pairs(Character:GetChildren()) do
                                    if limb:IsA("BasePart") and pcall(h.GetLimb, h, limb) then
                                        limb.BrickColor = BrickColor.Random()
                                    end
                                end
                            end
                        end
                    end
                end
                fixchar(Players.LocalPlayer.Character)
                Players.LocalPlayer.CharacterAppearanceLoaded:Connect(fixchar)
                Players.LocalPlayer.CharacterAdded:Connect(fixchar)
                if deep_scan then
                    game.ItemChanged:Connect(
                        function(obj, property)
                            if not rename_instances and "Name" == property then
                                return
                            end
                            local s, v =
                                pcall(
                                function()
                                    return obj[property]
                                end
                            )
                            if s then
                                if "string" == type(v) then
                                    for _, c in pairs(replaces_str) do
                                        RunService.RenderStepped:Wait()
                                        if string.find(obj[property], c, nil, true) then
                                            obj[property] = string.gsub(tostring(obj[property] or v), c, new_name)
                                        elseif string.find(obj[property], string.lower(c)) then
                                            obj[property] =
                                                string.gsub(
                                                tostring(obj[property] or v),
                                                string.lower(c),
                                                string.lower(new_name)
                                            )
                                        elseif string.find(obj[property], string.upper(c), nil, true) then
                                            obj[property] =
                                                string.gsub(
                                                tostring(obj[property] or v),
                                                string.upper(c),
                                                string.upper(new_name)
                                            )
                                        elseif string.find(string.upper(obj[property]), string.upper(c), nil, true) then
                                            obj[property] = string.gsub(tostring(obj[property] or v), casepatt(c), new_name)
                                        end
                                    end
                                    RunService.RenderStepped:Wait()
                                    for _, c in pairs(replaces_num) do
                                        RunService.RenderStepped:Wait()
                                        if string.find(obj[property], new_id) then
                                            obj[property] = string.gsub(tostring(obj[property] or v), c, new_id)
                                        end
                                    end
                                elseif "number" == type(v) then
                                    v = tostring(obj[property] or v)
                                    for _, c in pairs(replaces_num) do
                                        RunService.RenderStepped:Wait()
                                        if string.find(v, c) then
                                            obj[property] =
                                                tonumber(
                                                tonumber(string.gsub(v, c, new_id) or obj[property]) or obj[property]
                                            )
                                        end
                                    end
                                end
                            end
                        end
                    )
                    CoreGui.DescendantAdded:Connect(replace)
                    PlayerGui.DescendantAdded:Connect(replace)
                end
                local function filterstr(s)
                    for _, data in pairs(
                        {
                            [new_name] = replaces_str,
                            [new_id] = replaces_num
                        }
                    ) do
                        for c, v in pairs(data) do
                            if string.find(s, v, nil, true) then
                                s = string.gsub(s, v, c)
                            elseif string.find(s, string.lower(v), nil, true) then
                                s = string.gsub(s, string.lower(v), string.lower(c))
                            elseif string.find(s, string.upper(v), nil, true) then
                                s = string.gsub(s, string.upper(v), string.upper(c))
                            elseif string.find(string.upper(s), string.upper(v), nil, true) then
                                s = string.gsub(s, casepatt(v), c)
                            end
                        end
                    end
                    return s
                end
                if filter_httpget.enabled and type(hookfunc or hookfunction or detour_function) == "function" then
                    local hget
                    hget =
                        assert(hookfunction or hookfunc or detour_function, "Hook function required for filter_httpget")(
                        assert(game.HttpGet, "HttpGet required for filter_httpget"),
                        function(shelf, u, ...)
                            if filter_httpget.request then
                                local x, e = pcall(filterstr, u)
                                if x and e then
                                    u = e
                                end
                            end
                            if filter_httpget.result then
                                local result = hget(shelf, u, ...)
                                local x, e = pcall(filterstr, result)
                                if x and e then
                                    return e
                                end
                            end
                            return hget(shelf, u, ...)
                        end
                    )
                end
                scan_and_replace(true)
                while wait(1) do
                    if rename_instances then
                        Players.LocalPlayer.Name = new_name
                        if Players.LocalPlayer.Character then
                            Players.LocalPlayer.Character.Name = new_name
                        end
                    end
                    if change_id then
                        Players.LocalPlayer.UserId = tonumber(tonumber(new_id or 1) or 1)
                    end
                    scan_and_replace()
                end
            end
        }
    )
    local rbxLink = "http://www.roblox.com/asset/?id="
    local skyTable = {
        ["Realistic Sky"] = 4607457995,
        ["Realistic Sky(2)"] = 10256505900,
        ["Minecraft Sky"] = 2758029221,
        ["Minecraft Sky(2)"] = 10594760952,
        ["Night Sky"] = 7975080965,
        ["Moon Sky"] = 14828385099,
        ["Halloween Sky"] = 15220097936,
        ["Pink Sky"] = 8202961731,
        ["Black Sky"] = 4696746436,
        ["Galaxy Sky"] = 15983996673,
        ["Space Sky"] = 12612655684,
        ["Anime Sky"] = 13107361022,
        ["Hell Sky"] = 17893731831,
        ["Rainbow Sky"] = 127719608807122,
        ["Scary Sky"] = 8808550143,
        ["The Rock Sky"] = 9774228162
    }
    
    local lighting = game:GetService("Lighting") -- Pastikan lighting terdefinisi
    local currentSky
    local skyNames = {}
    
    for name, id in pairs(skyTable) do
        table.insert(skyNames, name)
    end
    
    local SkyDropdown = Tabs.Visual:AddDropdown(
        "Dropdown",
        {
            Title = "Sky",
            Values = skyNames,
            Multi = false,
            Default = 1
        }
    )
    
    SkyDropdown:OnChanged(function(SkyName)
        currentSky = SkyName
    end)
    
    Tabs.Visual:AddButton(
        {
            Title = "Change Sky",
            Description = "You have to wait a while for the sky to fully load.",
            Callback = function()
                if not currentSky or not skyTable[currentSky] then
                    Fluent:Notify(
                        {
                            Title = "Error",
                            Content = "No sky selected or invalid selection.",
                            Duration = 5
                        }
                    )
                    return
                end
    
                local oldSky = lighting:FindFirstChildWhichIsA("Sky")
                if oldSky then
                    oldSky:Destroy()
                end
    
                local newSky = game:GetObjects("rbxassetid://" .. tostring(skyTable[currentSky]))[1]
                if newSky then
                    lighting.ClockTime = 14.5
                    newSky.Parent = lighting
                else
                    Fluent:Notify(
                        {
                            Title = "Error",
                            Content = "Problem Error: 00x1b",
                            SubContent = "If the problem continues, please write about it in our discord channel 'bug-reports'.",
                            Duration = 5
                        }
                    )
                end
            end
        }
    )
    Window:SelectTab(1)
    -- Hunt Code
    _G.SelectedTarget = nil
    _G.Hunting = false
    
    local TargetList = {
        "Megalodon Default",
        "Megalodon Ancient",
        "Megalodon Phantom",
        "Forsaken Veil - Scylla",
        "Kraken Pool",
        "Ancient Kraken Pool",
        "Orcas Pool",
        "Whales Pool",
        "Plumrick O'Luck",
        "Blarney McBreeze",
        "Rowdy McCharm",
        "O'Mango Goldgrin",
        "Sunny O'Coin"
    }
    
    Tabs.Event:AddDropdown("SelectTarget", {
        Title = "Select Hunting Target",
        Values = TargetList,
        Callback = function(Value)
            _G.SelectedTarget = Value
        end
    })
    
    Tabs.Event:AddToggle("Hunting", {
        Title = "Hunt Selected Target",
        Default = false,
        Callback = function(Value)
            _G.Hunting = Value
    
            while _G.Hunting do
                task.wait()
    
                if not _G.SelectedTarget then
                    warn("Please select a hunting target first!")
                    break
                end
    
                local Target = workspace.zones.fishing:FindFirstChild(_G.SelectedTarget)
    
                if Target then
                    Target.CanCollide = true
                    if not Target:FindFirstChild("RodEquipCheck") then
                        local rodpart = Instance.new("Part", Target)
                        rodpart.Name = "RodEquipCheck"
    
                        local toolEquipped = false
    
                        for _, tool in game.Players.LocalPlayer.Backpack:GetChildren() do
                            if tool:IsA("Tool") then
                                for _, folder in tool:GetChildren() do
                                    if folder:IsA("Folder") and folder.Name == "events" then
                                        for _, v in game.Players.LocalPlayer.Character:GetChildren() do
                                            if v:IsA("Tool") then
                                                v.Parent = game.Players.LocalPlayer.Backpack
                                                tool.Parent = game.Players.LocalPlayer.Character
                                                toolEquipped = true
                                                break
                                            end
                                        end
    
                                        if not toolEquipped then
                                            tool.Parent = game.Players.LocalPlayer.Character
                                        end
                                    end
                                end
                            end
                        end
                    end
    
                    local target_pos = CFrame.new(Target.CFrame.Position + Vector3.new(0, 74, 0))
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target_pos
                end
            end
        end
    })    

    Tabs.Automatically:AddDropdown("ChooseTotem", {
        Title = "Choose Totem",
        Values = { "Sundial Totem", "Aurora Totem", "Tempest Totem", "Smokescreen Totem", "Windset Totem", "Eclipse Totem", "Meteor Totem", "Blizzard Totem", "Avalanche Totem", "Zeus Storm Totem", "Poseidon's Wrath Totem" },
        Default = nil,
        Multi = false,
        Callback = function(selectedTotem)
            _G.ChooseTotem = selectedTotem
        end
    })
    
    Tabs.Automatically:AddToggle("AutoUseTotem", {
        Title = "Auto Use Totem",
        Description = "Automatically uses selected Totem.",
        Default = false,
        Callback = function(isEnabled)
            _G.AutoUseTotem = isEnabled
        end
    })        
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Sundial Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Sundial Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Aurora Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Aurora Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Tempest Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Tempest Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Smokescreen Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Smokescreen Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Windset Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Windset Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Eclipse Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(Lgame:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Eclipse Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Meteor Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Meteor Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Blizzard Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Blizzard Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Avalanche Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Avalanche Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Zeus Storm Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Zeus Storm Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    
    spawn(function()
        while wait(.1) do
            if _G.ChooseTotem == "Poseidon's Wrath Totem" and _G.AutoUseTotem then
                pcall(function()
                    repeat task.wait(0.01) 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Poseidon's Wrath Totem" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                        game:GetService'VirtualUser':CaptureController()
                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                end)
            end
        end
    end)
    --     -- Initial Setup
    UpdatePlayerList()
    local section = Tabs.Forge:AddSection("Forge Feature")
    local FishData = loadstring(game:HttpGet("https://raw.githubusercontent.com/ProjektEta/Vixie.lua/refs/heads/main/Tools/Fisch/FishData.lua"))()
    local __t = {}
    local CheckValues = Tabs.Forge:AddDropdown("CheckValues", { 
        Title = "Check Values Fish", 
        Values = __t,
        Multi = false,
        Default = nil,
        Callback = function(v)
            if not v or v == "" then return end
    
            local data = game.ReplicatedStorage.playerstats:FindFirstChild(v)
            if not data then return end
            data = data.Inventory:GetChildren()
    
            local curValue = 0
    
            for _, item in pairs(data) do
                if FishData.Fish[item.Value] then
                   -- GIVE ME CREDIT NIGGA [{Naaellx}] - THIS FEATURE DOESNT WORKING IF YOU NOT GIVE ME CREDIT HAHAHAHAHA CUS I REMOVE ONE CODE ON HERE [BE SMART] 
                    -- GIVE ME CREDIT NIGGA [{Naaellx}] - THIS FEATURE DOESNT WORKING IF YOU NOT GIVE ME CREDIT HAHAHAHAHA CUS I REMOVE ONE CODE ON HERE [BE SMART] 
                        -- GIVE ME CREDIT NIGGA [{Naaellx}] - THIS FEATURE DOESNT WORKING IF YOU NOT GIVE ME CREDIT HAHAHAHAHA CUS I REMOVE ONE CODE ON HERE [BE SMART] 
                    end
                    curValue = curValue + itemPrice
                end
            end
    
            Fluent:Notify({
                Title = "Account Value",
                Content = v .. "Account is worth : " .. curValue .. " C$",
                Duration = 5
            })
        end
    })
    
    game.ReplicatedStorage.playerstats.ChildAdded:Connect(function(c)
        table.insert(__t, c.Name)
        CheckValues:SetValues(__t)
    end)
    
    game.ReplicatedStorage.playerstats.ChildRemoved:Connect(function(c)
        local index = table.find(__t, c.Name)
        if index then
            table.remove(__t, index)
            CheckValues:SetValues(__t)
        end
    end)
    
    for _, v in pairs(game.ReplicatedStorage.playerstats:GetChildren()) do
        table.insert(__t, v.Name)
    end
    CheckValues:SetValues(__t)