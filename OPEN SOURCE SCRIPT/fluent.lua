repeat task.wait(0.25) until game:IsLoaded();
getgenv().Image = "rbxassetid://87987688628967"; 
getgenv().ToggleUI = "LeftControl" 

task.spawn(function()
    if not getgenv().LoadedMobileUI == true then getgenv().LoadedMobileUI = true
        local OpenUI = Instance.new("ScreenGui");
        local ImageButton = Instance.new("ImageButton");
        local UICorner = Instance.new("UICorner");
        OpenUI.Name = "OpenUI";
        OpenUI.Parent = game:GetService("CoreGui");
        OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ImageButton.Parent = OpenUI;
        ImageButton.BackgroundColor3 = Color3.fromRGB(105,105,105);
        ImageButton.BackgroundTransparency = 0.8
        ImageButton.Position = UDim2.new(0.9,0,0.1,0);
        ImageButton.Size = UDim2.new(0,50,0,50);
        ImageButton.Image = getgenv().Image;
        ImageButton.Draggable = true;
        ImageButton.Transparency = 1;
        UICorner.CornerRadius = UDim.new(0,200);
        UICorner.Parent = ImageButton;
        ImageButton.MouseButton1Click:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true,getgenv().ToggleUI,false,game);
        end)
    end
end)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local enemiesFolder = workspace:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client")
local remote = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")

local teleportEnabled = false
local killedNPCs = {}
local dungeonkill = {}
local selectedMobName = ""
local movementMethod = "Tween" 
local farmingStyle = "Default" 
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    hrp = newCharacter:WaitForChild("HumanoidRootPart")
end)

local function anticheat()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local characterScripts = player.Character:FindFirstChild("CharacterScripts")
        
        if characterScripts then
            local flyingFixer = characterScripts:FindFirstChild("FlyingFixer")
            if flyingFixer then
                flyingFixer:Destroy()
            end

            local characterUpdater = characterScripts:FindFirstChild("CharacterUpdater")
            if characterUpdater then
                characterUpdater:Destroy()
            end
        end
    end
end

local function isEnemyDead(enemy)
    local healthBar = enemy:FindFirstChild("HealthBar")
    if healthBar and healthBar:FindFirstChild("Main") and healthBar.Main:FindFirstChild("Bar") then
        local amount = healthBar.Main.Bar:FindFirstChild("Amount")
        if amount and amount:IsA("TextLabel") and amount.ContentText == "0 HP" then
            return true
        end
    end
    return false
end

local function getNearestSelectedEnemy()
    local nearestEnemy = nil
    local shortestDistance = math.huge
    local playerPosition = hrp.Position

    for _, enemy in ipairs(enemiesFolder:GetChildren()) do
        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
            local healthBar = enemy:FindFirstChild("HealthBar")
            if healthBar and healthBar:FindFirstChild("Main") and healthBar.Main:FindFirstChild("Title") then
                local title = healthBar.Main.Title
                if title and title:IsA("TextLabel") and title.ContentText == selectedMobName and not killedNPCs[enemy.Name] then
                    local enemyPosition = enemy.HumanoidRootPart.Position
                    local distance = (playerPosition - enemyPosition).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestEnemy = enemy
                    end
                end
            end
        end
    end
    return nearestEnemy
end

local function getAnyEnemy()
    for _, enemy in ipairs(enemiesFolder:GetChildren()) do
        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and not dungeonkill[enemy.Name] then
            return enemy
        end
    end
    return nil
end

local function fireShowPetsRemote()
    local args = {
        [1] = {
            [1] = {
                ["Event"] = "ShowPets"
            },
            [2] = "\t"
        }
    }
    remote:FireServer(unpack(args))
end

local function getNearestEnemy()
    local nearestEnemy, shortestDistance = nil, math.huge
    local playerPosition = hrp.Position

    for _, enemy in ipairs(enemiesFolder:GetChildren()) do
        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and not killedNPCs[enemy.Name] then
            local distance = (playerPosition - enemy:GetPivot().Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestEnemy = enemy
            end
        end
    end
    return nearestEnemy
end

local function moveToTarget(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") then return end
    local enemyHrp = target.HumanoidRootPart

    if movementMethod == "Teleport" then
        hrp.CFrame = enemyHrp.CFrame * CFrame.new(0, 0, 6)
    elseif movementMethod == "Tween" then
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = enemyHrp.CFrame * CFrame.new(0, 0, 6)})
        tween:Play()
    elseif movementMethod == "Walk" then
        hrp.Parent:MoveTo(enemyHrp.Position)
    end
end

local function teleportAndTrackDeath()
    while teleportEnabled do
        local target = getNearestEnemy()
        if target and target.Parent then
            anticheat()
            moveToTarget(target)
            task.wait(0.5)
            fireShowPetsRemote()
            remote:FireServer({
                {
                    ["PetPos"] = {},
                    ["AttackType"] = "All",
                    ["Event"] = "Attack",
                    ["Enemy"] = target.Name
                },
                "\7"
            })

            while teleportEnabled and target.Parent and not isEnemyDead(target) do
                task.wait(0.1)
            end

            killedNPCs[target.Name] = true
        end
        task.wait(0.2)
    end
end

local function teleportDungeon()
    while teleportEnabled do
        local target = getAnyEnemy()

        if target and target.Parent then
            anticheat()
            moveToTarget(target)
            task.wait(0.50)
            fireShowPetsRemote()
            remote:FireServer({
                {
                    ["PetPos"] = {},
                    ["AttackType"] = "All",
                    ["Event"] = "Attack",
                    ["Enemy"] = target.Name
                },
                "\7"
            })

            repeat task.wait() until not target.Parent or isEnemyDead(target)

            dungeonkill[target.Name] = true
        end
        task.wait()
    end
end

local function teleportToSelectedEnemy()
    while teleportEnabled do
        local target = getNearestSelectedEnemy()
        if target and target.Parent then
            anticheat()
            moveToTarget(target)
            task.wait(0.5)
            fireShowPetsRemote()

            remote:FireServer({
                {
                    ["PetPos"] = {},
                    ["AttackType"] = "All",
                    ["Event"] = "Attack",
                    ["Enemy"] = target.Name
                },
                "\7"
            })

            while teleportEnabled and target.Parent and not isEnemyDead(target) do
                task.wait(0.1)
            end

            killedNPCs[target.Name] = true
        end
        task.wait(0.20)
    end
end

local function attackEnemy()
    while damageEnabled do
        local targetEnemy = getNearestEnemy()
        if targetEnemy then
            local args = {
                [1] = {
                    [1] = {
                        ["Event"] = "PunchAttack",
                        ["Enemy"] = targetEnemy.Name
                    },
                    [2] = "\4"
                }
            }
            remote:FireServer(unpack(args))
        end
        task.wait(1)
    end
