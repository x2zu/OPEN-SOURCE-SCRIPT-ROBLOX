--[[#Naaellx Code]] -- Dont Skid Please I just learn lua :(
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
    
    task.delay(3, function() 
        game:GetService("ReplicatedStorage"):WaitForChild("resources", 9e9):WaitForChild("sounds", 9e9):WaitForChild("sfx", 9e9):WaitForChild("event", 9e9):WaitForChild("aurora", 9e9)
        local Message = "<font color='#BA73D3'><i>Ancestral</i></font> has been loaded!"
        game:GetService("ReplicatedStorage").events.anno_localthoughtbig:Fire(Message, nil, nil, nil, "Exotic")
    end)
    
        -- Update ukuran teks secara dinamis
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        TitleText.Size = GetResponsiveSize(0.15)
        SubText.Size = GetResponsiveSize(0.12)
        end)  
        
        -- Load UI utama Fluent
        local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Knuxy92/Ui-linoria/main/Fluent/Fluent.lua"))()
        local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
        local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
        
        local ClickButton = Instance.new("ScreenGui")
        local MainFrame = Instance.new("Frame")
        local IconLabel = Instance.new("ImageLabel")
        local TextLabel = Instance.new("TextLabel")
        local ExpandButton = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")
        local Divider = Instance.new("Frame")
        
        ClickButton.Name = "ClickButton"
        ClickButton.Parent = game.CoreGui
        ClickButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ClickButton.ResetOnSpawn = false
        
        -- Frame utama tombol (diperlebar agar tombol tidak bertabrakan)
        MainFrame.Name = "MainFrame"
        MainFrame.Parent = ClickButton
        MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        MainFrame.BackgroundTransparency = 0.3 -- Background transparan
        MainFrame.BorderSizePixel = 0
        MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
        MainFrame.Size = UDim2.new(0, 140, 0, 50) 
        MainFrame.Active = true
        MainFrame.Draggable = true
        
        -- Sudut melengkung
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = MainFrame
        
        -- UIGradient untuk efek transisi warna
        local Gradient = Instance.new("UIGradient")
        Gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(136, 77, 167)), 
            ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 80))
        }
        Gradient.Rotation = 90
        Gradient.Parent = MainFrame
        
        -- Ikon di sebelah kiri (tetap solid)
        IconLabel.Parent = MainFrame
        IconLabel.BackgroundTransparency = 1
        IconLabel.Size = UDim2.new(0, 24, 0, 24)
        IconLabel.Position = UDim2.new(0.08, 0, 0.5, -12)
        IconLabel.Image = "rbxassetid://73407780444753"
        IconLabel.ScaleType = Enum.ScaleType.Fit
        
        -- Garis pemisah (tetap solid)
        Divider.Parent = MainFrame
        Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Warna putih
        Divider.BackgroundTransparency = 0 -- Tidak transparan
        Divider.Position = UDim2.new(0.35, 0, 0.15, 0)
        Divider.Size = UDim2.new(0, 1, 0.7, 0)
        
        -- Teks subtitle "Ancestral" (diperkecil agar tidak terlalu besar)
        TextLabel.Parent = MainFrame
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(0.5, 0, 0.4, 0) -- Ukuran teks diperkecil
        TextLabel.Position = UDim2.new(0.38, 0, 0.3, 0) -- Sedikit digeser ke bawah
        TextLabel.Font = Enum.Font.GothamSemibold
        TextLabel.Text = "Ancestral"
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Tetap solid
        TextLabel.TextScaled = false
        TextLabel.TextSize = 14 -- Ukuran teks lebih kecil seperti sebelumnya
        TextLabel.TextTransparency = 0.1
        
        -- Tombol untuk perbesar/minimize (digeser lebih ke kanan agar tidak bertabrakan)
        ExpandButton.Parent = MainFrame
        ExpandButton.BackgroundTransparency = 1
        ExpandButton.Size = UDim2.new(0, 20, 0, 20)
        ExpandButton.Position = UDim2.new(0.9, -5, 0.5, -10) -- Digeser lebih ke kanan
        ExpandButton.Image = "rbxassetid://10734886735"
        ExpandButton.ScaleType = Enum.ScaleType.Fit
        
        -- Variabel untuk cek status minimize
        local isMinimized = false
        
        ExpandButton.MouseButton1Click:Connect(function()
            isMinimized = not isMinimized
        
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "LeftControl", false, game)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "LeftControl", false, game)
        
            if isMinimized then
                ExpandButton.Image = "rbxassetid://10734886735"
            else
                ExpandButton.Image = "rbxassetid://10734895698"
            end
        end)
        
    -- UI utama menggunakan Fluent
    local Window = Fluent:CreateWindow({
        Title = game:GetService("MarketplaceService"):GetProductInfo(16732694052).Name .. " 〢 Ancestral v1.0",
        SubTitle = "discord.gg/ancestral",
        TabWidth = 160,
        Size = UDim2.fromOffset(520, 400), -- Ukuran lebih kecil agar lebih responsif
        Acrylic = false,
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    print([[  
      ∧,,,∧
    (  ̳• · • ̳)
    /    づ You want my heart? Don't skid please :D
      ∧,,,∧
    (  ̳• · • ̳)
    /    づ♡ Ok here's my heart
    
    🟢 Successfully Loaded!
    ]])
        -- // // // Services // // // --
        local VirtualInputManager = game:GetService("VirtualInputManager")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local VirtualUser = game:GetService("VirtualUser")
        local HttpService = game:GetService("HttpService")
        local GuiService = game:GetService("GuiService")
        local RunService = game:GetService("RunService")
        local Workspace = game:GetService("Workspace")
        local Players = game:GetService("Players")
        local CoreGui = game:GetService('StarterGui')
        local ContextActionService = game:GetService('ContextActionService')
        local UserInputService = game:GetService('UserInputService')
        
        -- // // // Locals // // // --
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
    
        -- local shadowCountLabel = Instance.new("TextLabel", screenGui)
        local RenderStepped = RunService.RenderStepped
        local WaitForSomeone = RenderStepped.Wait
        
        -- // // // Features List // // // --
        
        -- // // // Variables // // // --
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
        
        -- // // // Functions // // // --
        function ShowNotification(String)
            Fluent:Notify({
                Title = "Ancestral",
                Content = String,
                Duration = 5
            })
        end
        
        -- // // // Tabs Gui // // // --
        local Tabs = { -- https://lucide.dev/icons/
            CharacterTab = Window:AddTab({ Title = "Character", Icon = "rbxassetid://10747373176" }),
            Config = Window:AddTab({ Title = "Config", Icon = "rbxassetid://121667411319639" }),
            Main = Window:AddTab({ Title = "Fishing", Icon = "rbxassetid://10734941354" }),
            Items = Window:AddTab({ Title = "Market", Icon = "rbxassetid://10734952273" }),
            Forge = Window:AddTab({ Title = "Forge", Icon = "rbxassetid://77943964625400" }), 
            Automatically = Window:AddTab({ Title = "Automatically", Icon = "rbxassetid://104768258304566" }),
            Event = Window:AddTab({ Title = "Event", Icon = "rbxassetid://103886955707876" }),
            Teleports = Window:AddTab({ Title = "Worlds", Icon = "rbxassetid://10709811445" }),
            Visual = Window:AddTab({ Title = "Visual", Icon = "rbxassetid://97855077268525" }), 
            Exclusives = Window:AddTab({ Title = "Exclusives", Icon = "rbxassetid://10734966248" }), 
            Misc = Window:AddTab({ Title = "Misc", Icon = "rbxassetid://10734976739" }),
        }
        local Options = Fluent.Options
        local autoCastEnabled = false
        local autoShakeEnabled = false
        local autoShakeConnection
        
        local function autoShake()
            if not autoShakeEnabled then return end 
        
            if ShakeMode == "Navigation" then
                xpcall(function()
                    local shakeui = PlayerGui:FindFirstChild("shakeui")
                    if not shakeui then return end
        
                    local safezone = shakeui:FindFirstChild("safezone")
                    local button = safezone and safezone:FindFirstChild("button")
                    if not button then return end
        
                    task.wait(0.0000000000000001) 
                    GuiService.SelectedObject = button
        
                    if GuiService.SelectedObject == button then
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                    end
        
                    task.wait(0.1)
                    GuiService.SelectedObject = nil 
                end, function(err)
                end)
        
            elseif ShakeMode == "Mouse" then
                local currentTime = tick()
                if currentTime - lastMouseShakeTime < 0.1 then return end 
                lastMouseShakeTime = currentTime
        
                xpcall(function()
                    local shakeui = PlayerGui:FindFirstChild("shakeui")
                    if not shakeui then return end
        
                    local safezone = shakeui:FindFirstChild("safezone")
                    local button = safezone and safezone:FindFirstChild("button")
                    if not button then return end
        
                    local pos = button.AbsolutePosition
                    local size = button.AbsoluteSize
                    local centerX, centerY = pos.X + size.X / 2, pos.Y + size.Y / 2
                    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, LocalPlayer, 0)
                    task.wait(0.07) 
                    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, LocalPlayer, 0)
                end, function(err)
                end)
            end
        end
        local function startAutoShake()
            if autoShakeConnection or not autoShakeEnabled then return end
            autoShakeConnection = RunService.RenderStepped:Connect(autoShake)
        end
        
        local function stopAutoShake()
            if autoShakeConnection then
                autoShakeConnection:Disconnect()
                autoShakeConnection = nil
            end
        end
        
        local autoReelEnabled = false
        local PerfectCatchEnabled = false
        local autoReelConnection
        local ReelMode = "Legit" 
        local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
        
            local section = Tabs.Main:AddSection("Auto Fishing")
            -- AutoEquip Rod
            local function getEquippedRod()
                return ReplicatedStorage.playerstats[tostring(LocalPlayer)].Stats.rod.Value
            end
            
            local function equipRod()
                local rodName = getEquippedRod()
                if rodName and not LocalPlayer.Character:FindFirstChild(rodName) then
                    local rod = LocalPlayer.Backpack:FindFirstChild(rodName)
                    if rod then
                        rod.Parent = LocalPlayer.Character
                    end
                end
            end
            
            variables = variables or {}
    
            Tabs.Main:AddToggle("autoEquip", {
                Title = "Auto Equip Rod",
                Description = "Dont use with Instant Reel [BUG]",
                Default = false,
                Callback = function(isEnabled)
                    variables.AutoEquipRod = isEnabled
                    if isEnabled then
                        Fluent:Notify({
                            Title = "[BETA] Feature",
                            Content = "Don't use/combine this feature with Instant Reel!",
                            Duration = 8
                        })
                    end
                    while variables.AutoEquipRod do
                        equipRod()
                        task.wait(0.1)
                    end
                end
            })        
            local autoCast = Tabs.Main:AddToggle("autoCast", { 
                Title = "Auto Cast", 
                Default = false, 
                Description = "Automatically casts the fishing rod"
            })
            local autoShakeToggle = Tabs.Main:AddToggle("autoShake", {
                Title = "Auto Shake",
                Default = false,
                Description = "Automatically shakes the fishing rod to attract fish",
                Callback = function(enabled)
                    autoShakeEnabled = enabled
                    if autoShakeEnabled then
                        startAutoShake()
                    else
                        stopAutoShake()
                    end
                end
            })
        local autoReelEnabled = false
        local instaReelEnabled = false
        -- AUTO RELL LEGIT
        local function StartAutoReel()
            spawn(function()
                while autoReelEnabled do
                    local reelGui = LocalPlayer.PlayerGui:FindFirstChild("reel")
                    if reelGui then
                        local bar = reelGui:FindFirstChild("bar")
                        if bar then
                            local playerBar = bar:FindFirstChild("playerbar")
                            local fish = bar:FindFirstChild("fish")
                            while bar and reelGui:IsDescendantOf(LocalPlayer.PlayerGui) do
                                RunService.RenderStepped:Wait()
                                local newPosition = playerBar.Position:Lerp(fish.Position, 0.7)
                                playerBar.Position = UDim2.fromScale(math.clamp(newPosition.X.Scale, 0.15, 0.85), newPosition.Y.Scale)
                            end
                        end
                    end
                    wait(math.random(0.1, 0.3))
                end
            end)
        end
        
        -- AUTO REEL LEGIT END
            -- AutoreelToggleLegit
            local autoReelToggle = Tabs.Main:AddToggle("autoReel", { 
                Title = "Auto Reel Legit", 
                Default = false, 
                Description = "Automatically reels in fish when hooked"
            })        
        autoReelToggle:OnChanged(function()
            autoReelEnabled = Options.autoReel.Value
            if autoReelEnabled then
                task.spawn(StartAutoReel)
            end
        end)
    -- FASTREELCODE
    local function StartFastReel()
        spawn(function()
            while Options.fastReel.Value do
                local delay = tonumber(Options.fastreeldelay.Value) or 0
                local perfectCatchChance = tonumber(Options.perfectCatchChance.Value) or 0.2
                
                task.wait(delay)
                repeat
                    task.wait()
                    local ui = LocalPlayer.PlayerGui:FindFirstChild("reel")
                    if ui and ui:FindFirstChild("bar") then
                        local b = ui:FindFirstChild("bar")
                        if b:FindFirstChild("fish") and b:FindFirstChild("playerbar") then
                            b:FindFirstChild("playerbar").Position = b:FindFirstChild("fish").Position
                        end
                        ReplicatedStorage:WaitForChild("events"):WaitForChild("reelfinished ")
                            :FireServer(100, math.random() <= perfectCatchChance)
                    end
                    if not ui then ui = false end
                until not ui
                task.wait(perfectCatchChance / 100)
            end
        end)
    end 
    -- FASTREELCODE END
    
    local autoFishSettings = Tabs.Config:AddSection("Auto Fish Settings")
    local fastReelDelayInputUI = Tabs.Config:AddInput("fastreeldelay", {
        Title = "Fast Reel Delay",
        Description = "Input 0-100 [S]",
        Default = "0",  -- Set default value as string
        Placeholder = "Enter delay in seconds",
    })
    local perfectCatchChanceInputUI = Tabs.Config:AddInput("perfectCatchChance", {
        Title = "Perfect Catch Chance",
        Description = "Input 0.1-1 [%]",
        Default = "0.2",
        Placeholder = "Enter chance (0.1-1)",
    })
        local autoCastDelayInputUI = autoFishSettings:AddInput("autocastdelay", {
            Title = "Auto Cast Delay",
            Description = "Input 0-100 [S]",
            Default = "0",  -- Set default value as string
            Placeholder = "Enter delay in seconds",
        })
        instantBobber = false
        local function StartAutoFishing()
            LocalPlayer.Character.ChildAdded:Connect(function(child)
                local rodName = ReplicatedStorage.playerstats[LocalPlayer.Name].Stats.rod.Value
                if child.Name == rodName then
                    if autoCastEnabled then
                        task.spawn(function()
                            while autoCastEnabled and LocalPlayer.Character:FindFirstChild(rodName) do
                                local Rod = LocalPlayer.Character:FindFirstChild(rodName)
                                if Rod then
                                    local randomValue = math.random(960, 989) / 10
                                    Rod.events.cast:FireServer(randomValue, 1)
                                    local Bobber = Rod:FindFirstChild("bobber")
                                    if Bobber and instantBobber then
                                        local Params = RaycastParams.new()
                                        Params.FilterType = Enum.RaycastFilterType.Include
                                        Params.FilterDescendantsInstances = { workspace.Terrain }
                                        local RaycastResult = workspace:Raycast(Bobber.Position, -Vector3.yAxis * 100, Params)
                                        if RaycastResult and RaycastResult.Instance and RaycastResult.Instance:IsA("Terrain") then
                                            if Bobber:IsA("Model") and Bobber.PrimaryPart then
                                                Bobber:SetPrimaryPartCFrame(CFrame.new(RaycastResult.Position))
                                            elseif Bobber:IsA("BasePart") then
                                                Bobber.CFrame = CFrame.new(RaycastResult.Position)
                                            end
                                        end
                                    end
                                    game:GetService("RunService").Heartbeat:Wait() 
                                end
                            end
                        end)
                    end
                end
            end)    
        end
        
        autoCast:OnChanged(function()
            autoCastEnabled = Options.autoCast.Value
            if autoCastEnabled then
                StartAutoFishing()
            end
        end)
    
        -- Fast Reel Toggle
        local fastReelToggle = Tabs.Main:AddToggle("fastReel", { 
            Title = "Fast Reel", 
            Default = false, 
            Description = "Allowing you to catch fish faster than usual"
        })
        fastReelToggle:OnChanged(function()
            if Options.fastReel.Value then
                task.spawn(StartFastReel)
            end
        end)
    -- Auto Shake Mode Dropdown
    local section = Tabs.Config:AddSection("Mode Shake")
    local autoShakeMode = Tabs.Config:AddDropdown("autoShakeMode", {
        Title = "Auto Shake Mode",
        Values = {"Navigation"},
        Multi = false,
        Default = ShakeMode,
    })
    
        local FishingToggle = Tabs.Main:AddToggle("FishingToggle", {
            Title = "Instant Reel",
            Description = "Enable Fast Reel To Working",
            Default = false
        })
        FishingToggle:OnChanged(function(value)         
            isFishing = value
            while isFishing do
                local rodName = ReplicatedStorage.playerstats[LocalPlayer.Name].Stats.rod.Value
                local reel
                local startTime = tick()
                while not reel and tick() - startTime < 10 do
                    reel = PlayerGui and PlayerGui:FindFirstChild("reel")
                    task.wait(0.1)
                end
                if reel then
                    reel:Destroy()
                    LocalPlayer.Character.Humanoid:UnequipTools()
                    task.wait(0)
                    LocalPlayer.Character.Humanoid:EquipTool(Backpack:FindFirstChild(rodName))
                else
                    LocalPlayer.Character.Humanoid:UnequipTools()
                    task.wait(0)
                    LocalPlayer.Character.Humanoid:EquipTool(Backpack:FindFirstChild(rodName))
                end
                task.wait(2)
            end         
        end)
        task.spawn(function()
            while true do
                local player = game:GetService("Players").LocalPlayer
                if player and player.Character then
                    local rootPart = workspace:FindFirstChild(player.Character.Name)
                    if rootPart then
                        local humanoidRoot = rootPart:FindFirstChild("HumanoidRootPart")
                        if humanoidRoot then
                            for _, obj in pairs(humanoidRoot:GetChildren()) do
                                if obj:IsA("Sound") then
                                    obj:Destroy() 
                                end
                            end
                        end
                    end
                end
                task.wait(100)
            end
        end)
        
        RunService.Heartbeat:Connect(function()
            local fishUI = workspace:FindFirstChild("active")
            if fishUI then
                fishUI:Destroy()
            end
        end)
        local toggleInstantBobber = Tabs.Main:AddToggle("InstantBobber", { 
            Title = "Instant Bobber",
            Description = "Works on high UNC Executors",
            Default = false 
        })
        
        toggleInstantBobber:OnChanged(function(value)
            instantBobber = value
        end)
        local FreezeCharacter = Tabs.Main:AddToggle("FreezeCharacter", { 
            Title = "Freeze Character", 
            Default = false, 
            Description = "Prevents your character from moving"
        })    
        FreezeCharacter:OnChanged(function()
            local oldpos = HumanoidRootPart.CFrame
            FreezeChar = Options.FreezeCharacter.Value
            task.wait()
            while WaitForSomeone(RenderStepped) do
                if FreezeChar and HumanoidRootPart ~= nil then
                    task.wait()
                    HumanoidRootPart.CFrame = oldpos
                else
                    break
                end
            end
        end)
                -- AutoBalanceNuke
                local autoBalanceNukeEnabled = true
                local Connections2 = {}
                local StartMinigame
                
                Tabs.Main:AddToggle("AutoBalanceNuke", {
                    Title = "Auto Balance Nuke",
                    Description = "Automatically plays the nuke minigame",
                    Default = true,
                    Callback = function(value)
                        autoBalanceNukeEnabled = value
                
                        if autoBalanceNukeEnabled then
                            if getgc then
                                task.spawn(function()
                                    for _, v in pairs(getgc(true)) do
                                        if type(v) == "function" then
                                            local name = debug.info(v, "n")
                
                                            if name == "StartMinigame" then
                                                task.spawn(function()
                                                    -- v()
                                                end)
                
                                                StartMinigame = v
                                            elseif name == "LoopMinigame" then
                                                if debug.setupvalue then
                                                    task.spawn(function()
                                                        while autoBalanceNukeEnabled do
                                                            local success = pcall(function()
                                                                debug.setupvalue(v, 13, os.clock() - 10)
                                                            end)
                
                                                            if not success then
                                                                break
                                                            end
                
                                                            task.wait()
                                                        end
                                                    end)
                                                end
                                            end
                                        end
                                    end
                                end)
                            else
                                local LocalPlayer = game.Players.LocalPlayer
                                task.wait(1)
                                local nukeGui = LocalPlayer.PlayerGui:FindFirstChild("NukeMinigame")
                                if nukeGui then
                                    Connections2.AutoBalanceNuke = nukeGui.Center.Marker.Pointer.Frame:GetPropertyChangedSignal("AbsoluteRotation"):Connect(function()
                                        local rot = nukeGui.Center.Marker.Pointer.Frame.AbsoluteRotation
                                        if rot < -35 then
                                            VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                            VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                        elseif rot > 35 then
                                            VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                                            VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                                        end
                                    end)
                                end
                            end
                        else
                            if Connections2.AutoBalanceNuke then
                                Connections2.AutoBalanceNuke:Disconnect()
                                Connections2.AutoBalanceNuke = nil
                            end
                        end
                    end
                })
        local section = Tabs.CharacterTab:AddSection("Character")
    local function createPurpleWhiteGradient(obj)
        if obj and obj:IsA("TextLabel") then
            obj.RichText = true
            local uiGradient = Instance.new("UIGradient")
            uiGradient.Parent = obj
            uiGradient.Rotation = 90 -- Gradient dari atas ke bawah
            uiGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 255)), -- Ungu lebih terang
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) -- Putih
            }
        end
    end
    
    getgenv().name = "⭐.gg/ancestral"
    local Plr = game.Players.LocalPlayer
    
    local function ProtectIdentity()
        for _, Value in ipairs(game:GetDescendants()) do
            if Value:IsA("TextLabel") and Value.Text:find(Plr.Name) then
                Value.Text = Value.Text:gsub(Plr.Name, getgenv().name)
                Value:GetPropertyChangedSignal("Text"):Connect(function()
                    Value.Text = Value.Text:gsub(Plr.Name, getgenv().name)
                end)
                createPurpleWhiteGradient(Value)
            end
        end
    
        game.DescendantAdded:Connect(function(Value)
            if Value:IsA("TextLabel") and Value.Text:find(Plr.Name) then
                Value:GetPropertyChangedSignal("Text"):Connect(function()
                    Value.Text = Value.Text:gsub(Plr.Name, getgenv().name)
                end)
                Value.Text = Value.Text:gsub(Plr.Name, getgenv().name)
                createPurpleWhiteGradient(Value)
            end
        end)
    end
    
    local function disguisechar(char)
        task.spawn(function()
            if not char then return end
            
            -- Hapus semua aksesori, baju, celana, dan body colors
            for _, v in ipairs(char:GetChildren()) do
                if v:IsA("Accessory") or v:IsA("Clothing") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
                    v:Destroy()
                end
            end
            local parts = {
                Head = Vector3.new(2, 2, 2),
                Torso = Vector3.new(1.5, 2.5, 1),
                LeftArm = Vector3.new(0.8, 2, 0.8),
                RightArm = Vector3.new(0.8, 2, 0.8),
                LeftLeg = Vector3.new(0.8, 2, 0.8),
                RightLeg = Vector3.new(0.8, 2, 0.8)
            }
            
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") and parts[part.Name] then
                    part.Material = Enum.Material.SmoothPlastic
                    part.Size = parts[part.Name]
                    task.spawn(function()
                        while char and part.Parent == char do
                            part.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                            task.wait(0.3)
                        end
                    end)
                    
                    if part.Name == "Head" then
                        if part:FindFirstChildOfClass("SpecialMesh") then
                            part:FindFirstChildOfClass("SpecialMesh"):Destroy()
                        end
                        local decal = Instance.new("Decal", part)
                        decal.Texture = "rbxassetid://87987688628967"
                        decal.Face = Enum.NormalId.Front
                    end
                end
            end
        end)
    end
    local IdentityHiderUI = Tabs.CharacterTab:AddToggle("IdentityHiderUI", {
        Title = "Protect Identity",
        Description = "Hides your name and disguises your character",
        Default = false,
        Callback = function(state)
            if state then 
                ProtectIdentity()
                disguisechar(Plr.Character)
            end
        end
    })
        IdentityHiderUI:OnChanged(function()
            if Options.IdentityHiderUI.Value then
                ProtectIdentity()
                
                if UserPlayer:FindFirstChild("streak") then
                    UserPlayer.streak.Text = "Ancestral"
                    createPurpleWhiteGradient(UserPlayer.streak)
                end
                if UserPlayer:FindFirstChild("level") then
                    UserPlayer.level.Text = "∞"
                    createPurpleWhiteGradient(UserPlayer.level)
                end
                if UserPlayer:FindFirstChild("user") then
                    UserPlayer.user.Text = "⭐.gg/ancestral"
                    createPurpleWhiteGradient(UserPlayer.user)
                end
        
                local hud = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("hud"):WaitForChild("safezone")
                if hud:FindFirstChild("coins") then
                    hud.coins.Text = "HIDDEN"
                    createPurpleWhiteGradient(hud.coins) -- Terapkan gradient ungu-putih ke coins
                end
        
                if hud:FindFirstChild("lvl") then
                    hud.lvl.Text = "Ancestral MAX"
                    createPurpleWhiteGradient(hud.lvl)
                end
            end
        end)
        
            local WalkOnWater = Tabs.CharacterTab:AddToggle("WalkOnWater", {Title = "Walk On Water", Default = false })
            WalkOnWater:OnChanged(function()
                for i,v in pairs(workspace.zones.fishing:GetChildren()) do
                    if v.Name == WalkZone then
                        v.CanCollide = Options.WalkOnWater.Value
                        if v.Name == "Ocean" then
                            for i,v in pairs(workspace.zones.fishing:GetChildren()) do
                                if v.Name == "Deep Ocean" then
                                    v.CanCollide = Options.WalkOnWater.Value
                                end
                            end
                        end
                    end
                end
            end)
            local WalkOnWaterZone = Tabs.CharacterTab:AddDropdown("WalkOnWaterZone", {
                Title = "Walk On Water Zone",
                Values = {"Ocean", "Desolate Deep", "The Depths"},
                Multi = false,
                Default = "Ocean",
            })
            WalkOnWaterZone:OnChanged(function(Value)
                WalkZone = Value
            end)
            local WalkSpeedToggle = Tabs.CharacterTab:AddToggle("WalkSpeedToggle", {
                Title = "Enable Walk Speed",
                Default = false,
            })
            
            local WalkSpeedInputUI = Tabs.CharacterTab:AddInput("WalkSpeedInputUI", {
                Title = "Walk Speed",
                Default = "16",
                Placeholder = "Enter walk speed",
            })
            
            WalkSpeedToggle:OnChanged(function(enabled)
                if enabled then
                    local walkSpeed = tonumber(WalkSpeedInputUI.Value)
                    if walkSpeed then
                        LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
                    end
                else
                    LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- Reset ke default
                end
            end)
            
            WalkSpeedInputUI:OnChanged(function(value)
                if WalkSpeedToggle.Value then
                    local walkSpeed = tonumber(value)
                    if walkSpeed then
                        LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
                    end
                end
            end)
            
            local JumpHeightToggle = Tabs.CharacterTab:AddToggle("JumpHeightToggle", {
                Title = "Enable Jump Height",
                Default = false,
            })
            
            local JumpHeightInputUI = Tabs.CharacterTab:AddInput("JumpHeightInputUI", {
                Title = "Jump Height",
                Default = "50",
                Placeholder = "Enter jump height",
            })
            
            JumpHeightToggle:OnChanged(function(enabled)
                if enabled then
                    local jumpPower = tonumber(JumpHeightInputUI.Value)
                    if jumpPower then
                        LocalPlayer.Character.Humanoid.JumpPower = jumpPower
                    end
                else
                    LocalPlayer.Character.Humanoid.JumpPower = 50 -- Reset ke default
                end
            end)
            
            JumpHeightInputUI:OnChanged(function(value)
                if JumpHeightToggle.Value then
                    local jumpPower = tonumber(value)
                    if jumpPower then
                        LocalPlayer.Character.Humanoid.JumpPower = jumpPower
                    end
                end
            end)
        -- Noclip
            local ToggleNoclip = Tabs.CharacterTab:AddToggle("ToggleNoclip", {Title = "Noclip", Default = false })
            ToggleNoclip:OnChanged(function()
                Noclip = Options.ToggleNoclip.Value
            end)
        -- // // // Noclip Stepped // // // --
        NoclipConnection = RunService.Stepped:Connect(function()
            if Noclip == true then
                if LocalCharacter ~= nil then
                    for i, v in pairs(LocalCharacter:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide == true then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)
        Tabs.CharacterTab:AddToggle("InfiniteOxygen", {Title = "Infinite Oxygen", Default = true}):OnChanged(function(m)
            local character = LocalPlayer.Character
            if m then
                local divingTank = Instance.new("Glue")
                divingTank.Name = "DivingTank"
                divingTank:SetAttribute("Tier", 9e9)
                divingTank.Parent = character
            else
                local existingTank = character:FindFirstChild("DivingTank")
                if existingTank then
                    existingTank:Destroy()
                end
            end
        end)
        local BypassRadar = Tabs.CharacterTab:AddToggle("BypassRadar", {Title = "Bypass Fish Radar", Default = false })
        BypassRadar:OnChanged(function()
            for _, v in pairs(game:GetService("CollectionService"):GetTagged("radarTag")) do
                if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                    v.Enabled = Options.BypassRadar.Value
                end
            end
        end)
        Tabs.CharacterTab:AddToggle("AntiDrown", {
            Title = "Disable Temperature",
            Default = false,
            Description = "",
            Callback = function(isEnabled)
                local temperature = LocalPlayer.Character:FindFirstChild("client") and LocalPlayer.Character.client:FindFirstChild("temperature")
                -- print("Temperature Object:", temperature)
                if isEnabled then
                    if temperature then
                        -- print("Connecting to Temperature")
                        temperature.Disabled = true
                        temperatureConnection = temperature.Changed:Connect(function()
                            -- print("Temperature Changed - Disabled:", temperature.Disabled)
                            temperature.Disabled = true
                        end)
                    end
                else
                    if temperatureConnection then
                        -- print("Disconnecting Temperature connection")
                        temperatureConnection:Disconnect()
                        temperature.Enabled = true
                    end
                end
            end,
        })
        --[[#Naaellx Code]]
        local section = Tabs.Teleports:AddSection("NPC Teleport")
    -- Menemukan folder NPC di dalam world
    local NpcFolder = Workspace:FindFirstChild("world"):WaitForChild("npcs")
    local npcList = {}
    local npcPositions = {}
    
    -- Menambahkan NPC yang ditemukan di dalam game
    for _, npc in pairs(NpcFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            table.insert(npcList, npc.Name)
            npcPositions[npc.Name] = npc.HumanoidRootPart.Position
        end
    end
    
    -- Menambahkan NPC manual
    local npcData = {
        {name = "Marc Merchant", position = Vector3.new(466, 151, 224)},
        {name = "Appraiser", position = Vector3.new(453.182, 150.5, 206.909)},
        {name = "Merlin", position = Vector3.new(-928.033, 223.7, -998.745)},
        {name = "Jack Marrow", position = Vector3.new(-2829.856, 212.093, 1517.44)},
        {name = "Mods Lantern Keeper", position = Vector3.new(-39, -247, 196)},
        {name = "Terrapin Shipwright", position = Vector3.new(5869.422, 143.498, 7.101)}
    }
    
    for _, npc in pairs(npcData) do
        table.insert(npcList, npc.name)
        npcPositions[npc.name] = npc.position
    end
    
    -- Pastikan npcList terurut alfabetis
    table.sort(npcList, function(a, b)
        return a:lower() < b:lower()
    end)
    
    -- Dropdown untuk memilih NPC tujuan teleportasi
    local NpcTPDropdownUI = Tabs.Teleports:AddDropdown("NpcTPDropdownUI", {
        Title = "NPC Teleport",
        Values = npcList,
        Multi = false,
        Default = nil,
    })
    
    -- Input untuk mencari NPC
    Tabs.Teleports:AddInput("NpcSearchBox", {
        Title = "Search NPC",
        Default = "",
        Placeholder = "Type to search...",
        Numeric = false,
        Callback = function(value)
            -- Filter daftar NPC berdasarkan input
            local filteredNPCs = {}
            for _, npc in ipairs(npcList) do
                if npc:lower():find(value:lower()) then
                    table.insert(filteredNPCs, npc)
                end
            end
    
            -- Perbarui dropdown dengan hasil filter
            NpcTPDropdownUI:SetValues(filteredNPCs)
        end
    })
    
    -- Fungsi teleportasi ke NPC yang dipilih
    local function teleportToNPC(Value)
        if Value and HumanoidRootPart then
            xpcall(function()
                local targetPosition = npcPositions[Value]
                if targetPosition then
                    HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
                    NpcTPDropdownUI:SetValue(nil) -- Reset dropdown setelah teleportasi
                else
                    warn("NPC position not found!")
                end
            end, function(err)
                warn("Teleport Error: ", err)
            end)
        end
    end
    
    -- Tombol teleport jika menggunakan touchscreen
    if game:GetService("UserInputService").TouchEnabled then
        Tabs.Teleports:AddButton({
            Title = "Teleport To NPC",
            Callback = function()
                teleportToNPC(NpcTPDropdownUI.Value)
            end
        })
    else
        NpcTPDropdownUI:OnChanged(teleportToNPC)
    end
    local section = Tabs.Teleports:AddSection("Island Teleport")
    for i, v in pairs(TpSpotsFolder:GetChildren()) do
        if table.find(teleportSpots, v.Name) == nil then
            table.insert(teleportSpots, v.Name)
        end
    end
    
    table.sort(teleportSpots, function(a, b)
        return a:lower() < b:lower()
    end)
    
    local filteredSpots = teleportSpots
    local IslandTPDropdownUI = Tabs.Teleports:AddDropdown("IslandTPDropdownUI", {
        Title = "Island Teleport",
        Values = filteredSpots,
        Multi = false,
        Default = nil,
    })
    
    -- Input untuk mencari lokasi teleportasi
    Tabs.Teleports:AddInput("SearchBox", {
        Title = "Search Island",
        Default = "",
        Placeholder = "Type to search...",
        Numeric = false,
        Callback = function(value)
            -- Filter daftar teleportasi berdasarkan input
            filteredSpots = {}
            for _, spot in ipairs(teleportSpots) do
                if spot:lower():find(value:lower()) then
                    table.insert(filteredSpots, spot)
                end
            end
    
            -- Perbarui dropdown dengan hasil filter
            IslandTPDropdownUI:SetValues(filteredSpots)
        end
    })
    
    -- Fungsi untuk teleport ke lokasi yang dipilih
    local function teleportToSelection(Value)
        if Value and HumanoidRootPart then
            xpcall(function()
                local target = TpSpotsFolder:FindFirstChild(Value)
                if target then
                    HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 5, 0)
                    IslandTPDropdownUI:SetValue(nil)
                end
            end, function(err)
                warn("Teleport Error: ", err)
            end)
        end
    end
    
    IslandTPDropdownUI:OnChanged(teleportToSelection)
    if game:GetService("UserInputService").TouchEnabled then
        Tabs.Teleports:AddButton({
            Title = "Teleport To Selection",
            Callback = function()
                teleportToSelection(IslandTPDropdownUI.Value)
            end
        })
    end
    local section = Tabs.Teleports:AddSection("Fishing Zone")
    local FishingZonesFolder = game:GetService("Workspace").zones.fishing
    local FishingSpots = {}
    local SeenZones = {}  
    
    for _, v in ipairs(FishingZonesFolder:GetChildren()) do
        local zoneName = v.Name
        if not SeenZones[zoneName] then  
            table.insert(FishingSpots, zoneName)
            SeenZones[zoneName] = true  
        end
    end
    
    table.sort(FishingSpots, function(a, b)
        return a:lower() < b:lower()
    end)
    
    local OriginalFishingSpots = table.clone(FishingSpots)
    
    local FishingTPDropdownUI = Tabs.Teleports:AddDropdown("FishingTPDropdownUI", {
        Title = "Fishing Zones",
        Values = FishingSpots,
        Multi = false,
        Default = nil,
    })
    
    local function teleportToSelection(zoneName)
        if zoneName then
            local targetZone = FishingZonesFolder:FindFirstChild(zoneName)
            if targetZone and targetZone:IsA("BasePart") then
                local player = game:GetService("Players").LocalPlayer
                local character = player.Character
                if character and character.PrimaryPart then
                    character:SetPrimaryPartCFrame(targetZone.CFrame)
                end
            end
        end
    end
    
    FishingTPDropdownUI:OnChanged(teleportToSelection)
    
    if game:GetService("UserInputService").TouchEnabled then
        Tabs.Teleports:AddButton({
            Title = "Teleport To Selection",
            Callback = function()
                teleportToSelection(FishingTPDropdownUI.Value)
            end
        })
    end
    
    Tabs.Teleports:AddInput("SearchBox", {
        Title = "Search Fishing Zone",
        Default = "",
        Placeholder = "Type to search...",
        Numeric = false,
        Callback = function(value)
            if value == "" then
                FishingTPDropdownUI:SetValues(OriginalFishingSpots)
            else
                local filteredSpots = {}
                for _, spot in ipairs(OriginalFishingSpots) do
                    if spot:lower():find(value:lower()) then
                        table.insert(filteredSpots, spot)
                    end
                end
                FishingTPDropdownUI:SetValues(filteredSpots)
            end
        end
    })
    
    local zoneList = {
        ["Megalodon Default"] = true, ["Megalodon Ancient"] = true, ["Great White Shark"] = false,
        ["Great Hammerhead Shark"] = false, ["Whale Shark"] = false, ["The Kraken Pool"] = true,
        ["Ancient Kraken Pool"] = true, ["Forsaken Veil - Scylla"] = true, ["Moby"] = true,
        ["Rowdy McCharm"] = true, ["O'Mango Goldgrin"] = true, ["Sunny O'Coin"] = true,
        ["Blarney McBreeze"] = true, ["Plumrick O'Luck"] = true
    }

    local autoTeleportEnabled = false
    local originalCFrame = nil
    local player = game.Players.LocalPlayer
    local floatHeight = 20 
    
    Tabs.Teleports:AddInput("FloatHeightInput", {
        Title = "Set Float Height",
        Default = tostring(floatHeight),
        Placeholder = "Enter height...",
        Numeric = true,
        Callback = function(value)
            local num = tonumber(value)
            if num then
                floatHeight = math.clamp(num, 3, 50)
            end
        end
    })
    local function FloatAboveZone(zoneName)
        local character = player.Character or player.CharacterAdded:Wait()
        if not character then return end
    
        local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local Humanoid = character:FindFirstChildOfClass("Humanoid")
        if not HumanoidRootPart or not Humanoid then return end
    
        originalCFrame = HumanoidRootPart.CFrame
    
        local targetZone = FishingZonesFolder:FindFirstChild(zoneName)
        if not targetZone then return end
    
        HumanoidRootPart.CFrame = targetZone.CFrame + Vector3.new(0, floatHeight, 0)
    
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
        BodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
        BodyVelocity.Parent = HumanoidRootPart
    
        local WalkSpeedBackup = Humanoid.WalkSpeed
        local JumpPowerBackup = Humanoid.JumpPower
        Humanoid.WalkSpeed = 0
        Humanoid.JumpPower = 0
    
        autoTeleportEnabled = true
        while autoTeleportEnabled do
            task.wait(1)
        end
        BodyVelocity:Destroy()
        Humanoid.WalkSpeed = WalkSpeedBackup
        Humanoid.JumpPower = JumpPowerBackup
        if originalCFrame then
            HumanoidRootPart.CFrame = originalCFrame
        end
    end
    FishingTPDropdownUI:OnChanged(function(Value)
        if Value then
            FloatAboveZone(Value)
        end
    end)
    if game:GetService("UserInputService").TouchEnabled then
        Tabs.Teleports:AddButton({
            Title = "Teleport to Fishing Zone",
            Callback = function()
                FloatAboveZone(FishingTPDropdownUI.Value)
            end
        })
    end
    Tabs.Teleports:AddButton({
        Title = "Return to Original Position",
        Callback = function()
            autoTeleportEnabled = false
        end
    })
    
    local PlayersTeleport = Tabs.Teleports:AddSection("Player Teleport")
    local persistentPlayers = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        table.insert(persistentPlayers, v.Name)
    end
    local playerTeleportDropdown = Tabs.Teleports:AddDropdown("PlayerTeleportDropdown", {
        Title = "Player Teleport",
        Values = persistentPlayers,
        Multi = false,
        Default = nil,
    })
    
    local selectedPlayer = nil
    playerTeleportDropdown:OnChanged(function(value)
        selectedPlayer = value
    end)
    local function teleportToSelection()
        if not selectedPlayer or selectedPlayer == "" then return end
        local targetPlayer = game.Players:FindFirstChild(selectedPlayer)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    end
    Tabs.Teleports:AddButton({
        Title = "Teleport To Selection",
        Callback = function()
            teleportToSelection()
        end
    })
    
    Tabs.Teleports:AddInput("SearchBox", {
        Title = "Search Player",
        Default = "",
        Placeholder = "Type to search...",
        Numeric = false,
        Callback = function(value)
            -- Filter daftar pemain berdasarkan input
            local filteredPlayers = {}
            for _, player in ipairs(persistentPlayers) do
                if player:lower():find(value:lower()) then
                    table.insert(filteredPlayers, player)
                end
            end
    
            -- Perbarui dropdown dengan hasil filter
            playerTeleportDropdown:SetValues(filteredPlayers)
        end
    })
    game.Players.PlayerAdded:Connect(function(player)
        table.insert(persistentPlayers, player.Name)
        playerTeleportDropdown:SetValues(persistentPlayers)
    end)
    game.Players.PlayerRemoving:Connect(function(player)
        local index = table.find(persistentPlayers, player.Name)
        if index then
            table.remove(persistentPlayers, index)
            playerTeleportDropdown:SetValues(persistentPlayers)
        end
    end)
        local section = Tabs.Teleports:AddSection("Useful Feature")
        Tabs.Teleports:AddButton({
            Title = "Discover All Locations [XP]",
            Variant = "Primary",
            Callback = function()
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local success, event = pcall(function()
                    return ReplicatedStorage:WaitForChild("events"):WaitForChild("discoverlocation")
                end)
        
                if not success or not event then
                    Fluent:Notify({
                        Title = "Error",
                        Content = "Failed to find discoverlocation event!",
                        Duration = 3
                    })
                    return
                end
        
                -- Ambil semua zona/fishing zones
                local FishingZonesFolder = game:GetService("Workspace").zones.fishing
                local FishingZones = {}
        
                for _, zone in pairs(FishingZonesFolder:GetChildren()) do
                    if zone:IsA("Model") then
                        table.insert(FishingZones, zone.Name)  -- Menambahkan nama zona ke tabel FishingZones
                    end
                end
        
                -- Daftar lokasi lainnya
                local Locations = {
                    ["The Depths"] = {}, ["Roslit"] = {}, ["Ancient Isle"] = {}, ["Sunstone"] = {}, ["Volcanic Vents"] = {},
                    ["Winter's Edge"] = {}, ["Frigid Cavern"] = {}, ["Atlantean Storm"] = {}, ["Abyssal Zenith"] = {}, ["Terrapin"] = {},
                    ["Ancient Archives"] = {}, ["Snowcap"] = {}, ["Glacial Grotto"] = {}, ["All"] = {}, ["Ashfall"] = {},
                    ["Overgrowth Caves"] = {}, ["Roslit Volcano"] = {}, ["Veil of the Forsaken"] = {}, ["Calm Zone"] = {}, ["Moosewood"] = {},
                    ["Vertigo"] = {}, ["FischFright"] = {}, ["Challenger's Deep"] = {}, ["Keepers Altar"] = {}, ["Ocean"] = {},
                    ["Archeological Site"] = {}, ["Cryogenic Canal"] = {}, ["Forsaken Shores"] = {}, ["Fischgiving"] = {}, ["Grand Reef"] = {},
                    ["Brine Pool"] = {}, ["Fischmas"] = {}, ["Desolate Deep"] = {}, ["Mushgrove"] = {}, ["Golden Tide"] = {}, ["Atlantis"] = {}
                }
        
                -- Gabungkan Locations dan FishingZones
                for _, zoneName in ipairs(FishingZones) do
                    Locations[zoneName] = {}
                end
        
                -- Kirimkan semua lokasi (termasuk fishing zones) ke event
                for key in pairs(Locations) do
                    event:FireServer(key)
                end
        
                -- Tampilkan notifikasi sukses
                Fluent:Notify({
                    Title = "Ancestral",
                    Content = "All Location Has Been Discover!",
                    Duration = 8
                })
            end,
        })
        local EventToggle = Tabs.Event:AddSection("Event Spawn")
        local pools = {
            ["Whales Pool"] = workspace.zones.fishing:FindFirstChild("Whales Pool"),
            ["Orcas Pool"] = workspace.zones.fishing:FindFirstChild("Orcas Pool"),
            ["Kraken Pool"] = workspace.zones.fishing:FindFirstChild("Kraken Pool"),
            ["Ancient Kraken Pool"] = workspace.zones.fishing:FindFirstChild("Ancient Kraken Pool"),
            ["Forsaken Veil - Scylla"] = workspace.zones.fishing:FindFirstChild("Forsaken Veil - Scylla")
        }
        
        local luck_zones = {}
        for _, zoneName in ipairs({
            "Plumrick O'Luck",
            "Blarney McBreeze",
            "Rowdy McCharm",
            "O'Mango Goldgrin",
            "Sunny O'Coin"
        }) do
            luck_zones[zoneName] = workspace.zones.fishing:FindFirstChild(zoneName)
        end
        
        local megalodon_pools = {
            Default = workspace.zones.fishing:FindFirstChild("Megalodon Default"),
            Ancient = workspace.zones.fishing:FindFirstChild("Megalodon Ancient"),
            Phantom = workspace.zones.fishing:FindFirstChild("Megalodon Phantom")
        }
        
        local function getStatus(obj)
            return obj and "1" or "0"
        end
        
        local function updateEventStatus()
            local success, errorMessage = pcall(function()
                local eventStatus = ""
        
                for name, obj in pairs(pools) do
                    eventStatus = eventStatus .. string.format("%s: %s\n", name, getStatus(obj))
                end
        
                for name, obj in pairs(megalodon_pools) do
                    eventStatus = eventStatus .. string.format("Megalodon %s: %s\n", name, getStatus(obj))
                end
        
                for name, obj in pairs(luck_zones) do
                    eventStatus = eventStatus .. string.format("%s: %s", name, getStatus(obj))
                end
        
                if eventParagraph then
                    eventParagraph:Destroy()
                end
        
                eventParagraph = Tabs.Event:AddParagraph({
                    Title = "STATUS EVENT",
                    Content = eventStatus
                })
                print("[SUCCESS] Event status updated successfully.")
            end)
        
            if not success then
                warn("[ERROR] Failed to update event status: " .. errorMessage)
            end
        end
        
        task.spawn(function()
            while true do
                updateEventStatus()
                task.wait(5) 
            end
        end)        
    _G.SelectedTarget = nil
    _G.Hunting = false
    
    local LuckZones = {
        "Plumrick O'Luck",
        "Blarney McBreeze",
        "Rowdy McCharm",
        "O'Mango Goldgrin",
        "Sunny O'Coin"
    }
    
    local TargetList = {
        "Megalodon Default",
        "Megalodon Ancient",
        "Megalodon Phantom",
        "Forsaken Veil - Scylla",
        "Kraken Pool",
        "Ancient Kraken Pool",
        "Orcas Pool",
        "Whales Pool",
        unpack(LuckZones) -- Menambahkan zona keberuntungan ke dalam TargetList
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
                    local heightOffset = table.find(LuckZones, _G.SelectedTarget) and 20 or 74
                    local target_pos = CFrame.new(Target.CFrame.Position + Vector3.new(0, heightOffset, 0))
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target_pos
                end
            end
        end
    })        
    local SummonEvent = Tabs.Event:AddSection("Summon Event")
    Tabs.Event:AddToggle("SummonPhantomMeg", {
        Title = "Summon Phantom Megalodon",
        Default = false,
        Callback = function(Value)
            _G.Summon_Phantom = Value
        end
    })
    Tabs.Event:AddToggle("SummonWhales", {
        Title = "Summon Whales",
        Default = false,
        Callback = function(Value)
            _G.Summon_Whale = Value
        end
    })
    local EventNotif = Tabs.Event:AddSection("Info Event")
    
            local rodsFolder = game:GetService("ReplicatedStorage").resources.items.rods
            local event = game:GetService("ReplicatedStorage").events.purchase
        -- Mengumpulkan nama semua pancingan dalam folder
        local rodNames = {}
        for _, rod in pairs(rodsFolder:GetChildren()) do
            if rod:IsA("Folder") then
                table.insert(rodNames, rod.Name)
            end
        end
        local section = Tabs.Items:AddSection("Rod Shop")
        -- Dropdown untuk memilih pancingan
        local RodDropdown = Tabs.Items:AddDropdown("RodSelection", {
            Title = "Select a Rod",
            Description = "Choose a fishing rod from the shop to purchase.", 
            Values = rodNames,
            Multi = false,
            Default = nil,
        })
        
        Tabs.Items:AddButton({
            Title = "Buy Selected Rod",
            Description = "Click this button to purchase the selected fishing rod.", 
            Callback = function()
                local selectedRod = RodDropdown.Value
                if selectedRod then
                    event:FireServer(selectedRod, "Rod", nil, 1)
                else
                    warn("No Rod selected!")
                end
            end
        })
        local section = Tabs.Items:AddSection("Items Shop")
        -- Mengumpulkan daftar item dari folder
        local itemsFolder = game:GetService("ReplicatedStorage"):FindFirstChild("resources") 
            and game:GetService("ReplicatedStorage").resources:FindFirstChild("items") 
            and game:GetService("ReplicatedStorage").resources.items:FindFirstChild("items")
        
        local itemNames = {}
        
        if itemsFolder then
            for _, item in pairs(itemsFolder:GetChildren()) do
                if item:IsA("Folder") then
                    table.insert(itemNames, item.Name)
                end
            end
        else
            warn("Items folder not found")
        end
        
        -- Input jumlah item yang ingin dibeli
        local BuyAmountInput = Tabs.Items:AddInput("BuyAmountInput", {
            Title = "Amount to Buy",
            Default = "1",
            Placeholder = "Enter amount...",
            Numeric = true
        })
        
        -- Dropdown untuk memilih item
        local ItemDropdown = Tabs.Items:AddDropdown("ItemSelection", {
            Title = "Select an Item",
            Description = "Choose an item from the shop to purchase.", -- Deskripsi ditambahkan
            Values = itemNames,
            Multi = false,
            Default = nil,
        })
        
        -- Tombol untuk membeli item yang dipilih
        Tabs.Items:AddButton({
            Title = "Buy Selected Item",
            Description = "Click this button to purchase the selected item from the shop.", -- Deskripsi ditambahkan
            Callback = function()
                local selectedItem = ItemDropdown.Value
                local selectedAmount = tonumber(BuyAmountInput.Value) or 1
                
                if selectedItem then
                    game:GetService("ReplicatedStorage").events.purchase:FireServer(selectedItem, "Item", nil, selectedAmount)
                else
                    warn("No item selected!")
                end
            end
        })
            local section = Tabs.Items:AddSection("Merlin's Shop")
            local BuyAmountInput = Tabs.Items:AddInput("BuyAmountInput", {
                Title = "Amount to Buy",
                Default = "1",
                Placeholder = "Enter amount...",
                Numeric = true
            })
            Tabs.Items:AddButton({
                Title = "Buy Enchant Relic",
                Description = "View 11,000C$/1",
                Callback = function()
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local amount = tonumber(BuyAmountInput.Value) or 1
            
                    local previousPosition = character.HumanoidRootPart.Position
                    local targetPosition = Vector3.new(-931.5254516601562, 223.78355407714844, -986.8485717773438)
                    character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
            
                    local merlin = workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Merlin"):WaitForChild("Merlin"):WaitForChild("power")
                    
                    for i = 1, amount do
                        merlin:InvokeServer()
                    end
            
                    character:SetPrimaryPartCFrame(CFrame.new(previousPosition))
                end
            })
            
            Tabs.Items:AddButton({
                Title = "Buy Luck Upgrade",
                Description = "Need 5,000C$/1",
                Callback = function()
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local amount = tonumber(BuyAmountInput.Value) or 1
            
                    local previousPosition = character.HumanoidRootPart.Position
                    local targetPosition = Vector3.new(-931.525, 223.784, -986.849)
                    character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
            
                    local merlinLuck = workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Merlin"):WaitForChild("Merlin"):WaitForChild("luck")
                    
                    for i = 1, amount do
                        merlinLuck:InvokeServer()
                    end
            
                    character:SetPrimaryPartCFrame(CFrame.new(previousPosition))
                end
            })
        variables = variables or {} 
        
        local section = Tabs.Forge:AddSection("Trade Feature")
        -- Functions
        local selectedPlayer = ""
        local currentPlayerList = {}
        local Options = {}
        getgenv().giftloop = false
        getgenv().autoconfirm = false
        
        local function UpdatePlayerList()
            local newPlayerList = {}
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player then
                    table.insert(newPlayerList, player.Name)
                end
            end
            currentPlayerList = newPlayerList
            if Options.PlayerSelect then
                Options.PlayerSelect:SetValues(newPlayerList)
            end
        end
        
        local function TradeEquipped()
            if selectedPlayer == "" then
                Fluent:Notify({
                    Title = "[Error] Ancestral",
                    Content = "Select a player first!",
                    Duration = 3
                })
                return
            end
        
            local targetPlayer = Players:FindFirstChild(selectedPlayer)
            if targetPlayer then
                local equippedTool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                if equippedTool and equippedTool:FindFirstChild("offer") then
                    equippedTool.offer:FireServer(targetPlayer)
                else
                    Fluent:Notify({
                        Title = "[Error] Ancestral",
                        Content = "Hold an item first!",
                        Duration = 3
                    })
                end
            end
        end
        
        local function GiftAll()
            if selectedPlayer == "" then
                Fluent:Notify({
                    Title = "[Error] Ancestral",
                    Content = "Select a player first!",
                    Duration = 3
                })
                getgenv().giftloop = false
                return
            end
        
            local targetPlayer = Players:FindFirstChild(selectedPlayer)
            if targetPlayer then
                while getgenv().giftloop do
                    for _, item in pairs(Player.Backpack:GetChildren()) do
                        if not getgenv().giftloop then break end
                        if item:FindFirstChild("offer") then
                            Player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(item)
                            wait(0.1)
                            item.offer:FireServer(targetPlayer)
                            wait(0.2)
                        end
                    end
                    wait(0.5)
                end
            end
        end
        
        local function startAutoConfirm()
            PlayerGui.hud.safezone.bodyannouncements.ChildAdded:Connect(function(child)
                if getgenv().autoconfirm and child:IsA("Frame") and child.Name == "offer" then
                    local confirmButton = child:FindFirstChild("confirm")
                    local shouldStop = false
                    
                    child.AncestryChanged:Connect(function(_, parent)
                        if not parent then shouldStop = true end
                    end)
                    
                    if confirmButton then
                        confirmButton.AncestryChanged:Connect(function(_, parent)
                            if not parent then shouldStop = true end
                        end)
                        
                        while not shouldStop and getgenv().autoconfirm do
                            if confirmButton.Visible then
                                local pos = confirmButton.AbsolutePosition
                                local size = confirmButton.AbsoluteSize
                                local x = pos.X + size.X / 2
                                local y = pos.Y + size.Y / 2 + 58
                                
                                VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, Player, 0)
                                VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, Player, 0)
                            end
                            task.wait(0.01)
                        end
                    end
                end
            end)
        end
        
        -- Gifting Tab Elements
        Options.PlayerSelect = Tabs.Forge:AddDropdown("PlayerSelect", {
            Title = "Select Player",
            Values = {},
            Multi = false,
            Default = "",
            Callback = function(Value)
                selectedPlayer = Value
            end
        })
        
        Tabs.Forge:AddButton({
            Title = "Refresh Player List",
            Callback = UpdatePlayerList
        })
        
        Tabs.Forge:AddToggle("AutoGift", {
            Title = "Auto Send All Items",
            Default = false,
            Callback = function(Value)
                getgenv().giftloop = Value
                if Value then
                    spawn(GiftAll)
                end
            end
        })
        
        Tabs.Forge:AddButton({
            Title = "Send Equipped Fish",
            Callback = TradeEquipped
        })
        
        Tabs.Forge:AddToggle("AutoConfirm", {
            Title = "Auto Accept Trade",
            Default = false,
            Callback = function(Value)
                getgenv().autoconfirm = Value
                if Value then
                    startAutoConfirm()
                end
            end
        })
    
    -- Initial Setup
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
                    local itemPrice = tonumber(FishData.Fish[item.Value].Price) * item.Stack.Value
                    if item:FindFirstChild("Mutation") and FishData.Mutations[item.Mutation.Value] then
                        itemPrice = itemPrice * tonumber(FishData.Mutations[item.Mutation.Value].PriceMultiply)
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
        local section = Tabs.Forge:AddSection("Selling")
        Tabs.Forge:AddToggle("AutoSell", {
            Title = "Auto Sell",
            Default = false,
            Description = "RE-Enable After use delay sell.",
            Callback = function(isEnabled)
                variables.autoselling = isEnabled
                if isEnabled then
                    coroutine.wrap(function()
                        while variables.autoselling do
                            pcall(function()
                                ReplicatedStorage.events.SellAll:InvokeServer()
                            end)
                            task.wait(variables.autoSellDelay or 60) -- Pastikan ada nilai default
                            if not variables.autoselling then break end
                        end
                    end)()
                end
            end,
        })
        Tabs.Forge:AddToggle("AutoSellHand", {
            Title = "Auto Sell Held Item",
            Default = false,
            Description = "Be smart to use this.",
            Callback = function(isEnabled)
                variables.autosellingHand = isEnabled
                while isEnabled do
                    ReplicatedStorage.events.Sell:InvokeServer()
                    task.wait()
                end
            end,
        })
        Tabs.Forge:AddInput("Auto Sell Delay", {
            Title = "Auto Sell Delay [S]",
            Description = "",
            Default = "60",
            Numeric = true,
            Callback = function(value)
                variables.autoSellDelay = tonumber(value) or 60
            end,
        })
        Tabs.Forge:AddButton({
            Title = "Sell All",
            Variant = "Primary",
            Callback = function()
                ReplicatedStorage.events.SellAll:InvokeServer()
            end,
        })
        
        Tabs.Forge:AddButton({
            Title = "Sell Hand",
            Variant = "Primary",
            Callback = function()
                ReplicatedStorage.events.Sell:InvokeServer()
            end,
        })
        local AutoTotem = Tabs.Automatically:AddSection("Auto Totem")

        -- Function to determine the time of day (Daytime or Nighttime)
        local function getTimeOfDay()
            local time = os.date("!*t")
            local hour = time.hour
            if hour >= 6 and hour < 18 then
                return "Daytime"
            else
                return "Nighttime"
            end
        end
        
        -- Function to check if it's night (6pm to 6am)
        local function isNighttime()
            local timeOfDay = game.Lighting:GetMinutesAfterMidnight() / 60
            return timeOfDay >= 18 or timeOfDay < 6
        end
        
        -- Dropdown for selecting a day totem
        Tabs.Automatically:AddDropdown("ChooseDayTotem", {
            Title = "Choose Day Totem",
            Values = { "Sundial Totem", "Aurora Totem", "Tempest Totem", "Smokescreen Totem", "Windset Totem", "Eclipse Totem", "Meteor Totem", "Blizzard Totem", "Avalanche Totem", "Zeus Storm Totem", "Poseidon's Wrath Totem" },
            Default = nil,
            Multi = false,
            Callback = function(selectedTotem)
                _G.ChooseDayTotem = selectedTotem
            end
        })
        
        -- Toggle for automatically using the day totem
        Tabs.Automatically:AddToggle("AutoUseDayTotem", {
            Title = "Auto Use Day Totem",
            Description = "Automatically uses selected Totem during the day.",
            Default = false,
            Callback = function(isEnabled)
                _G.AutoUseDayTotem = isEnabled
            end
        })
        
        -- Dropdown for selecting a night totem
        Tabs.Automatically:AddDropdown("ChooseNightTotem", {
            Title = "Choose Night Totem",
            Values = { "Sundial Totem", "Aurora Totem", "Tempest Totem", "Smokescreen Totem", "Windset Totem", "Eclipse Totem", "Meteor Totem", "Blizzard Totem", "Avalanche Totem", "Zeus Storm Totem", "Poseidon's Wrath Totem" },
            Default = nil,
            Multi = false,
            Callback = function(selectedTotem)
                _G.ChooseNightTotem = selectedTotem
            end
        })
        
        -- Toggle for automatically using the night totem
        Tabs.Automatically:AddToggle("AutoUseNightTotem", {
            Title = "Auto Use Night Totem",
            Description = "Automatically uses selected Totem during the night.",
            Default = false,
            Callback = function(isEnabled)
                _G.AutoUseNightTotem = isEnabled
            end
        })
        
        -- Function to use the selected totem
        local function useTotem(totemName)
            pcall(function()
                for _, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == totemName then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
                game:GetService('VirtualUser'):CaptureController()
                game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
            end)
        end
        
        -- Heartbeat connection to check time and auto-use totems
        game:GetService("RunService").Heartbeat:Connect(function()
            -- Check if it's daytime and auto-use the selected day totem
            if getTimeOfDay() == "Daytime" and _G.AutoUseDayTotem then
                if _G.ChooseDayTotem then
                    print("Using Day Totem:", _G.ChooseDayTotem)
                    useTotem(_G.ChooseDayTotem)
                end
            -- Check if it's nighttime and auto-use the selected night totem
            elseif isNighttime() and _G.AutoUseNightTotem then
                if _G.ChooseNightTotem then
                    print("Using Night Totem:", _G.ChooseNightTotem)
                    useTotem(_G.ChooseNightTotem)
                end
            end
        end)        
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

