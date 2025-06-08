local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Ancestral| Premium Scripts",
    Icon = "",
    Author = "Fisch by Naaellx - "..os.date('%A, %B %dth, %Y.'),
    Folder = "AncestralTheme",
    Size = UDim2.fromOffset(580, 300),
    Transparent = true,
    Theme = "Ancestral",
    SideBarWidth = 200,
    HasOutline = true,
})

local Tabs = {
    GeneralTab = Window:Tab({ Title = "General", Icon = "toggle-left", Desc = "" }),
    AutomaticTab = Window:Tab({ Title = "Automatic ", Icon = "arrow-big-up", Desc = "" }),
    TeleportTab = Window:Tab({ Title = "Teleport ", Icon = "disc", Desc = "" }),
    b = Window:Divider(),
    WindowTab = Window:Tab({ Title = "Theme Account", Icon = "settings", Desc = "" }),
    CreateThemeTab = Window:Tab({ Title = "Create Theme", Icon = "palette", Desc = "" }),
}

Window:SelectTab(1)

local Choose_Position = CFrame.new(356.8832702636719, 131.48373413085938, 297.43634033203125)
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

function TP(Pos)	game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(Pos)
end

spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        pcall(function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            local humanoid = character:WaitForChild("Humanoid")
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

            if _G.AutoFish or _G.AutoTeleportToEventZone or _G.AutoSubmarineQuest then
                if syn then
                     setfflag("HumanoidParallelRemoveNoPhysics", "False")
                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                    humanoid:ChangeState(11)
                  
                    if humanoid.Sit then
                        humanoid.Sit = false
                    end
                else                
                    if humanoidRootPart and not humanoidRootPart:FindFirstChild("BodyVelocity1") then                     
                        if humanoid.Sit then
                            humanoid.Sit = false
                        end                  
                        local BodyVelocity = Instance.new("BodyVelocity")
                        BodyVelocity.Name = "BodyVelocity1"
                        BodyVelocity.Parent = humanoidRootPart
                        BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end              
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            else
                if humanoidRootPart and humanoidRootPart:FindFirstChild("BodyVelocity1") then
                    humanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy()
                end
            end
        end)
    end)
end)

local ChoosePosition = Tabs.GeneralTab:Paragraph({
    Title = "[📛] Current Fishing Position",
    Desc = "[📍] Position : 356 X 131 Y 297 Z"
})

Tabs.GeneralTab:Button({
    Title = "Choose Fishing Position",
    Desc = "Set you new fishing position.",
    Callback = function()
if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
Choose_Position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
ChoosePosition:SetDesc("[📍] Position : "..tostring(math.floor(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.X)).." X "..tostring(math.floor(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y)).." Y "..tostring(math.floor(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Z)).." Z")
end
end
})

Tabs.GeneralTab:Toggle({
    Title = "Auto Fishing",
    Desc = "Automaticy fish for you.",
    Default = false,
    Callback = function(Value)
    _G.AutoFish = Value
 end
})

