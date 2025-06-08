-- JOIN FOR ALL SCRIPT LEAKS FOR ALL GAME ROBLOX FOR FREE https://discord.gg/eTVvgvRq4s
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Arise Crossover [BETA] by Naaellx",
    Icon = 0,
    LoadingTitle = "Ancestral",
    LoadingSubtitle = "by Naaellx",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Ancestral"
    },
    Discord = {
        Enabled = false,
        Invite = "https://discord.gg/eTVvgvRq4s",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Hello"}
    }
})

local MainTab = Window:CreateTab("Auto Farm", nil)
local IslandsTab = Window:CreateTab("Islands", nil)
local MainSection = MainTab:CreateSection("Main")

-- Auto Attack Button
local AutoAttackButton = MainTab:CreateButton({
    Name = "Auto Attack",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local enemiesFolder = workspace.__Main.__Enemies.Client
        local bridgeNetEvent = game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent

        local playerDetectionRadius = 10
        local petDetectionRadius = 10

        local function findNearestNPC(radius)
            local nearestNPC = nil
            local nearestDistance = math.huge

            for _, npc in pairs(enemiesFolder:GetChildren()) do
                if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
                    local npcRootPart = npc.HumanoidRootPart
                    local distance = (humanoidRootPart.Position - npcRootPart.Position).Magnitude

                    if distance < radius and distance < nearestDistance then
                        nearestDistance = distance
                        nearestNPC = npc
                    end
                end
            end

            return nearestNPC
        end

        local function getTopPets()
            local inventoryPets = player.leaderstats.Inventory.Pets
            local petList = {}

            for _, petFolder in ipairs(inventoryPets:GetChildren()) do
                if petFolder:IsA("Folder") then
                    local levelAttribute = petFolder:GetAttribute("Level")
                    if levelAttribute then
                        table.insert(petList, {
                            pet = petFolder.Name,
                            level = levelAttribute
                        })
                    end
                end
            end

            table.sort(petList, function(a, b)
                return a.level > b.level
            end)

            local topPets = {}
            for i = 1, math.min(4, #petList) do
                table.insert(topPets, petList[i].pet)
            end

            return topPets
        end

        local punchLoopConnection = nil
        local lastPetTarget = nil
        local lastPlayerTarget = nil

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

        local function attackPets(npcName)
            if not npcName then return end

            local topPets = getTopPets()
            local petPositions = {
                ["Dongsoo163c021"] = Vector3.new(563.4175415039062, 27.834564208984375, 171.351318359375),
                ["Dongsoo82df5bf"] = Vector3.new(558.7167358398438, 27.834562301635742, 173.65542602539062),
                ["Dongsoo9ce4ea7"] = Vector3.new(553.59765625, 27.83456039428711, 172.55935668945312),
                ["Dongsoo00de96a"] = Vector3.new(565.68701171875, 27.834566116333008, 166.63372802734375)
            }

            local petAttackArgs = {
                [1] = {
                    [1] = {
                        ["PetPos"] = {},
                        ["AttackType"] = "All",
                        ["Event"] = "Attack",
                        ["Enemy"] = npcName
                    },
                    [2] = "\7"
                }
            }

            for _, petName in ipairs(topPets) do
                if petPositions[petName] then
                    petAttackArgs[1][1]["PetPos"][petName] = petPositions[petName]
                end
            end

            if bridgeNetEvent then
                coroutine.wrap(function()
                    bridgeNetEvent:FireServer(unpack(petAttackArgs))
                end)()
            else
                warn("BridgeNet2 or dataRemoteEvent not found in ReplicatedStorage.")
            end
        end

        local function checkProximity()
            local nearestNPCForPlayer = findNearestNPC(playerDetectionRadius)
            local nearestNPCForPets = findNearestNPC(petDetectionRadius)

            if nearestNPCForPets and nearestNPCForPets.Name ~= lastPetTarget then
                print("Nearest NPC (Pets): " .. nearestNPCForPets.Name)
                attackPets(nearestNPCForPets.Name)
                lastPetTarget = nearestNPCForPets.Name
            end

            if nearestNPCForPlayer then
                if nearestNPCForPlayer.Name ~= lastPlayerTarget then
                    print("Nearest NPC (Player): " .. nearestNPCForPlayer.Name)
                    lastPlayerTarget = nearestNPCForPlayer.Name;
                end

                if punchLoopConnection then
                    punchLoopConnection:Disconnect()
                end
                punchLoopConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    punchLoop(nearestNPCForPlayer.Name)
                end)
            elseif punchLoopConnection then
                punchLoopConnection:Disconnect()
                punchLoopConnection = nil
                lastPlayerTarget = nil -- Reset target when out of range
            end
        end

        game:GetService("RunService").Heartbeat:Connect(checkProximity)
    end,
})