end
local ScreenGui = Instance.new("ScreenGui")
local AdFrame = Instance.new("Frame")
local DiscordLabel = Instance.new("TextLabel")
local CopyButton = Instance.new("TextButton")
local ExitButton = Instance.new("TextButton")
local WaitButton = Instance.new("TextButton")
local UIGradientFrame = Instance.new("UIGradient")
local UIGradientText = Instance.new("UIGradient")

ScreenGui.Name = "AdsGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

AdFrame.Name = "AdFrame"
AdFrame.Parent = ScreenGui
AdFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
AdFrame.Position = UDim2.new(0.5, 0, 0.35, 0)
AdFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AdFrame.BorderSizePixel = 2
AdFrame.Draggable = true
AdFrame.Active = true
AdFrame.BorderColor3 = Color3.fromRGB(128, 0, 128) -- Ungu

-- Gradient untuk Background AdFrame
UIGradientFrame.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), -- Putih di atas
    ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128)) -- Ungu di bawah
}
UIGradientFrame.Parent = AdFrame

DiscordLabel.Name = "DiscordLabel"
DiscordLabel.Parent = AdFrame
DiscordLabel.Size = UDim2.new(1, 0, 0.6, 0)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "Ancestral Hub"
DiscordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordLabel.TextSize = 22
DiscordLabel.TextWrapped = true

-- Gradient untuk teks "Ancestral Hub"
UIGradientText.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), -- Putih di atas
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 200)), -- Gradasi Ungu Muda
    ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128)) -- Ungu di bawah
}
UIGradientText.Parent = DiscordLabel

CopyButton.Name = "CopyButton"
CopyButton.Parent = AdFrame
CopyButton.Size = UDim2.new(0.4, 0, 0.2, 0)
CopyButton.Position = UDim2.new(0.1, 0, 0.7, 0)
CopyButton.Text = "Copy Link Discord"
CopyButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Ungu
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ExitButton.Name = "ExitButton"
ExitButton.Parent = AdFrame
ExitButton.Size = UDim2.new(0.4, 0, 0.2, 0)
ExitButton.Position = UDim2.new(0.5, 0, 0.7, 0)
ExitButton.Text = "Exit"
ExitButton.Visible = false
ExitButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- Putih

WaitButton.Name = "WaittoExit"
WaitButton.Parent = AdFrame
WaitButton.Size = UDim2.new(0.4, 0, 0.2, 0)
WaitButton.Position = UDim2.new(0.5, 0, 0.7, 0)
WaitButton.Text = "Waitting Delay Exit"
WaitButton.Visible = true
WaitButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
WaitButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- Putih

task.delay(5, function()
    WaitButton.Visible = false
    ExitButton.Visible = true
end)

CopyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.com/invite/eTVvgvRq4s")
        task.wait()
        CopyButton.Text = "Copied To Discord Link"
        task.wait(0.6)
        CopyButton.Text = "Copy Link Discord"
    end
end)

ExitButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Farm Method Selection Dropdown
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Knuxy92/Ui-linoria/main/Fluent/Fluent.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = game:GetService("MarketplaceService"):GetProductInfo(87039211657390).Name .. " 〢 Ancestral",
    SubTitle = "discord.gg/dJmUxnAfbq",
    TabWidth = 160,
    Size = UDim2.fromOffset(520, 400), -- Ukuran lebih kecil agar lebih responsif
    Acrylic = false,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl
})
local Tabs = {
    Player = Window:AddTab({ Title = "Character", Icon = "rbxassetid://10747373176" }),
    Discord = Window:AddTab({ Title = "Information", Icon = "rbxassetid://10723415903" }),
    Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://10734966248" }), 
    tp = Window:AddTab({ Title = "Worlds", Icon = "rbxassetid://10709811445" }),
    mount = Window:AddTab({ Title = "Mounts", Icon = "rbxassetid://103886955707876" }),
    dungeon = Window:AddTab({ Title = "Dungeon", Icon = "rbxassetid://77943964625400" }),
    pets = Window:AddTab({ Title = "Pets", Icon = "rbxassetid://10723345518" }),
    misc = Window:AddTab({ Title = "Misc", Icon = "rbxassetid://10734976739" }),
}
print([[  
    ∧,,,∧
  (  ̳• · • ̳)
  /    づ You want my heart? Don't skid please :D
    ∧,,,∧
  (  ̳• · • ̳)
  /    づ♡ Ok here's my heart
  
  🟢 Successfully Loaded!
  ]])
local autoAttackEnabled = false
local punchLoopConnection = nil
local proximityConnection = nil

local AutoAttackButton = Tabs.Main:AddToggle("AutoAttack", {
    Title = "Auto Attack",
    Default = false,
    Callback = function(enabled)
        autoAttackEnabled = enabled

        if not enabled then
            -- Hentikan semua koneksi saat toggle mati
            if punchLoopConnection then
                punchLoopConnection:Disconnect()
                punchLoopConnection = nil
            end
            if proximityConnection then
                proximityConnection:Disconnect()
                proximityConnection = nil
            end
            return
        end

        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local enemiesFolder = workspace.__Main.__Enemies.Client
        local bridgeNetEvent = game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent

        local function findNearestNPC()
            local nearestNPC = nil
            local nearestDistance = math.huge

            for _, npc in pairs(enemiesFolder:GetChildren()) do
                if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
                    local npcRootPart = npc.HumanoidRootPart
                    local distance = (humanoidRootPart.Position - npcRootPart.Position).Magnitude

                    if distance < nearestDistance then
                        nearestDistance = distance
                        nearestNPC = npc
                    end
                end
            end

            return nearestNPC
        end

        local function punchLoop(npcName)
            if not npcName then return end

            local args = {
                [1] = {
                    [1] = {
                        ["Event"] = "PunchAttack",
                        ["Enemy"] = npcName
                    },
                    [2] = "\4"
                }
            }

            if bridgeNetEvent then
                bridgeNetEvent:FireServer(unpack(args))
            else
                warn("BridgeNet2 or dataRemoteEvent not found in ReplicatedStorage.")
            end
        end

        local function checkProximity()
            if not autoAttackEnabled then
                if punchLoopConnection then
                    punchLoopConnection:Disconnect()
                    punchLoopConnection = nil
                end
                return
            end

            local nearestNPC = findNearestNPC()

            if nearestNPC then
                if punchLoopConnection then
                    punchLoopConnection:Disconnect()
                end
                punchLoopConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    if autoAttackEnabled then
                        punchLoop(nearestNPC.Name)
                    else
                        punchLoopConnection:Disconnect()
                        punchLoopConnection = nil
                    end
                end)
            elseif punchLoopConnection then
                punchLoopConnection:Disconnect()
                punchLoopConnection = nil
            end
        end

        proximityConnection = game:GetService("RunService").Heartbeat:Connect(checkProximity)
    end,
})