spawn(function()
    while wait(0.1) do
        if _G.AutoFish then
            pcall(function()
                local player = game.Players.LocalPlayer
                local playerCharacter = player.Character
                local playerGui = player:WaitForChild("PlayerGui")
                if playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart") then
                    playerCharacter.HumanoidRootPart.CFrame = Choose_Position
                end             
                local rod = nil
                for _, v in pairs(player.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name:lower():find("rod") then
                        rod = v
                        break
                    end
                end             
                if rod then                  playerCharacter.Humanoid:EquipTool(rod)
                end              
                local equippedTool = playerCharacter:FindFirstChildOfClass("Tool")
                if equippedTool and equippedTool:FindFirstChild("events") then
                    equippedTool.events.cast:FireServer(100, 1)
                end            
                local shakeUI = playerGui:FindFirstChild("shakeui")
                if shakeUI and shakeUI.Enabled then
                    local safezone = shakeUI:FindFirstChild("safezone")
                    if safezone then
                        local button = safezone:FindFirstChild("button")
                        if button and button:IsA("ImageButton") and button.Visible then
                            GuiService.SelectedObject = button
                            button.BackgroundTransparency = 1
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                        end
                    end
                end               
                local reelGui = playerGui:FindFirstChild("reel")
                if reelGui and reelGui:FindFirstChild("bar") then
                    local bar = reelGui.bar
                    local fish = bar:FindFirstChild("fish")
                    if fish then
                        local playerBar = bar:FindFirstChild("playerbar")
                        if playerBar then
                            playerBar.Position = UDim2.new(fish.Position.X.Scale, fish.Position.X.Offset, 
                                fish.Position.Y.Scale, fish.Position.Y.Offset)
                        end
                    end
                end
            end)
        end
    end
end)


Tabs.GeneralTab:Toggle({
    Title = "Teleport To Choose Position",
    Desc = "Automaticy teleport while fishing to you fishing position.",
    Default = false,
    Callback = function(Value)
    _G.AutoTpPosition = Value
spawn(function()
while _G.AutoTpPosition == true do        
wait()
local player = game.Players.LocalPlayer
if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then                 
player.Character.HumanoidRootPart.CFrame = Choose_Position
end
end
end)
 end
})

Tabs.GeneralTab:Paragraph({
    Title = "[🛸] Nuke",
})

Tabs.GeneralTab:Toggle({
    Title = "Auto Nuke Minigame",
    Desc = "Automaticy puzzle minigame nuke.",
    Default = false,
    Callback = function(Value)
    _G.AutoMinigameNuke = Value
 end
})

spawn(function()
    while wait(.1) do
        if _G.AutoMinigameNuke then
            pcall(function()
                repeat task.wait(0.01) 
	        for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if v.Name == "Nuke" then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                end
            end                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                until not _G.AutoMinigameNuke
            end)
        end
    end
end)

Tabs.GeneralTab:Paragraph({
    Title = "[🍗] Bait",
})

local BaitList = {
    "Bagel",
    "Worm",
    "Insect",
    "Flakes",
    "Garbage",
    "Maggot",
    "Shrimp",
    "Squid",
    "Seaweed",
    "Magnet",
    "Minnow",
    "Coral",
    "Peppermint Worm",
    "Super Flakes",
    "Coal",
    "Rapid Catcher",
    "Truffle Worm",
    "Weird Algae",
    "Fish Head",
    "Night Shrimp",
    "Instant Catcher",
    "Deep Coral",
    "Holly Berry",
    "Shark Head",
    "Aurora Bait"
}

Tabs.Automatically:AddDropdown("ChooseBait", {
    Title = "Choose Bait",
    Values = BaitList,
    Default = nil,
    Callback = function(Value)
        _G.ChooseBait = Value
    end
})

Tabs.Automatically:AddToggle("AutoUseBait", {
    Title = "Auto Equip Bait",
    Description = "Automatically use bait when fishing.",
    Default = false,
    Callback = function(Value)
        _G.AutoUseBait = Value
    end
})

spawn(function()
    while wait(.1) do
        if _G.AutoUseBait then
            pcall(function()
                repeat task.wait(0.01)
local args = {
    [1] = _G.ChooseBait
}

game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/Bait/Equip"):FireServer(unpack(args))
                until not _G.AutoUseBait
            end)
        end
    end
end)

Tabs.GeneralTab:Paragraph({
    Title = "[🎃] Sell",
})

_G.DelaySell = 120
Tabs.GeneralTab:Slider({
    Title = "Choose Delay Sell",
    Value = {
        Min = 0,
        Max = 5000,
        Default = 120,
    },
    Callback = function(Value)
    _G.DelaySell = Value
end
})

Tabs.GeneralTab:Toggle({
    Title = "Enable Sell All",
    Desc = "Automaticy sell fish in backpack all.",
    Default = false,
    Callback = function(Value)
    _G.AutoSellAll = Value
 end
})

function SellAll()
game:GetService("ReplicatedStorage").events.SellAll:InvokeServer()
end

spawn(function()
    while wait(0.1) do
        if _G.AutoSellAll then
            pcall(function()
            SellAll()
            task.wait(_G.DelaySell)
            end)
        end
    end
end)

Tabs.AutomaticTab:Paragraph({
    Title = "[💰] Treasure",
})

Tabs.AutomaticTab:Toggle({
    Title = "Auto Collect Treasure",
    Desc = "Automaticy if auto (fully) is turned on, and then automaticy collect the treasure chest.",
    Default = false,
    Callback = function(Value)
    _G.AutoCollectTreasure = Value
 end
})

spawn(function()
    while wait(0.1) do
        if _G.AutoCollectTreasure then
            pcall(function()
                for i, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if v.ClassName == "ProximityPrompt" then
                        v.HoldDuration = 0
                    end
                end
                for i, v in pairs(workspace.world.chests:GetDescendants()) do
                    if v:IsA("Part") and v:FindFirstChild("ChestSetup") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                          for _, prompt in pairs(workspace.world.chests:GetDescendants()) do
                            if prompt.Name == "ProximityPrompt" then
                                fireproximityprompt(prompt)
                            end
                        end
                        task.wait(1)
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while wait(0.1) do
        if _G.AutoFully and _G.AutoCollectTreasure then
            pcall(function()
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                    if v.Name == "Treasure Map" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then                 
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2824.359, 214.311, 1518.130)
                        end
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                        workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Jack Marrow"):WaitForChild("treasure"):WaitForChild("repairmap"):InvokeServer()
                    end
                end
            end)
        end
    end
end)


Tabs.AutomaticTab:Toggle({
    Title = "Auto (Fully)",
    Desc = "Automaticy repair the Treasure Map.",
    Value = true,
    Callback = function(Value)
    _G.AutoFully = Value
 end
})

Tabs.AutomaticTab:Toggle({
    Title = "Auto Use Fillionaire",
    Desc = "Automaticy Puzzle the Fillionaire.",
    Value = false,
    Callback = function(Value)
    _G.AutoUseFillionaire = Value
 end
})

spawn(function()
    while wait(0.1) do
        if _G.AutoUseFillionaire then
            pcall(function()
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:UnequipTools()
                    local Fillionaire = LocalPlayer.Backpack:FindFirstChild("Fillionaire")
                    if Fillionaire then
                        local FillionaireLink = tostring(Fillionaire.link.Value)
                        local FillionaireAmount = ReplicatedStorage.playerstats[LocalPlayer.Name].Inventory[FillionaireLink].Stack.Value
                        for _ = 1, FillionaireAmount do
                            humanoid:EquipTool(Fillionaire)
                        end
                    end                 
                    task.wait(1)

                    local mainGui = LocalPlayer.PlayerGui.Fillionaire.Main                  
                    for _, child in ipairs(mainGui:GetChildren()) do
                        if child.Name == "Template" and child.Visible then
                            local playerNumbers = child:FindFirstChild("PlayerNumbers")
                            if playerNumbers then                             
                                for i = 1, 4 do
                                    local numberButton = playerNumbers:FindFirstChild(tostring(i))
                                    if numberButton and numberButton:IsA("GuiButton") then                                    
                                        if getconnections then
                                            for _, v in pairs(getconnections(numberButton.MouseButton1Click)) do
                                                v.Function()
                                            end
                                        else                                                                                  firesignal(numberButton.MouseButton1Click)
                                        end
                                    end
                                end
                            end
                            task.wait()
                            child:Destroy()
                        end
                    end
                end
            end)
        end
    end
end)

Tabs.AutomaticTab:Paragraph({
    Title = "[🌠] Totem",
})

Tabs.AutomaticTab:Dropdown({
    Title = "Choose Totem",
    Values = { "Sundial Totem", "Aurora Totem", "Tempest Totem", "Smokescreen Totem", "Windset Totem", "Eclipse Totem" , "Meteor Totem" , "Blizzard Totem" , "Avalanche Totem" , "Zeus Storm Totem" , "Poseidon's Wrath Totem"},
    Value = "",
    Callback = function(Value)
    _G.ChooseTotem = Value
end
})

Tabs.AutomaticTab:Toggle({
    Title = "Auto Use Totem",
    Desc = "Automaticy use totem.",
    Default = false,
    Callback = function(Value)
    _G.AutoUseTotem = Value
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

Tabs.AutomaticTab:Toggle({
    Title = "Auto Collect Meteor",
    Desc = "Automaticy collect a material.",
    Default = false,
    Callback = function(Value)
    _G.AutoCollectMeteor = Value
 end
})

spawn(function()
    while wait(.1) do
        if _G.AutoCollectMeteor then
            pcall(function()
                repeat task.wait(0.01)
                local player = game.Players.LocalPlayer
                      if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then                 
                      player.Character.HumanoidRootPart.CFrame = CFrame.new(5695.01123046875, 174.5264434814453, 631.5857543945312)
                    end
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                until not _G.AutoCollectMeteor
            end)
        end
    end
end)

Tabs.AutomaticTab:Paragraph({
    Title = "[📦] Bait Crate",
})

Tabs.AutomaticTab:Dropdown({
    Title = "Choose Bait Crate",
    Values = { "Common Crate", "Bait Crate", "Carbon Crate", "Quality Bait Crate", "Volcanic Geode", "Coral Geode" },
    Value = "",
    Callback = function(Value)
    _G.ChooseBaitCrate = Value
end
})

Tabs.AutomaticTab:Toggle({
    Title = "Auto Open Bait Crate",
    Desc = "Automaticy open a the box bait crate.",
    Default = false,
    Callback = function(Value)
    _G.AutoOpenBaitCrate = Value
 end
})

spawn(function()
    while wait(.1) do
        if _G.ChooseBaitCrate == "Common Crate" and _G.AutoOpenBaitCrate then
            pcall(function()
                repeat task.wait(0.01)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                if v.Name == "Common Crate" then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                 end
                end
                game:GetService'VirtualUser':CaptureController()
                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                until not _G.AutoOpenBaitCrate
            end)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if _G.ChooseBaitCrate == "Bait Crate" and _G.AutoOpenBaitCrate then
            pcall(function()
                repeat task.wait(0.01)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                if v.Name == "Bait Crate" then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                 end
                end
                game:GetService'VirtualUser':CaptureController()
                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                until not _G.AutoOpenBaitCrate
            end)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if _G.ChooseBaitCrate == "Carbon Crate" and _G.AutoOpenBaitCrate then
            pcall(function()
                repeat task.wait(0.01)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                if v.Name == "Carbon Crate" then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                 end
                end
                game:GetService'VirtualUser':CaptureController()
                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                until not _G.AutoOpenBaitCrate
            end)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if _G.ChooseBaitCrate == "Quality Bait Crate" and _G.AutoOpenBaitCrate then
            pcall(function()
                repeat task.wait(0.01)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                if v.Name == "Quality Bait Crate" then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                 end
                end
                game:GetService'VirtualUser':CaptureController()
                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                until not _G.AutoOpenBaitCrate
            end)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if _G.ChooseBaitCrate == "Volcanic Geode" and _G.AutoOpenBaitCrate then
            pcall(function()
                repeat task.wait(0.01)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                if v.Name == "Volcanic Geode" then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                 end
                end
                game:GetService'VirtualUser':CaptureController()
                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                until not _G.AutoOpenBaitCrate
            end)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if _G.ChooseBaitCrate == "Coral Geode" and _G.AutoOpenBaitCrate then
            pcall(function()
                repeat task.wait(0.01)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                if v.Name == "Coral Geode" then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                 end
                end
                game:GetService'VirtualUser':CaptureController()
                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                until not _G.AutoOpenBaitCrate
            end)
        end
    end
end)

Tabs.AutomaticTab:Paragraph({
    Title = "[🌊] Event Zone",
})

local EventZone = Tabs.AutomaticTab:Paragraph({
    Title = "[🐢] suck table check status event zone right here,",
    Desc = ""
})

task.spawn(function()
	while task.wait() do
		pcall(function()
if _G.ChooseEventZone == "Isonade"  then
			if game.Workspace.zones.fishing:FindFirstChild("Isonade") or game.Workspace.zones.fishing:FindFirstChild("Isonade") then
				EventZone:SetDesc("Table Data : [🟢]")
			else
				EventZone:SetDesc("Table Data : [❌]")
        end
			end
if _G.ChooseEventZone == "The Depths - Serpent"  then
			if game.Workspace.zones.fishing:FindFirstChild("The Depths - Serpent") or game.Workspace.zones.fishing:FindFirstChild("The Depths - Serpent") then
				EventZone:SetDesc("Table Data : [🟢]")
			else
				EventZone:SetDesc("Table Data : [❌]")
        end
			end
if _G.ChooseEventZone == "Great Hammerhead Shark"  then
			if game.Workspace.zones.fishing:FindFirstChild("Great Hammerhead Shark") or game.Workspace.zones.fishing:FindFirstChild("Great Hammerhead Shark") then
				EventZone:SetDesc("Table Data : [🟢]")
			else
				EventZone:SetDesc("Table Data : [❌]")
        end
			end
if _G.ChooseEventZone == "Great White Shark"  then
			if game.Workspace.zones.fishing:FindFirstChild("Great White Shark") or game.Workspace.zones.fishing:FindFirstChild("Great White Shark") then
				EventZone:SetDesc("Table Data : [🟢]")
			else
				EventZone:SetDesc("Table Data : [❌]")
        end
			end
if _G.ChooseEventZone == "Whale Shark"  then
			if game.Workspace.zones.fishing:FindFirstChild("Whale Shark") or game.Workspace.zones.fishing:FindFirstChild("Whale Shark") then
				EventZone:SetDesc("Table Data : [🟢]")
			else
				EventZone:SetDesc("Table Data : [❌]")
        end
			end
		end)
	end
end)

_G.ChooseEventZone  = "Isonade"
Tabs.AutomaticTab:Dropdown({
    Title = "Choose Event Zone",
    Values = { "Isonade", "The Depths - Serpent", "Great Hammerhead Shark", "Great White Shark", "Whale Shark" },
    Value = "Isonade",
    Callback = function(Value)
    _G.ChooseEventZone = Value
end
})

Tabs.AutomaticTab:Toggle({
    Title = "Auto Teleport To Event Zone",
    Desc = "Automaticy warp to event.",
    Default = false,
    Callback = function(Value)
    _G.AutoTeleportToEventZone = Value
 end
})

spawn(function()
    pcall(function()
        while wait() do          
            if _G.ChooseEventZone == "Isonade" and _G.AutoTeleportToEventZone then
                for _, zone in pairs(game.Workspace.zones.fishing:GetChildren()) do               
                    if zone.Name == "Isonade" then                      
                        local offset = Vector3.new(0, 115, 15)                                         
                        TP(CFrame.new(zone.Position + offset))
                    end
                end
            end
        end
    end)
end)

spawn(function()
    pcall(function()
        while wait() do          
            if _G.ChooseEventZone == "The Depths - Serpent" and _G.AutoTeleportToEventZone then
                for _, zone in pairs(game.Workspace.zones.fishing:GetChildren()) do               
                    if zone.Name == "The Depths - Serpent" then                      
                        local offset = Vector3.new(0, 115, 15)                                         
                        TP(CFrame.new(zone.Position + offset))
                    end
                end
            end
        end
    end)
end)

spawn(function()
    pcall(function()
        while wait() do          
            if _G.ChooseEventZone == "Great Hammerhead Shark" and _G.AutoTeleportToEventZone then
                for _, zone in pairs(game.Workspace.zones.fishing:GetChildren()) do               
                    if zone.Name == "Great Hammerhead Shark" then                      
                        local offset = Vector3.new(0, 115, 15)                                         
                        TP(CFrame.new(zone.Position + offset))
                    end
                end
            end
        end
    end)
end)

spawn(function()
    pcall(function()
        while wait() do          
            if _G.ChooseEventZone == "Great White Shark" and _G.AutoTeleportToEventZone then
                for _, zone in pairs(game.Workspace.zones.fishing:GetChildren()) do               
                    if zone.Name == "Great White Shark" then                      
                        local offset = Vector3.new(0, 115, 15)                                         
                        TP(CFrame.new(zone.Position + offset))
                    end
                end
            end
        end
    end)
end)

spawn(function()
    pcall(function()
        while wait() do          
            if _G.ChooseEventZone == "Whale Shark" and _G.AutoTeleportToEventZone then
                for _, zone in pairs(game.Workspace.zones.fishing:GetChildren()) do               
                    if zone.Name == "Whale Shark" then                      
                        local offset = Vector3.new(0, 115, 15)                                         
                        TP(CFrame.new(zone.Position + offset))
                    end
                end
            end
        end
    end)
end)

Tabs.AutomaticTab:Paragraph({
    Title = "[⛴️] Submarine",
})
spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        pcall(function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            local humanoid = character:WaitForChild("Humanoid")
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

            if _G.AutoFish or _G.AutoTeleportToEventZone or _G.AutoSubmarineQuest then
                if syn then
                     setfflag("HumanoidParallelRemoveNoPhysics", "False")
                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                    humanoid:ChangeState(11)
                  
                    if humanoid.Sit then
                        humanoid.Sit = false
                    end
                else                
                    if humanoidRootPart and not humanoidRootPart:FindFirstChild("BodyVelocity1") then                     
                        if humanoid.Sit then
                            humanoid.Sit = false
                        end                  
                        local BodyVelocity = Instance.new("BodyVelocity")
                        BodyVelocity.Name = "BodyVelocity1"
                        BodyVelocity.Parent = humanoidRootPart
                        BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end              
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            else
                if humanoidRootPart and humanoidRootPart:FindFirstChild("BodyVelocity1") then
                    humanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy()
                end
            end
        end)
    end)
end)

Tabs.AutomaticTab:Toggle({
    Title = "Auto Submarine Quest",
    Desc = "Automaticy collect obsidian and then Automaticy unlock submarine quest.",
    Default = false,
    Callback = function(Value)
    _G.AutoSubmarineQuest = Value
 end
})

spawn(function()
    while wait(0.1) do
        if _G.AutoSubmarineQuest then
            pcall(function()
                if game:GetService("ReplicatedStorage"):WaitForChild("playerstats"):WaitForChild(game:GetService("Players").LocalPlayer.Name):WaitForChild("Boats"):FindFirstChild("Submarine") then  
        WindUI:Notify({
            Title = "Submarine",
            Content = "[🔐] Unlock the Quest Succeed[Fully]",
            Icon = "droplet-off",
            Duration = 15,
        })               
                    _G.AutoSubmarineQuest = false
                else
                    if #game:GetService("ReplicatedStorage"):WaitForChild("playerstats"):WaitForChild(game:GetService("Players").LocalPlayer.Name):WaitForChild("Cache")["Submarine"].Crafted.Value:split(".") >= 5 then
                        game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("Net")["RF/Dr Glimmerfin/QuestCompleted"]:InvokeServer()
                        wait(0.5)
                    else
                        local missingPart = nil
                        for _, partName in pairs({
                            "Back Fins", "Submarine Top", "Metal Panels", "Side Fins", "Windows"
                        }) do
                            if not table.find(game:GetService("ReplicatedStorage"):WaitForChild("playerstats"):WaitForChild(game:GetService("Players").LocalPlayer.Name):WaitForChild("Cache")["Submarine"].Crafted.Value:split("."), partName) then
                                missingPart = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(partName) or game:GetService("Players").LocalPlayer.Character:FindFirstChild(partName)
                            end
                        end
                        if missingPart then
                            local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid:EquipTool(missingPart)
                            end
                            if missingPart.Parent == game:GetService("Players").LocalPlayer.Character then
                                game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("Net")["RE/SubmarineCraftService/PlacePart"]:FireServer()
                            end
                        else                         
                            local drill = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Drill") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Drill")
                            if drill then
                                if drill.Parent ~= game:GetService("Players").LocalPlayer.Character then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(drill)
                                end
                                local obsidian = nil
                                for _, obsidianObj in pairs(game.Workspace.world:WaitForChild("map")["Roslit Bay"]:FindFirstChild("Obsidians"):GetChildren()) do
                                    if obsidianObj:GetAttribute("Health") > 0 then
                                        obsidian = obsidianObj
                                        break
                                    end
                                end
                                if obsidian then
                                    local centerPart = obsidian:FindFirstChild("Center")
                                    if centerPart then
                                        local humanoidRootPart = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                        if humanoidRootPart then
                                            humanoidRootPart.CFrame = centerPart.CFrame * CFrame.new(0, 0, 7)
                                        end
                                        drill:Activate()
                                    end
                                else
                                    local humanoidRootPart = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                    if humanoidRootPart then
                                        humanoidRootPart.CFrame = CFrame.new(-1396.83447, 134.567032, 463.88974, -0.999221683, 4.04264977e-09, 0.0394458957, 5.39107292e-09, 1, 3.4077754e-08, -0.0394458957, 3.42638877e-08, -0.999221683)
                                    end
                                end
                            else                             game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("Net")["RF/Dr Glimmerfin/Talked"]:InvokeServer()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

Tabs.TeleportTab:Paragraph({
    Title = "[🏝️] Island",
})

local Islandlist = {
    "Mousewood",
    "Enchant Room",
    "Rod Crafting",
    "Roslit Bay",
    "Snowcap Island",
    "Statue",
    "Sunstone",
    "Terrapin Island",
    "Roslit Volcano",
    "Vertigo",
    "Desolate Deep",
    "Forsaken Shores",
    "The Depths",
    "Blizzard",
    "Ancient Isle",
    "Grand Reef",
    "Atlantean Storm",
    "Atlantis Island",
    "Kraken Pool",
    "Ethereal Abyss",
    "Abyssal Zenith",
    "Volcanic Vents",
    "Challengers Deep"
}

Tabs.TeleportTab:Dropdown({
    Title = "Choose Island",
    Values = Islandlist,
    Value = "",
    Callback = function(Value)
    _G.SelectIsland = Value
end
})

Tabs.TeleportTab:Button({
    Title = "Teleport To Island",
    Desc = "Automaticy teleport island position.",
    Callback = function()
local player = game.Players.LocalPlayer
if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
    if _G.SelectIsland == "Mousewood" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(411.232727, 135.103302, 224.096329, 0.992985964, 1.00463694e-07, 0.118232146, -1.01840307e-07, 1, 5.60170088e-09, -0.118232146, -1.76032078e-08, 0.992985964)
    elseif _G.SelectIsland == "Enchant Room" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(1308.7430419921875, -802.427001953125, -81.36365509033203)
    elseif _G.SelectIsland == "Rod Crafting" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-3160.3095703125, -745.4639892578125, 1682.7935791015625)
    elseif _G.SelectIsland == "Roslit Bay" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-1446.406005859375, 134.9540557861328, 702.18408203125)
    elseif _G.SelectIsland == "Snowcap Island" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(2622.982666015625, 149.70736694335938, 2406.6318359375)
    elseif _G.SelectIsland == "Statue" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-21.4614315032959, 136.5426025390625, -1128.92724609375)
    elseif _G.SelectIsland == "Sunstone" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-950.8275146484375, 141.89602661132812, -1110.8980712890625)
    elseif _G.SelectIsland == "Vertigo" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-125.87995147705078, -492.8369140625, 1003.998046875)
    elseif _G.SelectIsland == "Desolate Deep" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-1652.1475830078125, -185.40029907226562, -2878.5908203125)
    elseif _G.SelectIsland == "Forsaken Shores" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-2482.68603515625, 135.99893188476562, 1580.337646484375)
    elseif _G.SelectIsland == "The Depths" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(985.5209350585938, -700.447998046875, 1254.260986328125)
    elseif _G.SelectIsland == "Terrapin Island" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-167.29579162597656, 145.02565002441406, 1936.748291015625)
    elseif _G.SelectIsland == "Roslit Volcano" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-1888.523193359375, 167.78244018554688, 329.2409362792969)
    elseif _G.SelectIsland == "Blizzard" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-3819.39453125, 133.5209197998047, 383.2669982910156)
    elseif _G.SelectIsland == "Ancient Isle" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(5998.216796875, 242.49667358398438, 514.9320068359375)
    elseif _G.SelectIsland == "Grand Reef" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-3618.27880859375, 140.0048370361328, 502.09930419921875)
    elseif _G.SelectIsland == "Atlantean Storm" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-3868.323486328125, 153.95181274414062, 429.4833984375)
    elseif _G.SelectIsland == "Atlantis Island" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-4269.32568359375, -603.4046630859375, 1819.7086181640625)
    elseif _G.SelectIsland == "Kraken Pool" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-4311.00537109375, -1002.4795532226562, 2012.411865234375)
    elseif _G.SelectIsland == "Ethereal Abyss" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-3789.61669921875, -566.771728515625, 1851.0374755859375)
    elseif _G.SelectIsland == "Abyssal Zenith" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-13502.861328125, -11048.6884765625, 150.31800842285156)
    elseif _G.SelectIsland == "Volcanic Vents" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-3483.3388671875, -2256.806884765625, 3843.344482421875)
    elseif _G.SelectIsland == "Challengers Deep" then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-756.0162353515625, -3282.168701171875, -713.2869873046875)
    end