-- Script to be placed in a LocalScript inside StarterPlayerScripts
--Tween Speedd teleportation
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local locations = {
    CFrame.new(555.987366, 27.638092, 153.378983) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(615.902832, 38.4664612, -23.1269665) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(558.342346, 36.8911018, -20.6030388) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(623.534912, 27.6380959, 138.817123) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(493.286682, 30.9406681, 18.0997391) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012)
}

local currentTargetIndex = 1
local targetNPC = nil
local heartbeatConnection = nil -- Store the heartbeat connection

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then -- Check if NPC is close to the location
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkProximity()
    if targetNPC and targetNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        currentTargetIndex = currentTargetIndex + 1
        if currentTargetIndex > #locations then
            currentTargetIndex = 1
        end
        targetNPC = nil
    end

    if not targetNPC then
        targetNPC = findNPCAtLocation(locations[currentTargetIndex])
        if targetNPC then
            tweenCharacter(locations[currentTargetIndex])
            print("Tweening to location " .. currentTargetIndex)
        end
    end
end

local function startSoondoo()
    if humanoidRootPart then
        tweenCharacter(locations[currentTargetIndex])
        targetNPC = findNPCAtLocation(locations[currentTargetIndex])
        print("Initial tween to location 1.")
    else
        print("Character not found.")
    end

    heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkProximity)
end

local function stopSoondoo()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
        print("Soondoo movement stopped.")
    end
end

-- Script to be placed in a LocalScript inside StarterPlayerScripts

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local gonsheeLocations = {
    CFrame.new(409.754791, 28.7839146, 77.2221298) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(427.516449, 28.4950428, 10.139122) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(577.832947, 27.6630726, -161.732498) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(515.446899, 27.6630707, -146.634628) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(514.245667, 27.6630573, -68.8822021) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012)
}

local currentGonsheeTargetIndex = 1
local targetGonsheeNPC = nil
local gonsheeHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkGonsheeProximity()
    if targetGonsheeNPC and targetGonsheeNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        currentGonsheeTargetIndex = currentGonsheeTargetIndex + 1
        if currentGonsheeTargetIndex > #gonsheeLocations then
            currentGonsheeTargetIndex = 1
        end
        targetGonsheeNPC = nil
    end

    if not targetGonsheeNPC then
        targetGonsheeNPC = findNPCAtLocation(gonsheeLocations[currentGonsheeTargetIndex])
        if targetGonsheeNPC then
            tweenCharacter(gonsheeLocations[currentGonsheeTargetIndex])
            print("Gonshee Tweening to location " .. currentGonsheeTargetIndex)
        end
    end
end

local function startGonshee()
    if humanoidRootPart then
        tweenCharacter(gonsheeLocations[currentGonsheeTargetIndex])
        targetGonsheeNPC = findNPCAtLocation(gonsheeLocations[currentGonsheeTargetIndex])
        print("Gonshee Initial tween to location 1.")
    else
        print("Character not found.")
    end

    gonsheeHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkGonsheeProximity)
end

local function stopGonshee()
    if gonsheeHeartbeatConnection then
        gonsheeHeartbeatConnection:Disconnect()
        gonsheeHeartbeatConnection = nil
        print("Gonshee movement stopped.")
    end
end

-- Script to be placed in a LocalScript inside StarterPlayerScripts

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local daekLocations = {
    CFrame.new(42.0308075, 28.1683941, -31.478796) * CFrame.Angles(0, 0, -1),
    CFrame.new(115.410873, 28.1978397, 73.3190842) * CFrame.Angles(0, 0, -1),
    CFrame.new(-66.4298935, 28.1683941, -45.7393341) * CFrame.Angles(0, 0, -1),
    CFrame.new(-159.387054, 27.8509312, -101.384613) * CFrame.Angles(0, 0, -1),
    CFrame.new(-198.39209, 27.8509502, -209.924988) * CFrame.Angles(0, 0, -1)
}

local currentDaekTargetIndex = 1
local targetDaekNPC = nil
local daekHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkDaekProximity()
    if targetDaekNPC and targetDaekNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        currentDaekTargetIndex = currentDaekTargetIndex + 1
        if currentDaekTargetIndex > #daekLocations then
            currentDaekTargetIndex = 1
        end
        targetDaekNPC = nil
    end

    if not targetDaekNPC then
        targetDaekNPC = findNPCAtLocation(daekLocations[currentDaekTargetIndex])
        if targetDaekNPC then
            tweenCharacter(daekLocations[currentDaekTargetIndex])
            print("Daek Tweening to location " .. currentDaekTargetIndex)
        end
    end
end

local function startDaek()
    if humanoidRootPart then
        tweenCharacter(daekLocations[currentDaekTargetIndex])
        targetDaekNPC = findNPCAtLocation(daekLocations[currentDaekTargetIndex])
        print("Daek Initial tween to location 1.")
    else
        print("Character not found.")
    end

    daekHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkDaekProximity)
