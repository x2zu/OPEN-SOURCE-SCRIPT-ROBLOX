local function getMethodLoading()
	Tixker = tick();

    local GG = (getgenv and getgenv()) or _G or shared;
    local Iden; pcall(function() Iden = identifyexecutor(); end);
    if game:GetService("CoreGui"):FindFirstChild("InputPcToMobile") then
        pcall(function() game:GetService("CoreGui"):FindFirstChild("InputPcToMobile"):Destroy(); end);
    end;
    if not game:GetService("CoreGui"):FindFirstChild("Neu") then
        local Neu = Instance.new("ScreenGui");
        Neu.Parent = game:GetService("CoreGui");
        Neu.IgnoreGuiInset = true;
        GG["Neu"] = Neu;
    end;

    GG["NewNeu"] = true;
    task.wait(1);
    GG["NewNeu"] = false;

    if Configs == nil then
        if isfile and isfile("Neuron_Fisch.bin") then
            Configs = game:GetService('HttpService'):JSONDecode(readfile("Neuron_Fisch.bin"));
            if Configs["ESP"] == nil then
                warn("[Neuron X] : Take Over");
                Configs = {
                    ["Main"] = {
                        ["Fishing_Auto"] = {
                            ["Mode"] = "Legit"; -- Legit, Fast, Perfect
                            ["CastMode"] = "Perfect"; -- Legit, Perfect
                            ["AutoFish"] = false;
                        };
                        ["Fishing_Manual"] = {
                            ["AutoPerfect"] = false;
                            ["AutoReeling"] = false;
                        };
                        ["Shake"] = {
                            ["AutoShake"] = false;
                            ["ScaleSize"] = 1; -- Multiplier
                            ["AutoScale"] = false;
                        };
                        ["Economy"] = {
                            ["AutoSellHoldingFish"] = false;
                        };
                        ["Crate"] = {
                            ["AutoOpen"] = false;
                            ["AutoBuy"] = false;
                        };
                    };
                    ["Players"] = {
                        ["Render"] = true;
                        ["Noclip"] = false;
                        ["Float"] = false;
                        ["WalkSpeed"] = 16;
                        ["WalkSpeedToggle"] = false;
                        ["JumpPower"] = 50;
                        ["JumpPowerToggle"] = false;
                        ["FlySpeed"] = 1;
                        ["Fly"] = 60;
                        ["MaxFPSCap"] = 60;
                        ["WalkOnWater"] = false;
                        ["Freeze"] = false;
                        ["InfOxygen"] = false;
                    };
                    ["World"] = {
                        ["RecordedPosition"] = nil;
                        ["RecordCage"] = {};
                        ["Recording"] = false;
                        ["SavePosition"] = nil;
                        ["AutoBuy"] = false;
                    };
                    ["ESP"] = {
                        ["Rod"] = false;
                        ["NPC"] = false;
                    };
                };
            end;
        else
            Configs = {
                ["Main"] = {
                    ["Fishing_Auto"] = {
                        ["Mode"] = "Legit"; -- Legit, Fast, Perfect
                        ["CastMode"] = "Perfect"; -- Legit, Perfect
                        ["AutoFish"] = false;
                    };
                    ["Fishing_Manual"] = {
                        ["AutoPerfect"] = false;
                        ["AutoReeling"] = false;
                    };
                    ["Shake"] = {
                        ["AutoShake"] = false;
                        ["ScaleSize"] = 1; -- Multiplier
                        ["AutoScale"] = false;
                    };
                    ["Economy"] = {
                        ["AutoSellHoldingFish"] = false;
                    };
                    ["Crate"] = {
                        ["AutoOpen"] = false;
                        ["AutoBuy"] = false;
                    };
                };
                ["Players"] = {
                    ["Render"] = true;
                    ["Noclip"] = false;
                    ["Float"] = false;
                    ["WalkSpeed"] = 16;
                    ["WalkSpeedToggle"] = false;
                    ["JumpPower"] = 50;
                    ["JumpPowerToggle"] = false;
                    ["FlySpeed"] = 1;
                    ["Fly"] = 60;
                    ["MaxFPSCap"] = 60;
                    ["WalkOnWater"] = false;
                    ["Freeze"] = false;
                    ["InfOxygen"] = false;
                };
                ["World"] = {
                    ["RecordedPosition"] = nil;
                    ["RecordCage"] = {};
                    ["Recording"] = false;
                    ["SavePosition"] = nil;
                    ["AutoBuy"] = false;
                };
                ["ESP"] = {
                    ["Rod"] = false;
                    ["NPC"] = false;
                };
            };
        end;
    end; task.wait();

    local SData = {
        
    };

    local W = game:GetService("Workspace")
    local P = game:GetService("Players");
    local L = game:GetService("Lighting");
    local C = game:GetService("CoreGui");
    local H = game:GetService("RunService");
    local R = game:GetService("ReplicatedStorage");
    local VU = game:GetService("VirtualUser");
    local T = game:GetService("TeleportService");
    local TW = game:GetService("TweenService");
    local selff = P.LocalPlayer;
    local PSG = selff:WaitForChild("PlayerGui");
    local Backpack = selff.Backpack;
    local selc = selff.Character;
    local Cam = W:WaitForChild("Camera");
    WC = nil;
    CageRecorder = {};
    RodList = {
        "Training Rod"; "Plastic Rod"; "Carbon Rod";
        "Long Rod"; "Fast Rod"; "Lucky Rod";

        "Steady Rod"; "Fortune Rod"; "Rapid Rod"; "Magma Rod";

        "Nocturnal Rod"; "Aurora Rod"; "Rod of the Depths";

        "Kings Rod";
    };

    setc = setclipboard or toclipboard;
    tos = tostring;
    tablein = table.insert;
    tablecl = table.clear;
    print = print;
    tk = task;
    tspawn = tk.spawn;
    twait = tk.wait;
    tdelay = task.delay;
    wait = wait;
    FindFirstChild = game.FindFirstChild;
    Vec3 = Vector3.new;
    CF = CFrame.new;
    str = string;
    strgsub = str.gsub;
    strfind = str.find;
    pir = pairs;
    IsA = game.IsA;
    pcal = pcall;
    FindFirstChildOfClass = game.FindFirstChildOfClass;
    GetAttribute = game.GetAttribute;
    SetAttribute = game.SetAttribute;
    Instancen = Instance.new;
    tick = tick;
    delay = delay;
    SetPrimaryPartCFrame = W.SetPrimaryPartCFrame;
    GetPivot = W.GetPivot;
    GetDescendants = game.GetDescendants;
    GetChildren = game.GetChildren;
    FindFirstAncestorWhichIsA = game.FindFirstAncestorWhichIsA;
    FindFirstChildWhichIsA = game.FindFirstChildWhichIsA;
    PivotTo = W.PivotTo;
    GetPivot = W.GetPivot;
    WaitForChild = game.WaitForChild

    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0};

    FLYING = false;

    speedofthevfly = 1;

    speedofthefly = 1;

    local cmdm = selff:GetMouse();

    local screenGui2 = Instancen("ScreenGui"); screenGui2.Parent = game:GetService("CoreGui"); screenGui2.Name = "InputPcToMobile"; local buttonSize = UDim2.new(0.05, 0, 0.05, 0);

    local function createButton(key, position) local button = Instancen("TextButton"); button.Parent = screenGui2;
        button.Name = key; button.Text = key; button.Size = buttonSize; button.Position = position; button.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5); local isPressed = false;
        button.MouseButton1Down:Connect(function() isPressed = true; if key == "W" then CONTROL.F = Configs.Players.FlySpeed; elseif key == "S" then CONTROL.B = -Configs.Players.FlySpeed; elseif key == "A" then CONTROL.L = -Configs.Players.FlySpeed; elseif key == "D" then CONTROL.R = Configs.Players.FlySpeed end; end);
        button.MouseButton1Up:Connect(function() isPressed = false; if key == "W" then CONTROL.F = 0; elseif key == "S" then CONTROL.B = 0; elseif key == "A" then CONTROL.L = 0; elseif key == "D" then CONTROL.R = 0; end; end);
    end;

    createButton("W", UDim2.new(0.05, 0, 0.1, 0));createButton("A", UDim2.new(0, 0, 0.2, 0));createButton("S", UDim2.new(0.05, 0, 0.3, 0));createButton("D", UDim2.new(0.1, 0, 0.2, 0));
    TTJYMobileIn = game:GetService("CoreGui"):WaitForChild("InputPcToMobile");

    PlaceId = game.PlaceId;
    GameId = game.GameId;

    APISource = isfile("NeuronXS/UI_P.lua") and readfile("NeuronXS/UI_P.lua");
    if APISource then
        NothingLibrary = loadstring(APISource)();
        warn("[Neuron X] : Loaded UI_P from device and NOT github");
    else
        SourceXS = game.HttpGet(game, 'https://raw.githubusercontent.com/Yumiara/Python/refs/heads/main/Python.py');
        NothingLibrary = loadstring(SourceXS)();
        writefile("NeuronXS/UI_P.lua", SourceXS);
        warn("[Neuron X] : Loaded UI_P from github");
    end;
    local Notification = NothingLibrary.Notification();

    function dist(position)
        return selff:DistanceFromCharacter(position);
    end;

    function Tp2(xyz, int)
        if FindFirstChild(selc, "HumanoidRootPart") then
            selc.HumanoidRootPart.CFrame = xyz;
        end;
        twait(int)
    end;

    function Tp(x, y, z, int)
        if FindFirstChild(selc, "HumanoidRootPart") then
            selc.HumanoidRootPart.CFrame = CF(x, y, z);
        end;
        twait(int)
    end;

    if Iden == "Solara" then
        function FProximityPrompt()
            local unc = {
                Prompts = {};
            }
        
            local Camera = workspace.CurrentCamera;
            local Execonce = Instance.new('Part');
        
            Execonce.Anchored = true;
            Execonce.CanTouch = false;
            Execonce.CanCollide = false;
            Execonce.CanQuery = false;
            Execonce.CastShadow = false;
            Execonce.Size = Vector3.new(0.01,0.01,0.01);
            Execonce.Parent = workspace;
            Execonce.Name = 'Regisiter';
            Execonce.Transparency = 1;
        
            function unc.fireprompt(ProximityPrompt, ...)
                if not unc[ProximityPrompt] then
                    local Information = {};
                    
                    Information.HoldDuration = ProximityPrompt.HoldDuration;
                    Information.MaxActivationDistance = ProximityPrompt.MaxActivationDistance;
                    Information.RequiresLineOfSight = ProximityPrompt.RequiresLineOfSight;
                    Information.Parent = ProximityPrompt.Parent;
                    
                    unc[ProximityPrompt] = Information;
                end;
                
                local Init = function()
                    
                
                    Execonce.CFrame = Camera.CFrame * CFrame.new(0,0,-4);
                    
                    ProximityPrompt.HoldDuration = -5;
                    ProximityPrompt.MaxActivationDistance = 250;
                    ProximityPrompt.Enabled = true;
                    ProximityPrompt.RequiresLineOfSight = false;
                    ProximityPrompt.Parent = Execonce;
                    
                    local spam = task.spawn(function()
                        while true do 
                            twait(0.000001/9)
                            Execonce.CFrame = Camera.CFrame * CFrame.new(0,0,-4);
                            ProximityPrompt:InputHoldBegin();
                            
                            game:GetService('RunService').RenderStepped:Wait()
                            
                            Execonce.CFrame = Camera.CFrame * CFrame.new(0,0,-4);
                            ProximityPrompt:InputHoldEnd();
                        end;
                    end)
                    
                    ProximityPrompt.Triggered:Wait();
                    
                    repeat twait();
                        KAWKWDKDK, WDAJDUWAY2waWDW = pcal(function()
                            task.cancel(spam);
                        end);
                    until KAWKWDKDK
                    
                    local Loaded = unc[ProximityPrompt];
                    
                    ProximityPrompt.HoldDuration = Loaded.HoldDuration;
                    ProximityPrompt.MaxActivationDistance = Loaded.MaxActivationDistance;
                    ProximityPrompt.RequiresLineOfSight = Loaded.RequiresLineOfSight;
                    ProximityPrompt.Parent = Loaded.Parent;
                end;
                
                local option = {...};
                
                if typeof(option[1]) == 'number' then
                    for i=1,option[1] do
                        Init();
                    end;
                end;
            end;
        
            return unc
        end;
        GG["fireproximityprompt"] = FProximityPrompt().fireprompt;
    end;

    if GG["ESPT"] == nil then
        GG["ESPT"] = {};
    end;
    function ESP(obj, Color, Size)
        if not FindFirstChild(obj, "BoxHandleAdornment") then
            local Box = Instance.new("BoxHandleAdornment");
            Box.Color3 = Color;
            Box.AlwaysOnTop = true;
            Box.Size = Size;
            Box.Transparency = 0.5;
            Box.Adornee = obj;
            Box.ZIndex = 1;
            Box.Parent = obj;
            table.insert(GG["ESPT"], obj);
        end;
    end;
    function ClearESP()
        for _, v in pir(GG["ESPT"]) do
            if FindFirstChild(v, "BoxHandleAdornment") then
                v.BoxHandleAdornment:Destroy(true);
            end;
        end;
    end;

    function TWp(speed, posX, posY, posZ)
        local tween;
        tweenInfo = TweenInfo.new(speed, Enum.EasingStyle.Linear);
        tween = TW:Create(selff.Character.HumanoidRootPart, tweenInfo, {CFrame = CF(posX, posY, posZ)});
        tween:Play();
        tween.Completed:Wait();
    end;

    local VirtualInputManager = game:GetService('VirtualInputManager');

    function keyPress(Key, Press)
        VirtualInputManager:SendKeyEvent(Press, Key, false, game);
    end;

    local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create or find a ScreenGui to contain the frame
    local screenGui = PlayerGui:FindFirstChild("ClickIndicatorGui") or Instance.new("ScreenGui")
    screenGui.IgnoreGuiInset = true;
    screenGui.Name = "ClickIndicatorGui"
    screenGui.Parent = PlayerGui

    function showClickIndicator(position)
        -- Create the frame
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 20, 0, 20)  -- Size of the frame (20x20 pixels)
        frame.Position = UDim2.new(0, position.X, 0, position.Y)  -- Position at click
        frame.AnchorPoint = Vector2.new(0, 0)  -- Center the frame at the click
        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red color for visibility
        frame.BorderSizePixel = 0  -- No border
        frame.Parent = screenGui  -- Parent the frame to the ScreenGui
    
        -- Wait 2 seconds, then remove the frame
        task.wait(2)
        frame:Destroy()
    end

    function mousePress(LoX, LoY, PSGFramme)
        --mouseLoX = LoX;
        --mouseLoY = LoY + 30;
        --mouse1click(1, 1, Vector2.new(mouseLoX, mouseLoY), true)
        VirtualInputManager:SendMouseButtonEvent(LoX+5 , LoY +50 , 0 , true , nil , 1);
        VirtualInputManager:SendMouseButtonEvent(LoX+5 , LoY +50, 0 , false, nil , 1);
        --VirtualInputManager:SendMouseButtonEvent(mouseLoX, mouseLoY, 0, true, PSGFramme, 1);
        --VU:CaptureController();
		--VU:Button1Down(Vector2.new(mouseLoX, mouseLoY));
        --twait(0.1);
        --VU:Button1Up(Vector2.new(mouseLoX, mouseLoY));
        --VirtualInputManager:SendMouseButtonEvent(mouseLoX, mouseLoY, 0, false, PSGFramme, 1);
        --showClickIndicator(Vector2.new(mouseLoX, mouseLoY));
    end;

    function GetKuy()
        KuyYaimak = nil;
        pcal(function()
            for _, v in pir(GetChildren(selff.Character)) do
                if v and strfind(v.Name, "Rod") and v.Name ~= "RodBodyModel" then
                    KuyYaimak = v;
                    return KuyYaimak;
                end;
            end;
        end);
        return KuyYaimak;
    end;

    function GetKuyFB()
        KuyYaimak = nil;
        dd,ddd = pcal(function()
            for _, v in pir(GetChildren(selff.Backpack)) do
                if v and strfind(v.Name, "Rod") then
                    KuyYaimak = v;
                    return KuyYaimak;
                end;
            end;
        end);
        return KuyYaimak;
    end;

    function EquipeKuy()
        InvKuyFB = GetKuyFB();
        if InvKuyFB then
            PSG.hud.safezone.backpack.events.equip:FireServer(InvKuyFB);
        end;
    end;

    function OnAddedActive()
        --workspace.active.rigga5669.handle
        return W.active.ChildAdded:Connect(function(v)
            if v.Name == selff.Name then
                local handleofCage = WaitForChild(v, "handle", 5);
                tablein(Configs.World.RecordCage, handleofCage.CFrame);
            end;
        end);
    end;

    function PlayRecordCage()
        --workspace.active.rigga5669.handle
        NewSetRecordSave = Configs.World.RecordCage;
        -- This script was generated by Hydroxide's RemoteSpy: https://github.com/Upbolt/Hydroxide
        if not FindFirstChild(selff.Character, "Crab Cage") then
            if FindFirstChild(selff.Backpack, "Crab Cage") then
                PSG.hud.safezone.backpack.events.equip:FireServer(FindFirstChild(selff.Backpack, "Crab Cage"));
            else
                return Notification.new({
                    Description = "Cage Not Found";
                    Title = "Neuron X Guide";
                    Duration = 10;
                });
            end;
        end;
        warn(selff.Character , Configs.World.RecordedPosition)
        selff.Character:PivotTo(Configs.World.RecordedPosition); twait(0.3);
        for _, v in pir(NewSetRecordSave) do
            if v then
                CageCFrameToDep = v;
                if not FindFirstChild(selff.Character, "Crab Cage") then
                    if FindFirstChild(selff.Backpack, "Crab Cage") then
                        PSG.hud.safezone.backpack.events.equip:FireServer(FindFirstChild(selff.Backpack, "Crab Cage"));
                    else
                        return Notification.new({
                            Description = "Cage Not Found";
                            Title = "Neuron X Guide";
                            Duration = 10;
                        });
                    end;
                end;
                selff.Character["Crab Cage"].Deploy:FireServer(NewSetRecordSave[_]);
            end;
        end;
    end;

    function CollectAllCage()
        for _, v in pir(GetChildren(W.active)) do
            if v and v.Name == selff.Name and FindFirstChild(v, "Deployed_Crab _Cage_Server") and FindFirstChild(v, "Prompt") then
                if v.Prompt.Enabled then
                    PivotTo(selff.Character, GetPivot(v));
                    twait(0.3);
                    fireproximityprompt(v.Prompt, 1, true);
                end;
            end;
        end;
    end;

    function GetMerchant()
        for _, v in pir(GetChildren(W.world.npcs)) do
            if v and strfind(v.Name, "Merchant") then
                if FindFirstChild(v, "merchant") and FindFirstChild(v.merchant, "sellall") then
                    return v;
                end;
            end;
        end;
        return nil;
    end;

    function FetchIsland()
        --workspace.world.spawns
        return GetChildren(W.world.spawns);
    end;

    function GetHoldingFish()
        for _, v in pir(GetChildren(selff.Character)) do
            if IsA(v, "Model") and FindFirstChild(v, "offer") then
                return v;
            end;
        end;
        return nil;
    end;

    function BuyCrate()
        --workspace.world.interactables["Bait Crate"]["Bait Crate"].purchaserompt
        CrateSeller = W.world.interactables["Bait Crate"]["Bait Crate"];
        if CrateSeller then
            if dist(GetPivot(CrateSeller).Position) >= 10 then
                PivotTo(selff.Character, GetPivot(CrateSeller));
                twait(0.3);
            end;
            fireproximityprompt(CrateSeller.purchaserompt, 1, true);
            if getconnections then
                for _, v in next, getconnections(PSG.over.prompt.confirm.MouseButton1Click) do
                    v:Fire();
                end;
            end;
        end;
    end;

    function BuyCage()
        --workspace.world.interactables["Crab Cage"]["Crab Cage"].purchaserompt
        CageSeller = W.world.interactables["Crab Cage"]["Crab Cage"];
        if CageSeller then
            if dist(GetPivot(CageSeller).Position) >= 10 then
                PivotTo(selff.Character, GetPivot(CageSeller));
                twait(0.3);
            end;
            fireproximityprompt(CageSeller.purchaserompt, 1, true);
            if getconnections then
                for _, v in next, getconnections(PSG.over.prompt.confirm.MouseButton1Click) do
                    v:Fire();
                end;
            end;
        end;
    end;

    local NameTextLibrary = ""
    if Iden == "Solara" then
        NameTextLibrary = "[Solara UNC]";
        Notification.new({
            Description = "Your current Executor is Solara or Solara Skidded and may not fully support this script. You will be using custom prompt function (R)";
            Title = "Neuron X Executor";
            Duration = 10;
        });
    else
        NameTextLibrary = "[" .. tos(Iden) .. " UNC]";
    end;
    local Windows = nil;

    if Iden == "Solara" then
        Windows = NothingLibrary.new({
            Title = "Fisch " .. NameTextLibrary,
            Description = "By Neuron X",
            Keybind = Enum.KeyCode.T,
            Logo = 'http://www.roblox.com/asset/?id=80055499055359',
            Size = UDim2.new(0.100000001, 445, 0.100000001, 315),
            IsRich = true,
            RichText = string.format(
                '<font color="#FFFFFF">Fisch </font><font color="#FF0000">%s</font>', 
                NameTextLibrary
            ),
        });
    else
        Windows = NothingLibrary.new({
            Title = "Fisch " .. NameTextLibrary,
            Description = "By Neuron X",
            Keybind = Enum.KeyCode.T,
            Logo = 'http://www.roblox.com/asset/?id=80055499055359',
            Size = UDim2.new(0.100000001, 445, 0.100000001, 315),
            IsRich = true,
            RichText = string.format(
                '<font color="#FFFFFF">Fisch </font><font color="#00FF00">%s</font>', 
                NameTextLibrary
            ),
        });
    end;

    Main = Windows:NewTab({
        Title = "Main",
        Description = "",
        Icon = "rbxassetid://10723407389"
    });

    MainS1 = Main:NewSection({
        Title = "Fishing (A)",
        Icon = "rbxassetid://10709782230",
        Position = "Left"
    });

    MainS1:NewDropdown({
        Title = "Mode",
        Data = {"Legit", "Fast", "Perfect"},
        Default = Configs.Main.Fishing_Auto.Mode,
        Callback = function(a)
            Configs.Main.Fishing_Auto.Mode = a;
        end,
    });
    MainS1:NewDropdown({
        Title = "Cast Mode",
        Data = {"Legit", "Perfect"},
        Default = Configs.Main.Fishing_Auto.CastMode,
        Callback = function(a)
            Configs.Main.Fishing_Auto.CastMode = a;
        end,
    });
    MainS1:NewToggle({
        Title = "Auto Fish",
        Default = Configs.Main.Fishing_Auto.AutoFish,
        Callback = function(tr)
            Configs.Main.Fishing_Auto.AutoFish = tr;
        end,
    });

    MainS2 = Main:NewSection({
        Title = "Fishing (M)",
        Icon = "rbxassetid://10723405649",
        Position = "Right"
    });

    MainS2:NewToggle({
        Title = "Auto Perfect",
        Default = Configs.Main.Fishing_Manual.AutoPerfect,
        Callback = function(tr)
            Configs.Main.Fishing_Manual.AutoPerfect = tr;
        end,
    });
    MainS2:NewToggle({
        Title = "Auto Reeling",
        Default = Configs.Main.Fishing_Manual.AutoReeling,
        Callback = function(tr)
            Configs.Main.Fishing_Manual.AutoReeling = tr;
        end,
    });

    MainS3 = Main:NewSection({
        Title = "Shake",
        Icon = "rbxassetid://10723406480",
        Position = "Left"
    });
    MainS3:NewToggle({
        Title = "Auto Shake",
        Default = Configs.Main.Shake.AutoShake,
        Callback = function(tr)
            Configs.Main.Shake.AutoShake = tr;
        end,
    });
    MainS3:NewSlider({
        Title = "Scale Size",
        Min = 1,
        Max = 100,
        Default = Configs.Main.Shake.ScaleSize or 1,
        Callback = function(a)
            Configs.Main.Shake.ScaleSize = a;
        end,
    });
    MainS3:NewToggle({
        Title = "Auto Scale",
        Default = Configs.Main.Shake.AutoScale,
        Callback = function(tr)
            Configs.Main.Shake.AutoScale = tr;
        end,
    });

    MainS4 = Main:NewSection({
        Title = "Economy",
        Icon = "rbxassetid://10709776126",
        Position = "Left"
    });
    MainS4:NewButton({
        Title = "Sell All",
        Callback = function()
            SellMerchant = GetMerchant();
            if SellMerchant then
                SellMerchant.merchant.sellall:InvokeServer();
            end;
        end,
    });
    MainS4:NewToggle({
        Title = "Auto Sell Holding Fish",
        Default = Configs.Main.Economy.AutoSellHoldingFish,
        Callback = function(tr)
            Configs.Main.Economy.AutoSellHoldingFish = tr;
        end,
    });

    MainS5 = Main:NewSection({
        Title = "Crate",
        Icon = "rbxassetid://10709782497",
        Position = "Right"
    });
    MainS5:NewToggle({
        Title = "Auto Open",
        Default = Configs.Main.Crate.AutoOpen,
        Callback = function(tr)
            Configs.Main.Crate.AutoOpen = tr;
        end,
    });
    if Iden ~= "Solara" then
        MainS5:NewToggle({
            Title = "Auto Buy",
            Default = Configs.Main.Crate.AutoBuy,
            Callback = function(tr)
                Configs.Main.Crate.AutoBuy = tr;
            end,
        });
    else
        MainS5:NewToggle({
            Title = "Unsupported Executor (Function G)",
            Default = false,
            Callback = function(tr)
                
            end,
        });
    end;

    World = Windows:NewTab({
        Title = "World",
        Description = "",
        Icon = "rbxassetid://10734906975"
    });

    WorldS1 = World:NewSection({
        Title = "Teleport",
        Icon = "rbxassetid://10734929723",
        Position = "Left"
    });
    TargetPlaceA = nil;
    SelectPlaceDrop = WorldS1:NewDropdown({
        Title = "Select Place",
        Data = {},
        Default = "nil",
        Callback = function(a)
            TargetPlaceA = a;
        end,
    });

    WorldS1:NewButton({
        Title = "Refresh Place",
        Callback = function()
            SelectPlaceDrop.Set(FetchIsland());
        end,
    });

    WorldS1:NewButton({
        Title = "Teleport",
        Callback = function()
            TargetPlaceSpawn = FindFirstChildWhichIsA(TargetPlaceA, "Part");
            if TargetPlaceSpawn then
                Tp2(TargetPlaceSpawn.CFrame, nil);
            end;
        end,
    });

    WorldS2 = World:NewSection({
        Title = "Teleport (NPC)",
        Icon = "rbxassetid://10734929723",
        Position = "Left"
    });

    WorldS2:NewButton({
        Title = "Teleport to Sell Merchant",
        Callback = function()
            SellMerchant = GetMerchant();
            if SellMerchant then
                PivotTo(selff.Character, GetPivot(SellMerchant));
            end;
        end,
    });
    
    WorldS3 = World:NewSection({
        Title = "Island",
        Icon = "rbxassetid://10734929723",
        Position = "Right"
    });

    WorldS3:NewButton({
        Title = "Unlock All (Probably Risk)",
        Callback = function()
            IslandList = {
                "DesolateDeep";
                "Forsaken Shores";
                "Gamma Grotto";
                "Keepers Altar";
                "Moosewood";
                "Mushgrove Elevator";
                "Roslit";
                "Snowcap";
                "Statue Of Sovereignty";
                "Sunstone";
                "Vertigo";
            };
            for i=1,#IslandList do twait(0.7)
                R.events.discoverlocation:FireServer(IslandList[i]);
            end;
        end,
    });

    WorldS4 = World:NewSection({
        Title = "Cage",
        Icon = "rbxassetid://10709782582",
        Position = "Right"
    });

    if Iden ~= "Solara" then
        WorldS4:NewToggle({
            Title = "Auto Buy",
            Default = Configs.World.AutoBuy,
            Callback = function(tr)
                Configs.World.AutoBuy = tr;
            end,
        });
    else
        WorldS4:NewToggle({
            Title = "Unsupported Executor (Function G)",
            Default = false,
            Callback = function(tr)
                
            end,
        });
    end;

    WorldS4:NewButton({
        Title = "Collect All Cage",
        Callback = function()
            CollectAllCage()
        end,
    });

    RecordingConnection = nil;
    WorldS4:NewToggle({
        Title = "Record",
        Default = Configs.World.Recording,
        Callback = function(tr)
            Configs.World.Recording = tr;
            tspawn(function()
                if Configs.World.Recording then
                    if not RecordingConnection then
                        Configs.World.RecordedPosition = GetPivot(selff.Character);
                        RecordingConnection = OnAddedActive();
                    end;
                else
                    if RecordingConnection then
                        RecordingConnection:Disconnect();
                        RecordingConnection = nil;
                    end;
                end;
            end);
        end,
    });

    WorldS4:NewButton({
        Title = "Play (Patched)",
        Callback = function()
            OneRUnCall, OneRUnErr = pcal(function()
                PlayRecordCage();
            end);
            if not OneRUnCall then
                warn("[Neuron X] : Error : " .. OneRUnErr);
            end;
        end,
    });

    WorldS4:NewButton({
        Title = "Copy Nearest Cage Position",
        Callback = function()
            MaxOfCageDist = math.huge;
            CurrentObj = nil;

            for _, v in pir(GetChildren(W.active)) do
                if v and v.Name == selff.Name and FindFirstChild(v, "Deployed_Crab _Cage_Server") and FindFirstChild(v, "Prompt") and FindFirstChild(v, "handle") then
                    distanceSELFCage = dist(v.handle.Position);

                    if distanceSELFCage < MaxOfCageDist then
                        CurrentObj = v.handle;
                        MaxOfCageDist = distanceSELFCage;
                    end;
                end;
            end;
            Configs.World.SavePosition = CurrentObj.Position;
            print(Configs.World.SavePosition);
        end,
    });

    WorldS4:NewButton({
        Title = "Deploy at save (Patched)",
        Callback = function()
            selff.Character["Crab Cage"].Deploy:FireServer(Configs.World.SavePosition);
        end,
    });

    WorldS5 = World:NewSection({
        Title = "Game",
        Icon = "rbxassetid://10723395457",
        Position = "Left"
    });

    WorldS5:NewButton({
        Title = "No fog (Can't be turn off)",
        Callback = function()
            for _, v in pir(GetChildren(L)) do
                Property, hasProperty = pcal(function()
                    return v.Enabled ~= nil;
                end);
                if Property and hasProperty then
                    v.Enabled = false;
                end;
            end;
        end,
    });

    WorldS5:NewButton({
        Title = "No Rain Effect (Can't be turn off)",
        Callback = function()
            for _,v in pir(GetChildren(W.Camera.__RainEmitter)) do
                if v and not getgenv().__RainEmitter then
                    getgenv().__RainEmitter = true;
                    v:GetPropertyChangedSignal("Enabled"):Connect(function()
                        v.Enabled = false;
                    end);
                    v.Enabled = false;
                end;
            end;
        end,
    });

    WorldS5:NewDropdown({
		Title = "Graphics",
		Data ={"Compatibility"; "Future";
			"Legacy"; "ShadowMap";
			"Unified"; "Voxel"
		},
		Default = "ShadowMap",
		Callback = function(a)
			L.Technology = Enum.Technology[a];
		end,
	});

    WorldS5:NewButton({
        Title = "Trash Water",
        Callback = function()
            pcal(function()
                Teraaina = W.Terrain;
                Teraaina.CastShadow = false;
                Teraaina.Material = Enum.Material.Air;
                Teraaina.WaterColor = Color3.fromRGB(255,255,255)
                Teraaina.WaterReflectance = 0;
                Teraaina.WaterTransparency = 1;
                Teraaina.WaterWaveSize = 0;
                Teraaina.WaterWaveSpeed = 0;
            end);
        end,
    });

    WorldS6 = World:NewSection({
        Title = "Rod",
        Icon = "rbxassetid://7743869054",
        Position = "Left"
    });

    SeletcedRodToTp = nil;
    WorldS6:NewDropdown({
		Title = "Select Rod",
		Data = RodList,
		Default = "Training Rod",
		Callback = function(a)
			SeletcedRodToTp = a;
		end,
	});

    WorldS6:NewButton({
        Title = "Teleport",
        Callback = function()
            if SeletcedRodToTp ~= nil then
                if (SeletcedRodToTp == "Training Rod") or (SeletcedRodToTp == "Plastic Rod") or (SeletcedRodToTp == "Carbon Rod") or (SeletcedRodToTp == "Long Rod") or (SeletcedRodToTp == "Fast Rod") or (SeletcedRodToTp == "Lucky Rod") then
                    PivotTo(selff.Character, CF(500.488434, 147.40181, 219.991364, -0.564704418, 0, -0.825293183, 0, 1, 0, 0.825293183, 0, -0.564704418));
                elseif (SeletcedRodToTp == "Steady Rod") or (SeletcedRodToTp == "Fortune Rod") or (SeletcedRodToTp == "Rapid Rod") or (SeletcedRodToTp == "Magma Rod") then
                    PivotTo(selff.Character, CF(-1476.51147, 130.168427, 671.685303, 0, 0, -1, 0, 1, 0, 1, 0, 0));
                elseif (SeletcedRodToTp == "Nocturnal Rod") or (SeletcedRodToTp == "Aurora Rod") or (SeletcedRodToTp == "Rod of the Depths") then
                    PivotTo(selff.Character, CF(-118.308685, -488.324677, 1019.01196, -1, 0, 0, 0, 1, 0, 0, 0, -1));
                elseif (SeletcedRodToTp == "Kings Rod") then
                    PivotTo(selff.Character, CF(1294.57568, -807.365051, -307.565216, 0.0331695676, 0, 0.99944973, 0, 1, 0, -0.99944973, 0, 0.0331695676));
                end;
            end;
        end,
    });

    WorldS7 = World:NewSection({
        Title = "Teleport (Whirlpool)",
        Icon = "rbxassetid://10734898476",
        Position = "Left"
    });

    WorldS7:NewButton({
        Title = "Teleport to nearest",
        Callback = function()
            SafeWhirlPloll = FindFirstChild(W.active, "Safe Whirlpool");
            if SafeWhirlPloll then
                PivotTo(selff.Character, SafeWhirlPloll.CFrame * CF(0, 30, 0))
            end;
        end,
    });

    WorldS8 = World:NewSection({
        Title = "Boat",
        Icon = "rbxassetid://10734941354",
        Position = "Left"
    });

    SeletcedRodToTp = nil;
    SelectBoatedaDropW8 = WorldS8:NewDropdown({
		Title = "Select Boat",
		Data = {},
		Default = "nil",
		Callback = function(a)
			SeletcedRodToTp = a;
		end,
	});

    WorldS8:NewButton({
        Title = "Refresh",
        Callback = function()
            --workspace.active.boats
            NewDropW8Table = {};
            for i, v in pir(GetChildren(W.active.boats)) do
                tablein(NewDropW8Table, v);
                twait();
            end;
            SelectBoatedaDropW8.Set(NewDropW8Table);
        end,
    });

    WorldS8:NewButton({
        Title = "Teleport",
        Callback = function()
            PivotTo(selff.Character, GetPivot(FindFirstChildWhichIsA(SeletcedRodToTp, "Model")));
        end,
    });


    CFTable = {};
    CurrentName = "Fish Spot";
    SelectedWaypoint = nil;
    WorldS6 = World:NewSection({
        Title = "Waypoint",
        Icon = "rbxassetid://10734898756",
        Position = "Right"
    });
    WorldS6:NewTextbox({
        Title = "Waypoint Name",
        Default = "Fish Spot",
        FileType = "",
        Callback = function(a)
            CurrentName = a;
        end,
    });
    WorldS6:NewButton({
        Title = "Add Waypoint",
        Callback = function()
            CFTable[CurrentName] = selff.Character.HumanoidRootPart.CFrame;
        end,
    });
    SWW = WorldS6:NewDropdown({
        Title = "Select Waypoint",
        Data = {"nil"},
        Default = "nil",
        Callback = function(a)
            SelectedWaypoint = CFTable[a];
        end,
    });
    WorldS6:NewButton({
        Title = "Refresh Waypoint",
        Callback = function()
            NewCFTable = {};
            for i, v in pir(CFTable) do
                tablein(NewCFTable, i); warn(i);
                twait();
            end;
            SWW.Set(NewCFTable);
        end,
    });
    WorldS6:NewButton({
        Title = "Teleport",
        Callback = function()
            selff.Character.HumanoidRootPart.CFrame = SelectedWaypoint;
        end,
    });



    PlayersTT = Windows:NewTab({
        Title = "Player",
        Description = "",
        Icon = "rbxassetid://10747373176"
    });

    PlayersT = PlayersTT:NewSection({
        Title = "Client",
        Icon = "rbxassetid://10747371901",
        Position = "Left"
    });

    PlayersT:NewToggle({
        Title = "Render",
        Default = Configs.Players.Render,
        Callback = function(tr)
            Configs.Players.Render = tr;
        end,
    });

    PlayersT:NewToggle({
        Title = "Noclip",
        Default = Configs.Players.Noclip,
        Callback = function(tr)
            Configs.Players.Noclip = tr;
        end,
    });

    PlayersT:NewButton({
        Title = "Full Bright (Toggle)",
        Callback = function(tr)
            if not GG.FullBrightExecuted then
        
                GG.FullBrightEnabled = false
            
                GG.NormalLightingSettings = {
                    Brightness = game:GetService("Lighting").Brightness,
                    ClockTime = game:GetService("Lighting").ClockTime,
                    FogEnd = game:GetService("Lighting").FogEnd,
                    GlobalShadows = game:GetService("Lighting").GlobalShadows,
                    Ambient = game:GetService("Lighting").Ambient
                }
            
                game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
                    if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= GG.NormalLightingSettings.Brightness then
                        GG.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
                        if not GG.FullBrightEnabled then
                            repeat
                                wait()
                            until GG.FullBrightEnabled
                        end
                        game:GetService("Lighting").Brightness = 1
                    end
                end)
            
                game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
                    if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= GG.NormalLightingSettings.ClockTime then
                        GG.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
                        if not GG.FullBrightEnabled then
                            repeat
                                wait()
                            until GG.FullBrightEnabled
                        end
                        game:GetService("Lighting").ClockTime = 12
                    end
                end)
            
                game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
                    if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= GG.NormalLightingSettings.FogEnd then
                        GG.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
                        if not GG.FullBrightEnabled then
                            repeat
                                wait()
                            until GG.FullBrightEnabled
                        end
                        game:GetService("Lighting").FogEnd = 786543
                    end
                end)
            
                game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
                    if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= GG.NormalLightingSettings.GlobalShadows then
                        GG.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
                        if not GG.FullBrightEnabled then
                            repeat
                                wait()
                            until GG.FullBrightEnabled
                        end
                        game:GetService("Lighting").GlobalShadows = false
                    end
                end)
            
                game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
                    if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= GG.NormalLightingSettings.Ambient then
                        GG.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
                        if not GG.FullBrightEnabled then
                            repeat
                                wait()
                            until GG.FullBrightEnabled
                        end
                        game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                    end
                end)
            
                game:GetService("Lighting").Brightness = 1
                game:GetService("Lighting").ClockTime = 12
                game:GetService("Lighting").FogEnd = 786543
                game:GetService("Lighting").GlobalShadows = false
                game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
            
                local LatestValue = true
                spawn(function()
                    repeat
                        wait()
                    until GG.FullBrightEnabled
                    while wait() do
                        if GG.FullBrightEnabled ~= LatestValue then
                            if not GG.FullBrightEnabled then
                                game:GetService("Lighting").Brightness = GG.NormalLightingSettings.Brightness
                                game:GetService("Lighting").ClockTime = GG.NormalLightingSettings.ClockTime
                                game:GetService("Lighting").FogEnd = GG.NormalLightingSettings.FogEnd
                                game:GetService("Lighting").GlobalShadows = GG.NormalLightingSettings.GlobalShadows
                                game:GetService("Lighting").Ambient = GG.NormalLightingSettings.Ambient
                            else
                                game:GetService("Lighting").Brightness = 1
                                game:GetService("Lighting").ClockTime = 12
                                game:GetService("Lighting").FogEnd = 786543
                                game:GetService("Lighting").GlobalShadows = false
                                game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                            end
                            LatestValue = not LatestValue
                        end
                    end
                end)
            end
            
            GG.FullBrightExecuted = true
            GG.FullBrightEnabled = not GG.FullBrightEnabled
        end,
    });

    PlayersT:NewToggle({
        Title = "Float",
        Default = Configs.Players.Float,
        Callback = function(tr)
            Configs.Players.Float = tr;
        end,
    });
    PlayersT:NewSlider({
        Title = "WalkSpeed",
        Min = 1,
        Max = 300,
        Default = Configs.Players.WalkSpeed,
        Callback = function(a)
            Configs.Players.WalkSpeed = a;
        end,
    });
    PlayersT:NewToggle({
        Title = "Toggle WalkSpeed",
        Default = Configs.Players.WalkSpeedToggle,
        Callback = function(tr)
            Configs.Players.WalkSpeedToggle = tr;
            if not tr then
                if selff and selff.Character and FindFirstChild(selff.Character, "Humanoid") then
                    selff.Character.Humanoid.WalkSpeed = 46;
                end;
            end;
        end,
    });
    PlayersT:NewSlider({
        Title = "JumpPower",
        Min = 1,
        Max = 300,
        Default = Configs.Players.JumpPower,
        Callback = function(a)
            Configs.Players.JumpPower = a;
        end,
    });
    PlayersT:NewToggle({
        Title = "Toggle JumpPower",
        Default = Configs.Players.JumpPowerToggle,
        Callback = function(tr)
            Configs.Players.JumpPowerToggle = tr;
        end,
    });
    PlayersT:NewSlider({
        Title = "Fly Speed",
        Min = 1,
        Max = 10,
        Default = Configs.Players.FlySpeed,
        Callback = function(a)
            Configs.Players.FlySpeed = a;
        end,
    });
    SuperLativeKeyUp = nil;
    SuperLativeKeyDown = nil;
    PlayersT:NewToggle({
        Title = "Fly",
        Default = false,
        Callback = function(tr)
            Configs.Players.Fly = tr;
            FLYING = tr;
            local UKAWFWA, WDAKWDL = pcall(function()
                local T = selc.HumanoidRootPart;
                local SPEED = 0;
                function FLY()
                    local BG = Instancen("BodyGyro", T);
                    local BV = Instancen("BodyVelocity", T);
                    BG.P = 9e4;
                    BG.maxTorque = Vec3(9e9, 9e9, 9e9);
                    BG.cframe = T.CFrame;
                    BV.velocity = Vec3(0, 0, 0);
                    BV.maxForce = Vec3(9e9, 9e9, 9e9);
                    spawn(function()
                        while FLYING do
                            if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                                SPEED = 50;
                            elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                                SPEED = 0;
                            end;
                            if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                                BV.velocity = ((Cam.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((Cam.CoordinateFrame * CF(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0 ).p) - Cam.CoordinateFrame.p)) * SPEED
                            else
                                BV.velocity = Vec3(0, 0, 0);
                            end;
                            BG.cframe = Cam.CoordinateFrame;
                            wait();
                        end;
                        CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0};
                        SPEED = 0;
                        BG:Destroy();
                        BV:Destroy();
                        selc.Humanoid.PlatformStand = false;
                        if SuperLativeKeyDown then
                            SuperLativeKeyDown:Disconnect();
                            SuperLativeKeyDown = nil;
                        end;
                        if SuperLativeKeyUp then
                            SuperLativeKeyUp:Disconnect();
                            SuperLativeKeyUp = nil;
                        end;
                    end);
                end;
                SuperLativeKeyDown = cmdm.KeyDown:connect(function(KEY)
                    if KEY:lower() == "w" then
                        if vfly then
                            CONTROL.F = Configs.Players.FlySpeed;
                        else
                            CONTROL.F = Configs.Players.FlySpeed;
                        end
                    elseif KEY:lower() == "s" then
                        if vfly then
                            CONTROL.B = -Configs.Players.FlySpeed;
                        else
                            CONTROL.B = -Configs.Players.FlySpeed;
                        end
                    elseif KEY:lower() == "a" then
                        if vfly then
                            CONTROL.L = -Configs.Players.FlySpeed;
                        else
                            CONTROL.L = -Configs.Players.FlySpeed;
                        end;
                    elseif KEY:lower() == "d" then
                        if vfly then
                            CONTROL.R = Configs.Players.FlySpeed;
                        else
                            CONTROL.R = Configs.Players.FlySpeed;
                        end;
                    elseif KEY:lower() == "y" then
                        if vfly then
                            CONTROL.Q = Configs.Players.FlySpeed * 2;
                        else
                            CONTROL.Q = Configs.Players.FlySpeed * 2;
                        end;
                    elseif KEY:lower() == "t" then
                        if vfly then
                            CONTROL.E = -Configs.Players.FlySpeed * 2;
                        else
                            CONTROL.E = -Configs.Players.FlySpeed * 2;
                        end;
                    end;
                end);
                SuperLativeKeyUp = cmdm.KeyUp:connect(function(KEY)
                    if KEY:lower() == "w" then
                        CONTROL.F = 0;
                    elseif KEY:lower() == "s" then
                        CONTROL.B = 0;
                    elseif KEY:lower() == "a" then
                        CONTROL.L = 0;
                    elseif KEY:lower() == "d" then
                        CONTROL.R = 0;
                    elseif KEY:lower() == "y" then
                        CONTROL.Q = 0;
                    elseif KEY:lower() == "t" then
                        CONTROL.E = 0;
                    end;
                end);
                FLY();
            end);
        end,
    });

    PlayersT:NewSlider({
        Title = "Max FPS Cap",
        Min = 1,
        Max = 360,
        Default = Configs.Players.MaxFPSCap,
        Callback = function(a)
            Configs.Players.MaxFPSCap = a;
            setfpscap(a);
        end,
    });

    PlayersT2 = PlayersTT:NewSection({
        Title = "Water",
        Icon = "rbxassetid://10723397678",
        Position = "Right"
    });
    PlayersT2:NewToggle({
        Title = "Walk On Water",
        Default = Configs.Players.WalkOnWater,
        Callback = function(tr)
            Configs.Players.WalkOnWater = tr;
        end,
    });

    PlayersT3 = PlayersTT:NewSection({
        Title = "Fishing",
        Icon = "rbxassetid://10723407498",
        Position = "Right"
    });
    PlayersT3:NewToggle({
        Title = "Freeze",
        Default = Configs.Players.Freeze,
        Callback = function(tr)
            Configs.Players.Freeze = tr;
        end,
    });

    PlayersT4 = PlayersTT:NewSection({
        Title = "Oxygen",
        Icon = "rbxassetid://10723415766",
        Position = "Right"
    });
    PlayersT4:NewToggle({
        Title = "Inf Oxygen",
        Default = Configs.Players.InfOxygen,
        Callback = function(tr)
            Configs.Players.InfOxygen = tr;
            pcal(function()
                if Configs.Players.InfOxygen then
                    selff.Character.client.oxygen.Enabled = false;
                else
                    selff.Character.client.oxygen.Enabled = true;
                end;
            end);
        end,
    });

    ESPTa = Windows:NewTab({
        Title = "ESP",
        Description = "",
        Icon = "rbxassetid://10747375132"
    });

    ESPTaS1 = ESPTa:NewSection({
        Title = "Main ESP",
        Icon = "rbxassetid://10747374131",
        Position = "Left"
    });
    ESPTaS1:NewToggle({
        Title = "Rod",
        Default = Configs.ESP.Rod,
        Callback = function(tr)
            Configs.ESP.Rod = tr;
            if tr then
                for _, v in pir(GetChildren(W.world.interactables)) do
                    if v and strfind(v.Name, "Rod") then
                        ESP(v, Color3.fromRGB(0, 0, 255), Vec3(2,4,2));
                    end;
                end;
            end;
        end,
    });
    ESPTaS1:NewToggle({
        Title = "NPC",
        Default = Configs.ESP.NPC,
        Callback = function(tr)
            Configs.ESP.NPC = tr;
            if tr then
                for _, v in pir(GetChildren(W.world.npcs)) do
                    if v then
                        ESP(v, Color3.fromRGB(255, 0, 255), Vec3(3, 3, 3));
                    end;
                end;
            end;
        end,
    });
    ESPTaS1:NewButton({
        Title = "Clear All ESP",
        Callback = function()
            ClearESP();
        end,
    });

    DupeT = Windows:NewTab({
        Title = "Dupe",
        Description = "",
        Icon = "rbxassetid://10747372702"
    });

    DupeS1 = DupeT:NewSection({
        Title = "Dupe (1)",
        Icon = "rbxassetid://10747374131",
        Position = "Left"
    });
    DupeItemSelected = nil;
    DupeS1:NewButton({
        Title = "Equipe Rod",
        Callback = function()
            DupeRodding = GetKuyFB();
            if DupeRodding then
                DupeRodding.Parent = selff.Character;
            end;
        end,
    });
    DupeS1:NewTextbox({
        Title = "Item Name",
        Default = "",
        FileType = "",
        Callback = function(a)
            DupeItemSelected = a;
        end,
    });
    DupeS1:NewButton({
        Title = "Equipe Item",
        Callback = function()
            DupeIteming = FindFirstChild(selff.Backpack, DupeItemSelected);
            if DupeIteming then
                DupeIteming.Parent = selff.Character;
            end;
        end,
    });
    DupeS1:NewButton({
        Title = "Unequipe All",
        Callback = function()
            for i=1, 3 do twait(0.3);
                DupeAlling = FindFirstChildWhichIsA(selff.Character, "Tool");
                if DupeAlling then
                    DupeAlling.Parent = selff.Backpack
                end;
            end;
        end,
    });
    DupeS1:NewToggle({
        Title = "Loop Activation",
        Default = false,
        Callback = function(tr)
            tspawn(function()
                while tr do twait();
                    DupeItemming2 = FindFirstChildWhichIsA(selff.Character, "Tool");
                    if DupeItemming2 then
                        DupeItemming2:Activate();
                    end;
                end;
            end);
        end,
    });
    DupeS1:NewToggle({
        Title = "Super Fast Activation",
        Default = false,
        Callback = function(tr)
            DupeItemming2 = FindFirstChildWhichIsA(selff.Character, "Tool");
            tspawn(function()
                while tr do twait();
                    DupeItemming2 = FindFirstChildWhichIsA(selff.Character, "Tool");
                    if DupeItemming2 then
                        DupeItemming2:Activate();
                    end;
                end;
            end);
            HeartD = H.Heartbeat:Connect(function()
                if not tr then HeartD:Disconnect(); HeartD = nil; end;
                DupeItemming2 = FindFirstChildWhichIsA(selff.Character, "Tool");
                if DupeItemming2 then
                    DupeItemming2:Activate();
                end;
            end);
            RenderSD = H.RenderStepped:Connect(function()
                if not tr then RenderSD:Disconnect(); RenderSD = nil; end;
                DupeItemming2 = FindFirstChildWhichIsA(selff.Character, "Tool");
                if DupeItemming2 then
                    DupeItemming2:Activate();
                end;
            end);
            StepD = H.Stepped:Connect(function()
                if not tr then StepD:Disconnect(); StepD = nil; end;
                DupeItemming2 = FindFirstChildWhichIsA(selff.Character, "Tool");
                if DupeItemming2 then
                    DupeItemming2:Activate();
                end;
            end);
            PreRenderD = H.PreRender:Connect(function()
                if not tr then PreRenderD:Disconnect(); PreRenderD = nil; end;
                DupeItemming2 = FindFirstChildWhichIsA(selff.Character, "Tool");
                if DupeItemming2 then
                    DupeItemming2:Activate();
                end;
            end);
        end,
    });
    DupeS2 = DupeT:NewSection({
        Title = "Dupe (2) (Comming)",
        Icon = "rbxassetid://10747374131",
        Position = "Right"
    });
    DupeS2:NewButton({
        Title = "Offer yourself",
        Callback = function()
            ToolsModelero = FindFirstChildWhichIsA(selff.Character, "Tool");
            if ToolsModelero then
                ToolsModelero.offer:FireServer(selff);
            end;
        end,
    });
    if Iden ~= "Solara" then
        IsAcceptingOffer = false;
        DupeS2:NewToggle({
            Title = "Auto Accept Offer",
            Default = false,
            Callback = function(tr)
                IsAcceptingOffer = tr;
                tspawn(function()
                    while IsAcceptingOffer do
                        if FindFirstChild(PSG.hud.safezone.bodyannouncements, "offer") and FindFirstChild(PSG.hud.safezone.bodyannouncements.offer, "confirm") then
                            pcal(function()
                                for i, v in next, getconnections(PSG.hud.safezone.bodyannouncements.offer.confirm.MouseButton1Click) do
                                    v:Fire();
                                end;
                            end);
                        end;
                    end;
                end);
            end,
        });
    else
        DupeS2:NewToggle({
            Title = "Unsupported Executor (Function G)",
            Default = false,
            Callback = function(tr)
                
            end,
        });
    end;


    IgnoreF = false;
    IgnoreF2 = false;
    SystemStackDestroy = false;
    SystemConnection1 = nil;
    SystemConnection2 = nil;
    SystemConnection1 = H.Stepped:Connect(function()
        if SystemStackDestroy then SystemConnection1:Disconnect(); SystemConnection1 = nil; end;
        selff = P.LocalPlayer;
        selc = selff.Character;
        Backpack = selff.Backpack;
        if Configs.Players.Noclip then
            for _, child in pir(GetDescendants(selc)) do
                if IsA(child, "BasePart") then
                    child.CanCollide = false;
                end;
            end;
        end;
        if GG["NewNeu"] then
            SystemStackDestroy = true;
            GG["NewNeu"] = false;
        end;
    end);
    if not FindFirstChild(W, "selcRootX") then
        UFPart = Instancen("Part");
        UFPart.Size = Vec3(2, 0.2, 1.5);
        UFPart.Material = Enum.Material.Grass;
        UFPart.Anchored = true;
        UFPart.Transparency = 1;
        UFPart.Parent = W;
        UFPart.Name = "selcRootX";
    else
        UFPart = FindFirstChild(W, "selcRootX");
    end;
    if not FindFirstChild(W, "selcRootW") then
        selcRootW = Instancen("Part");
        selcRootW.Size = Vec3(3, 10, 3);
        selcRootW.Material = Enum.Material.Grass;
        selcRootW.Anchored = true;
        selcRootW.Transparency = 1;
        selcRootW.Parent = W;
        selcRootW.Name = "selcRootW";
    else
        selcRootW = FindFirstChild(W, "selcRootW");
    end; 
    twait();
    SystemConnection2 = H.RenderStepped:Connect(function()
        if SystemStackDestroy then SystemConnection2:Disconnect(); SystemConnection2 = nil; end;
        if not UFPart then
            UFPart = FindFirstChild(W, "selcRootX");
        end;
        if not selcRootW then
            selcRootW = FindFirstChild(W, "selcRootW");
        end;
        HumRSelf = selc and FindFirstChild(selc, "HumanoidRootPart");
        if UFPart and HumRSelf and (Configs.Players.Float or ForceFloat) and not NoFloat then
            UFPart.CFrame = HumRSelf.CFrame * CF(0, -3.1, 0);
        else
            UFPart.CFrame = CF(0, -10000, 0);
        end;
        if Configs.Players.JumpPowerToggle and selc and FindFirstChild(selc, "Humanoid") then
            selc.Humanoid.JumpPower = Configs.Players.JumpPower;
        end;
        if Configs.Players.WalkSpeedToggle and selc and FindFirstChild(selc, "Humanoid") then
            selc.Humanoid.WalkSpeed = Configs.Players.WalkSpeed;
        end;
        if Configs.Players.WalkOnWater then
            PivotForChar = selff.Character:GetPivot().Position;
            selcRootW.Position = Vec3(PivotForChar.X, 126.37568664550781 - 5, PivotForChar.Z);
        end;
        if Configs.Players.Freeze and not IgnoreF and not IgnoreF2 then
            selff.Character.HumanoidRootPart.Anchored = true;
        else
            selff.Character.HumanoidRootPart.Anchored = false;
        end;
        H:Set3dRenderingEnabled(Configs.Players.Render);
    end);

    tspawn(function()
        while not SystemStackDestroy do
            if FindFirstChild(selff.Character, "afk") then
                game:GetService("ReplicatedStorage").events.afk:FireServer(false);
            end;
            if Configs.Main.Shake.AutoScale then
                PSGShake = FindFirstChild(PSG, "shakeui");
                if PSGShake then
                    pcal(function()
                        PSGShake.safezone.button.Size = UDim2.new(Configs.Main.Shake.ScaleSize, PSGShake.safezone.button.Size.X.Offset, Configs.Main.Shake.ScaleSize, PSGShake.safezone.button.Size.Y.Offset)
                    end);
                end;
            end;
            twait();
            if Configs.Main.Economy.AutoSellHoldingFish then
                HoldingFishs = GetHoldingFish();
                if GetHoldingFish() then
                    SellMerchant = GetMerchant();
                    if SellMerchant then
                        SellMerchant.merchant.sell:InvokeServer();
                    end;
                end;
            end;
            if Configs.Main.Shake.AutoShake then
                PSGShake = FindFirstChild(PSG, "shakeui");
                PSGSafze = PSGShake and FindFirstChild(PSGShake, "safezone");
                PSGButtonShake = PSGSafze and FindFirstChild(PSGSafze, "button")
                PSGReel = FindFirstChild(PSG, "reel");
                SavePSGShake = UDim2.new(1.2,0,1,0);
                if PSGShake and PSGButtonShake then
                    repeat
                        aadwa, awda = pcal(function()
                            PSGReel = FindFirstChild(PSG, "reel");
                            PSGButtonShake.Position = SavePSGShake;
                            repeat twait(0); until (not PSGButtonShake or (PSGButtonShake and not PSGButtonShake.Parent)) or (not PSGShake or (PSGShake and not PSGShake.Parent) or PSGShake.safezone.button.Position == SavePSGShake) or not Configs.Main.Shake.AutoShake;
                            mousePress(PSGButtonShake.ripple.AbsolutePosition.X + (PSGButtonShake.ripple.AbsoluteSize.X / 2), PSGButtonShake.ripple.AbsolutePosition.Y + (PSGButtonShake.ripple.AbsoluteSize.Y / 2), PSGButtonShake);
                        end);
                        repeat twait(); until (not PSGButtonShake or (PSGButtonShake and not PSGButtonShake.Parent)) or (PSGReel or (PSGReel and PSGReel.Parent) or not PSGShake or (PSGShake and not PSGShake.Parent) or not Configs.Main.Shake.AutoShake) or not Configs.Main.Shake.AutoShake;
                    until (not PSGButtonShake or (PSGButtonShake and not PSGButtonShake.Parent)) or (PSGReel or (PSGReel and PSGReel.Parent) or not PSGShake or (PSGShake and not PSGShake.Parent) or not Configs.Main.Shake.AutoShake) or not Configs.Main.Shake.AutoShake;
                end;
            end;
            if Configs.Main.Fishing_Auto.AutoFish then
                IgnoreF = true;
                selff.Character.HumanoidRootPart.Anchored = false;
                FoundKuy = GetKuy();
                if not FoundKuy then
                    EquipeKuy(); twait(0.3);
                    FoundKuy = GetKuy();
                end;
                PSGReel = FindFirstChild(PSG, "reel");
                PSGShake = FindFirstChild(PSG, "shakeui");
                if not PSGReel and not PSGShake and FoundKuy then
                    pcal(function()
                        maHtA = math.random(70, 100);
                        if Configs.Main.Fishing_Auto.Mode == "Legit" then
                            twait(0.3);
                            if Configs.Main.Fishing_Auto.CastMode == "Legit" then
                                VirtualInputManager:SendMouseButtonEvent(1472.47, 637.40, 0 , true , nil , 1);
                                twait(0.8)
                                VirtualInputManager:SendMouseButtonEvent(1472.47, 637.40, 0 , false, nil , 1);
                            else
                                FoundKuy.events.cast:FireServer(maHtA, 1);
                            end;
                        elseif Configs.Main.Fishing_Auto.Mode == "Fast" then
                            twait(0.3);
                            if Configs.Main.Fishing_Auto.CastMode == "Legit" then
                                --mousePress(1472.47, 637.40);
                                VirtualInputManager:SendMouseButtonEvent(1472.47, 637.40, 0 , true , nil , 1);
                                twait(0.8)
                                VirtualInputManager:SendMouseButtonEvent(1472.47, 637.40, 0 , false, nil , 1);
                            else
                                FoundKuy.events.cast:FireServer(maHtA, 1);
                            end;
                        elseif Configs.Main.Fishing_Auto.Mode == "Perfect" then
                            twait(0.3);
                            FoundKuy.events.cast:FireServer(100, 1);
                        end;
                    end);
                end;
                if Configs.Players.Freeze then
                    selff.Character.HumanoidRootPart.Anchored = true;
                else
                    selff.Character.HumanoidRootPart.Anchored = false;
                end;
                IgnoreF = false;
                PSGReel = FindFirstChild(PSG, "reel");
                if PSGReel then
                    if Configs.Main.Fishing_Auto.Mode == "Legit" then
                        repeat twait();
                            OUK, OUKK = nil;
                            OUK, OUKK = pcal(function()
                                PSGReel.bar.playerbar.Position = PSGReel.bar.fish.Position;
                            end);
                        until not PSGReel or not PSGReel.Parent;
                        twait(0.7);
                    elseif Configs.Main.Fishing_Auto.Mode == "Fast" then
                        twait(1.3);
                        pcal(function()
                            R.events.reelfinished:FireServer(math.random(80, 100), true);
                        end);
                        twait(0.7);
                    elseif Configs.Main.Fishing_Auto.Mode == "Perfect" then
                        twait(1.3);
                        pcal(function()
                            R.events.reelfinished:FireServer(100, true);
                        end);
                        twait(0.7);
                    end;
                end;
            else
                if Configs.Main.Fishing_Manual.AutoPerfect then
                    PSGReel = FindFirstChild(PSG, "reel");
                    if PSGReel then
                        twait(1.3);
                        R.events.reelfinished:FireServer(100, true);
                        twait(0.7);
                    end;
                else
                    if Configs.Main.Fishing_Manual.AutoReeling then
                        PSGReel = FindFirstChild(PSG, "reel");
                        if PSGReel then
                            repeat twait();
                                pcal(function()
                                    PSGReel.bar.playerbar.Position = PSGReel.bar.fish.Position;
                                end);
                            until not PSGReel or not PSGReel.Parent or not Configs.Main.Fishing_Manual.AutoReeling;
                        end;
                    end;
                end;
            end;
            if Configs.Main.Crate.AutoOpen then
                BaitCrateBP = FindFirstChild(selff.Backpack, "Bait Crate");
                BaitCrateChar = FindFirstChild(selff.Character, "Bait Crate");
                if not BaitCrateChar and BaitCrateBP then
                    PSG.hud.safezone.backpack.events.equip:FireServer(BaitCrateBP);
                end; twait(0.3);
                BaitCrateChar = FindFirstChild(selff.Character, "Bait Crate");
                if BaitCrateChar then
                    for i=1,10 do twait();
                        mousePress(1472.47, 637.40);
                    end;
                end;
            end;
            if Configs.Main.Crate.AutoBuy then
                pcal(function()
                    BuyCrate();
                end);
            end;
            if Configs.World.AutoBuy then
                pcal(function()
                    BuyCage();
                end);
            end;
        end;
    end);

    tspawn(function()
        while twait(2) do
            if SystemStackDestroy then break; end; 
            if writefile then
                if SystemStackDestroy then break; end; 
                SaveConfigs = game:GetService('HttpService'):JSONEncode(Configs)
                writefile("Neuron_Fisch.bin", SaveConfigs);
            end;
            if SystemStackDestroy then break; end; 
        end;
    end);

    if not GG.RootXRod then
        GG.RootXMain = W.world.interactables.ChildAdded:Connect(function(v)
            if Configs.ESP.Rod then
                if strfind(v.Name, "Rod") then
                    ESP(v, Color3.fromRGB(0, 0, 255), Vec3(2, 4, 2));
                end;
            end;
        end);
        GG.RootXSep1 = W.world.npcs.ChildAdded:Connect(function(v)
            if Configs.ESP.NPC then
                if v then
                    ESP(v, Color3.fromRGB(255, 0, 255), Vec3(3, 3, 3));
                end;
            end;
        end);
    end;

    Tixker2 = tick();

    function mathr(number)
        return math.floor(number + 0.5)
    end

    function calculateWorkingPercentage(total, nonWorking)
        if total == 0 then return "none" end;
        local workingFunctions = total - nonWorking;
        local percentage = (workingFunctions / total) * 100;
        return mathr(percentage) .. "%";
    end

    workingPercentage = calculateWorkingPercentage(40, 2);
    OPSS = calculateWorkingPercentage(0, 0);

    print("[Neuron X] : WF: " .. workingPercentage);
    print("[Neuron X] : AOPs: " .. OPSS);
    print("[Neuron X] : XUNC: 16%");
    print("[Neuron X] : Script is running on <" .. tos(math.round(((Tixker2 - Tixker) * 1000))) .. "x16>");
    print("[Neuron X] : Script is running on different thread");
    print("[Neuron X] : Script protected with key: !2!?Protectec?NeuronX?By?+%*- (4 Newlines)");
    print("[Final Check] : " .. Iden ..", Fisch, PData:False Configs:???, Status:Untested");
    warn("[Neuron X] : VIP Not found , Script is keyless");
end;

return coroutine.wrap(getMethodLoading)();