-- Function to check if it's night
local function isNighttime()
    local timeOfDay = game.Lighting:GetMinutesAfterMidnight() / 60
    return timeOfDay >= 18 or timeOfDay < 6
end

local function autoUseTotem(totemName, isNight)
    spawn(function()
        while wait(0.1) do
            if (_G["Choose" .. totemName .. "Totem"] == totemName) and _G.AutoUseTotem then
                if isNight then
                    -- Handle night totem logic
                    pcall(function()
                        repeat task.wait(0.01)
                        for _, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                            if v.Name == totemName then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                            end
                        end
                        game:GetService('VirtualUser'):CaptureController()
                        game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                    end)
                elseif not isNight then
                    -- Handle day totem logic
                    pcall(function()
                        repeat task.wait(0.01)
                        for _, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                            if v.Name == totemName then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                            end
                        end
                        game:GetService('VirtualUser'):CaptureController()
                        game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
                    until not _G.AutoUseTotem
                    end)
                end
            end
        end
    end)
end

-- Call the function for all totems
local totems = { "Sundial", "Aurora", "Tempest", "Smokescreen", "Windset", "Eclipse", "Meteor", "Blizzard", "Avalanche", "Zeus Storm", "Poseidon's Wrath" }

-- Get current time (day or night)
local isNight = isNighttime()