end

local function stopDaek()
    if daekHeartbeatConnection then
        daekHeartbeatConnection:Disconnect()
        daekHeartbeatConnection = nil
        print("Daek movement stopped.")
    end
end

-- Script to be placed in a LocalScript inside StarterPlayerScripts

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local longInLocations = {
    CFrame.new(420.371277, 27.7416592, -257.068207) * CFrame.Angles(0, 0, -1),
    CFrame.new(253.170258, 27.7416592, -257.18573) * CFrame.Angles(0, 0, -1),
    CFrame.new(188.344284, 28.2418346, -272.746368) * CFrame.Angles(0, 0, -1),
    CFrame.new(206.443451, 28.2418346, -316.322571) * CFrame.Angles(0, 0, -1),
    CFrame.new(271.442535, 28.2418346, -325.495697) * CFrame.Angles(0, 0, -1)
}

local currentLongInTargetIndex = 1
local targetLongInNPC = nil
local longInHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkLongInProximity()
    if targetLongInNPC and targetLongInNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        currentLongInTargetIndex = currentLongInTargetIndex + 1
        if currentLongInTargetIndex > #longInLocations then
            currentLongInTargetIndex = 1
        end
        targetLongInNPC = nil
    end

    if not targetLongInNPC then
        targetLongInNPC = findNPCAtLocation(longInLocations[currentLongInTargetIndex])
        if targetLongInNPC then
            tweenCharacter(longInLocations[currentLongInTargetIndex])
            print("LongIn Tweening to location " .. currentLongInTargetIndex)
        end
    end
end

local function startLongIn()
    if humanoidRootPart then
        tweenCharacter(longInLocations[currentLongInTargetIndex])
        targetLongInNPC = findNPCAtLocation(longInLocations[currentLongInTargetIndex])
        print("LongIn Initial tween to location 1.")
    else
        print("Character not found.")
    end

    longInHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkLongInProximity)
end

local function stopLongIn()
    if longInHeartbeatConnection then
        longInHeartbeatConnection:Disconnect()
        longInHeartbeatConnection = nil
        print("LongIn movement stopped.")
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local andersLocations = {
    CFrame.new(-21.6539726, 27.8331356, -571.8573) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-105.873772, 27.8331394, -590.795288) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-179.388763, 27.8331337, -558.530762) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-253.847107, 27.8331394, -587.180542) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-337.63736, 27.833128, -512.342529) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012)
}

local currentAndersTargetIndex = 1
local targetAndersNPC = nil
local andersNPCCKilled = false
local andersHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkAndersProximity()
    if targetAndersNPC and targetAndersNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetAndersNPC = nil
        andersNPCCKilled = true
        print("Anders NPC at location " .. currentAndersTargetIndex .. " died.")
    end

    if andersNPCCKilled then
        andersNPCCKilled = false
        currentAndersTargetIndex = currentAndersTargetIndex + 1

        if currentAndersTargetIndex > #andersLocations then
            currentAndersTargetIndex = 1
            print("Anders looping back to location 1.")
        end

        tweenCharacter(andersLocations[currentAndersTargetIndex])
        print("Anders forced tween to location " .. currentAndersTargetIndex)

    elseif not targetAndersNPC then
        targetAndersNPC = findNPCAtLocation(andersLocations[currentAndersTargetIndex])
        if targetAndersNPC then
            tweenCharacter(andersLocations[currentAndersTargetIndex])
            print("Anders tweening to location " .. currentAndersTargetIndex)
        end
    end
end

local function startAnders()
    if humanoidRootPart then
        tweenCharacter(andersLocations[currentAndersTargetIndex])
        targetAndersNPC = findNPCAtLocation(andersLocations[currentAndersTargetIndex])
        print("Anders initial tween to location 1.")
    else
        print("Character not found.")
    end

    andersHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkAndersProximity)
end

local function stopAnders()
    if andersHeartbeatConnection then
        andersHeartbeatConnection:Disconnect()
        andersHeartbeatConnection = nil
        print("Anders movement stopped.")
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local largangalLocations = {
    CFrame.new(-24.1408443, 94.9486542, -537.89856) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012),
    CFrame.new(-95.0146332, 119.883209, -584.235168) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012),
    CFrame.new(-152.64061, 124.243095, -480.124695) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012),
    CFrame.new(-233.431793, 124.316246, -412.280975) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012),
    CFrame.new(-169.629944, 124.3162, -329.628632) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012)
}