Tabs.Main:AddInput("Input", {
    Title = "Enter Mob Name",
    Default = "",
    Placeholder = "Type Here",
    Callback = function(text)
        selectedMobName = text
        killedNPCs = {} -- Reset killed NPCs when changing mob
        print("Selected Mob:", selectedMobName) -- Debugging
    end
})

Tabs.Main:AddToggle("FarmSelectedMob", {
    Title = "Farm Selected Mob",
    Default = false,
    Callback = function(state)
        teleportEnabled = state
        damageEnabled = state -- Ensures damage mobs is active
        killedNPCs = {} -- Reset killed NPCs when enabling farm
        if state then
            task.spawn(teleportToSelectedEnemy)
        end
    end
})

Tabs.Main:AddToggle("TeleportMobs", {
    Title = "Auto farm (nearest NPCs)",
    Default = false,
    Callback = function(state)
        teleportEnabled = state
        if state then
            task.spawn(teleportAndTrackDeath)
        end
    end
})

local Dropdown = Tabs.Main:AddDropdown("MovementMethod", {
    Title = "Farming Method",
    Values = {"Tween", "Teleport"},
    Multi = false,
    Default = 1, -- Default to "Tween"
    Callback = function(option)
        movementMethod = option
    end
})


-- Daftar lokasi spawn
local spawnLocations = {
    "Brum Island",
    "Grass Village",
    "Solo City",
    "Faceheal Town",
    "Lucky Island"
}

-- Pemetaan nama lokasi ke kode spawn
local spawnData = {
    ["Brum Island"] = "OPWorld",
    ["Grass Village"] = "NarutoWorld",
    ["Solo City"] = "SoloWorld",
    ["Faceheal Town"] = "BleachWorld",
    ["Lucky Island"] = "BCWorld"
}

-- Variabel untuk menyimpan lokasi yang dipilih
local selectedSpawn = nil

-- Fungsi untuk Set Spawn & Reset
local function SetSpawnAndReset(spawnName)
    local args = {
        [1] = {
            [1] = {
                ["Event"] = "ChangeSpawn",
                ["Spawn"] = spawnName
            },
            [2] = "\n"
        }
    }

    local remote = game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
    remote:FireServer(unpack(args))

    -- Tunggu sebentar untuk memastikan spawn telah diset
    task.wait(0.5)

    -- Reset karakter
    local player = game.Players.LocalPlayer
    if player.Character and player.Character.Parent then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0 -- Memicu kematian alami tanpa menghapus karakter secara tiba-tiba
        end
    end
end

-- Membuat Dropdown untuk memilih lokasi spawn
local spawnDropdown = Tabs.tp:AddDropdown("SpawnDropdown", {
    Title = "Select Spawn Location",
    Values = spawnLocations,
    Multi = false,
    Default = nil,
    Callback = function(selected)
        selectedSpawn = spawnData[selected] -- Simpan lokasi spawn yang dipilih
        print("Selected Spawn Location:", selected)
    end
})

-- Membuat tombol untuk Set Spawn & Reset setelah memilih lokasi
Tabs.tp:AddButton({
    Title = "Set Spawn & Reset",
    Callback = function()
        if selectedSpawn then
            SetSpawnAndReset(selectedSpawn)
        else
            warn("Please select a spawn location first!")
        end
    end
})






-- Get Player and HumanoidRootPart
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- Update HRP when character respawns
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    hrp = newCharacter:WaitForChild("HumanoidRootPart") -- Get the new HRP after respawn
end)

-- Fungsi untuk teleportasi dengan Tween (lebih lambat agar aman dari anti-cheat)
local function teleportWithTween(targetCFrame)
    if hrp then
        local tweenInfo = TweenInfo.new(
            4, -- Durasi lebih lama (4 detik) agar tidak terdeteksi anti-cheat
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )

        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
    end
end

-- Variabel untuk menyimpan lokasi yang dipilih
local selectedLocation = nil

-- Daftar lokasi yang tersedia
local locations = {
    "Location 1", "Location 2", "Location 3", "Location 4",
    "Location 5", "Location 6", "Location 7"
}

-- Pemetaan nama lokasi ke CFrame
local locationData = {
    ["Location 1"] = CFrame.new(-6161.25781, 140.639832, 5512.9668),
    ["Location 2"] = CFrame.new(-5868.44141, 132.70488, 362.519379),
    ["Location 3"] = CFrame.new(-5430.81006, 107.441559, -5502.25244),
    ["Location 4"] = CFrame.new(-702.243225, 133.344467, -3538.11646),
    ["Location 5"] = CFrame.new(450.001709, 117.564827, 3435.4292),
    ["Location 6"] = CFrame.new(3230.96826, 135.41008, 36.1600113),
    ["Location 7"] = CFrame.new(4325.36523, 118.995422, -4819.78857)
}

-- Membuat Dropdown untuk memilih lokasi
local locationDropdown = Tabs.mount:AddDropdown("LocationDropdown", {
    Title = "Select Location",
    Values = locations,
    Multi = false,
    Default = nil,
    Callback = function(selected)
        selectedLocation = locationData[selected] -- Simpan lokasi yang dipilih
        print("Selected Location:", selected)
    end
})

-- Membuat tombol untuk teleportasi setelah memilih lokasi
Tabs.mount:AddButton({
    Title = "Teleport",
    Callback = function()
        if selectedLocation then
            teleportWithTween(selectedLocation)
        else
            warn("Please select a location first!")
        end
    end
})

local autoDestroy = false
local autoArise = false

-- Function to Fire DestroyPrompt


local enemiesFolder = workspace:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client")


local function fireDestroy()
    while autoDestroy do
        task.wait(0.3)  -- Delay to prevent overloading

        for _, enemy in ipairs(enemiesFolder:GetChildren()) do
            if enemy:IsA("Model") then
                local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                local DestroyPrompt = rootPart and rootPart:FindFirstChild("DestroyPrompt")

                if DestroyPrompt then
                    DestroyPrompt:SetAttribute("MaxActivationDistance", 100000)
                    fireproximityprompt(DestroyPrompt)
                end
            end
        end
    end
end



-- Function to Fire ArisePrompt

local enemiesFolder = workspace:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client")


local function fireArise()
    while autoArise do
        task.wait(0.3)  -- Delay to prevent overloading

        for _, enemy in ipairs(enemiesFolder:GetChildren()) do
            if enemy:IsA("Model") then
                local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                local arisePrompt = rootPart and rootPart:FindFirstChild("ArisePrompt")

                if arisePrompt then
                    arisePrompt:SetAttribute("MaxActivationDistance", 100000)
                    fireproximityprompt(arisePrompt)
                end
            end
        end
    end
end





