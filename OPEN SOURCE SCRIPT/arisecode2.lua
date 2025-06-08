local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local tween

local function TweenToPosition(targetCFrame, speed, isSlowTween)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")

    if humanoid.Health <= 0 then
        if tween then tween:Cancel() end
        repeat task.wait() until humanoid.Health > 0
        task.wait(0.2)
        return
    end

    -- Calculate a position closer to the enemy
    local offset = CFrame.new(0, 0, -getgenv().TweenOffset) -- Negative Z is forward, brings you closer
    local adjustedCFrame = targetCFrame * offset

    local distance = (rootPart.Position - adjustedCFrame.Position).Magnitude
    if distance <= 150 then
        pcall(function()
            if tween then tween:Cancel() end
            rootPart.CFrame = adjustedCFrame
        end)
        return
    end

    -- Use slower speed for dungeon/castle if enabled
    if isSlowTween then
        speed = speed or (distance < 1000 and 200 or 150) -- Slower speed for dungeon/castle
    else
        speed = speed or (distance < 1000 and 315 or 300) -- Regular speed
    end
    
    local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
    tween = TweenService:Create(rootPart, tweenInfo, {CFrame = adjustedCFrame})
    tween:Play()

    return { Stop = function() tween:Cancel() end }
end

-- Check if enemy is big or small based on ZonePrompt.MaxActivationDistance
local function IsEnemyBig(enemy)
    if not enemy or not enemy:IsA("Model") then return false end
    
    local zonePrompt = enemy:FindFirstChild("ZonePrompt")
    if zonePrompt and zonePrompt:IsA("ProximityPrompt") then
        return zonePrompt.MaxActivationDistance >= 20
    end
    
    -- If no ZonePrompt found, try to determine by model size
    local primaryPart = enemy:FindFirstChild("HumanoidRootPart") or enemy.PrimaryPart
    if primaryPart then
        local size = enemy:GetExtentsSize()
        return (size.X + size.Y + size.Z) / 3 >= 5 -- Arbitrary threshold
    end
    
    return false
end

-- Find nearest enemy with size filter
local function FindFilteredEnemy(sizeFilter)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    
    local hrp = character.HumanoidRootPart
    local validEnemies = {}
    
    for _, v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
        local healthText = v:FindFirstChild("HealthBar") and v.HealthBar:FindFirstChild("Main") and v.HealthBar.Main:FindFirstChild("Bar") and v.HealthBar.Main.Bar:FindFirstChild("Amount")
        local root = v:FindFirstChild("HumanoidRootPart")
        
        if healthText and root and v:IsDescendantOf(workspace) and healthText.ContentText ~= "0 HP" then
            local isBig = IsEnemyBig(v)
            
            if (sizeFilter == "Big" and isBig) or 
               (sizeFilter == "Small" and not isBig) or
               (sizeFilter == "Any") then
                
                local dist = (hrp.Position - root.Position).Magnitude
                table.insert(validEnemies, {
                    instance = v,
                    name = v.Name,
                    rootPart = root,
                    healthText = healthText,
                    distance = dist
                })
            end
        end
    end
    
    -- Sort by distance
    table.sort(validEnemies, function(a, b)
        return a.distance < b.distance
    end)
    
    -- Return the closest enemy if available
    if #validEnemies > 0 then
        return validEnemies[1]
    end
    
    return nil
end

