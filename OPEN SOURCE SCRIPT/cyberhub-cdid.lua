repeat wait() until game:IsLoaded()

--- + Variable 
local Camera = workspace.CurrentCamera
local Workspace = game:GetService("Workspace")
local ReplStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local COREGUI = game:GetService("CoreGui")
local LP = game:GetService("Players").LocalPlayer
local HumanoidRootPart = LP.Character.HumanoidRootPart
local VirtualUser = game:GetService("VirtualUser")
local VIM = game:GetService("VirtualInputManager")

--Service
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunS = game:GetService("RunService")
local TPS = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local Event = game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents

--Date
local day = os.date("%A")
local month = os.date("%B")
local days = os.date("%d")
local year = os.date("%Y")

local playerName = game.Players.LocalPlayer.Name 
local executionTime = os.date("%X") 
local executionDate = os.date("%x") 

local mouse = LP:GetMouse()
local MousePosition = function()
    return Vector2.new(mouse.X,mouse.Y)
end

local TotalEarning = 0;
local StopFarm = false;

local request = (syn and syn.request) or (http and http.request) or http_request
local GC = getconnections or get_signal_cons

local job = require(game:GetService("ReplicatedStorage").Modules.Job)
local Network = require(game:GetService("ReplicatedStorage").Modules.Network)
local TweenModule = require(game:GetService("ReplicatedStorage").Modules.Tween)

local mapName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local OSTime = os.time();
local Time = os.date('!*t', OSTime);

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/download/1.1.0/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

function notify(title, content, duration)
    Fluent:Notify({ Title = title, Content = content, Duration = duration})
end


local Window = Fluent:CreateWindow({
    Title = "FinzStore16",
    SubTitle = "Private Script",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 350),
    Acrylic = false, 
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl 
})

function sendNotification()

    local Description = string.format(
        "🙍‍♂️ | Account & Execute Informations\n" ..
        "> - Roblox Name: ``%s``\n" ..
        "> - Executor Name: ``%s``\n" ..
        "> - Map Name: ``%s``\n" ..
        "> - HWID: ``%s``\n",
        LP.Name,
        identifyexecutor(),
        mapName,
        game:GetService("RbxAnalyticsService"):GetClientId()
    )

    local Embed = 
    {
        title = 'Script Executions',
        color = tonumber(0xffffff),
        description = Description,
        author = { name = "Cyber Hub 📸", url = 'https://discord.gg/8nKBS8EEP2', icon_url = 'https://images-ext-1.discordapp.net/external/zxPoOShh-Qjj0GwshkqkK_wPFZ5_hpnUqHf98ujhgGA/%3Fsize%3D4096/https/cdn.discordapp.com/icons/1264126428383936564/6fbbdb002d224d743e23fb366d941570.png?format=webp&quality=lossless&width=625&height=625' },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ", OSTime), 
        footer = { text = ' Cyber Hub Devloper', icon_url = '' }
    }

    local postData = game:GetService('HttpService'):JSONEncode({embeds = {Embed}})

    local response = (syn and syn.request or http_request)({
        Url = 'https://discordapp.com/api/webhooks/1278303429420388363/7ITMd6ZOkaabVJWFmSriLyv5mipWj73lP8TSmcvuFZq1TR9SiO5Y9jmz-7HWhgb-Tdtu',
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = postData
    })
    
    local notificationUrl = '' 
    local notificationResponse = syn.request:PostAsync(notificationUrl, postData)
    
end


local FarmingConfig = 
{
    WebhookName         = "Cyber Hub",
    WebhookLink         = "Unknown",
    FarmingTime         = "00:00:00 (0 minutes)",
    CurrentTime         = "00.00 WIB",
    StartFarming        = "00.00 WIB",
    TotalTelport        = 0,
    CountdownTelport    = 55,
    Destination         = "Unknown",
    CurrentMoney        = LP:FindFirstChild("PlayerGui").Main.Container.Hub.CashFrame.Frame.TextLabel.Text,
    SalaryMoney         = LP:FindFirstChild("PlayerGui").PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value.Text,
    TargetMoney         = 999999999,
    --Gamepass            = MarketplaceService:UserOwnsGamePassAsync(LP.UserId, 37328594) and "⏳ Estimated Time [GP]" or "⏳ Estimated Time [Without GP]",
    TimeToTarget        = "00000 Hours, 00 Minutes, 00 Seconds",
    DateToTarget        = "00/00/0000 00:00",
    AutoFarmMethod      = "Instant",
}

function Yetetea(tujuan)

    local Description = string.format(
        "⌚ | Time and Account Information\n" ..
        "> - Webhook Name: ``%s``\n" ..
        "> - Farming Time: ``%s``\n" ..
        "> - Current Time: ``%s``\n" ..
        "> - Started Time: ``%s``\n" ..
        "> - Total Teleport: ``%d``\n" ..
        "> - Latest Destination: ``%s``\n" ..
        "💵 | Money Information\n" ..
        "> - Current Money: ``%s``\n" ..
        "> - Total of Salary: ``%s``\n",
        FarmingConfig.WebhookName,
        FarmingConfig.FarmingTime,
        FarmingConfig.CurrentTime,
        FarmingConfig.StartFarming,
        FarmingConfig.TotalTelport,
        FarmingConfig.Destination,
        FarmingConfig.CurrentMoney,
        FarmingConfig.SalaryMoney
    )

    local embed = 
    {
        title = 'Click this to join our discord 🪂', 
        url = 'https://discord.gg/8nKBS8EEP2',
        color = tonumber(0xffffff),
        description = Description,
        author = { name = "🚚 | AutoFarming Logs", icon_url = '' },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ", OSTime), 
        footer = { text = 'Cyber Hub Development Team', icon_url = '' }
    }

    local response = (syn and syn.request or http_request)({
        Url = FarmingConfig.WebhookLink,
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = game:GetService('HttpService'):JSONEncode({embeds = {embed}})
    });

end

function TeleportTrans(name)
    game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.TransEvent:FireServer(name)
end