-- Auto Destroy Toggle
Tabs.Main:AddToggle("AutoDestroy", {
    Title = "Auto Destroy",
    Default = false,
    Callback = function(state)
        autoDestroy = state
        if state then
            task.spawn(fireDestroy)
        end
    end
})

-- Auto Arise Toggle
Tabs.Main:AddToggle("AutoArise", {
    Title = "Auto Arise",
    Default = false,
    Callback = function(state)
        autoArise = state
        if state then
            task.spawn(fireArise)
        end
    end
})

Tabs.dungeon:AddToggle("AutoDestroy", {
    Title = "Auto Destroy",
    Default = false,
    Callback = function(state)
        autoDestroy = state
        if state then
            task.spawn(fireDestroy)
        end
    end
})

-- Auto Arise Toggle
Tabs.dungeon:AddToggle("AutoArise", {
    Title = "Auto Arise",
    Default = false,
    Callback = function(state)
        autoArise = state
        if state then
            task.spawn(fireArise)
        end
    end
})


local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart") -- Get HumanoidRootPart

local dungeonFolder = Workspace:WaitForChild("__Main"):WaitForChild("__Dungeon")

-- Variable to control teleporting
local teleportingEnabled = false

-- Function to create a dungeon
local function createDungeon()
    print("[DEBUG] Attempting to create dungeon...")
    local args = {
        [1] = {
            [1] = {
                ["Event"] = "DungeonAction",
                ["Action"] = "Create"
            },
            [2] = "\n" 
        }
    }
    ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
    print("[DEBUG] Create Dungeon event fired!")
end

-- Function to start the dungeon
local function startDungeon()
    local dungeonInstance = dungeonFolder:FindFirstChild("Dungeon")
    if dungeonInstance then
        local dungeonID = dungeonInstance:GetAttribute("ID")
        if dungeonID then
            print("[DEBUG] Starting dungeon with ID:", dungeonID)
            local args = {
                [1] = {
                    [1] = {
                        ["Dungeon"] = dungeonID,
                        ["Event"] = "DungeonAction",
                        ["Action"] = "Start"
                    },
                    [2] = "\n"
                }
            }
            ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
            print("[DEBUG] Start Dungeon event fired!")
        else
            print("[ERROR] Dungeon ID is missing!")
        end
    else
        print("[ERROR] Dungeon instance not found!")
    end
end

-- Function to teleport directly to an object and bypass anti-cheat
local function teleportToObject(object)
    if object and object:IsA("Part") then
        print("[DEBUG] Teleporting to:", object.Name)

        -- Anti-cheat bypass
        local f = player.Character and player.Character:FindFirstChild("CharacterScripts") and player.Character.CharacterScripts:FindFirstChild("FlyingFixer")
        if f then f:Destroy() else print("blablabla bleble") end

        local cha = player.Character and player.Character:FindFirstChild("CharacterScripts") and player.Character.CharacterScripts:FindFirstChild("CharacterUpdater")
        if cha then cha:Destroy() print("discord") else print("Cid") end

        -- Direct teleport
        hrp.CFrame = object.CFrame
        print("[DEBUG] Teleport completed to:", object.Name)

        task.wait(2) -- Small delay after teleportation
        createDungeon() -- Fire the create dungeon remote

        task.wait(1) -- Short delay before starting dungeon
        startDungeon() -- Fire the start dungeon remote
    else
        print("[ERROR] Invalid teleport target!")
    end
end

-- Function to continuously teleport to objects when enabled
local function teleportLoop()
    while teleportingEnabled do
        print("[DEBUG] Searching for dungeon objects...")
        local foundObject = false
        for _, object in ipairs(dungeonFolder:GetChildren()) do
            if object:IsA("Part") then
                foundObject = true
                teleportToObject(object)
                task.wait(1) -- Prevent excessive execution
            end
        end
        if not foundObject then
            print("[WARNING] No valid dungeon objects found!")
        end
        task.wait(0.5) -- Delay before checking again
    end
end
Tabs.dungeon:AddToggle("TeleportToDungeon", {
    Title = "Teleport to Dungeon",
    Default = false,
    Callback = function(state)
        teleportingEnabled = state
        print("[DEBUG] Teleporting toggled:", state)
        if state then
            task.spawn(teleportLoop) 
        end
    end
})
local AutoDetectToggle = Tabs.dungeon:AddToggle("AutoDetectDungeon", {Title = "Auto Detect Dungeon (KEEP THIS ON)", Default = true})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local villageSpawns = {
    ["Grass Village"] = "NarutoWorld",
    ["BRUM ISLAND"] = "OPWorld",
    ["Leveling City"] = "SoloWorld",
    ["FACEHEAL TOWN"] = "BleachWorld",
    ["Lucky"] = "BCWorld"
}

local function SetSpawnAndReset(spawnName)
    local args = {
        [1] = {
            [1] = {
                ["Event"] = "ChangeSpawn",
                ["Spawn"] = spawnName
            },
            [2] = "\n"
        }
    }

    local remote = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
    remote:FireServer(unpack(args))

    -- Wait a moment before resetting (optional, to ensure spawn is set)
    task.wait(0.5)

    -- Reset Character
    if player.Character then
        player.Character:BreakJoints() -- This forces the character to respawn
    end
end

local function detectDungeon()
    player.PlayerGui.Warn.ChildAdded:Connect(function(dungeon)
        if dungeon:IsA("Frame") and AutoDetectToggle.Value then
            print("Dungeon detected!")
            for _, child in ipairs(dungeon:GetChildren()) do
                if child:IsA("TextLabel") then
                    for village, spawnName in pairs(villageSpawns) do
                        if string.find(string.lower(child.Text), string.lower(village)) then
                            teleportEnabled = false
                            print("Detected village:", village)
                            SetSpawnAndReset(spawnName)
                            return
                        end
                    end
                end
            end
        end
    end)
end

-- Ensure function runs
AutoDetectToggle:OnChanged(function(value)
    if value then
        detectDungeon()
    end
end)

detectDungeon()

local function resetAutoFarm()
    -- Reset all toggle states and functions
    killedNPCs = {} -- Reset NPC kills

    print("AutoFarm has been reset!") -- Print message for confirmation

    -- Restart all functions if needed
end

task.spawn(function()
    while true do
        task.wait(120) -- Wait for 10 seconds
        resetAutoFarm() -- Call the reset function
    end
end)

local rankMapping = { "E", "D", "C", "B", "A", "S", "SS" }

-- Dropdown for choosing which ranks to sell
local SellDropdown = Tabs.pets:AddDropdown("ChooseRankToSell", {
    Title = "Choose Rank to Sell",
    Values = rankMapping,
    Multi = true,
    Default = {}
})

-- Dropdown for choosing pets to keep
local KeepPetsDropdown = Tabs.pets:AddDropdown("ChoosePetsToKeep", {
    Title = "Pets to Not Delete",
    Values = {},
    Multi = true,
    Default = {}
})