local currentLargangalTargetIndex = 1
local targetLargangalNPC = nil
local largangalNPCCKilled = false
local largangalHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkLargangalProximity()
    if targetLargangalNPC and targetLargangalNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetLargangalNPC = nil
        largangalNPCCKilled = true
        print("Largangal NPC at location " .. currentLargangalTargetIndex .. " died.")
    end

    if largangalNPCCKilled then
        largangalNPCCKilled = false
        currentLargangalTargetIndex = currentLargangalTargetIndex + 1

        if currentLargangalTargetIndex > #largangalLocations then
            currentLargangalTargetIndex = 1
            print("Largangal looping back to location 1.")
        end

        tweenCharacter(largangalLocations[currentLargangalTargetIndex])
        print("Largangal forced tween to location " .. currentLargangalTargetIndex)

    elseif not targetLargangalNPC then
        targetLargangalNPC = findNPCAtLocation(largangalLocations[currentLargangalTargetIndex])
        if targetLargangalNPC then
            tweenCharacter(largangalLocations[currentLargangalTargetIndex])
            print("Largangal tweening to location " .. currentLargangalTargetIndex)
        end
    end
end

local function startLargangal()
    if humanoidRootPart then
        tweenCharacter(largangalLocations[currentLargangalTargetIndex])
        targetLargangalNPC = findNPCAtLocation(largangalLocations[currentLargangalTargetIndex])
        print("Largangal initial tween to location 1.")
    else
        print("Character not found.")
    end

    largangalHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkLargangalProximity)
end

local function stopLargangal()
    if largangalHeartbeatConnection then
        largangalHeartbeatConnection:Disconnect()
        largangalHeartbeatConnection = nil
        print("Largangal movement stopped.")
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local snakemanLocations = {
    CFrame.new(-3388.00781, 29.5961876, 2401.38599) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3348.72046, 29.5278111, 2377.44019) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3401.87573, 29.5961876, 2467.00415) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3530.46729, 29.5278111, 2413.83472) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3464.23584, 29.5278111, 2414.1792) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012)
}

local currentSnakemanTargetIndex = 1
local targetSnakemanNPC = nil
local snakemanNPCCKilled = false
local snakemanHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkSnakemanProximity()
    if targetSnakemanNPC and targetSnakemanNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetSnakemanNPC = nil
        snakemanNPCCKilled = true
        print("Snakeman NPC at location " .. currentSnakemanTargetIndex .. " died.")
    end

    if snakemanNPCCKilled then
        snakemanNPCCKilled = false
        currentSnakemanTargetIndex = currentSnakemanTargetIndex + 1

        if currentSnakemanTargetIndex > #snakemanLocations then
            currentSnakemanTargetIndex = 1
            print("Snakeman looping back to location 1.")
        end

        tweenCharacter(snakemanLocations[currentSnakemanTargetIndex])
        print("Snakeman forced tween to location " .. currentSnakemanTargetIndex)

    elseif not targetSnakemanNPC then
        targetSnakemanNPC = findNPCAtLocation(snakemanLocations[currentSnakemanTargetIndex])
        if targetSnakemanNPC then
            tweenCharacter(snakemanLocations[currentSnakemanTargetIndex])
            print("Snakeman tweening to location " .. currentSnakemanTargetIndex)
        end
    end
end

local function startSnakeman()
    if humanoidRootPart then
        tweenCharacter(snakemanLocations[currentSnakemanTargetIndex])
        targetSnakemanNPC = findNPCAtLocation(snakemanLocations[currentSnakemanTargetIndex])
        print("Snakeman initial tween to location 1.")
    else
        print("Character not found.")
    end

    snakemanHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkSnakemanProximity)
end

local function stopSnakeman()
    if snakemanHeartbeatConnection then
        snakemanHeartbeatConnection:Disconnect()
        snakemanHeartbeatConnection = nil
        print("Snakeman movement stopped.")
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local blossomLocations = {
    CFrame.new(-3315.99878, 29.3932247, 2648.13062) * CFrame.Angles(-0.0138685703, 0, -0.999903858),
    CFrame.new(-3353.44214, 29.4616032, 2608.74536) * CFrame.Angles(-0.0138685703, 0, -0.999903858),
    CFrame.new(-3430.30371, 29.3932285, 2671.78394) * CFrame.Angles(-0.0138685703, 0, -0.999903858),
    CFrame.new(-3378.32764, 29.3932285, 2714.56934) * CFrame.Angles(-0.0138685703, 0, -0.999903858),
    CFrame.new(-3325.27417, 29.4616032, 2510.68579) * CFrame.Angles(-0.0138685703, 0, -0.999903858)
}