for _, totem in ipairs(totems) do
    autoUseTotem(totem, isNight)
end

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
        Tabs.Automatically:AddToggle("AutoCollectMeteor", {
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
        local AutoSubmarine = Tabs.Automatically:AddSection("Auto Quest")
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
        
        Tabs.Automatically:AddToggle("AutoSubmarineQuest", {
            Title = "Auto Submarine Quest",
            Description = "Automatically collect obsidian and then unlock the submarine quest.",
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
                            Fluent:Notify({
                                Title = "Submarine",
                                Content = "[🔐] Unlock the Quest Succeeded [Fully]",
                                Duration = 15,
                            })               
                            _G.AutoSubmarineQuest = false
                        else
                            if #game:GetService("ReplicatedStorage"):WaitForChild("playerstats"):WaitForChild(game:GetService("Players").LocalPlayer.Name):WaitForChild("Cache")["Submarine"].Crafted.Value:split(".") >= 5 then
                                game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("Net")["RF/Dr Glimmerfin/QuestCompleted"]:InvokeServer()
                                wait(0.5)
                            else
                                local missingPart = nil
                                for _, partName in pairs({"Back Fins", "Submarine Top", "Metal Panels", "Side Fins", "Windows"}) do
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
                                                humanoidRootPart.CFrame = CFrame.new(-1396.83447, 134.567032, 463.88974)
                                            end
                                        end
                                    else                             
                                        game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("Net")["RF/Dr Glimmerfin/Talked"]:InvokeServer()
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
        Tabs.Automatically:AddToggle("AutoUseFillionaire", {
            Title = "Auto Use Fillionaire",
            Description = "Automatically puzzle the Fillionaire.",
            Default = false,
            Callback = function(Value)
                _G.AutoUseFillionaire = Value
            end
        })
        
        spawn(function()
            while wait(0.1) do
                if _G.AutoUseFillionaire then
                    pcall(function()
                        local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid:UnequipTools()
                            local Fillionaire = game.Players.LocalPlayer.Backpack:FindFirstChild("Fillionaire")
                            if Fillionaire then
                                local FillionaireLink = tostring(Fillionaire.link.Value)
                                local FillionaireAmount = game:GetService("ReplicatedStorage").playerstats[game.Players.LocalPlayer.Name].Inventory[FillionaireLink].Stack.Value
                                for _ = 1, FillionaireAmount do
                                    humanoid:EquipTool(Fillionaire)
                                end
                            end                 
                            task.wait(1)
        
                            local mainGui = game.Players.LocalPlayer.PlayerGui.Fillionaire.Main                  
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
        local AutoSubmarine = Tabs.Automatically:AddSection("Automatic")
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
        Tabs.Automatically:AddDropdown("ChooseBaitCrate", {
            Title = "Choose Bait Crate",
            Values = { "Common Crate", "Bait Crate", "Carbon Crate", "Quality Bait Crate", "Volcanic Geode", "Coral Geode" },
            Value = "",
            Callback = function(Value)
                _G.ChooseBaitCrate = Value
            end
        })
        
        Tabs.Automatically:AddToggle("AutoOpenBaitCrate", {
            Title = "Auto Open Bait Crate",
            Description = "Automatically open a bait crate.",
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
        
        local section = Tabs.Forge:AddSection("Treasure")
        Tabs.Forge:AddButton({
            Title = "Teleport to Jack Marrow",
            Callback = function()
                HumanoidRootPart.CFrame = CFrame.new(-2824.359, 214.311, 1518.130)
            end
        })
        Tabs.Forge:AddButton({
            Title = "Repair Map",
            Callback = function()
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                    if v.Name == "Treasure Map" then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                        workspace.world.npcs["Jack Marrow"].treasure.repairmap:InvokeServer()
                    end
                end
            end
        })
        Tabs.Forge:AddButton({
            Title = "Collect Treasure",
            Callback = function()
                for i, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if v.ClassName == "ProximityPrompt" then
                        v.HoldDuration = 0
                    end
                end
                for i, v in pairs(workspace.world.chests:GetDescendants()) do
                    if v:IsA("Part") and v:FindFirstChild("ChestSetup") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        for _, v in pairs(workspace.world.chests:GetDescendants()) do
                            if v.Name == "ProximityPrompt" then
                                fireproximityprompt(v)
                            end
                        end
                        task.wait(1)
                    end 
                end
            end
        })
            -- // Exclusives Tab // --
        local sectionExclus = Tabs.Exclusives:AddSection("Exclusives Feature")
        local PromptButtonHoldBegan = nil
        
        local InstantPPToggle = sectionExclus:AddToggle("InstantProximityPrompt", {
            Title = "Instant Interact NPC",
            Default = false,
            Description = "Instant Interact triggers Proximity Prompts instantly.",
            Callback = function(isEnabled)
                if isEnabled then
                    if fireproximityprompt then
                        PromptButtonHoldBegan = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
                            fireproximityprompt(prompt)
                        end)
                    else
                        Fluent:Notify({
                            Title = "Incompatible Exploit",
                            Content = "Your exploit does not support this feature (missing fireproximityprompt)",
                            Duration = 8
                        })
                        InstantPPToggle:Set(false)
                    end
                else
                    if PromptButtonHoldBegan then
                        PromptButtonHoldBegan:Disconnect()
                        PromptButtonHoldBegan = nil
                    end
                end
            end
        })    
        local section = Tabs.Visual:AddSection("Visual Feature")
        Tabs.Visual:AddButton({
            Title = "Change Sky & Name Changer",
            Description = "You can change the sky and & name in here.",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/isMoons/loader/refs/heads/main/AncestralSecond.lua'))()
                
                -- Notifikasi setelah script dieksekusi
                Fluent:Notify({
                    Title = "Ancestral-Universal",
                    Content = "Has been loaded!",
                    Duration = 8
                })
            end
        })
        Tabs.Visual:AddButton({
            Title = "Custom Color [PC]",
            Description = "You can change the color of the sky to any color you want.",
            Callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/isMoons/loader/main/CustomObfuscated.lua'))()
                
                -- Notifikasi setelah script dieksekusi
                Fluent:Notify({
                    Title = "Ancestral-Universal",
                    Content = "Has been loaded!",
                    Duration = 8
                })
            end
        })
        
        local section = Tabs.Misc:AddSection("Misc Feature")
        Tabs.Misc:AddButton({
            Title = "Redeem All Codes",
            Description = "Redeem all active Fisch codes.",
            Variant = "Primary",
            Callback = function()
                local activeCodes = {
                    "THEKRAKEN", "RFG", "CARBON", "SORRYGUYS", "ATLANTEANSTORM",
                    "GOLDENTIDE", "GOODBYEFISCHMAS", "NewYear", "1BVisits", "RRG", "NorthernExpedition"
                }
                for _, code in ipairs(activeCodes) do
                    ReplicatedStorage:WaitForChild("events"):WaitForChild("runcode"):FireServer(code)
                end
            end,
        })
        Tabs.Misc:AddButton({
            Title = "Instant Die",
            Description = "Click if you want die",
            Variant = "Primary",
            Callback = function()
                ReplicatedStorage:WaitForChild("events"):WaitForChild("drown"):FireServer(0)     
            end,
        })
        Tabs.Misc:AddButton({
            Title = "Copy Coordinat",
            Description = "Copy to see your Coordinat",
            Callback = function()
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local XYZ = player.Character.HumanoidRootPart.Position
                    local coordString = string.format("game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(%f, %f, %f)", XYZ.X, XYZ.Y, XYZ.Z)
                    
                    -- Menyalin koordinat ke clipboard
                    setclipboard(coordString)
                    
                    -- Menampilkan notifikasi
                    Fluent:Notify({
                        Title = "Ancestral",
                        Content = "Coordinates copied to clipboard!",
                        Duration = 8
                    })
                else
                    Fluent:Notify({
                        Title = "Error",
                        Content = "Failed to get coordinates!",
                        Duration = 5
                    })
                end
            end
        })
        spawn(function()
            while true do
                game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("afk"):FireServer(false)
                task.wait(0.01)
            end
        end)
        local ServerFeature = Tabs.Misc:AddSection("Server Feature")
        local ServerHop = Tabs.Misc:AddButton({
            Title = "Low-Server",
            Description = "Join a old server low player in the same game.",
            Callback = function()
                HopToServer()
            end
        })
        
        function HopToServer()
            local placeId = game.PlaceId
            local visitedServers = {}
            local nextCursor = ""
            local currentHour = os.date("!*t").hour
        
            function FindNewServer()
                local serverList
                if nextCursor == "" then
                    serverList = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
                else
                    serverList = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. nextCursor))
                end
        
                if serverList.nextPageCursor then
                    nextCursor = serverList.nextPageCursor
                end
        
                for _, server in pairs(serverList.data) do
                    local canJoin = true
                    local serverId = tostring(server.id)
        
                    if server.maxPlayers > server.playing then
                        for _, visited in pairs(visitedServers) do
                            if serverId == tostring(visited) then
                                canJoin = false
                            end
                        end
        
                        if canJoin then
                            table.insert(visitedServers, serverId)
                            wait()
                            pcall(function()
                                game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, serverId, game.Players.LocalPlayer)
                            end)
                            wait()
                        end
                    end
                end
            end
        
            function TryFindServer()
                while wait() do
                    pcall(function()
                        FindNewServer()
                        if nextCursor ~= "" then
                            FindNewServer()
                        end
                    end)
                end
            end
        
            TryFindServer()
        end    
        local RejoinServer = Tabs.Misc:AddButton({
            Title = "Rejoin Server",
            Description = "",
            Callback = function()
                game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
            end
        })
        -- Input field for Job ID
    local JobInput = Tabs.Misc:AddInput("JobInput", {
        Title = "Job ID",
        Default = "",
        Placeholder = "Paste Job ID Here",
        Numeric = false,
        Finished = false,
        Callback = function(input)
            _G.JobID = input
        end
    })
    
    -- Button to join a specific Job ID
    local JoinJobButton = Tabs.Misc:AddButton({
        Title = "Join Job ID",
        Description = "Join a specific server using Job ID.",
        Callback = function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _G.JobID, game.Players.LocalPlayer)
        end
    })
    local CopyJobIDButton = Tabs.Misc:AddButton({
        Title = "Copy Job ID",
        Description = "Copy the current server's Job ID to clipboard.",
        Callback = function()
            local jobId = tostring(game.JobId) 
            setclipboard(jobId)
            Fluent:Notify({
                Title = "Success",
                Content = "Copied Job ID: " .. jobId,
                Duration = 5
            })
        end
    })

    local Rejoin = Tabs.Misc:AddToggle("Rejoin", {Title = "Auto-Rejoin", Default = true})
    Rejoin:OnChanged(function(enabled)
        if enabled then
            _G.AutoRejoin = true
            getgenv().RejoinConnection = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
                if child.Name == "ErrorPrompt" and child:FindFirstChild("MessageArea") and child.MessageArea:FindFirstChild("ErrorFrame") then
                    game:GetService("TeleportService"):Teleport(game.PlaceId)
                end
            end)
        else
            _G.AutoRejoin = false
            if getgenv().RejoinConnection then
                getgenv().RejoinConnection:Disconnect()
                getgenv().RejoinConnection = nil
            end
        end
    end)
    local ToggleMisc = Tabs.Misc:AddSection("UI Feature")
        local AntiAFK = Tabs.Misc:AddToggle("AntiAFK", {Title = "Anti-AFK", Default = true})
        AntiAFK:OnChanged(function(m)
            if m then
                local virtualUser = game:GetService("VirtualUser")
                LocalPlayer.Idled:Connect(function()
                    virtualUser:CaptureController()
                    virtualUser:ClickButton2(Vector2.new())
                end)
            end
        end)
        local JustUI = Tabs.Misc:AddToggle("JustUI", {Title = "SHOW/HIDE UI", Default = true })
        JustUI:OnChanged(function()
            local BlackShow = JustUI.Value
            if BlackShow then
                PlayerGui.hud.safezone.Visible = true
            else
                PlayerGui.hud.safezone.Visible = false
            end
        end)
        local FpsBoost = Tabs.Misc:AddSection("FPS Boost")
        local terrain, lighting, settingsService = workspace.Terrain, game:GetService("Lighting"), settings()
        local defaultProps = {
            terrain = { WaterWaveSize = terrain.WaterWaveSize, WaterWaveSpeed = terrain.WaterWaveSpeed, WaterReflectance = terrain.WaterReflectance, WaterTransparency = terrain.WaterTransparency },
            lighting = { GlobalShadows = lighting.GlobalShadows, FogEnd = lighting.FogEnd, Brightness = lighting.Brightness },
            quality = settingsService.Rendering.QualityLevel
        }
        local storedGameElements, terrainClearConnection, genv = {}, nil, genv or {}
        
        Tabs.Misc:AddToggle("ClearTerrain", {
            Title = "Clear All Terrain [Improve FPS]", Default = false,
            Description = "Optimizes terrain, lighting, and game elements for better FPS",
            Callback = function(isEnabled)
                genv.clearTerrainToggle = isEnabled
                if terrainClearConnection then terrainClearConnection:Disconnect() end
                
                if isEnabled then
                    terrainClearConnection = game:GetService("RunService").RenderStepped:Connect(function()
                        for _, v in pairs(terrain:GetChildren()) do v.Parent = nil end
                        terrain.WaterWaveSize, terrain.WaterWaveSpeed, terrain.WaterReflectance, terrain.WaterTransparency = 0, 0, 0, 1
                    end)
                    lighting.GlobalShadows, lighting.FogEnd, lighting.Brightness = false, 1e9, 0
                    settingsService.Rendering.QualityLevel = "Level01"
                    
                    for _, obj in pairs(game:GetDescendants()) do
                        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                            storedGameElements[obj] = { Material = obj.Material, Reflectance = obj.Reflectance, CastShadow = obj.CastShadow }
                            obj.Material, obj.Reflectance, obj.CastShadow = "SmoothPlastic", 0, false
                        elseif obj:IsA("Decal") then
                            storedGameElements[obj] = { Transparency = obj.Transparency }
                            obj.Transparency = 1
                        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                            storedGameElements[obj] = { Lifetime = obj.Lifetime }
                            obj.Lifetime = NumberRange.new(0)
                        elseif obj:IsA("Fire") or obj:IsA("SpotLight") or obj:IsA("Smoke") then
                            storedGameElements[obj] = { Enabled = obj.Enabled }
                            obj.Enabled = false
                        end
                    end
                    for _, effect in pairs(lighting:GetChildren()) do
                        if effect:IsA("PostEffect") or effect:IsA("DepthOfFieldEffect") then
                            storedGameElements[effect] = { Enabled = effect.Enabled }
                            effect.Enabled = false
                        end
                    end
                else
                    for prop, value in pairs(defaultProps.terrain) do terrain[prop] = value end
                    for prop, value in pairs(defaultProps.lighting) do lighting[prop] = value end
                    settingsService.Rendering.QualityLevel = defaultProps.quality
                    for obj, props in pairs(storedGameElements) do if obj then for prop, value in pairs(props) do obj[prop] = value end end end
                end
            end
        }) 
    Window:SelectTab(1)
    Fluent:Notify({
        Title = "Ancestral",
        Content = "Has Been Loaded!",
        Duration = 8
    })