-- Button to refresh the "Keep Pets" dropdown
Tabs.pets:AddButton({
    Title = "Refresh Keep Pets List",
    Callback = function()
        updateKeepPetsDropdown()
    end
})

-- Function to get pets by selected rank
local function getPetsByRank(selectedRanks, keepPets)
    local player = game:GetService("Players").LocalPlayer
    local petsFolder = player.leaderstats.Inventory:FindFirstChild("Pets")
    if not petsFolder then return {} end

    local petsByRank = {}  -- Store pets by rank
    local petsToSell = {}  -- Pets that will be sold
    local keepOnePet = {}  -- Ensure only 1 pet of each chosen type is kept

    for _, pet in ipairs(petsFolder:GetChildren()) do
        local rankValue = pet:GetAttribute("Rank")
        local petName = pet.Name

        if rankValue and rankMapping[rankValue] and selectedRanks[rankMapping[rankValue]] then
            petsByRank[rankMapping[rankValue]] = petsByRank[rankMapping[rankValue]] or {}
            table.insert(petsByRank[rankMapping[rankValue]], petName)
        end
    end

    -- Process each rank
    for rank, petList in pairs(petsByRank) do
        table.sort(petList) -- Sort pets for consistency

        local keptOne = false
        for _, pet in ipairs(petList) do
            if keepPets[pet] then
                if not keepOnePet[pet] then
                    keepOnePet[pet] = true -- Keep only 1 copy of this pet
                    keptOne = true
                else
                    table.insert(petsToSell, pet) -- Sell extra copies
                end
            elseif not keptOne then
                keptOne = true -- Ensure at least 1 pet per rank is kept
            else
                table.insert(petsToSell, pet) -- Sell remaining pets
            end
        end
    end

    return petsToSell
end

-- Function to sell pets
local function sellPets()
    local selectedRanks = SellDropdown.Value
    local keepPets = KeepPetsDropdown.Value
    local pets = getPetsByRank(selectedRanks, keepPets)

    if #pets > 0 then
        local args = {
            [1] = {
                [1] = {
                    ["Event"] = "SellPet",
                    ["Pets"] = pets
                },
                [2] = "\t"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
    end
end

-- Function to update the "Keep Pets" dropdown
function updateKeepPetsDropdown()
    local player = game:GetService("Players").LocalPlayer
    local petsFolder = player.leaderstats.Inventory:FindFirstChild("Pets")
    if not petsFolder then return end

    local petNames = {} -- Array for dropdown

    for _, pet in ipairs(petsFolder:GetChildren()) do
        if not table.find(petNames, pet.Name) then
            table.insert(petNames, pet.Name) -- Add pet names only once
        end
    end

    KeepPetsDropdown:SetValues(petNames) -- Update dropdown with pet names
end

-- Start the selling loop
local function startSellingLoop()
    while true do
        sellPets()
        wait(1) -- Prevent spamming
    end
end

-- Run the loop in a separate thread
spawn(startSellingLoop)

-- Initialize pet dropdown on start
updateKeepPetsDropdown()

-- Refresh pet list when dropdown changes
SellDropdown:OnChanged(updateKeepPetsDropdown)
KeepPetsDropdown:OnChanged(updateKeepPetsDropdown)

local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = game:GetService("Players").LocalPlayer

local antiAfkConnection

local AntiAfkToggle = Tabs.Player:AddToggle("AntiAfk", {
    Title = "Anti AFK",
    Default = true,
    Callback = function(enabled)
        if enabled then
            print("Anti AFK Enabled")
            -- Ensure we don't create multiple connections
            if not antiAfkConnection then
                antiAfkConnection = LocalPlayer.Idled:Connect(function()
                    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    task.wait(1) -- Adjustable wait time
                    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                end)
            end
        else
            print("Anti AFK Disabled")
            -- Disconnect the event when disabling
            if antiAfkConnection then
                antiAfkConnection:Disconnect()
                antiAfkConnection = nil -- Reset the connection variable
            end
        end
    end
})



local function getUniqueWeaponNames()
    local weapons = {}
    local seenNames = {} -- To track unique names

    local playerWeapons = game:GetService("Players").LocalPlayer.leaderstats.Inventory.Weapons:GetChildren()
    print("Fetching weapons...") -- DEBUG

    for _, weapon in ipairs(playerWeapons) do
        local weaponName = weapon:GetAttribute("Name") -- Get "Name" attribute
        if weaponName then
            print("Found Weapon:", weaponName) -- DEBUG
            if not seenNames[weaponName] then
                table.insert(weapons, weaponName)
                seenNames[weaponName] = true -- Mark name as seen
            end
        end
    end
    return weapons
end

-- Populate dropdown with **unique** weapon names
local weaponNames = getUniqueWeaponNames()
local WeaponDropdown = Tabs.misc:AddDropdown("WeaponDropdown", {
    Title = "Select Weapon to Upgrade",
    Description = "Choose a weapon to upgrade",
    Values = weaponNames,
    Multi = false, -- Single selection
    Default = ""
})

-- Dropdown for selecting upgrade level (2-6)
local LevelDropdown = Tabs.misc:AddDropdown("LevelDropdown", {
    Title = "Select Upgrade Level",
    Description = "Choose the level for upgrade",
    Values = {"2", "3", "4", "5", "6", "7"},
    Multi = false,
    Default = "2"
})

-- Toggle for Auto Upgrade Weapon
 local AutoUpgradeToggle = Tabs.misc:AddToggle("AutoUpgradeToggle", { Title = "Auto Upgrade Weapon", Default = false })

local function AutoUpgradeWeapon()
    while AutoUpgradeToggle.Value do
        local selectedWeapon = WeaponDropdown.Value
        local selectedLevel = tonumber(LevelDropdown.Value) or 2

        if selectedWeapon and selectedWeapon ~= "" then
            local args = {
                [1] = {
                    [1] = {
                        ["Type"] = selectedWeapon,
                        ["BuyType"] = "Gems",
                        ["Weapons"] = {},
                        ["Event"] = "UpgradeWeapon",
                        ["Level"] = selectedLevel
                    },
                    [2] = "\n"
                }
            }

            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
            task.wait(0.1) -- Adjust delay if needed
        else
            Fluent:Notify({
                Title = "Error",
                Content = "Please select a weapon before upgrading.",
                Duration = 5
            })
            print("ERROR: No weapon selected!") -- DEBUG
            break
        end
    end
end

AutoUpgradeToggle:OnChanged(function(Value)
    if Value then
        task.spawn(AutoUpgradeWeapon) -- Start upgrading in a separate thread
    end
end)

 local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local AppearFolder = workspace:FindFirstChild("__Extra") and workspace.__Extra:FindFirstChild("__Appear")

local locations = {
    {Name = "Location 1", CFrame = CFrame.new(-6161.25781, 140.639832, 5512.9668)},
    {Name = "Location 2", CFrame = CFrame.new(-5868.44141, 132.70488, 362.519379)},
    {Name = "Location 3", CFrame = CFrame.new(-5430.81006, 107.441559, -5502.25244)},
    {Name = "Location 4", CFrame = CFrame.new(-702.243225, 133.344467, -3538.11646)},
    {Name = "Location 5", CFrame = CFrame.new(450.001709, 117.564827, 3435.4292)},
    {Name = "Location 6", CFrame = CFrame.new(3230.96826, 135.41008, 36.1600113)},
    {Name = "Location 7", CFrame = CFrame.new(4325.36523, 118.995422, -4819.78857)}
}

local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)

if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end

function TPReturner()
    local Site
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0
    for _, v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _, Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, Players.LocalPlayer)
                end)
                wait(4)
                break -- Exit the loop after finding a suitable server to teleport to
            end
        end
    end