local currentBlossomTargetIndex = 1
local targetBlossomNPC = nil
local blossomNPCCKilled = false
local blossomHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkBlossomProximity()
    if targetBlossomNPC and targetBlossomNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetBlossomNPC = nil
        blossomNPCCKilled = true
        print("Blossom NPC at location " .. currentBlossomTargetIndex .. " died.")
    end

    if blossomNPCCKilled then
        blossomNPCCKilled = false
        currentBlossomTargetIndex = currentBlossomTargetIndex + 1

        if currentBlossomTargetIndex > #blossomLocations then
            currentBlossomTargetIndex = 1
            print("Blossom looping back to location 1.")
        end

        tweenCharacter(blossomLocations[currentBlossomTargetIndex])
        print("Blossom forced tween to location " .. currentBlossomTargetIndex)

    elseif not targetBlossomNPC then
        targetBlossomNPC = findNPCAtLocation(blossomLocations[currentBlossomTargetIndex])
        if targetBlossomNPC then
            tweenCharacter(blossomLocations[currentBlossomTargetIndex])
            print("Blossom tweening to location " .. currentBlossomTargetIndex)
        end
    end
end

local function startBlossom()
    if humanoidRootPart then
        tweenCharacter(blossomLocations[currentBlossomTargetIndex])
        targetBlossomNPC = findNPCAtLocation(blossomLocations[currentBlossomTargetIndex])
        print("Blossom initial tween to location 1.")
    else
        print("Character not found.")
    end

    blossomHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkBlossomProximity)
end

local function stopBlossom()
    if blossomHeartbeatConnection then
        blossomHeartbeatConnection:Disconnect()
        blossomHeartbeatConnection = nil
        print("Blossom movement stopped.")
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local blackCrowLocations = {
    CFrame.new(-3543.98755, 28.3846512, 2785.43774) * CFrame.Angles(0, 0, 1),
    CFrame.new(-3461.99854, 28.3846512, 2820.15625) * CFrame.Angles(0, 0, 1),
    CFrame.new(-3414.19702, 28.1443138, 2948.16162) * CFrame.Angles(0, 0, 1),
    CFrame.new(-3537.94751, 28.1443138, 2921.59033) * CFrame.Angles(0, 0, 1),
    CFrame.new(-3301.5769, 27.8205986, 2826.51196) * CFrame.Angles(0, 0, 1)
}

local currentBlackCrowTargetIndex = 1
local targetBlackCrowNPC = nil
local blackCrowNPCCKilled = false
local blackCrowHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkBlackCrowProximity()
    if targetBlackCrowNPC and targetBlackCrowNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetBlackCrowNPC = nil
        blackCrowNPCCKilled = true
        print("Black Crow NPC at location " .. currentBlackCrowTargetIndex .. " died.")
    end

    if blackCrowNPCCKilled then
        blackCrowNPCCKilled = false
        currentBlackCrowTargetIndex = currentBlackCrowTargetIndex + 1

        if currentBlackCrowTargetIndex > #blackCrowLocations then
            currentBlackCrowTargetIndex = 1
            print("Black Crow looping back to location 1.")
        end

        tweenCharacter(blackCrowLocations[currentBlackCrowTargetIndex])
        print("Black Crow forced tween to location " .. currentBlackCrowTargetIndex)

    elseif not targetBlackCrowNPC then
        targetBlackCrowNPC = findNPCAtLocation(blackCrowLocations[currentBlackCrowTargetIndex])
        if targetBlackCrowNPC then
            tweenCharacter(blackCrowLocations[currentBlackCrowTargetIndex])
            print("Black Crow tweening to location " .. currentBlackCrowTargetIndex)
        end
    end
end

local function startBlackCrow()
    if humanoidRootPart then
        tweenCharacter(blackCrowLocations[currentBlackCrowTargetIndex])
        targetBlackCrowNPC = findNPCAtLocation(blackCrowLocations[currentBlackCrowTargetIndex])
        print("Black Crow initial tween to location 1.")
    else
        print("Character not found.")
    end

    blackCrowHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkBlackCrowProximity)
end

local function stopBlackCrow()
    if blackCrowHeartbeatConnection then
        blackCrowHeartbeatConnection:Disconnect()
        blackCrowHeartbeatConnection = nil
        print("Black Crow movement stopped.")
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local sharkmanLocations = {
    CFrame.new(-3063.7981, 60.0788689, -2099.13672) * CFrame.Angles(0, -1, 0),
    CFrame.new(-3004.47656, 59.5817032, -2089.91138) * CFrame.Angles(0, -1, 0),
    CFrame.new(-2882.02124, 59.623127, -2073.42822) * CFrame.Angles(0, -1, 0),
    CFrame.new(-3057.62842, 62.6517754, -2223.80566) * CFrame.Angles(0, -1, 0),
    CFrame.new(-2930.2019, 65.1449966, -2141.74048) * CFrame.Angles(0, -1, 0)
}