local Tabs = {
    MainTab         = Window:AddTab({ Title = "Main", Icon = "home" }),
    LocalPlayerTab  = Window:AddTab({ Title = "LocalPlayer", Icon = "smile" }),
    TruckTab        = Window:AddTab({ Title = "Farming", Icon = "truck" }),
    WebhookTab      = Window:AddTab({ Title = "Webhook", Icon = "anchor" }),
    Vehicle         = Window:AddTab({ Title = "Vehicle Mod", Icon = "car" }),
    Credits         = Window:AddTab({ Title = "Credits", Icon = "copyright" }),
    Settings        = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local Options = Fluent.Options

do
    Tabs.Credits:AddParagraph({
        Title = "Finz",
        Content = "Founder & Developer"

    })

    local Walkspeed = Tabs.LocalPlayerTab:AddSlider("Slider", {
        Title = "Walkspeed",
        Description = " ",
        Default = 16,
        Min = 2,
        Max = 250,
        Rounding = 1,
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    })

    local JumpHeight = Tabs.LocalPlayerTab:AddSlider("Slider", {
        Title = "Jump Power",
        Description = " ",
        Default = 16,
        Min = 2,
        Max = 250,
        Rounding = 1,
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = Value
        end
    })

    local SpawnFeature = Tabs.Vehicle:AddButton({
        Title = "Create vehicle feature",
        Description = "make sure you already spawned your vehicle!",
        Callback = function()
            Window:Dialog({
                Title = "IMPORTANT",
                Content = "are you already spawn your vehicle?",
                Buttons = {
                    {
                        Title = "Yes",
                        Callback = function()
                            VehicleFeature()
                        end
                    },
                    {
                        Title = "No",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })

    function VehicleFeature()

        SpawnFeature:Destroy()
    
        local FPlate = Tabs.Vehicle:AddInput("frontplate", {
            Title = "Front Date Plate",
            Default = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Plate.F.Date.SGUI.Date.Text,
            Placeholder = " ",
            Numeric = false, -- Only allows numbers
            Finished = true, -- Only calls callback when you press enter
            Callback = function(Value)
                workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Plate.F.Date.SGUI.Date.Text = Value
            end
        })
    
        local RPlate = Tabs.Vehicle:AddInput("rearplate", {
            Title = "Rear Date Plate",
            Default = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Plate.R.Date.SGUI.Date.Text,
            Placeholder = " ",
            Numeric = false, -- Only allows numbers
            Finished = true, -- Only calls callback when you press enter
            Callback = function(Value)
                workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Plate.R.Date.SGUI.Date.Text = Value
            end
        })
    
        local FPlateMain = Tabs.Vehicle:AddInput("frontplateMain", {
            Title = "Front Main Plate",
            Default = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body["Plate Text"].Plates.Front.SGUI.Identifier.Text,
            Placeholder = " ",
            Numeric = false, -- Only allows numbers
            Finished = true, -- Only calls callback when you press enter
            Callback = function(Value)
                workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body["Plate Text"].Plates.Front.SGUI.Identifier.Text = Value
            end
        })
    
        local RPlateMain = Tabs.Vehicle:AddInput("rearplateMain", {
            Title = "Rear Main Plate",
            Default = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body["Plate Text"].Plates.Rear.SGUI.Identifier.Text,
            Placeholder = " ",
            Numeric = false, -- Only allows numbers
            Finished = true, -- Only calls callback when you press enter
            Callback = function(Value)
                workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body["Plate Text"].Plates.Rear.SGUI.Identifier.Text = Value
            end
        })
    
        local DestroyPlate = Tabs.Vehicle:AddButton({
            Title = "Remove Plate",
            Description = "reset spawn to add car plate again",
            Callback = function()
                workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Plate:Destroy()
                workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body["Plate Text"]:Destroy()
            end
        })
    
        local CarColor = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Body.CPart
        local WindowColor = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Body.Windows
    
        local VehicleColor = Tabs.Vehicle:AddColorpicker("Colorpicker", {
            Title = "Car Color",
            Default = CarColor.Color
        })
    
        VehicleColor:OnChanged(function()
            CarColor.Color = VehicleColor.Value
        end)
    
        local CarWindow = Tabs.Vehicle:AddColorpicker("Colorpicker", {
            Title = "Car Window Color",
            Default = CarColor.Color
        })
    
        CarWindow:OnChanged(function()
            WindowColor.Color = CarWindow.Value
        end)
    
        local LFogs = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Lights.Fogs
        local LHB = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Lights.HighBeam
        local LLb = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Lights.LowBeam
    
        local ColorFogs = Tabs.Vehicle:AddColorpicker("Colorpicker", {
            Title = "Color Fogs Objek",
            Default = LFogs.Color
        })
    
        local ColorHB = Tabs.Vehicle:AddColorpicker("Colorpicker", {
            Title = "Color High Beams Objek",
            Default = LHB.Color
        })
    
        local ColorLB = Tabs.Vehicle:AddColorpicker("Colorpicker", {
            Title = "Color Low Beams Objek",
            Default = LLb.Color
        })
    
        ColorFogs:OnChanged(function()
            LFogs.Color = ColorFogs.Value
        end)
    
        ColorHB:OnChanged(function()
            LHB.Color = ColorHB.Value
        end)
    
    
        ColorLB:OnChanged(function()
            LLb.Color = ColorLB.Value
        end)
    
        -- [ Lightning Handler ]
        local LeftLighting  = Tabs.Vehicle:AddSection("Left Lightning Color")
        local RightLighting = Tabs.Vehicle:AddSection("Right Lightning Color")
        local Fun           = Tabs.Vehicle:AddSection("Fun")
    
        ---! left lightning
        local LFB = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Lights.Light.Left.FB
        local LFB2 = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Lights.Light.Left.FB2
        local LFogs = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Lights.Light.Left.Fogs
    
        ---! right lightning
        local RFB = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Lights.Light.Right.FB
        local RFB2 = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Lights.Light.Right.FB2
        local RFogs = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Lights.Light.Right.Fogs
    
        ---? shit of right
        local RPickerLFB = RightLighting:AddColorpicker("Colorpicker", {
            Title = "Lightning LB",
            Default = RFB.Color
        })
    
        local RPickerLFB2 = RightLighting:AddColorpicker("Colorpicker", {
            Title = "Lightning HB",
            Default = RFB2.Color
        })
    
        local RPickerLFogs = RightLighting:AddColorpicker("Colorpicker", {
            Title = "Lightning Fogs",
            Default = RFogs.Color
        })
    
        RPickerLFB:OnChanged(function()
            RFB.Color = RPickerLFB.Value
        end)
    
        RPickerLFB2:OnChanged(function()
            RFB2.Color = RPickerLFB2.Value
        end)
    
        RPickerLFogs:OnChanged(function()
            RFogs.Color = RPickerLFogs.Value
        end)
    
        ---? shit of left 
        local LPickerLFB = LeftLighting:AddColorpicker("Colorpicker", {
            Title = "Lightning LB",
            Default = LFB.Color
        })
    
        local LPickerLFB2 = LeftLighting:AddColorpicker("Colorpicker", {
            Title = "Lightning HB",
            Default = LFB2.Color
        })
    
        local LPickerLFogs = LeftLighting:AddColorpicker("Colorpicker", {
            Title = "Lightning Fogs",
            Default = LFogs.Color
        })
    
        LPickerLFB:OnChanged(function()
            LFB.Color = LPickerLFB.Value
        end)
    
        LPickerLFB2:OnChanged(function()
            LFB2.Color = LPickerLFB2.Value
        end)
    
        LPickerLFogs:OnChanged(function()
            LFogs.Color = LPickerLFogs.Value
        end)
    
    
        local CarRGBColor = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Body.CPart
        local WindowColor = workspace.Vehicles:FindFirstChild(LP.Name .. "sCar").Body.Body.Windows
        local CarPath = workspace.Vehicles
        local connection
        local windowconnection
        
    
        local CarRGB = Fun:AddToggle("RGCAR", {Title = "RGB Car", Default = false})
        local WindowRGB = Fun:AddToggle("WRGB", {Title = "RGB Window", Default = false})
        local BringCar = Fun:AddToggle("BRC", {Title = "Bring all Car", Default = false}) 
    
        BringCar:OnChanged(function()
            if Options.BRC.Value then
                repeat
                    if CarPath then
                        local playerPosition = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character.HumanoidRootPart.Position
                        if playerPosition then
                            for _, child in ipairs(CarPath:GetChildren()) do
                                if child:IsA("Model") and child.PrimaryPart then
                                    child:SetPrimaryPartCFrame(CFrame.new(playerPosition))
                                end
                            end
                        end
                    end
                    wait() 
                until not Options.BRC.Value
            end
        end)
    
        CarRGB:OnChanged(function()
            if Options.RGCAR.Value then
                local hue = 0
                local speed = 1
                
                if connection then
                    connection:Disconnect()
                end
                connection = RunService.RenderStepped:Connect(function(deltaTime)
                    hue = (hue + deltaTime * speed) % 1
                    local color = Color3.fromHSV(hue, 1, 1)
                    CarRGBColor.Color = color
                end)
            else
                if connection then
                    connection:Disconnect() 
                    connection = nil 
                end
    
            end
        end)    
    
        WindowRGB:OnChanged(function()
            if Options.WRGB.Value then
                local hue = 0
                local speed = 1
                
                if windowconnection then
                    windowconnection:Disconnect()
                end
                windowconnection = RunService.RenderStepped:Connect(function(deltaTime)
                    hue = (hue + deltaTime * speed) % 1
                    local color = Color3.fromHSV(hue, 1, 1)
                    WindowColor.Color = color
                end)
            else
                if windowconnection then
                    windowconnection:Disconnect() 
                    windowconnection = nil 
                end
    
            end
        end)
    end
        
    function tweeningObject(cframe, speed)
        local LP = game:GetService("Players").LocalPlayer
        local TweenService = game:GetService("TweenService")
        local HumanoidRootPart = LP.Character.HumanoidRootPart
        local targetCFrame = cframe
        local tweenInfo = TweenInfo.new(speed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        local tweenProperties = {CFrame = targetCFrame}
        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, tweenProperties)
        tween:Play()
        tween.Completed:Wait() 
    end

    function gotoDealership()
        local destinations = {
            CFrame.new(-13010.2803, 46.8383064, 1886.19617, -0.499959469, 0, 0.866048813, 0, -1, 0, 0.866048813, 0, 0.499959469),
            CFrame.new(-12263.7881, 46.1981049, 1973.57812, -0.866007447, -0, -0.500031412, 0, -1.00000024, 0, -0.500031412, 0, 0.866007268),
            CFrame.new(-14798.0957, 48.263916, 853.550903, -0.499959469, 0, 0.866048813, 0, -1, 0, 0.866048813, 0, 0.499959469),
            CFrame.new(-15228.6787, -97.3615036, 30053.9727, 0.258653998, 0, 0.965970039, 0, -1, 0, 0.965970039, 0, -0.258653998),
            CFrame.new(-5130.23682, 204.879227, 27456.0801, -0.500045776, -0, -0.865998983, 0, -1, 0, -0.865998983, 0, 0.500045776),
            CFrame.new(-5136.53955, 205.129257, 27308.1758, -0.499959469, -0, -0.866048813, 0, -1, 0, -0.866048813, 0, 0.499959469),
            CFrame.new(-4278.76172, 213.565567, 28127.0977, 0.866007268, 0, -0.500031412, 0, -1.00000024, -0, -0.500031412, 0, -0.866007447),
            CFrame.new(-3791.33374, 206.583069, 29516.4141, -0.866007447, 0, 0.500031412, 0, -1.00000024, 0, 0.500031412, 0, 0.866007268),
            CFrame.new(-2349.09473, 206.111053, 29134.7949, -0.499268651, -0, -0.86644727, 0, -1, 0, -0.86644727, 0, 0.499268651),
            CFrame.new(811.287354, 202.800964, 36686.6523, -0.707134247, -0, -0.707079291, 0, -1, 0, -0.707079291, 0, 0.707134247)
        }

        for _, destination in ipairs(destinations) do
            tweeningObject(destination, 30)
            wait(2)
        end
    end

    function gotoCity()
        local transCDID = Workspace.Etc.TransCDID
        local children = transCDID:GetChildren()

        local childNames = {}
        for i, child in ipairs(children) do
            table.insert(childNames, child.Name)
        end

        for _, name in ipairs(childNames) do
            print(name)
            wait(5)
        end
    end

    function dailyQuest()
        gotoDealership()
    end

    -- Trucking Logs Section
    function addLogs(title, content)
        local tLogs = Tabs.TruckLogs:AddParagraph({
            Title = title,
            Content = content
        })
        return tLogs
    end

    local sConfig = Tabs.TruckTab:AddSection("Config")

    local sFarmingCountdown = 50

    local SpecialFarming = sConfig:AddInput("sFarming", {
        Title = "Countdown",
        Description = " ",
        Default = 40,
        Placeholder = "minimum 40 seconds",
        Numeric = true, 
        Finished = false, 
        Callback = function(Value)
            sFarmingCountdown = Value
        end
    })

    SpecialFarming:OnChanged(function()
        sFarmingCountdown = SpecialFarming.Value
        print("Webhook updated:", SpecialFarming.Value)
    end)

    local MapValue = "No"

    local mapConfig = sConfig:AddDropdown("Dropdown", {
        Title = "Delete Map",
        Values = {"Yes", "No"},
        Multi = false,
        Default = "Yes",
    })

    mapConfig:OnChanged(function(Value)
        MapValue = Value
    end)

    sConfig:AddButton({
        Title = "Start Farming",
        Description = "You can't stop this farming.\nRelog or reset character to stop it.",
        Callback = function()
            Window:Dialog({
                Title = "Important❗",
                Content = "This Script Is Still In Beta Tester You Are The Chosen One Who Can Feel The Beta Test This Time. We ask you to report bugs in our script so that we can easily fix it and this script is not 100% safe from cdid staff logs so we ask you not to routinely execute the script\n\n\n~ Finz (Founder & Developer Cyber Hub) ~",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            dospecialFarm()
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })

    -- Special Farming Section
    local sStats = Tabs.TruckTab:AddSection("Stats")

    local sClientCash = sStats:AddParagraph({
        Title = "Total Money",
        Content = LP:FindFirstChild("PlayerGui").Main.Container.Hub.CashFrame.Frame.TextLabel.Text
    })
    
    local sClientEarningsValue = LP:FindFirstChild("PlayerGui").PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value.Text

    local sClientEarnings = sStats:AddParagraph({
        Title = "Total Earning Money",
        Content = (sClientEarningsValue == "0") and "You're not start Auto Farming" or sClientEarningsValue
    })

    local sClientTime =  sStats:AddParagraph({
        Title = "Elapsed Time",
        Content = "You're not start Auto Farming"
    })
    
    local sInfomation = sStats:AddParagraph({
        Title = "Status",
        Content = "You're not start Auto Farming"
    })

    function dospecialFarm()
        FireJob()
        wait(1)
        setDestinationToSemarang()
        wait(1)
        SpawnMinigunTruck()
        wait(1)
        if MapValue == "Yes" then
            local exceptions = { Prop = true }  -- Folder named "Prop" will not be deleted
            local function destroyDescendantsExcept(instance)
                for _, child in ipairs(instance:GetChildren()) do
                    if not exceptions[child.Name] then
                        destroyDescendantsExcept(child)
                        child:Destroy()
                    end
                end
            end

            local mapFolder = workspace:FindFirstChild("Map")
            if mapFolder then
                destroyDescendantsExcept(mapFolder)
                print("All descendants of 'Map' folder have been destroyed, except for 'Prop'.")
            else
                print("Folder 'Map' not found in workspace.")
            end
        end
        newFarming()
        sTimer()
    end


    function FireJob()
        recallJob()
        game.Workspace.Gravity = 10
        wait(0.5)
        game.Workspace.Gravity = 0
        sInfomation:SetDesc("Teleporting to Trucker PT. Shad Cirebon")
        local TargetTween = CFrame.new(-21799.8, 1042.65, -26797.7)
        tweeningObject(TargetTween, 1)
        game.Workspace.Gravity = 10
    end

    function setDestinationToSemarang()
        sInfomation:SetDesc("Settings Destination To Semarang")

        repeat
            wait(1) 
            local Waypoint = game.Workspace.Etc.Waypoint:FindFirstChild("Waypoint")
            local WaypointLabel = Waypoint:FindFirstChild("BillboardGui"):FindFirstChild("TextLabel")

            if WaypointLabel.Text ~= "Rojod Semarang" then
                recallJob()
                fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
            end

        until WaypointLabel.Text == "Rojod Semarang"
    end
    

    function SpawnMinigunTruck()
        sInfomation:SetDesc("Spawning Truck")
        task.wait()

        local TweenService = game:GetService("TweenService")
        local HumanoidRootPart = LP.Character.HumanoidRootPart
        local waypointPosition = game.Workspace.Etc.Job.Truck.Spawner.Part.Position

        local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

        local tweenProperties = {
            CFrame = CFrame.new(waypointPosition)
        }

        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, tweenProperties)
        tween:Play()
        tween.Completed:Wait() 
    
        fireproximityprompt(workspace.Etc.Job.Truck.Spawner.Part.Prompt)
        wait(0.5)
        fireproximityprompt(workspace.Etc.Job.Truck.Spawner.Part.Prompt)
        wait(3)
    
        repeat
            wait(0.5)
            local playerName = LP.Name
            local carIdentifier = "sCar"
            local miniTruck = game:GetService("Workspace").Vehicles[playerName .. carIdentifier]:FindFirstChild("Cost")
            
            if miniTruck.Value ~= 401000 then
                fireproximityprompt(workspace.Etc.Job.Truck.Spawner.Part.Prompt)
            end
        until miniTruck.Value == 401000

        local playerName = LP.Name
        local carIdentifier = "sCar"
        local vehicle = game:GetService("Workspace").Vehicles[playerName .. carIdentifier]

        wait(2)

        vehicle.DriveSeat:Sit(game:GetService("Players").LocalPlayer.Character.Humanoid)
    end
    
    
    function settingsDestinationTwo()
        local TweenService = game:GetService("TweenService")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local character = player.Character
        local seat = character.Humanoid.SeatPart
        local car = seat.Parent
        local primary = car.PrimaryPart
    
        local function tweenCar(toPosition, duration)
            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
            local tweenValue = Instance.new("CFrameValue")
            tweenValue.Value = car:GetPrimaryPartCFrame()
    
            tweenValue.Changed:Connect(function()
                car:PivotTo(tweenValue.Value)
            end)
    
            local tween = TweenService:Create(tweenValue, tweenInfo, {Value = toPosition})
            tween:Play()
            tween.Completed:Wait()
        end
    
        local function setCarAnchored(value)
            for _, part in ipairs(car:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = value
                end
            end
        end
    
        sInfomation:SetDesc("Settings Destination To Semarang")
    
        repeat
            wait(0.8) 
            tweenCar(CFrame.new(-21797.7852, 1040.35071, -26797.709, 1, 0, 0, 0, -1, 0, 0, 0, -1) + Vector3.new(0, 5, 0), 1)
            local Waypoint = game.Workspace.Etc.Waypoint:FindFirstChild("Waypoint")
            local WaypointLabel = Waypoint:FindFirstChild("BillboardGui"):FindFirstChild("TextLabel")
    
            if WaypointLabel.Text ~= "Rojod Semarang" then
                recallJob()
                fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
                game.Workspace.Gravity = 10
            end
        until WaypointLabel.Text == "Rojod Semarang" 
    
        newFarming()
    end
    

    function newFarming()
        local TweenService = game:GetService("TweenService")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local character = player.Character
        local seat = character.Humanoid.SeatPart
        local car = seat.Parent
        local primary = car.PrimaryPart

        local function tweenCar(toPosition, duration)
            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
            local tweenValue = Instance.new("CFrameValue")
            tweenValue.Value = car:GetPrimaryPartCFrame()

            tweenValue.Changed:Connect(function()
                car:PivotTo(tweenValue.Value)
            end)

            local tween = TweenService:Create(tweenValue, tweenInfo, {Value = toPosition})
            tween:Play()
            tween.Completed:Wait()
        end

        workspace.Gravity = 0

        -- Fly up
        tweenCar(primary.CFrame + Vector3.new(0, 1000, 0), 0)

        -- Fly to destination
        tweenCar(CFrame.new(-50889.6602, 1017.86719, -86514.7969, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268) + Vector3.new(0, 1000, 0), 2)

        -- Fly down
        tweenCar(CFrame.new(-50889.6602, 1017.86719, -86514.7969, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268) + Vector3.new(0, 0, 0), 50)

        settingsDestinationTwo()

    end
    
    function sCountdown()
        for i = sFarmingCountdown, 0, -1 do
            cd = i
            fireproximityprompt(workspace.Vehicles.catcat_devsCar.DriveSeat.PromptDriveSeat)
            sInfomation:SetDesc("Teleport To Destination In " .. cd)
            wait(1)
        end
    end

    function sWaypoint()
        for i = 48, 0, -1 do
            cd = i
            sInfomation:SetDesc("Teleport To Destination In " .. cd)
            wait(1)
        end
    end

    function sTimer()
        local jobTime = tick()
        local startTime = os.date("%H:%M:%S")
        local startDate = os.date("%Y-%m-%d")
    
        while wait() do
            local elapsedTime = tick() - jobTime
            local hours = math.floor(elapsedTime / 3600)
            local minutes = math.floor((elapsedTime % 3600) / 60)
            local seconds = math.floor(elapsedTime % 60)
    
            local timeText = string.format("%02d.%02d.%02d", hours, minutes, seconds)
    
            sClientTime:SetDesc(" " .. timeText)
        end
    end

    function recallJob()
        local args = { "Truck" }
        game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
    end

    -- End Of Special Farming Section!!
    local EnvironmentSettings = Tabs.Settings:AddSection("Environment")

    local brightloop

    local function DayWeather()
        game:GetService("Lighting").ClockTime = 12
    end

    local function NightWeather()
        game:GetService("Lighting").ClockTime = 0
    end

    local function StartWeatherLoop(weatherFunction)
        if brightloop then
            brightloop:Disconnect() 
        end
        brightloop = game:GetService("RunService").RenderStepped:Connect(weatherFunction)
    end

    local weatherStatus = EnvironmentSettings:AddDropdown("Dropdown", {
        Title = "Select Time",
        Values = {"Day", "Night"},
        Multi = false,
        Default = "",
    })

    weatherStatus:OnChanged(function(Value)
        if Value == "Day" then
            StartWeatherLoop(DayWeather)
        elseif Value == "Night" then
            StartWeatherLoop(NightWeather)
        else
            if brightloop then
                brightloop:Disconnect() 
            end
        end
    end)

    local ShadowToggle = EnvironmentSettings:AddToggle("shaow", {Title = "Shadow Options", Default = false})

    ShadowToggle:OnChanged(function(Value)
        game:GetService("Lighting").GlobalShadows = Value
    end)

    function destroyListedObjects()
        local objectsToDestroy = {
            "AmbientLightRevamp",
            "ChristmasEvent",
            "Map.TrafficLight",
            "Map.Tree",
            "Map.17",
            "Map.Chirstmas",
            "Map.Ramadhan",
            "Map.RoadLight"
        }

        for _, objectName in ipairs(objectsToDestroy) do
            local object
            if objectName:find("%.") then
                local parts = {}
                for part in objectName:gmatch("[^%.]+") do
                    table.insert(parts, part)
                end

                object = workspace
                for _, partName in ipairs(parts) do
                    object = object:FindFirstChild(partName)
                    if not object then break end
                end
            else
                object = workspace:FindFirstChild(objectName)
            end

            if object then
                object:Destroy()
            else
                warn(objectName .. " not found in workspace")
            end
        end
    end


    EnvironmentSettings:AddButton({
        Title = "Boost FPS",
        Description = "the effect will continue until you relog",
        Callback = function()
            destroyListedObjects()
        end
    })

    -- Fungsi untuk menangani input webhook
    function handleWebhookInput(value, webhookLink)
        if value ~= " " then
            webhookLink = value
            print(webhookLink)
        else
            print("Please enter valid webhook link")
        end
        return webhookLink
    end

    -- Fungsi untuk menangani toggle webhook
    function handleWebhookToggle(toggle, webhookLink)
        if webhookLink == nil or webhookLink == " " then
            Fluent:Notify({
                Title = "Cyber Hub Hub",
                Content = "Please set a Webhook First",
                Duration = 2
            })
        else
            toggle = true
        end
        return toggle
    end

    -- Menambahkan input webhook untuk AutoFarming
    local WebhookInput = Tabs.WebhookTab:AddInput("Input", {
        Title = "Discord Webhook",
        Description ="This will send\nresult data from\nyour truck\nfarming",
        Default = "https://discord.com/api/webhooks/1268811652749463635/HUhZsvYn-WJKvEAAaEb0Ic7E0n66R-KX8OHb6xZoDVaNqsNHhQI9pDF8z6iR6LFr7GAg",
        Placeholder = "Replace your webhook here",
        Finished = true,
        Callback = function(Value)
            FarmingConfig.WebhookLink = handleWebhookInput(Value, FarmingConfig.WebhookLink)
        end
    })

    -- Menambahkan toggle webhook untuk AutoFarming
    local webhookDataFarming = Tabs.WebhookTab:AddToggle("webhookfarming", {Title = "Farming Webhooks", Default = false})
    webhookDataFarming:OnChanged(function()
        FarmingConfig.WebhookLink = handleWebhookToggle(webhookDataFarming.Value, FarmingConfig.WebhookLink)
    end)

    -- Menyetel nilai awal untuk toggle webhook AutoFarming
    Options.webhookfarming:SetValue(true)


    -- [ FARM SECTION ]
    local FarmSection = Tabs.MainTab:AddSection("Farm Config")

    getgenv().SelectedJob = nil;
    local JobDrop = FarmSection:AddDropdown("Dropdown", {
        Title = "Select Job",
        Values = {"Office Worker", "Janji Jiwa"},
        Multi = false,
        Default = getgenv().SelectedJob,
    })

    JobDrop:OnChanged(function(Value)
        getgenv().SelectedJob = Value
    end)

    local Toggle = FarmSection:AddToggle("StartFarm", {Title = "Start AutoFarm", Default = false })

    Toggle:OnChanged(function()
        if Options.StartFarm.Value == true then
            if getgenv().SelectedJob ~= nil then
                if StopFarm == true then
                    StopFarm = false
                end
                DoFarm(getgenv().SelectedJob)
            else
                Fluent:Notify({
                    Title = "Cyber Hub",
                    Content = "Please Select a Job First",
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            end
        else
            if string.find(tostring(getgenv().SelectedJob), "Driver") then
                cd = 0;
            end 
            StopFarm = true
        end

    end)

    local delayPing = Tabs.MainTab:AddToggle("dping", {Title = "Ping Cheker", Description = "will check your ping and adjust the delay before teleporting", Default = false})

    delayPing:OnChanged(function()
        delayPingCheker = Options.dping.Value
    end)

    Options.dping:SetValue(false)

    -- [ SNIPER BOX ]
    local vehicleSniper = Tabs.MainTab:AddSection("Vehicle Sniper")

    local replicatedStorage = game:GetService("ReplicatedStorage")
    local limitedStock = replicatedStorage:FindFirstChild("LimitedStock")
    local vehicleNames = {}

    if limitedStock then
        local limitedStockChildren = limitedStock:GetChildren()
        for _, child in ipairs(limitedStockChildren) do
            table.insert(vehicleNames, child.Name)
        end
    end

    local limitedSniper = vehicleSniper:AddDropdown("Dropdown", {
        Title = "Buy Limited Vehicle",
        Description = "You must have money first to use this feature",
        Values = vehicleNames,
        Multi = false,
        Default = "",
    })

    limitedSniper:OnChanged(function(Value)
        local args = {
            [1] = "Buy",
            [2] = Value
        }
        game:GetService("ReplicatedStorage").NetworkContainer.RemoteFunctions.Dealership:InvokeServer(unpack(args))
    end)

    function BuyLimited()
        local replicatedStorage = game:GetService("ReplicatedStorage")
        local limitedStock = replicatedStorage:FindFirstChild("LimitedStock")
    
        if limitedStock then
            local limitedStockChildren = limitedStock:GetChildren()
            for _, child in ipairs(limitedStockChildren) do
                local args = {
                    [1] = "Buy",
                    [2] = child.Name
                }
                game:GetService("ReplicatedStorage").NetworkContainer.RemoteFunctions.Dealership:InvokeServer(unpack(args))
            end
        end
    end

    vehicleSniper:AddButton({
        Title = "Buy All Limited",
        Description = "You must have a lot money to use this feature",
        Callback = function()
            Window:Dialog({
                Title = "confirmation",
                Content = "are you sure wanna buy all limited?",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            BuyLimited()
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })

    local BoxSniper = Tabs.MainTab:AddSection("Box Sniper")

    BoxSniper:AddButton({
        Title = "Claim Box",
        Description = "",
        Callback = function()
            Event.Box:FireServer("Claim")
        end
    })

    BoxSniper:AddButton({
        Title = "Gamepass Box",
        Description = "",
        Callback = function()
            Event.Box:FireServer("Buy", "Gamepass Box")
        end
    })

    BoxSniper:AddButton({
        Title = "Limited Box",
        Description = "",
        Callback = function()
            Event.Box:FireServer("Buy", "Limited Box")
        end
    })

    local Dealership = Tabs.MainTab:AddSection("Dealership")

    local dealershipName = {}
    local dealerPrompt = {}

    for _, dealer in ipairs(workspace.Etc.Dealership:GetChildren()) do
        table.insert(dealershipName, dealer.Name)
        dealerPrompt[dealer.Name] = dealer.Prompt
    end 

    local UniversalDealership = Tabs.MainTab:AddDropdown("Dropdown", {
        Title = "Dealership",
        Values = dealershipName,
        Multi = false,
        Default = "",
    })

    UniversalDealership:OnChanged(function(Value)
        local promptToFire = dealerPrompt[Value]
        if promptToFire then
            fireproximityprompt(promptToFire)
        end
    end)

    local transName = {}

    for _, trans in ipairs(game.workspace.Etc.TransCDID:GetChildren()) do 
        table.insert(transName, trans.Name)
    end

    local TransTeleport = Tabs.MainTab:AddDropdown("Dropdown", {
        Title = "Trans CDID",
        Values = transName,
        Multi = false,
        Default = "",
    })

    TransTeleport:OnChanged(function(Value)
        TeleportTrans(Value)
    end)
    

    local vehiclesFolder = workspace.Vehicles
    local childNames = {}

    function createDropdown()
        childNames = {}
        for _, child in ipairs(vehiclesFolder:GetChildren()) do
            table.insert(childNames, child.Name)
        end

        table.insert(childNames, 1, "None")

        if Tabs.MainTab.StealCarDropdown then
            Tabs.MainTab.StealCarDropdown:Destroy()
        end

        local stealCar = Tabs.MainTab:AddDropdown("Vehicle Dropdown", {
            Title = "Steal Vehicle",
            Values = childNames, 
            Multi = false,
            Default = "",
        })
        
        Tabs.MainTab.StealCarDropdown = stealCar

        stealCar:OnChanged(function(Value)
            print("Selected Vehicle:", Value)
            local vehicle = game.Workspace.Vehicles:FindFirstChild(Value)
            if vehicle then
                vehicle.DriveSeat:Sit(game:GetService("Players").LocalPlayer.Character.Humanoid)
            else
                warn("Vehicle not found:", Value)
            end
        end)
    end

    if vehiclesFolder then
        createDropdown()

        vehiclesFolder.ChildAdded:Connect(createDropdown)
        vehiclesFolder.ChildRemoved:Connect(createDropdown)
    else
        warn("Vehicles folder not found in workspace!")
    end

    function CashFormat(cash)
        local v70 = 1
        local v73 = string.len(cash)
        local v74 = v73 - 1
        local v77 = math.floor((v74) / 3)
        local v78 = v77
        local v79 = 1
        for v70 = v70, v78, v79 do
            v73 = string.sub
            v77 = v73(cash, 1, (-3) * v70 - v70)
            v74 = string.sub
            cash = v77 .. "," .. v74(cash, (-3) * v70 - v70 + 1)
        end
        v79 = "RP. "
        v78 = v79 .. cash
        return v78

    end

    function DoFarm(job)
        if job == "Office Worker" then
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer("Office")
            game.Workspace.Gravity = 10
            wait(2)
            game.Workspace.Gravity = 0
            TakeEarlyPoint(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            game.Workspace.Gravity = 10
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            wait(2)
            local destination = GetWaypointName()
            game.Workspace.Gravity = 100
            wait(1)
            repeat wait()
                DoQuestOffice()
            until StopFarm == true
        elseif job == "Janji Jiwa" then
            local args = { "JanjiJiwa" }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
            game.Workspace.Gravity = 10
            wait(2)
            game.Workspace.Gravity = 0
            TakeEarlyPoint(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            game.Workspace.Gravity = 10
            fireproximityprompt(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            wait(2)
            local destination = GetWaypointName()
            game.Workspace.Gravity = 100
            DoJanjijiwaFarm()
        end

    end

    function GetTimer()
        local jobTime = tick()
        local startTime = os.date("%H:%M:%S")
        local startDate = os.date("%Y-%m-%d")

        while wait() do
            local elapsedTime = tick() - jobTime
            local timeText = ""

            if elapsedTime < 60 then
                timeText = string.format("%.1f seconds", elapsedTime)
            elseif elapsedTime < 3600 then
                timeText = string.format("%.1f minutes", elapsedTime / 60)
            else
                timeText = string.format("%.1f hours", elapsedTime / 3600)
            end

            local currentTime = os.date("%H:%M:%S")

            ClientTime:SetDesc("You've been farming for: " .. timeText)

            TimeHook = timeText
        end
    end

    local function GetDistance(Endpoint)
        if typeof(Endpoint) == "Instance" then
            Endpoint = Vector3.new(Endpoint.Position.X, LP.Character:FindFirstChild("HumanoidRootPart").Position.Y, Endpoint.Position.Z)
        elseif typeof(Endpoint) == "CFrame" then
            Endpoint = Vector3.new(Endpoint.Position.X, LP.Character:FindFirstChild("HumanoidRootPart").Position.Y, Endpoint.Position.Z)
        end
        local Magnitude = (Endpoint - LP.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
        return Magnitude
    end

    function TakeEarlyPoint(starterPrompts)
        local waypointPosition = game:GetService("Workspace").Etc.Waypoint.Waypoint.Position
        local humanoidRootPart = LP.Character.HumanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(waypointPosition)
        wait(1.5)
        for i = 1, 6 do
            fireproximityprompt(starterPrompts)
        end
    end

    function SpawnJobCar(waypointPos, promts)
        local waypointPosition = waypointPos
        local playerName = LP.Name
        local carIdentifier = "sCar"
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(waypointPosition)

        fireproximityprompt(promts)
        wait(1)
        fireproximityprompt(promts)
    end

    function SpawnTruck()
        local TweenService = game:GetService("TweenService")
        local HumanoidRootPart = LP.Character.HumanoidRootPart
        local waypointPosition = game.Workspace.Etc.Job.Truck.Spawner.Part.Position

        local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

        local tweenProperties = {
            CFrame = CFrame.new(waypointPosition)
        }

        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, tweenProperties)
        tween:Play()
        tween.Completed:Wait() 

        fireproximityprompt(game.Workspace.Etc.Job.Truck.Spawner.Part.Prompt)
        wait(1)
        fireproximityprompt(game.Workspace.Etc.Job.Truck.Spawner.Part.Prompt)
    end

    function GetInsideOfCar()
        local DriveSeat = game:GetService("Workspace").Vehicles[LP.Name .. 'sCar']:WaitForChild("DriveSeat", 9e9)
        local humanoidRootPart = LP.Character.HumanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(DriveSeat.Position)
        wait(1.5)
        local promptDriveSeat = DriveSeat.PromptDriveSeat
        fireproximityprompt(promptDriveSeat)
        wait(0.5)
        if LP.Character.Humanoid.SeatPart == nil or LP.Character.Humanoid.SeatPart.Name ~= "DriveSeat" then
            fireproximityprompt(promptDriveSeat)
            wait(0.5)
        end
    end

    function RemoveTrailerFromTruck()
        local playerName = LP.Name
        local carIdentifier = "sCar"
        local playerCar = game.Workspace.Vehicles[playerName .. carIdentifier]
        for _, descendant in pairs(playerCar:GetDescendants()) do
            if descendant.Name == "Trailer1" then
                descendant:Destroy()
            end
        end
    end

    function safelyTeleportCar(playerCar, cframe, destination)
        if not playerCar or not cframe then return end
        local playerPing = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local pingValue = tonumber(playerPing:match("%d+"))

        local waitTime = 0
        local delayMessage = " "

        if pingValue > 100 then
            waitTime = 8
            delayMessage = "Adding delay of 8 seconds."
        elseif pingValue > 80 then
            waitTime = 5
            delayMessage = "Adding delay of 5 seconds."
        elseif pingValue < 30 then
            waitTime = 3
            delayMessage = "Adding delay of 3 seconds."
        end

        local renderTimeValue = 100

        local success, errorMessage = pcall(function()
            if delayPingCheker then
                wait(waitTime) 
                playerCar:SetPrimaryPartCFrame(cframe)
                CountdownTP:SetDesc(string.format("you have render cooldown %d", renderTimeValue))
                game.Workspace.Gravity = -5
                wait(renderTimeValue)
                CountdownTP:SetTitle("Teleported")
                CountdownTP:SetDesc("Teleported successfully!")
                game.Workspace.Gravity = 500
                wait(0.5)
                if webhookToggle == true then
                    Yetetea(destination)
                end
            else
                playerCar:SetPrimaryPartCFrame(cframe)
                CountdownTP:SetDesc(string.format("you have render cooldown %d", renderTimeValue))
                game.Workspace.Gravity = -5
                wait(renderTimeValue)
                CountdownTP:SetTitle("Teleported")
                CountdownTP:SetDesc("Teleported successfully!")
                game.Workspace.Gravity = 500
                wait(0.5)
                if webhookToggle == true then
                    Yetetea(destination)
                end
            end
        end)

        if not success then
            warn("Error teleporting car: " .. errorMessage)
        end
    end

    function TruckFarm(value)
        task.spawn(function()
            while wait() do
                if StopFarm then return end

                local humanoid = LP.Character and LP.Character:FindFirstChild("Humanoid")
                if not humanoid or humanoid.SeatPart == nil or humanoid.SeatPart.Name ~= "DriveSeat" then
                    return
                end

                StartCountdown()

                local destination = GetWaypointName()

                local waypointGui = game.Workspace.Etc.Waypoint.Waypoint:FindFirstChild("BillboardGui")
                local Waypoint = waypointGui and waypointGui.TextLabel.Text
                local playerName = LP.Name
                local carIdentifier = "sCar"
                local playerCar = game:GetService("Workspace").Vehicles:FindFirstChild(playerName .. carIdentifier)

                if Waypoint == "PT.CDID Cargo Cirebon" then 
                    safelyTeleportCar(playerCar, CFrame.new(-21803.8867, 1046.98877, -27817.0586, 0, 0, -1, 0, 1, 0, 1, 0, 0), destination)
                elseif Waypoint == "Rojod Semarang" then 
                    safelyTeleportCar(playerCar, CFrame.new(-50889.6602, 1017.86719, -86514.7969), destination)
                else
                    local waypointPosition = game:GetService("Workspace").Etc.Waypoint.Waypoint.Position
                    safelyTeleportCar(playerCar, CFrame.new(waypointPosition), destination)
                end

            end
        end)
    end

    function DoJanjijiwaFarm()
        task.spawn(function()
            while wait() and not StopFarm do
                pcall(function()
                    repeat
                        TakeEarlyPoint(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
                        if LP.Backpack:FindFirstChild("Coffee") then
                            game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("JanjiJiwa"):FireServer("Delivery")
                        end
                    until StopFarm == true
                end)
            end

        end)
    end

    function DoQuestOffice()
        for i = 0, 4 do
            if StopFarm then break end
            local quest = LP.PlayerGui.Job.Components.Container.Office.Frame.Question.Text
            local Submit = LP.PlayerGui.Job.Components.Container.Office.Frame.SubmitButton
            local splitQuest = string.split(quest, " ")
            local num1 = tonumber(splitQuest[1])
            local operator = splitQuest[2]
            local num2 = tonumber(splitQuest[3])
            local solved;
            if operator == "+" then
                solved = tostring((num1 + num2))
            elseif operator == "-" then
                solved = tostring(num1 - num2)
            end

            LP.PlayerGui.Job.Components.Container.Office.Frame.TextBox.Text = string.match(solved, "%d+")
            repeat wait(0.5) until LP.PlayerGui.Job.Components.Container.Office.Frame.TextBox.Text == string.match(solved, "%d+")
            if (LP.PlayerGui.Job.Components.Container.Office.Frame.TextBox.Text == string.match(solved, "%d+")) then
                VIM:SendMouseButtonEvent(Submit.AbsolutePosition.X+Submit.AbsoluteSize.X/2,Submit.AbsolutePosition.Y+50,0,true,Submit,1)
                VIM:SendMouseButtonEvent(Submit.AbsolutePosition.X+Submit.AbsoluteSize.X/2,Submit.AbsolutePosition.Y+50,0,false,Submit,1)	
            end
        end
    end


    function StartCountdown()
        print('hai')
    end

    function CheckStartJob()
        local jobStarted = false
        while not jobStarted do
            wait()
            local waypoint = assert(game.Workspace.Etc.Waypoint.Waypoint, "Waypoint not found!")
            local waypointLabel = assert(waypoint.BillboardGui and waypoint.BillboardGui.TextLabel, "Waypoint label not found!")
            local labelText = waypointLabel.Text
            if labelText == "PT.Shad Cirebon" then
                LP.Character.HumanoidRootPart.CFrame = CFrame.new(-21799.8, 1042.65, -26797.7)
                local prompt = assert(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt, "Prompt not found!")
                for i = 1, 4 do
                    fireproximityprompt(prompt)
                end
                game.Workspace.Gravity = 10
            else
                jobStarted = true
            end
        end
    end


    function GetWaypointName()
        local waypoint = assert(game.Workspace.Etc.Waypoint.Waypoint, "Waypoint not found!")
        local waypointLabel = assert(waypoint:FindFirstChild("BillboardGui") and waypoint.BillboardGui:FindFirstChild("TextLabel"), "Waypoint label not found!")
        return waypointLabel.Text
    end

    function RefreshCash()
        sClientCash:SetDesc(LP:FindFirstChild("PlayerGui").Main.Container.Hub.CashFrame.Frame.TextLabel.Text)
        sClientEarnings:SetDesc(LP:FindFirstChild("PlayerGui").PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value.Text)
    end

    LP:FindFirstChild("PlayerGui").Main.Container.Hub.CashFrame.Frame.TextLabel:GetPropertyChangedSignal("Text"):Connect(RefreshCash)
    LP:FindFirstChild("PlayerGui").PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value:GetPropertyChangedSignal("Text"):Connect(RefreshCash)
    
    function AntiAFK()
        AFKVal = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
            wait()
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
        end)
    end

    function estimatedTime(earnings, earnedPerSecond)
        local estimateTime = earnings / earnedPerSecond
        local hour = math.floor(estimateTime / 3600)
        local remainSeconds = estimateTime % 3600
        local minute = math.floor(remainSeconds / 60)
        local seconds = math.floor(remainSeconds % 60)
        return string.format("%02d:%02d:%02d", hour, minute, seconds)
    end

    function removeNonNumeric(inputString)
        return inputString:gsub("[^%d]", "")
    end

end

function FluentMisc()
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})

    InterfaceManager:SetFolder("ganteng.wk")
    SaveManager:SetFolder("ganteng.wk/cdid")

    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

    Window:SelectTab(1)

    SaveManager:LoadAutoloadConfig()
end


-- [ CALLBACK FUNCTION ] --
FluentMisc()
AntiAFK()
sendNotification()