-- Find any enemy (free mode) with size filter
local function FindAnyFilteredEnemy(sizeFilter)
    local validEnemies = {}
    
    for _, v in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
        local healthText = v:FindFirstChild("HealthBar") and v.HealthBar:FindFirstChild("Main") and v.HealthBar.Main:FindFirstChild("Bar") and v.HealthBar.Main.Bar:FindFirstChild("Amount")
        local root = v:FindFirstChild("HumanoidRootPart")
        
        if healthText and root and v:IsDescendantOf(workspace) and healthText.ContentText ~= "0 HP" then
            local isBig = IsEnemyBig(v)
            
            if (sizeFilter == "Big" and isBig) or 
               (sizeFilter == "Small" and not isBig) or
               (sizeFilter == "Any") then
                
                table.insert(validEnemies, {
                    instance = v,
                    name = v.Name,
                    rootPart = root,
                    healthText = healthText
                })
            end
        end
    end
    
    -- Return a random enemy from the table if available
    if #validEnemies > 0 then
        return validEnemies[math.random(1, #validEnemies)]
    end
    
    return nil
end

-- Function to find target based on farm mode and size filter
local function FindTargetByMode()
    local sizeFilter = "Any"
    
    if getgenv().SizeMode == "Only Attack Big" then
        sizeFilter = "Big"
    elseif getgenv().SizeMode == "Only Attack Small" then
        sizeFilter = "Small"
    end
    
    if getgenv().FarmMode == "Nearest" then
        return FindFilteredEnemy(sizeFilter)
    else -- "Free" mode or default
        return FindAnyFilteredEnemy(sizeFilter)
    end
end

local VirtualInputManager = game:GetService("VirtualInputManager")

function ClickBody(enemy)
    local root = enemy:FindFirstChild("HumanoidRootPart")
    if root and enemy:IsDescendantOf(workspace) then
        local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
        if onScreen then
            VirtualInputManager:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, false, game, 0)
        end
    end
end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Test Arise", HidePremium = false, SaveConfig = true, ConfigFolder = "TestArise"})

local Tab = Window:MakeTab({
    Name = "Farming",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local TabDungeon = Window:MakeTab({
    Name = "Dungeon/Castle",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Farm Mode settings
getgenv().FarmMode = "Free"
Tab:AddDropdown({
    Name = "Farm Mode",
    Default = "Free",
    Options = {"Free", "Nearest"},
    Callback = function(Value)
        getgenv().FarmMode = Value
    end    
})

-- Enemy Size Filter
getgenv().SizeMode = "Attack All"
Tab:AddDropdown({
    Name = "Enemy Size Filter",
    Default = "Attack All",
    Options = {"Attack All", "Only Attack Big", "Only Attack Small"},
    Callback = function(Value)
        getgenv().SizeMode = Value
    end    
})

Tab:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(Value)
        getgenv().farm = Value
    end    
})

-- Auto Farm Function
spawn(function()
    while task.wait() do
        if getgenv().farm then
            pcall(function()
                -- Find a target based on selected mode and size filter
                local targetEnemy = FindTargetByMode()
                
                if targetEnemy then
                    -- Attack this enemy until it's dead (0 HP)
                    while targetEnemy.instance:IsDescendantOf(workspace) and 
                          targetEnemy.healthText.ContentText ~= "0 HP" and 
                          getgenv().farm do
                        
                        -- Move to enemy (closer position)
                        TweenToPosition(targetEnemy.rootPart.CFrame)
                        
                        -- Attack the enemy
                        local args = {
                            { { Event = "PunchAttack", Enemy = targetEnemy.name }, "\4" }
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                        
                        -- Wait before next attack
                        task.wait(getgenv().FarmDelay)
                    end
                    
                    -- Small delay after enemy is defeated before finding a new one
                    task.wait(0.1)
                else
                    -- No enemies found, short wait
                    task.wait(0.1)
                end
            end)
        else
            task.wait(0.5)
        end
    end
end)

-- Dungeon/Castle Functions
TabDungeon:AddToggle({
    Name = "Auto Dungeon",
    Default = false,
    Callback = function(Value)
        getgenv().autoDungeon = Value
    end    
})

TabDungeon:AddToggle({
    Name = "Auto Castle",
    Default = false,
    Callback = function(Value)
        getgenv().autoCastle = Value
    end    
})

-- Auto Dungeon Function
spawn(function()
    while task.wait() do
        if getgenv().autoDungeon then
            pcall(function()
                -- Find a target based on selected mode and size filter
                local targetEnemy = FindTargetByMode()
                
                if targetEnemy then
                    -- Attack this enemy until it's dead (0 HP)
                    while targetEnemy.instance:IsDescendantOf(workspace) and 
                          targetEnemy.healthText.ContentText ~= "0 HP" and 
                          getgenv().autoDungeon do
                        
                        -- Move to enemy (closer position) with slower tween
                        TweenToPosition(targetEnemy.rootPart.CFrame, nil, true)
                        
                        -- Attack the enemy
                        local args = {
                            { { Event = "PunchAttack", Enemy = targetEnemy.name }, "\4" }
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                        
                        -- Wait before next attack
                        task.wait(getgenv().FarmDelay * 1.5) -- Slightly longer delay for dungeon
                    end
                    
                    -- Small delay after enemy is defeated before finding a new one
                    task.wait(0.2)
                else
                    -- No enemies found, short wait
                    task.wait(0.2)
                end
            end)
        else
            task.wait(0.5)
        end
    end
end)

-- Auto Castle Function
spawn(function()
    while task.wait() do
        if getgenv().autoCastle then
            pcall(function()
                -- Find a target based on selected mode and size filter
                local targetEnemy = FindTargetByMode()
                
                if targetEnemy then
                    -- Attack this enemy until it's dead (0 HP)
                    while targetEnemy.instance:IsDescendantOf(workspace) and 
                          targetEnemy.healthText.ContentText ~= "0 HP" and 
                          getgenv().autoCastle do
                        
                        -- Move to enemy (closer position) with slower tween
                        TweenToPosition(targetEnemy.rootPart.CFrame, nil, true)
                        
                        -- Attack the enemy
                        local args = {
                            { { Event = "PunchAttack", Enemy = targetEnemy.name }, "\4" }
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                        
                        -- Wait before next attack
                        task.wait(getgenv().FarmDelay * 2) -- Even longer delay for castle
                    end
                    
                    -- Small delay after enemy is defeated before finding a new one
                    task.wait(0.3)
                else
                    -- No enemies found, short wait
                    task.wait(0.3)
                end
            end)
        else
            task.wait(0.5)
        end
    end
end)

Tab:AddToggle({
    Name = "Auto Send Pet",
    Default = false,
    Callback = function(Value)
        getgenv().sendPets = Value
    end    
})

spawn(function()
    while wait() do
        if getgenv().sendPets then
            pcall(function()
                loadstring(game:HttpGet('https://rawscripts.net/raw/Arise-Crossover-AUTO-ATTACK-UNLOCK-ARISE-CROSSOVER-33758'))()
                game:GetService("Players").LocalPlayer.Settings:SetAttribute("AutoAttack", true)
            end)
        end
    end
end)

Tab:AddToggle({
    Name = "Auto Click (Fast)",
    Default = true,
    Callback = function(Value)
        getgenv().fastClick = Value
        task.spawn(function()
            while wait() do
                pcall(function()
                    if getgenv().fastClick then
                        enemy = FindTargetByMode() -- Use the same target finding function based on selected mode
                        if enemy then
                            local args = {
                                { { Event = "PunchAttack", Enemy = enemy.name }, "\4" }
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                        end
                    end
                end)
            end
        end)
    end    
})

getgenv().TweenOffset = 3

getgenv().FarmDelay = 0.7
Tab:AddSlider({
    Name = "Farm Delay",
    Min = 0,
    Max = 2,
    Default = 0.7,
    Color = Color3.fromRGB(255,255,255),
    Increment = 0.1,
    ValueName = "Second(s)",
    Callback = function(Value)
        getgenv().FarmDelay = Value
    end    
})

TabDungeon:AddSlider({
    Name = "Tween Offset",
    Min = 1,
    Max = 10,
    Default = 3,
    Color = Color3.fromRGB(255,255,255),
    Increment = 0.5,
    ValueName = "Studs",
    Callback = function(Value)
        getgenv().TweenOffset = Value
    end    
})