local currentSharkmanTargetIndex = 1
local targetSharkmanNPC = nil
local sharkmanNPCCKilled = false
local sharkmanHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkSharkmanProximity()
    if targetSharkmanNPC and targetSharkmanNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetSharkmanNPC = nil
        sharkmanNPCCKilled = true
        print("Sharkman NPC at location " .. currentSharkmanTargetIndex .. " died.")
    end

    if sharkmanNPCCKilled then
        sharkmanNPCCKilled = false
        currentSharkmanTargetIndex = currentSharkmanTargetIndex + 1

        if currentSharkmanTargetIndex > #sharkmanLocations then
            currentSharkmanTargetIndex = 1
            print("Sharkman looping back to location 1.")
        end

        tweenCharacter(sharkmanLocations[currentSharkmanTargetIndex])
        print("Sharkman forced tween to location " .. currentSharkmanTargetIndex)

    elseif not targetSharkmanNPC then
        targetSharkmanNPC = findNPCAtLocation(sharkmanLocations[currentSharkmanTargetIndex])
        if targetSharkmanNPC then
            tweenCharacter(sharkmanLocations[currentSharkmanTargetIndex])
            print("Sharkman tweening to location " .. currentSharkmanTargetIndex)
        end
    end
end

local function startSharkman()
    if humanoidRootPart then
        tweenCharacter(sharkmanLocations[currentSharkmanTargetIndex])
        targetSharkmanNPC = findNPCAtLocation(sharkmanLocations[currentSharkmanTargetIndex])
        print("Sharkman initial tween to location 1.")
    else
        print("Character not found.")
    end

    sharkmanHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkSharkmanProximity)
end

local function stopSharkman()
    if sharkmanHeartbeatConnection then
        sharkmanHeartbeatConnection:Disconnect()
        sharkmanHeartbeatConnection = nil
        print("Sharkman movement stopped.")
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local eminelLocations = {
    CFrame.new(-3147.3667, 60.9353027, -2225.68091) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3178.89697, 59.0615425, -2263.26782) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3153.47803, 58.4662132, -2328.83008) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3142.7666, 59.2031059, -2394.18799) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3196.70459, 61.0635109, -2394.55005) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012)
}

local currentEminelTargetIndex = 1
local targetEminelNPC = nil
local eminelNPCCKilled = false
local eminelHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkEminelProximity()
    if targetEminelNPC and targetEminelNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetEminelNPC = nil
        eminelNPCCKilled = true
        print("Eminel NPC at location " .. currentEminelTargetIndex .. " died.")
    end

    if eminelNPCCKilled then
        eminelNPCCKilled = false
        currentEminelTargetIndex = currentEminelTargetIndex + 1

        if currentEminelTargetIndex > #eminelLocations then
            currentEminelTargetIndex = 1
            print("Eminel looping back to location 1.")
        end

        tweenCharacter(eminelLocations[currentEminelTargetIndex])
        print("Eminel forced tween to location " .. currentEminelTargetIndex)

    elseif not targetEminelNPC then
        targetEminelNPC = findNPCAtLocation(eminelLocations[currentEminelTargetIndex])
        if targetEminelNPC then
            tweenCharacter(eminelLocations[currentEminelTargetIndex])
            print("Eminel tweening to location " .. currentEminelTargetIndex)
        end
    end
end

local function startEminel()
    if humanoidRootPart then
        tweenCharacter(eminelLocations[currentEminelTargetIndex])
        targetEminelNPC = findNPCAtLocation(eminelLocations[currentEminelTargetIndex])
        print("Eminel initial tween to location 1.")
    else
        print("Character not found.")
    end

    eminelHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkEminelProximity)
end

local function stopEminel()
    if eminelHeartbeatConnection then
        eminelHeartbeatConnection:Disconnect()
        eminelHeartbeatConnection = nil
        print("Eminel movement stopped.")
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local lightAdmiralLocations = {
    CFrame.new(-3293.57812, 55.6797104, -2621.39941) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3173.02002, 53.5350304, -2583.7876) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3116.51392, 53.9176216, -2619.40039) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3131.98413, 58.6132965, -2744.6438) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(-3161.61963, 54.797039, -2821.41455) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012)
}

local currentLightAdmiralTargetIndex = 1
local targetLightAdmiralNPC = nil
local lightAdmiralNPCCKilled = false
local lightAdmiralHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkLightAdmiralProximity()
    if targetLightAdmiralNPC and targetLightAdmiralNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetLightAdmiralNPC = nil
        lightAdmiralNPCCKilled = true
        print("Light Admiral NPC at location " .. currentLightAdmiralTargetIndex .. " died.")
    end

    if lightAdmiralNPCCKilled then
        lightAdmiralNPCCKilled = false
        currentLightAdmiralTargetIndex = currentLightAdmiralTargetIndex + 1

        if currentLightAdmiralTargetIndex > #lightAdmiralLocations then
            currentLightAdmiralTargetIndex = 1
            print("Light Admiral looping back to location 1.")
        end

        tweenCharacter(lightAdmiralLocations[currentLightAdmiralTargetIndex])
        print("Light Admiral forced tween to location " .. currentLightAdmiralTargetIndex)

    elseif not targetLightAdmiralNPC then
        targetLightAdmiralNPC = findNPCAtLocation(lightAdmiralLocations[currentLightAdmiralTargetIndex])
        if targetLightAdmiralNPC then
            tweenCharacter(lightAdmiralLocations[currentLightAdmiralTargetIndex])
            print("Light Admiral tweening to location " .. currentLightAdmiralTargetIndex)
        end
    end