end

local function hasSpawned()
    return AppearFolder and #AppearFolder:GetChildren() > 0
end

local function tweenTeleport(targetCFrame)
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    local HRP = Character.HumanoidRootPart
    local Tween = TweenService:Create(HRP, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = targetCFrame})
    Tween:Play()
    Tween.Completed:Wait()
end
local function fireProximityPrompts()
    if not AppearFolder then return end
    for _, mount in ipairs(AppearFolder:GetChildren()) do
        for _, descendant in ipairs(mount:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                fireproximityprompt(descendant)
            end
        end
    end
end

local DelayToggle = false

local function checkMountsAndTeleport()
    local inventoryMounts = {}
    for _, mount in ipairs(LocalPlayer.leaderstats.Inventory.Mounts:GetChildren()) do
        table.insert(inventoryMounts, mount.Name:sub(1, 4))
    end

    for _, mount in ipairs(AppearFolder:GetChildren()) do
        local mountId = mount.Name:sub(1, 4)
        for _, invMount in ipairs(inventoryMounts) do
            if mountId == invMount then
                Fluent:Notify({
                    Title = "Mount Detected!",
                    Content = "Matching mount found! Server hopping...",
                    Duration = 5
                })
                TPReturner()
                return
            end
        end
    end
  for _, mount in ipairs(AppearFolder:GetChildren()) do
        local targetPosition = mount:GetPivot()
        tweenTeleport(targetPosition)

        if DelayToggle then
            task.wait(15)  -- Waits 15 seconds ONLY if toggle is enabled
        end

        fireProximityPrompts()
    end
end

local function teleportSequence()
    for _, loc in ipairs(locations) do
        tweenTeleport(loc.CFrame)
        task.wait(3)

        if hasSpawned() then
            checkMountsAndTeleport()
            Fluent:Notify({
                Title = "Mount Collected!",
                Content = "Server hopping...",
                Duration = 5
            })
            TPReturner()
            return
        end
    end
    TPReturner()
end




local TeleportToggle = Tabs.mount:AddToggle("AutoTeleport", {Title = "Auto Find Mount (serverHop)", Default = false })

TeleportToggle:OnChanged(function(enabled)
    if enabled then
        teleportSequence()
    end
end)

local DelayToggleOption = Tabs.mount:AddToggle("DelayBeforeFire", {Title = "Wait 15s ENABLE THIS IF U GET KICKED", Default = false })

DelayToggleOption:OnChanged(function(enabled)
    DelayToggle = enabled
end)



local function getUniquePetNames()
    local pets = {}
    local seenNames = {} -- To track unique names

    local playerPets = game:GetService("Players").LocalPlayer.leaderstats.Inventory.Pets:GetChildren()
    print("Fetching pets...") -- DEBUG

    for _, pet in ipairs(playerPets) do
        local petName = pet:GetAttribute("Name") -- Get "Name" attribute
        if petName then
            print("Found Pet:", petName) -- DEBUG
            if not seenNames[petName] then
                table.insert(pets, petName)
                seenNames[petName] = true -- Mark name as seen
            end
        end
    end
    return pets
end

-- Populate dropdown with **unique** pet names







local autoEquipEnabled = false

local function EquipBestPets()
    local player = game:GetService("Players").LocalPlayer
    local petsFolder = player.leaderstats.Inventory.Pets
    local maxEquip = player.leaderstats.Values:GetAttribute("MaxEquipPets") or 1
    local bestPets = {}

    local petsList = {}
    for _, pet in ipairs(petsFolder:GetChildren()) do
        local rank = pet:GetAttribute("Rank")
        if rank and typeof(rank) == "number" then
            table.insert(petsList, {name = pet.Name, rank = rank})
        end
    end

    table.sort(petsList, function(a, b) return a.rank > b.rank end)

    local equipCount = 0
    for _, petData in ipairs(petsList) do
        if equipCount < maxEquip then
            table.insert(bestPets, petData.name)
            equipCount = equipCount + 1
        else
            break
        end
    end

    if #bestPets > 0 then
        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer({
            {["Event"] = "EquipBest", ["Pets"] = bestPets},
            "\n"
        })
    end
end


local Toggle = Tabs.pets:AddToggle("AutoEquip", { Title = "Auto Equip Best Pets", Default = false })

Toggle:OnChanged(function(state)
    autoEquipEnabled = state
    if state then
        Fluent:Notify({ Title = "Auto Equip", Content = "Enabled. Equipping every 2 minutes.", Duration = 5 })
        task.spawn(function()
            while autoEquipEnabled do
                EquipBestPets()
                wait(120)
            end
        end)
    else
        Fluent:Notify({ Title = "Auto Equip", Content = "Disabled.", Duration = 5 })
    end
end)

Tabs.Player:AddButton({
    Title = "Boost FPS",
    Description = "Lowers graphics",
    Callback = function()
        local Optimizer = {Enabled = false}

        local function DisableEffects()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                    v.Enabled = not Optimizer.Enabled
                end
                if v:IsA("PostEffect") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") then
                    v.Enabled = not Optimizer.Enabled
                end
            end
        end

        local function MaximizePerformance()
            local lighting = game:GetService("Lighting")
            if Optimizer.Enabled then
                lighting.GlobalShadows = false
                lighting.FogEnd = 9e9
                lighting.Brightness = 2
                settings().Rendering.QualityLevel = 1
                settings().Physics.PhysicsEnvironmentalThrottle = 1
                settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
                settings().Physics.AllowSleep = true
                settings().Physics.ForceCSGv2 = false
                settings().Physics.DisableCSGv2 = true
                settings().Rendering.EagerBulkExecution = true

                game:GetService("StarterGui"):SetCore("TopbarEnabled", false)

                settings().Network.IncomingReplicationLag = 0
                settings().Rendering.MaxPartCount = 100000
            else
                lighting.GlobalShadows = true
                lighting.FogEnd = 100000
                lighting.Brightness = 3
                settings().Rendering.QualityLevel = 7
                settings().Physics.PhysicsEnvironmentalThrottle = 0
                settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
                settings().Physics.AllowSleep = false
                settings().Physics.ForceCSGv2 = true
                settings().Physics.DisableCSGv2 = false
                settings().Rendering.EagerBulkExecution = false

                game:GetService("StarterGui"):SetCore("TopbarEnabled", true)

                settings().Network.IncomingReplicationLag = 1
                settings().Rendering.MaxPartCount = 500000
            end
        end

        local function OptimizeInstances()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CastShadow = not Optimizer.Enabled
                    v.Reflectance = Optimizer.Enabled and 0 or v.Reflectance
                    v.Material = Optimizer.Enabled and Enum.Material.SmoothPlastic or v.Material
                end
                if v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = Optimizer.Enabled and 1 or 0
                end
                if v:IsA("MeshPart") then
                    v.RenderFidelity = Optimizer.Enabled and Enum.RenderFidelity.Performance or Enum.RenderFidelity.Precise
                end
            end

            game:GetService("Debris"):SetAutoCleanupEnabled(true)
        end

        local function CleanMemory()
            if Optimizer.Enabled then
                game:GetService("Debris"):AddItem(Instance.new("Model"), 0)
                settings().Physics.ThrottleAdjustTime = 2
                game:GetService("RunService"):Set3dRenderingEnabled(false)
            else
                game:GetService("RunService"):Set3dRenderingEnabled(true)
            end
        end

        local function ToggleOptimizer()
            Optimizer.Enabled = not Optimizer.Enabled
            DisableEffects()
            MaximizePerformance()
            OptimizeInstances()
            CleanMemory()
            print("FPS Booster: " .. (Optimizer.Enabled and "ON" or "OFF"))
        end

        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.RightControl then
                ToggleOptimizer()
            end
        end)

        ToggleOptimizer()

        game:GetService("RunService").Heartbeat:Connect(function()
            if Optimizer.Enabled then
                CleanMemory()
            end
        end)
    end
})