end
end
})

-- Configuration


local HttpService = game:GetService("HttpService")

local folderPath = "Alstra_Hub_Theme"
makefolder(folderPath)

local function SaveFile(fileName, data)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function LoadFile(fileName)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    end
end

local function ListFiles()
    local files = {}
    for _, file in ipairs(listfiles(folderPath)) do
        local fileName = file:match("([^/]+)%.json$")
        if fileName then
            table.insert(files, fileName)
        end
    end
    return files
end

Tabs.WindowTab:Section({ Title = "Window" })

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select Theme",
    Multi = false,
    AllowNone = false,
    Value = "AlstraTheme",
    Values = themeValues,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())

local ToggleTransparency = Tabs.WindowTab:Toggle({
    Title = "Toggle Window Transparency",
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

Tabs.WindowTab:Section({ Title = "Save" })

local fileNameInput = ""
Tabs.WindowTab:Input({
    Title = "Write File Name",
    PlaceholderText = "Enter file name",
    Callback = function(text)
        fileNameInput = text
    end
})

Tabs.WindowTab:Button({
    Title = "Save File",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.WindowTab:Section({ Title = "Load" })

local filesDropdown
local files = ListFiles()

filesDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select File",
    Multi = false,
    AllowNone = true,
    Values = files,
    Callback = function(selectedFile)
        fileNameInput = selectedFile
    end
})

Tabs.WindowTab:Button({
    Title = "Load File",
    Callback = function()
        if fileNameInput ~= "" then
            local data = LoadFile(fileNameInput)
            if data then
                WindUI:Notify({
                    Title = "File Loaded",
                    Content = "Loaded data: " .. HttpService:JSONEncode(data),
                    Duration = 5,
                })
                if data.Transparent then 
                    Window:ToggleTransparency(data.Transparent)
                    ToggleTransparency:SetValue(data.Transparent)
                end
                if data.Theme then WindUI:SetTheme(data.Theme) end
            end
        end
    end
})

Tabs.WindowTab:Button({
    Title = "Overwrite File",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.WindowTab:Button({
    Title = "Refresh List",
    Callback = function()
        filesDropdown:Refresh(ListFiles())
    end
})

local currentThemeName = WindUI:GetCurrentTheme()
local themes = WindUI:GetThemes()

local ThemeAccent = themes[currentThemeName].Accent
local ThemeOutline = themes[currentThemeName].Outline
local ThemeText = themes[currentThemeName].Text
local ThemePlaceholderText = themes[currentThemeName].PlaceholderText

function updateTheme()
    WindUI:AddTheme({
        Name = currentThemeName,
        Accent = ThemeAccent,
        Outline = ThemeOutline,
        Text = ThemeText,
        PlaceholderText = ThemePlaceholderText
    })
    WindUI:SetTheme(currentThemeName)
end

local CreateInput = Tabs.CreateThemeTab:Input({
    Title = "Theme Name",
    Value = currentThemeName,
    Callback = function(name)
        currentThemeName = name
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Background Color",
    Default = Color3.fromHex(ThemeAccent),
    Callback = function(color)
        ThemeAccent = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Outline Color",
    Default = Color3.fromHex(ThemeOutline),
    Callback = function(color)
        ThemeOutline = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Text Color",
    Default = Color3.fromHex(ThemeText),
    Callback = function(color)
        ThemeText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Placeholder Text Color",
    Default = Color3.fromHex(ThemePlaceholderText),
    Callback = function(color)
        ThemePlaceholderText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Button({
    Title = "Update Theme",
    Callback = function()
        updateTheme()
    end
})