end

local function startLightAdmiral()
    if humanoidRootPart then
        tweenCharacter(lightAdmiralLocations[currentLightAdmiralTargetIndex])
        targetLightAdmiralNPC = findNPCAtLocation(lightAdmiralLocations[currentLightAdmiralTargetIndex])
        print("Light Admiral initial tween to location 1.")
    else
        print("Character not found.")
    end

    lightAdmiralHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkLightAdmiralProximity)
end

local function stopLightAdmiral()
    if lightAdmiralHeartbeatConnection then
        lightAdmiralHeartbeatConnection:Disconnect()
        lightAdmiralHeartbeatConnection = nil
        print("Light Admiral movement stopped.")
    end
end

-- Script to be placed in a LocalScript inside StarterPlayerScripts

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local luryuLocations = {
    CFrame.new(2708.87622, 46.0233383, -2629.01611) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(2681.80273, 45.0223312, -2732.36035) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(2727.15039, 45.0223312, -2783.30884) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(2755.09521, 46.0233383, -2883.73584) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012),
    CFrame.new(2691.64917, 46.0233383, -2944.42578) * CFrame.Angles(-1.1920929e-07, 0, -1.00000012)
}

local currentLuryuTargetIndex = 1
local targetLuryuNPC = nil
local luryuNPCCKilled = false
local luryuHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkLuryuProximity()
    if targetLuryuNPC and targetLuryuNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetLuryuNPC = nil
        luryuNPCCKilled = true
        print("Luryu NPC at location " .. currentLuryuTargetIndex .. " died.")
    end

    if luryuNPCCKilled then
        luryuNPCCKilled = false
        currentLuryuTargetIndex = currentLuryuTargetIndex + 1

        if currentLuryuTargetIndex > #luryuLocations then
            currentLuryuTargetIndex = 1
            print("Luryu looping back to location 1.")
        end

        tweenCharacter(luryuLocations[currentLuryuTargetIndex])
        print("Luryu forced tween to location " .. currentLuryuTargetIndex)

    elseif not targetLuryuNPC then
        targetLuryuNPC = findNPCAtLocation(luryuLocations[currentLuryuTargetIndex])
        if targetLuryuNPC then
            tweenCharacter(luryuLocations[currentLuryuTargetIndex])
            print("Luryu tweening to location " .. currentLuryuTargetIndex)
        end
    end
end

local function startLuryu()
    if humanoidRootPart then
        tweenCharacter(luryuLocations[currentLuryuTargetIndex])
        targetLuryuNPC = findNPCAtLocation(luryuLocations[currentLuryuTargetIndex])
        print("Luryu initial tween to location 1.")
    else
        print("Character not found.")
    end

    luryuHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkLuryuProximity)
end

local function stopLuryu()
    if luryuHeartbeatConnection then
        luryuHeartbeatConnection:Disconnect()
        luryuHeartbeatConnection = nil
        print("Luryu movement stopped.")
    end
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace.__Main.__Enemies.Client

local tweenInfo = TweenInfo.new(
    1, -- Time (seconds)
    Enum.EasingStyle.Linear, -- Easing style
    Enum.EasingDirection.Out, -- Easing direction
    0, -- Repeat count
    false, -- Reverse
    0 -- Delay time
)

local fyakuyaLocations = {
    CFrame.new(2865.28467, 68.4785461, -2982.57642) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012),
    CFrame.new(2934.65479, 68.4772949, -2969.14087) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012),
    CFrame.new(2931.72095, 68.4786072, -3053.18237) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012),
    CFrame.new(3003.21753, 68.4772873, -3061.79492) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012),
    CFrame.new(3003.94995, 68.4786301, -3144.53027) * CFrame.Angles(-1.1920929e-07, 0, 1.00000012)
}

local currentFyakuyaTargetIndex = 1
local targetFyakuyaNPC = nil
local fyakuyaNPCCKilled = false
local fyakuyaHeartbeatConnection = nil

local function findNPCAtLocation(location)
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local npcRootPart = npc.HumanoidRootPart
            local distance = (npcRootPart.Position - location.p).Magnitude
            if distance < 5 then
                return npc
            end
        end
    end
    return nil
end