local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local targetCFrame = CFrame.new(
    3648.76318, 223.552261, 2637.36719, 
    0.846323907, 7.72367986e-18, -0.532668591, 
    -1.10462046e-17, 1, -3.05065368e-18, 
    0.532668591, 8.46580728e-18, 0.846323907
)

local function tweenToPivot()
    hrp.CFrame = targetCFrame
end


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local speedValue = 16 -- Default WalkSpeed
local jumpValue = 50  -- Default JumpPower
local speedEnabled = false
local jumpEnabled = false

local function updateCharacter()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        humanoid.WalkSpeed = speedEnabled and speedValue or 16
        humanoid.JumpPower = jumpEnabled and jumpValue or 50
    end
end

-- Speed Input
local SpeedInput = Tabs.Player:AddInput("SpeedInput", {
    Title = "Speed",
    Default = tostring(speedValue),
    Placeholder = "Enter speed",
    Numeric = true,
    Finished = true, 
    Callback = function(Value)
        speedValue = tonumber(Value) or 16
        updateCharacter() -- Update character immediately when speed is changed
    end
})

-- Jump Power Input
local JumpInput = Tabs.Player:AddInput("JumpInput", {
    Title = "Jump Power",
    Default = tostring(jumpValue),
    Placeholder = "Enter jump power",
    Numeric = true,
    Finished = true, 
    Callback = function(Value)
        jumpValue = tonumber(Value) or 50
        updateCharacter() -- Update character immediately when jump power is changed
    end
})

-- Speed Toggle
local SpeedToggle = Tabs.Player:AddToggle("SpeedToggle", {
    Title = "Enable Speed",
    Default = false
})

SpeedToggle:OnChanged(function(Value)
    speedEnabled = Value
    updateCharacter() -- Update character immediately when toggle is changed
end)

-- Jump Power Toggle
local JumpToggle = Tabs.Player:AddToggle("JumpToggle", {
    Title = "Enable Jump Power",
    Default = false
})

JumpToggle:OnChanged(function(Value)
    jumpEnabled = Value
    updateCharacter() -- Update character immediately when toggle is changed
end)

-- Update character on respawn
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1) -- Wait for the character to fully load
    updateCharacter()
end)

-- Initial update
updateCharacter()

local player = game.Players.LocalPlayer

local function tweenCharacter(targetCFrame)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = tweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
    end
end

-- Add button
Tabs.tp:AddButton({
    Title = "Tween to Dedu island",
    Description = "Smoothly moves your character",
    Callback = function()
        tweenCharacter(CFrame.new(3859.06299, 60.1228409, 3081.9458, -0.987112403, 6.46206388e-07, -0.160028473, 5.63319077e-07, 1, 5.63319418e-07, 0.160028473, 4.65912507e-07, -0.987112403)) -- Change this to your desired position
    end
})



local NoClipToggle = Tabs.Player:AddToggle("NoClipToggle", {
    Title = "Enable NoClip",
    Default = false
})

-- NoClip function
local noclipEnabled = false
NoClipToggle:OnChanged(function(Value)
    noclipEnabled = Value
    if noclipEnabled then
        task.spawn(function()
            while noclipEnabled do
                for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                task.wait()
            end
        end)
    else
        for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)