local function tweenCharacter(targetCFrame)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local function checkFyakuyaProximity()
    if targetFyakuyaNPC and targetFyakuyaNPC.HealthBar.Main.Bar.Amount.Text == "0 HP" then
        targetFyakuyaNPC = nil
        fyakuyaNPCCKilled = true
        print("Fyakuya NPC at location " .. currentFyakuyaTargetIndex .. " died.")
    end

    if fyakuyaNPCCKilled then
        fyakuyaNPCCKilled = false
        currentFyakuyaTargetIndex = currentFyakuyaTargetIndex + 1

        if currentFyakuyaTargetIndex > #fyakuyaLocations then
            currentFyakuyaTargetIndex = 1
            print("Fyakuya looping back to location 1.")
        end

        tweenCharacter(fyakuyaLocations[currentFyakuyaTargetIndex])
        print("Fyakuya forced tween to location " .. currentFyakuyaTargetIndex)

    elseif not targetFyakuyaNPC then
        targetFyakuyaNPC = findNPCAtLocation(fyakuyaLocations[currentFyakuyaTargetIndex])
        if targetFyakuyaNPC then
            tweenCharacter(fyakuyaLocations[currentFyakuyaTargetIndex])
            print("Fyakuya tweening to location " .. currentFyakuyaTargetIndex)
        end
    end
end

local function startFyakuya()
    if humanoidRootPart then
        tweenCharacter(fyakuyaLocations[currentFyakuyaTargetIndex])
        targetFyakuyaNPC = findNPCAtLocation(fyakuyaLocations[currentFyakuyaTargetIndex])
        print("Fyakuya initial tween to location 1.")
    else
        print("Character not found.")
    end

    fyakuyaHeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(checkFyakuyaProximity)
end

local function stopFyakuya()
    if fyakuyaHeartbeatConnection then
        fyakuyaHeartbeatConnection:Disconnect()
        fyakuyaHeartbeatConnection = nil
        print("Fyakuya movement stopped.")
    end
end

-- Function to stop all mob movements
local function stopAllMobs()
    stopSoondoo()
    stopGonshee()
    stopDaek()
    stopLongIn()
    stopAnders()
    stopLargangal()
    stopSnakeman()
    stopBlossom()
    stopBlackCrow()
    stopSharkman()
    stopEminel()
    stopLightAdmiral()
    stopLuryu()
    stopFyakuya()
end

-- Functions to start each mob
local function startSoondooMob()
    stopAllMobs()
    startSoondoo()
end

local function startGonsheeMob()
    stopAllMobs()
    startGonshee()
end

local function startDaekMob()
    stopAllMobs()
    startDaek()
end

local function startLongInMob()
    stopAllMobs()
    startLongIn()
end

local function startAndersMob()
    stopAllMobs()
    startAnders()
end

local function startLargangalMob()
    stopAllMobs()
    startLargangal()
end

local function startSnakemanMob()
    stopAllMobs()
    startSnakeman()
end

local function startBlossomMob()
    stopAllMobs()
    startBlossom()
end

local function startBlackCrowMob()
    stopAllMobs()
    startBlackCrow()
end

local function startSharkmanMob()
    stopAllMobs()
    startSharkman()
end

local function startEminelMob()
    stopAllMobs()
    startEminel()
end

local function startLightAdmiralMob()
    stopAllMobs()
    startLightAdmiral()
end

local function startLuryuMob()
    stopAllMobs()
    startLuryu()
end

local function startFyakuyaMob()
    stopAllMobs()
    startFyakuya()
end

local Dropdown = MainTab:CreateDropdown({
    Name = "Mob Selection",
    Options = {"None", "Soondoo", "Gonshee", "Daek", "LongIn", "Anders", "Largangal", "Snakeman", "Blossom", "Black Crow", "Sharkman", "Eminel", "Light Admiral", "Luryu", "Fyakuya", "Genji"},
    CurrentOption = {"None"},
    MultipleOptions = false,
    Flag = "MobSelection",
    Callback = function(Options)
        local selectedOption = Options[1]

        if selectedOption == "Soondoo" then
            startSoondooMob()
        elseif selectedOption == "Gonshee" then
            startGonsheeMob()
        elseif selectedOption == "Daek" then
            startDaekMob()
        elseif selectedOption == "LongIn" then
            startLongInMob()
        elseif selectedOption == "Anders" then
            startAndersMob()
        elseif selectedOption == "Largangal" then
            startLargangalMob()
        elseif selectedOption == "Snakeman" then
            startSnakemanMob()
        elseif selectedOption == "Blossom" then
            startBlossomMob()
        elseif selectedOption == "Black Crow" then
            startBlackCrowMob()
        elseif selectedOption == "Sharkman" then
            startSharkmanMob()
        elseif selectedOption == "Eminel" then
            startEminelMob()
        elseif selectedOption == "Light Admiral" then
            startLightAdmiralMob()
        elseif selectedOption == "Luryu" then
            startLuryuMob()
        elseif selectedOption == "Fyakuya" then
            startFyakuyaMob()
        else
            stopAllMobs()
            print("Selected option:", selectedOption)
        end
    end,
})