Tabs.Player:AddButton({
    Title = "Server Hop",
    Description = "Switches to a different server",
    Callback = function()
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        local File = pcall(function()
            AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
        end)
        if not File then
            table.insert(AllIDs, actualHour)
            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
        end
        local function TPReturner()
            local Site
            if foundAnything == "" then
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
            end
            for _, v in pairs(Site.data) do
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    local ID = tostring(v.id)
                    local isNewServer = true
                    for _, existing in pairs(AllIDs) do
                        if ID == tostring(existing) then
                            isNewServer = false
                            break
                        end
                    end
                    if isNewServer then
                        table.insert(AllIDs, ID)
                        writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                        return
                    end
                end
            end
        end
        TPReturner()
    end
})



    

        
Tabs.dungeon:AddToggle("AutoBuyDungeonTicket", {
    Title = "Auto Buy Dungeon Ticket",
    Default = false,
    Callback = function(state)
        buyTicketEnabled = state
        print("[DEBUG] Auto Buy Dungeon Ticket toggled:", state)
        
        if state then
            task.spawn(function()
                while buyTicketEnabled do
                    local args = {
                        [1] = {
                            [1] = {
                                ["Type"] = "Gems",
                                ["Event"] = "DungeonAction",
                                ["Action"] = "BuyTicket"
                            },
                            [2] = "\n"
                        }
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                    task.wait(5) -- Wait 5 seconds before firing again
                end
            end)
        end
    end
})



    local localPlayer = game:GetService("Players").LocalPlayer
local playerCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local playerHRP = playerCharacter:WaitForChild("HumanoidRootPart")
local enemyContainer = workspace:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client")
local networkEvent = game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")

local autoFarmActive = false
local defeatedEnemies = {}

local function isTargetDefeated(target)
    local healthUI = target:FindFirstChild("HealthBar")
    if healthUI and healthUI:FindFirstChild("Main") and healthUI.Main:FindFirstChild("Bar") then
        local healthText = healthUI.Main.Bar:FindFirstChild("Amount")
        if healthText and healthText:IsA("TextLabel") and healthText.ContentText == "0 HP" then
            return true
        end
    end
    return false
end

local function findClosestTarget()
    local closestJJ2, closestJJ3, closestJJ4 = nil, nil, nil
    local distJJ2, distJJ3, distJJ4 = math.huge, math.huge, math.huge
    local playerPos = localPlayer.Character and localPlayer.Character:GetPivot().Position

    if not playerPos then return nil end

    for _, enemy in ipairs(enemyContainer:GetChildren()) do
        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
            local enemyType = enemy:GetAttribute("ID")
            
            -- Ensure the script ignores dead enemies
            if not defeatedEnemies[enemy.Name] then
                local distance = (playerPos - enemy:GetPivot().Position).Magnitude
                
                if enemyType == "JJ2" and distance < distJJ2 then
                    distJJ2 = distance
                    closestJJ2 = enemy
                elseif enemyType == "JJ3" and distance < distJJ3 then
                    distJJ3 = distance
                    closestJJ3 = enemy
                elseif enemyType == "JJ4" and distance < distJJ4 then
                    distJJ4 = distance
                    closestJJ4 = enemy
                end
            end
        end
    end

    -- Priority: JJ2 > JJ3 > JJ4
    return closestJJ2 or closestJJ3 or closestJJ4
end

local function triggerPetVisibility()
    local arguments = {
        [1] = {
            [1] = {
                ["Event"] = "ShowPets"
            },
            [2] = "\t"
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(arguments))
end

local function startAutoFarm()
    while autoFarmActive do
        local targetEnemy = findClosestTarget()
        
        while autoFarmActive and targetEnemy do
            if not targetEnemy.Parent then break end

            local targetHRP = targetEnemy:FindFirstChild("HumanoidRootPart")
            local playerHRP = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

            if targetHRP and playerHRP then
                -- Move to target enemy
                playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 6)

                task.wait(0.5)
                triggerPetVisibility()

                networkEvent:FireServer({
                    {
                        ["PetPos"] = {},
                        ["AttackType"] = "All",
                        ["Event"] = "Attack",
                        ["Enemy"] = targetEnemy.Name
                    },
                    "\7"
                })

                -- Wait until enemy is defeated or a higher-priority one appears
                while autoFarmActive and targetEnemy.Parent do
                    if isTargetDefeated(targetEnemy) then
                        defeatedEnemies[targetEnemy.Name] = true -- Mark it as dead immediately
                        break
                    end
                    
                    task.wait(0.1)
                    
                    -- Switch if a higher-priority target appears
                    local newTarget = findClosestTarget()
                    if newTarget and newTarget:GetAttribute("ID") == "JJ2" and newTarget ~= targetEnemy then
                        break
                    elseif newTarget and newTarget:GetAttribute("ID") == "JJ3" and targetEnemy:GetAttribute("ID") == "JJ4" then
                        break
                    end
                end
            end

            targetEnemy = findClosestTarget() -- Move to next enemy
        end

        task.wait(0.20)
    end
end

Tabs.Main:AddToggle("AutoFarmToggle", {
    Title = "Auto Jeju Farm",
    Default = false,
    Callback = function(state)
        autoFarmActive = state
        if state then
            task.spawn(startAutoFarm)
        end
    end
})


local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Inventory = LocalPlayer:FindFirstChild("leaderstats") and LocalPlayer.leaderstats:FindFirstChild("Inventory")





local SelectedLevel = 1
local SellingEnabled = false

-- Dropdown for selecting the weapon level (moved to Misc tab)
local Dropdown = Tabs.misc:AddDropdown("WeaponLevel", {
    Title = "Select Weapon Level",
    Values = {"1", "2", "4", "5", "6", "7"},
    Multi = false,
    Default = "1",
})

Dropdown:OnChanged(function(Value)
    SelectedLevel = tonumber(Value)
end)

-- Toggle for auto-selling (moved to Misc tab)
local Toggle = Tabs.misc:AddToggle("AutoSell", { Title = "Auto-Sell Weapons", Default = false })

Toggle:OnChanged(function(Value)
    SellingEnabled = Value
end)

-- Function to sell weapons based on the selected level
local function SellWeapons()
    if not Inventory or not SellingEnabled then return end
    
    for _, weapon in ipairs(Inventory.Weapons:GetChildren()) do
        local level = weapon:GetAttribute("Level")
        if level == SelectedLevel then
            local args = {
                [1] = {
                    [1] = {
                        ["Action"] = "Sell",
                        ["Event"] = "WeaponAction",
                        ["Name"] = weapon.Name
                    },
                    [2] = "\n"
                }
            }
            ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
            
        end
    end
end

-- Loop to continuously check for weapons to sell
task.spawn(function()
    while task.wait(0.5) do
        if SellingEnabled then
            SellWeapons()
        end
    end
end)


local AutoEnterDungeon = Tabs.dungeon:AddToggle("AutoEnterDungeon", { Title = "Auto Enter Guild Dungeon", Default = false })

local function EnterDungeon()
    while AutoEnterDungeon.Value do
        local args = {
            [1] = {
                [1] = {
                    ["Event"] = "DungeonAction",
                    ["Action"] = "TestEnter"
                },
                [2] = "\n"
            }
        }

        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
        task.wait(0.5) -- Adjust delay if needed
    end
end

AutoEnterDungeon:OnChanged(function(Value)
    if Value then
        task.spawn(EnterDungeon) -- Start loop when enabled
    end
end)

Tabs.Discord:AddButton({
    Title = "Copy Discord link Ancestral",
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
Tabs.Discord:AddParagraph({
    Title = "CHANGELOGS 〢 Ancestral Arise-Crossover ",
    Content = [[
    Next Feature: 
    - Auto Send Pets

    ]]
})
local section = Tabs.Discord:AddSection("SkyHub")
Tabs.Discord:AddButton({
    Title = "Use this for best experience.",
    Description = "Keyless Script Arise-Crossover",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SKOIXLL/SKYLOLAND/refs/heads/main/Load.lua"))()
        
        -- Notifikasi setelah script dieksekusi
        Fluent:Notify({
            Title = "Ancestral",
            Content = "Skyhub Has been loaded!",
            Duration = 8
        })
    end
})    

Window:SelectTab(1)

Fluent:Notify({
    Title = "Ancestral",
    Content = "Script has been loaded!",
    Duration = 3
})


