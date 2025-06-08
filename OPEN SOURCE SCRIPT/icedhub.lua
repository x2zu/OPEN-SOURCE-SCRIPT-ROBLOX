-- [ICED HUB] Fishing & Event Script
-- Rewritten by OGSUNNY & J5STLN | Structured with Fluent UI
-- Optimized for PC and Mobile | Compatible with All Executors
-- Current Date: April 05, 2025

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

-- Player Setup
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Backpack = LocalPlayer:WaitForChild("Backpack")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")


-- External Data Loading
local roddata = loadstring(game:HttpGet("https://raw.githubusercontent.com/SundayN10/Iced-Hub/refs/heads/main/RodData.lua"))()
local FishData = loadstring(game:HttpGet("https://raw.githubusercontent.com/SundayN10/Iced-Hub/refs/heads/main/FishData.lua"))()
local enchantdata = loadstring(game:HttpGet("https://raw.githubusercontent.com/SundayN10/Iced-Hub/refs/heads/main/EnchantData.Lua"))()

-- Fluent UI Setup with Locked Responsive Scaling
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local screenSize = GuiService:GetScreenResolution() or Vector2.new(1024, 768)
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Fixed, Perfect Fluent UI Size
local windowSize = isMobile and UDim2.new(0, math.min(260, screenSize.X * 0.8), 0, math.min(360, screenSize.Y * 0.65)) 
                    or UDim2.new(0, math.min(600, screenSize.X * 0.6), 0, math.min(380, screenSize.Y * 0.55))
local tabWidth = isMobile and math.min(110, screenSize.X * 0.18) or math.min(160, screenSize.X * 0.18)

local Window = Fluent:CreateWindow({
    Title = "ICED HUB v3.1",
    SubTitle = "Crafted by OGSUNNY & J5STLN ❄️",
    TabWidth = tabWidth,
    Size = windowSize,
    Acrylic = true,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Lock the Window Size to Prevent Resizing Issues
local FluentGui = Window.Window -- Assuming this is the main frame; adjust if Fluent structure differs
if FluentGui then
    FluentGui.Size = windowSize
    FluentGui:GetPropertyChangedSignal("Size"):Connect(function()
        FluentGui.Size = windowSize -- Force it to stay the same
    end)
end

-- Enhanced Toggle Button Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IcedToggleGui"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Sleek, Compact Toggle Size
local toggleSize = isMobile and UDim2.new(0, 140, 0, 35) or UDim2.new(0, 180, 0, 45)
local togglePosition = isMobile and UDim2.new(1, -150, 0, 15) or UDim2.new(1, -190, 0, 15)

local ToggleFrame = Instance.new("Frame")
ToggleFrame.Name = "IcedFrame"
ToggleFrame.Size = toggleSize
ToggleFrame.Position = togglePosition
ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 50, 90)
ToggleFrame.BorderSizePixel = 0
ToggleFrame.ZIndex = 9999
ToggleFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6) -- Minimal rounding for a sharp, modern vibe
UICorner.Parent = ToggleFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(150, 210, 255)
UIStroke.Thickness = 1.5
UIStroke.Parent = ToggleFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 50, 90)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 80, 130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 120, 180))
}
UIGradient.Rotation = 90
UIGradient.Parent = ToggleFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "IcedToggle"
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.Position = UDim2.new(0, 0, 0, 0)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Text = ""
ToggleButton.ZIndex = 10000
ToggleButton.Parent = ToggleFrame

-- Crisp Logo on the Left
local Icon = Instance.new("ImageLabel")
Icon.Size = isMobile and UDim2.new(0, 25, 0, 25) or UDim2.new(0, 30, 0, 30)
Icon.Position = isMobile and UDim2.new(0, 5, 0.5, -12.5) or UDim2.new(0, 6, 0.5, -15)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://79682527046204"
Icon.ZIndex = 10001
Icon.Parent = ToggleFrame

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0, 4)
IconCorner.Parent = Icon

-- Name in the Middle (Tight and Bold)
local NameLabel = Instance.new("TextLabel")
NameLabel.Size = isMobile and UDim2.new(0, 80, 0, 25) or UDim2.new(0, 100, 0, 30)
NameLabel.Position = isMobile and UDim2.new(0.5, -40, 0.5, -12.5) or UDim2.new(0.5, -50, 0.5, -15)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = "ICED HUB"
NameLabel.TextColor3 = Color3.fromRGB(230, 245, 255)
NameLabel.Font = Enum.Font.GothamBlack
NameLabel.TextSize = isMobile and 14 or 18
NameLabel.ZIndex = 10001
NameLabel.Parent = ToggleFrame

-- Minimize Icon on the Right (Clean and Precise)
local MinimizeIcon = Instance.new("ImageLabel")
MinimizeIcon.Size = isMobile and UDim2.new(0, 18, 0, 18) or UDim2.new(0, 22, 0, 22)
MinimizeIcon.Position = isMobile and UDim2.new(1, -23, 0.5, -9) or UDim2.new(1, -28, 0.5, -11)
MinimizeIcon.BackgroundTransparency = 1
MinimizeIcon.Image = "rbxassetid://7072719338" -- Down arrow when open
MinimizeIcon.ZIndex = 10001
MinimizeIcon.Parent = ToggleFrame

-- Dragging Functionality (Smooth and Responsive)
local dragging, dragInput, dragStart, startPos
ToggleFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        local newX = math.clamp(startPos.X.Offset + delta.X, -ToggleFrame.Size.X.Offset, screenSize.X - ToggleFrame.Size.X.Offset)
        local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, screenSize.Y - ToggleFrame.Size.Y.Offset)
        ToggleFrame.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- Toggle UI Visibility with Polished Animation
local isVisible = true -- Starts open
local function toggleUI()
    isVisible = not isVisible
    if isVisible then
        Window:Maximize()
        MinimizeIcon.Image = "rbxassetid://7072719338" -- Down arrow when open
    else
        Window:Minimize()
        MinimizeIcon.Image = "rbxassetid://7072720870" -- Up arrow when minimized
    end
    local targetGradient = isVisible and ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 80, 130)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(70, 120, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 160, 220))
    } or ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 50, 90)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 80, 130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 120, 180))
    }
    -- Smooth gradient transition
    TweenService:Create(UIGradient, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), 
        {Color = targetGradient}):Play()
    -- Subtle hover-like scale effect
    local targetSize = isVisible and toggleSize + UDim2.new(0, 8, 0, 4) or toggleSize
    TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
        {Size = targetSize}):Play()
    -- Reset size after animation for consistency
    if not isVisible then
        wait(0.2)
        TweenService:Create(ToggleFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 
            {Size = toggleSize}):Play()
    end
end

ToggleButton.MouseButton1Click:Connect(toggleUI)

-- Tabs with Lucide Icons
local Tabs = {
    Config = Window:AddTab({ Title = "Config", Icon = "sliders" }), -- Moved to top
    Fish = Window:AddTab({ Title = "Fishing", Icon = "anchor" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
    Automation = Window:AddTab({ Title = "Automation", Icon = "settings" }),
    Events = Window:AddTab({ Title = "Event", Icon = "calendar-range" }),
    Market = Window:AddTab({ Title = "Market", Icon = "badge-cent" }),
    Gifting = Window:AddTab({ Title = "Gifting", Icon = "gift" }),
    Character = Window:AddTab({ Title = "Character", Icon = "user" }),
}

local Options = Fluent.Options

local teleportData = {
    Rods = {
        ["Long Rod"] = Vector3.new(485.695, 171.656, 145.746),
        ["Flimsy Rod"] = Vector3.new(471.108, 148.362, 229.642),
        ["Fortune Rod"] = Vector3.new(-1520.880, 141.283, 771.947),
        ["Fast Rod"] = Vector3.new(447.184, 148.226, 220.187),
        ["Lost Rod"] = Vector3.new(2879.877, 135.792, 2727.481),
        ["Summit Rod"] = CFrame.new(20211, 737, 5708), -- Updated with your CFrame
        ["Steady Rod"] = CFrame.new(-1511, 142, 762), -- Updated with your CFrame
        ["Kings Rod"] = CFrame.new(1379, -807, -302), -- Updated with your CFrame
        ["Carbon Rod"] = CFrame.new(450, 151, 224), -- Updated with your CFrame
        ["Lucky Rod"] = Vector3.new(446.086, 148.253, 222.160),
        ["Training Rod"] = Vector3.new(457.694, 148.358, 230.414),
        ["Phoenix Rod"] = CFrame.new(5965, 270, 847), -- Updated with your CFrame
        ["Magnet Rod"] = CFrame.new(-197, 133, 1932), -- Updated with your CFrame
        ["Avalanche Rod"] = CFrame.new(19769, 414, 5415), -- Updated with your CFrame
        ["Arctic Rod"] = CFrame.new(19580, 133, 5303), -- Updated with your CFrame
        ["Rapid Rod"] = Vector3.new(-1509.245, 139.726, 759.628),
        ["Plastic Rod"] = Vector3.new(454.425, 148.170, 229.172),
        ["Nocturnal Rod"] = CFrame.new(-144, -515, 1142), -- Updated with your CFrame
        ["Scurvy Rod"] = CFrame.new(-141, -512, 1145), -- Updated with your CFrame
        ["Heaven's Rod"] = CFrame.new(20025, -466, 7114), -- Updated with your CFrame (renamed to match)
        ["Rod Of The Depths"] = CFrame.new(1703, -903, 1443), -- Updated with your CFrame
        ["Trident Rod(150k)"] = CFrame.new(-1484, -226, -2202),
        ["Magma Rod(need pufferfish)"] = CFrame.new(-1847, 166, 161),
        ["Destiny Rod(190k)"] = CFrame.new(988, 131, -1238),
        ["Reinforced Rod(20k)"] = CFrame.new(-991, -244, -2693),
        ["Aurora Rod(90k+500k)"] = CFrame.new(-141, -512, 1145),
        ["Stone Rod(3K)"] = CFrame.new(5498, 144, -317)
    },
    Islands = {
        ["Zeus Puzzle"] = CFrame.new(-4296.198, -673.110, 2353.879),
        ["North Glider"] = CFrame.new(20240.863, 756.526, 5756.466),
        ["Gamma"] = CFrame.new(2233.239, -804.182, 1021.374),
        ["Kraken Puzzle 1"] = CFrame.new(-4352.249, -627.110, 2703.387),
        ["Kraken Puzzle 2"] = CFrame.new(-3806.049, -566.772, 1835.287),
        ["Kraken Puzzle 3"] = CFrame.new(-4283.250, -686.832, 1112.474),
        ["Kraken Puzzle 4"] = CFrame.new(-4855.273, -595.482, 1841.409),
        ["Ethereal Puzzle"] = CFrame.new(-4132.256, -598.605, 1826.292),
        ["Ice Puzzle"] = CFrame.new(19232.732, 395.872, 6010.346),
        ["Final Puzzle"] = CFrame.new(19963.973, 1137.889, 5401.835),
        ["Northern"] = CFrame.new(19550.641, 133.199, 5263.196),
        ["Camp 1"] = CFrame.new(20208.041, 208.420, 5278.676),
        ["Camp 2"] = CFrame.new(19756.590, 415.437, 5406.700),
        ["Lever Puzzle"] = CFrame.new(19955.672, 586.854, 5571.536),
        ["Mountain"] = CFrame.new(19558.537, 132.670, 5301.478),
        ["Crafting"] = CFrame.new(-3159.995, -745.614, 1684.168),
        ["Desolate"] = CFrame.new(-1654.967, -213.679, -2845.952),
        ["Ancient Archives"] = CFrame.new(-3155.022, -754.818, 2193.137),
        ["Boss Pool"] = CFrame.new(-2373.347, -11186.404, 7122.693),
        ["Peak"] = CFrame.new(19998.033, 1136.428, 5520.160),
        ["Sunken Puzzle"] = CFrame.new(-4855.273, -595.482, 1841.409),
        ["Depths Maze Exit"] = CFrame.new(977.838, -701.142, 1253.857),
        ["Depths Maze End"] = CFrame.new(1683.626, -902.402, 1440.505),
        ["Altar"] = CFrame.new(1296.320, -805.292, -298.940),
        ["Brine Pool"] = CFrame.new(-1794.095, -142.871, -3302.744),
        ["Grand Reef"] = CFrame.new(-3596, 154, 522), -- Updated with your CFrame
        ["Oil Rig"] = CFrame.new(-3157.537, -754.818, 2214.502),
        ["Poseidon Puzzle"] = CFrame.new(1296.320, -805.292, -298.940),
        ["Atlantis"] = CFrame.new(-4957.249, -583.894, 1870.688),
        ["Kraken Door"] = CFrame.new(-3565.767, 150.437, 535.247),
        ["Swamp"] = CFrame.new(1737.943, 143.000, -2435.172),
        ["Boss Arena"] = CFrame.new(-1901.498, 224.691, -486.300),
        ["Chess Puzzle"] = CFrame.new(-4615.349, -596.754, 1843.487),
        ["Abyssal Zenith"] = CFrame.new(-4265.131, -603.404, 1830.807),
        ["Moosewoof"] = CFrame.new(-4318.653, -876.582, 1745.410),
        ["Statue"] = CFrame.new(2501.446, 131.000, -720.727),
        ["Harvesters Spike"] = CFrame.new(5948.791, 154.926, 482.236),
        ["Roslit Submarine"] = CFrame.new(349.325, 136.036, 327.748),
        ["Vertigo"] = CFrame.new(-117, -515, 1138), -- Updated with your CFrame
        ["Arch"] = CFrame.new(-1254.972, 137.680, 1554.365),
        ["Deepshop"] = CFrame.new(-13488.281, -11050.188, 134.373),
        ["Terapin"] = CFrame.new(-933.005, 131.775, -1118.779),
        ["Volcano"] = CFrame.new(-1331.694, 132.501, 313.449),
        ["Roslit"] = CFrame.new(-1482, 138, 738), -- Updated with your CFrame
        ["Ancient Isle"] = CFrame.new(6056, 196, 283), -- Updated with your CFrame
        ["Crypt Exit"] = CFrame.new(129.482, 150.000, 2043.209),
        ["Forsaken"] = CFrame.new(-2655, 183, 1671), -- Updated with your CFrame
        ["The Depths"] = CFrame.new(502, -707, 1234), -- Updated with your CFrame
        ["Angler Minigame"] = CFrame.new(-10084.581, -9653.552, 274.826),
        ["Brinepool"] = CFrame.new(-1794, -143, -3315),
        ["Desolate Deep"] = CFrame.new(-1659, -214, -2847),
        ["Desolate Pocket"] = CFrame.new(-1500, -235, -2856),
        ["Keepers Altar"] = CFrame.new(1297, -805, -298),
        ["MooseWood"] = CFrame.new(384, 134, 232),
        ["Mushgrove Swamp"] = CFrame.new(2438, 132, -689),
        ["Deep Ocean"] = CFrame.new(-4665, 135, 1758),
        ["Snowcap"] = CFrame.new(2618, 146, 2402),
        ["Sunstone"] = CFrame.new(-918, 135, -1123),
        ["Terrapin"] = CFrame.new(-189, 143, 1926),
        ["Statue of Sovereignty"] = CFrame.new(26, 159, -1037),
        ["Forsaken Shores"] = CFrame.new(-2655, 183, 1671)
    },
    NPCs = {
        ["Inn Keeper Forsaken Shores"] = Vector3.new(-2476.738, 133.000, 1573.267),
        ["Summit Inn Keeper"] = Vector3.new(19664.459, 132.453, 5245.278),
        ["Rhea"] = Vector3.new(-1038.425, 203.337, -1115.580),
        ["Kenith"] = Vector3.new(-1143.180, 134.634, -1077.207),
        ["Skin Seller"] = Vector3.new(302.234, 132.145, 205.361),
        ["Merlin"] = Vector3.new(-928.033, 223.700, -998.745),
        ["Lantern Keeper"] = Vector3.new(658.446, 163.500, 260.214),
        ["Appraiser"] = CFrame.new(444, 151, 210), -- Updated with your CFrame
        ["Bait Seller"] = Vector3.new(386, 137, 332),
        ["Witch (Event Pot)"] = CFrame.new(405, 135, 317),
        ["Merchant"] = CFrame.new(467, 151, 231),
        ["Merlin (Relic Seller)"] = CFrame.new(-932, 224, -988),
        ["Lantern Guy"] = CFrame.new(-39, -247, 199),
        ["Jack Marrow"] = CFrame.new(-2825, 214, 1516)
    },
    Totems = {
        ["Avalanche Totem"] = CFrame.new(19709, 469, 6057), -- Updated with your CFrame
        ["Blizzard Totem"] = CFrame.new(20145.000, 742.953, 5805.000),
        ["Meteor Totem"] = CFrame.new(-1948, 274, 228), -- Updated with your CFrame
        ["Eclipse Totem"] = CFrame.new(5968.000, 273.861, 838.000),
        ["Sundial Totem"] = CFrame.new(-1147, 135, -1074), -- Updated with your CFrame
        ["Tempest Totem"] = CFrame.new(36, 135, 1946), -- Updated with your CFrame
        ["Windset Totem"] = CFrame.new(2852, 180, 2703), -- Updated with your CFrame
        ["Smokescreen Totem"] = CFrame.new(2793, 140, -629), -- Updated with your CFrame
        ["Aurora Totem"] = CFrame.new(-1811, -137, -3282), -- Updated with your CFrame
    },
    SubLocations = {
        ["Desolate Shop"] = CFrame.new(-994, -245, -2723),
        ["Enchant Altar"] = CFrame.new(1312, -802, -87),
        ["Gamma"] = CFrame.new(2231, -792, 1012),
        ["Ancient Temple"] = CFrame.new(-3155, -755, 2202),
        ["Rod Crafting"] = CFrame.new(-3162, -746, 1685),
        ["Vertigo Gate"] = CFrame.new(16, -706, 1225),
        ["Input Abyssal Relic"] = CFrame.new(1206, -715, 1315),
        ["Input Hexed Relic"] = CFrame.new(1050, -631, 1318),
        ["Input Relic in New Rod"] = CFrame.new(2730, 130, -825)
    },
    CastLocations = {
        ["The Depths"] = CFrame.new(939, -738, 1457),
        ["Vertigo"] = CFrame.new(-107, -734, 1214),
        ["Forsaken"] = CFrame.new(-2677, 165, 1755),
        ["Desolate Deep"] = CFrame.new(-1636, -231, -2895),
        ["Snowcap Cave"] = CFrame.new(2818, 133, 2721),
        ["Keeper Altar"] = CFrame.new(1415, -837, -227),
        ["Terappin"] = CFrame.new(-57, 132, 2024),
        ["Roslit bay"] = CFrame.new(-1657, 148, 501),
        ["Roslit pond"] = CFrame.new(-1786, 148, 637),
        ["SunStone Deck"] = CFrame.new(-937, 132, -1107),
        ["Bluefin tuna"] = CFrame.new(-1251, 136, 1560),
        ["The_Arch"] = CFrame.new(1283.30896, 130.923569, -1165.29602, 1, -5.89772364e-09, -3.3183043e-15, 5.89772364e-09, 1, 3.63913486e-08, 3.10367822e-15, -3.63913486e-08, 1),
        ["Mushgrove_Stone"] = CFrame.new(2525.36011, 131.000015, -776.184021, 1, 1.90145943e-08, -3.24206519e-15, -1.90145943e-08, 1, -1.06596836e-07, 1.21516956e-15, 1.06596836e-07, 1),
        ["Isonade"] = CFrame.new(-1060.99902, 121.164787, 953.996033, 0.999958456, 0.000633197487, -0.00909138657, -0.000568434712, 0.999974489, 0.00712434994, 0.00909566507, -0.00711888634, 0.999933302),
        ["Ancient Pond"] = CFrame.new(6039, 197, 338),
        ["Ancient WaterFall"] = CFrame.new(5808, 136, 408),
        ["Northern Cave"] = CFrame.new(19841, 439, 5613),
        ["Northern Canal"] = CFrame.new(20295, 272, 5516),
        ["Grand Reef Ocean"] = CFrame.new(-3589, 132, 572)
    },
    MountainLocations = {
        ["Top of the Mountain"] = CFrame.new(20006, 1137, 5533),
        ["Blue Energy Crystal"] = CFrame.new(20215, 211, 5447),
        ["Green Energy Crystal"] = CFrame.new(19873, 448, 5556),
        ["Yellow Energy Crystal"] = CFrame.new(19498, 335, 5551),
        ["Moosewood Button"] = CFrame.new(400, 135, 265),
        ["Ancient Isle Button"] = CFrame.new(5506, 147, -315),
        ["Snowcap Button"] = CFrame.new(2930, 281, 2594),
        ["Roslitbay Button"] = CFrame.new(-1715, 149, 737),
        ["Forsaken Button"] = CFrame.new(-2566, 181, 1353)
    },
    Levers = {
        ["Entrance"] = CFrame.new(19870, 629, 5375),
        ["Lever 1"] = CFrame.new(19854, 476, 4970),
        ["Lever 2"] = CFrame.new(19880, 425, 5380),
        ["Lever 3"] = CFrame.new(19600, 544, 5613),
        ["Lever 4"] = CFrame.new(19436, 690, 5856),
        ["Lever 5"] = CFrame.new(20194, 854, 5645),
        ["Lever 6"] = CFrame.new(19965, 587, 5573)
    }
}

-- Variables (modify this section)
local variables = {
    FreezeCharacter = false,
    AutoToggleRadar = false,
    WhaleHunting = false,
    isAutoClicking = false,
    isAutoCatch = false,
    autoCastEnabled = false,
    isAutoEquipRod = false,
    isFishing = false,
    autoselling = false,
    autoSellDelay = 60,
    autosellingHand = false,
    muteFishingSounds = false,
    AutoDrop = false,
    autoDropConnection = nil,
    -- New variables for added toggles
    AutoBalanceNuke = false,        -- Tracks AutoBalanceNuke state (though genv is used in callback)
    AutoOpenItem = false,           -- Tracks AutoOpenHeldItem state (though genv is used in callback)
    AutoBalanceNukeConnection = nil -- Stores the connection for AutoBalanceNuke (if needed)
}
local genv = getgenv()
genv.giftloop = false
genv.autoconfirm = false
local lastTeleportTime = 0
local teleportCooldown = 0

local function advancedAntiCheatBypass()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")

    local workspace = game.Workspace
    local genv = getgenv()
    genv._G = genv._G or {}

    -- Disable AFK Detection
    local function neutralizeAFK()
        local eventsFolder = ReplicatedStorage:FindFirstChild("events")
        if eventsFolder then
            local afkEvent = eventsFolder:FindFirstChild("afk")
            if afkEvent and afkEvent:IsA("RemoteEvent") then
                afkEvent.FireServer = function() return true end
            end
        end

        local netFolder = ReplicatedStorage:FindFirstChild("packages") and ReplicatedStorage.packages:FindFirstChild("Net")
        if netFolder then
            local leaveEvent = netFolder:FindFirstChild("RE/AFKArea/Leave")
            if leaveEvent and leaveEvent:IsA("RemoteEvent") then
                leaveEvent.FireServer = function() return true end
            end
            local buyLuckEvent = netFolder:FindFirstChild("RE/AFKArea/BuyDoubleLuck")
            if buyLuckEvent and buyLuckEvent:IsA("RemoteEvent") then
                buyLuckEvent.FireServer = function() return true end
            end
        end

        -- Simulate activity with debounce
        local lastPing = tick()
        spawn(function()
            while true do
                if tick() - lastPing >= 60 then
                    lastPing = tick()
                    if eventsFolder and eventsFolder:FindFirstChild("afk") then
                        pcall(function()
                            eventsFolder.afk:FireServer()
                        end)
                    end
                end
                task.wait(10) -- Increased from 5 to 10 seconds
            end
        end)
    end

    -- Block Kicks
    local function blockKicks()
        local mt = getrawmetatable(game)
        if not mt then return end
        local oldIndex = mt.__index
        if pcall(setreadonly, mt, false) then
            mt.__index = function(self, key)
                if self == LocalPlayer and key == "Kick" then
                    return function() end
                end
                return oldIndex(self, key)
            end
            pcall(setreadonly, mt, true)
        end
    end

    -- Spoof Remote Validation
    local function spoofRemotes()
        local eventsFolder = ReplicatedStorage:FindFirstChild("events")
        if not eventsFolder then return end
        local spoofPatterns = {
            ["returntosurface"] = true,
            ["cast"] = true, ["reelfinished"] = true, ["sell"] = true, ["sellall"] = true, ["drown"] = true, ["discoverlocation"] = true,
            ["offer"] = true, ["equip"] = true,
            ["validate"] = true, ["check"] = true
        }
        for _, event in ipairs(eventsFolder:GetChildren()) do
            if event:IsA("RemoteEvent") then
                local eventName = event.Name:lower()
                if spoofPatterns[eventName] then
                    event.FireServer = function() return true end
                end
            end
        end
    end

    -- Protect Environment
    local function secureEnvironment()
        local protectedFunctions = {"game", "workspace", "getgenv"}
        for _, funcName in ipairs(protectedFunctions) do
            genv._G[funcName] = _G[funcName]
        end
        if hookfunction then
            local oldHook = hookfunction
            _G.hookfunction = function(func, newFunc)
                for _, protected in ipairs(protectedFunctions) do
                    if tostring(func) == protected then
                        return func
                    end
                end
                return oldHook(func, newFunc)
            end
        end
    end

    -- Spoof Camera Properties
    local function spoofCamera()
        local mt = getrawmetatable(game)
        if not mt then return end
        local oldIndex = mt.__index
        if pcall(setreadonly, mt, false) then
            mt.__index = function(self, key)
                if self == LocalPlayer and (key == "CameraMinZoomDistance" or key == "CameraMaxZoomDistance") then
                    return 0
                end
                return oldIndex(self, key)
            end
            pcall(setreadonly, mt, true)
        end
    end

    -- Disable Atomic Binding
    local function disableAtomicChecks()
        local playerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
        if playerScripts then
            local atomic = playerScripts:FindFirstChild("AtomicBinding")
            if atomic then
                pcall(function() 
                    atomic.Disabled = true 
                end)
            end
        end
    end

    -- Physics Monitoring with increased interval
    local connection
    if true then -- Set to false to disable
        local lastCheck = tick()
        connection = RunService.Heartbeat:Connect(function()
            if tick() - lastCheck < 1 then return end -- Increased from 0.5 to 1 second
            lastCheck = tick()
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local hrp = character.HumanoidRootPart
                if hrp.Velocity.Magnitude > 100 then
                    pcall(function() 
                        hrp.Velocity = hrp.Velocity.Unit * 100 
                    end)
                end
            end
        end)
    end

    -- Execute with crash prevention
    pcall(neutralizeAFK)
    pcall(blockKicks)
    pcall(spoofRemotes)
    pcall(secureEnvironment)
    pcall(spoofCamera)
    pcall(disableAtomicChecks)

    -- Cleanup on teleport
    LocalPlayer.OnTeleport:Once(function()
        if connection then 
            connection:Disconnect() 
        end
    end)
end

-- Run bypass safely
task.spawn(function()
    pcall(advancedAntiCheatBypass)
end)

-- Utility Functions
local function teleportTo(position)
    if tick() - lastTeleportTime < teleportCooldown then
        Fluent:Notify({ Title = "Cooldown", Content = "Wait " .. math.ceil(teleportCooldown - (tick() - lastTeleportTime)) .. "s", Duration = 3 })
        return
    end
    local hrp = Character and Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local targetCFrame
        if typeof(position) == "Vector3" then
            targetCFrame = CFrame.new(position)
        elseif typeof(position) == "CFrame" then
            targetCFrame = position
        else
            Fluent:Notify({ Title = "Error", Content = "Invalid teleport position type!", Duration = 3 })
            return
        end
        TweenService:Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Linear), { CFrame = targetCFrame }):Play()
        lastTeleportTime = tick()
        Fluent:Notify({ Title = "Teleport", Content = "Teleported!", Duration = 3 })
    else
        Fluent:Notify({ Title = "Error", Content = "Character not found!", Duration = 3 })
    end
end

local function click_this_gui(to_click)
    if to_click and to_click:IsA("GuiObject") and to_click.Visible then
        GuiService.SelectedObject = to_click
        if GuiService.SelectedObject == to_click then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        end
    end
end

local function centerButton(button)
    if variables.isAutoClicking and button:IsA("ImageButton") then
        button.AnchorPoint = Vector2.new(0.5, 0.5)
        button.Position = UDim2.new(0.5, 0, 0.5, 0)
        button.Size = UDim2.new(0, 100, 0, 100)
    end
end

local function autoClick()
    local shakeUI = PlayerGui:FindFirstChild("shakeui")
    if not shakeUI then return end
    local button = shakeUI.safezone and shakeUI.safezone:FindFirstChild("button")
    if button and button:IsA("ImageButton") and variables.isAutoClicking then
        click_this_gui(button)
    end
end

local function getEquippedRod()
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
    return tool and tool.Name:lower():find("rod") and tool
end

local function equipRod()
    local backpack = LocalPlayer.Backpack
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name:lower():find("rod") and tool:FindFirstChild("events") then
            tool.events.reset:FireServer()
            if LocalPlayer.Character and not LocalPlayer.Character:FindFirstChild(tool.Name) then
                LocalPlayer.Character.Humanoid:EquipTool(tool)
            end
            return true
        end
    end
    Fluent:Notify({Title = "Equip Error", Content = "No rod found in backpack!", Duration = 3})
    return false
end

local function autoCast()
    local castArgs = { [1] = 99.79999999999994, [2] = 1 }
    while variables.autoCastEnabled do
        local rod = getEquippedRod()
        if rod and rod:FindFirstChild("events") then
            rod.events.cast:FireServer(unpack(castArgs))
        end
        task.wait(0.01)
    end
end

local function startCatching(perfect)
    local reelBar = PlayerGui:FindFirstChild("reel") and PlayerGui.reel:FindFirstChild("bar")
    if reelBar and variables.isAutoCatch then
        game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, perfect)
    end
end

local function syncPositions()
    local reel = PlayerGui:FindFirstChild("reel")
    if not reel then return end
    local bar = reel:FindFirstChild("bar")
    if not bar then return end
    local fish = bar:FindFirstChild("fish")
    local playerBar = bar:FindFirstChild("playerbar")
    if fish and playerBar and variables.isAutoCatch then
        playerBar.Position = fish.Position
    end
end

-- Define Event Variables for Events Tab
local eventVariables = {
    Summon_Whale = false,
    Whale_Hunting = false,
    HuntWhaleDebounce = false,
    Kraken_Hunting = false,
    Ancient_Kraken = false,
    Scylla_Hunting = false,
    Meg_Hunting = false,
    Ancient_Meg = false,
    Phantom_Meg = false,
    Summon_Phantom = false,
    Orca_Hunting = false
}

do
    Fluent:Notify({
        Title = "Iced Hub",
        Content = "The script is loading...",
        Duration = 5
    })
end

-- Fish Tab
Tabs.Fish:AddParagraph({
    Title = "Notice",
    Content = "Our Newest Version Update 3.1 | Enjoy❤️"
})

Tabs.Fish:AddSection("Fishing")

Tabs.Fish:AddToggle("AutoEquipRod", {
    Title = "Auto Equip Rod",
    Default = getgenv().config and getgenv().config.auto_equip_rod or false,
    Callback = function(Value)
        getgenv().config = getgenv().config or {}
        getgenv().config.auto_equip_rod = Value
        local function save_config()
            print("[Config] Auto Equip Rod set to:", Value)
        end
        save_config()
        spawn(function()
            while getgenv().config.auto_equip_rod do
                task.wait()
                local rod_name = workspace:FindFirstChild("PlayerStats") 
                    and workspace.PlayerStats:FindFirstChild(LocalPlayer.Name) 
                    and workspace.PlayerStats[LocalPlayer.Name]:FindFirstChild("T") 
                    and workspace.PlayerStats[LocalPlayer.Name].T:FindFirstChild(LocalPlayer.Name) 
                    and workspace.PlayerStats[LocalPlayer.Name].T[LocalPlayer.Name]:FindFirstChild("Stats") 
                    and workspace.PlayerStats[LocalPlayer.Name].T[LocalPlayer.Name].Stats:FindFirstChild("rod")
                rod_name = rod_name and rod_name.Value or "Training Rod"
                local equipped_rod = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(rod_name)
                local back_pack = LocalPlayer:WaitForChild("Backpack")
                if back_pack:FindFirstChild(rod_name) and not equipped_rod then
                    task.wait(0.2)
                    LocalPlayer.Character.Humanoid:EquipTool(back_pack:FindFirstChild(rod_name))
                end
            end
        end)
    end
})

Tabs.Fish:AddToggle("AutoThrowRod", {
    Title = "Auto Throw Rod",
    Default = getgenv().config and getgenv().config.auto_throw_rod or false,
    Callback = function(Value)
        getgenv().config = getgenv().config or {}
        getgenv().config.auto_throw_rod = Value
        local function save_config()
            print("[Config] Auto Throw Rod set to:", Value)
        end
        save_config()
        spawn(function()
            while getgenv().config.auto_throw_rod do
                task.wait()
                local rod_name = workspace:FindFirstChild("PlayerStats") 
                    and workspace.PlayerStats:FindFirstChild(LocalPlayer.Name) 
                    and workspace.PlayerStats[LocalPlayer.Name]:FindFirstChild("T") 
                    and workspace.PlayerStats[LocalPlayer.Name].T:FindFirstChild(LocalPlayer.Name) 
                    and workspace.PlayerStats[LocalPlayer.Name].T[LocalPlayer.Name]:FindFirstChild("Stats") 
                    and workspace.PlayerStats[LocalPlayer.Name].T[LocalPlayer.Name].Stats:FindFirstChild("rod")
                rod_name = rod_name and rod_name.Value or "Training Rod"
                local equipped_rod = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(rod_name)
                if equipped_rod then
                    equipped_rod.events.cast:FireServer(100)
                end
            end
        end)
    end
})

Tabs.Fish:AddToggle("AutoShake", {
    Title = "Auto Shake",
    Default = false,
    Callback = function(value)
        variables.isAutoClicking = value
        if value then
            task.spawn(function()
                while variables.isAutoClicking and task.wait(0.000000000000000000000000000000000001) do
                    autoClick()
                end
            end)
            local shakeUI = PlayerGui:FindFirstChild("shakeui")
            if shakeUI then
                local button = shakeUI.safezone and shakeUI.safezone:FindFirstChild("button")
                if button then centerButton(button) end
            end
        end
    end
})

PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "shakeui" and variables.isAutoClicking then
        local safezone = child:WaitForChild("safezone", 5)
        if safezone then  -- Corrected line
            safezone.ChildAdded:Connect(function(newChild)
                if newChild.Name == "button" then
                    centerButton(newChild)
                end
            end)
        end
    end
end)

Tabs.Fish:AddToggle("AutoCatch", {
    Title = "Auto Reel",
    Default = false,
    Callback = function(value)
        variables.isAutoCatch = value
    end
})

local reelingMethod = "Safe Reeling Perfect"
Tabs.Fish:AddDropdown("ReelingMethod", {
    Title = "Reeling Method",
    Values = {"Safe Reeling Perfect", "Instant Perfect"},
    Multi = false,
    Default = "Safe Reeling Perfect",
    Callback = function(value)
        reelingMethod = value
    end
})

RunService.RenderStepped:Connect(function()
    if variables.isAutoCatch then
        if reelingMethod == "Safe Reeling Perfect" then
            syncPositions()
        elseif reelingMethod == "Instant Perfect" then
            startCatching(true)
        end
    end
end)

Tabs.Fish:AddToggle("FishingToggle", {
    Title = "Instant Reel",
    Description = "Enable Fast Reel To Working",
    Default = false,
    Callback = function(value)
        variables.isFishing = value
        if value then
            task.spawn(function()
                while variables.isFishing and task.wait(2) do
                    local rodName = workspace:FindFirstChild("PlayerStats") and workspace.PlayerStats:FindFirstChild(LocalPlayer.Name) and workspace.PlayerStats[LocalPlayer.Name]:FindFirstChild("T") and workspace.PlayerStats[LocalPlayer.Name].T:FindFirstChild(LocalPlayer.Name) and workspace.PlayerStats[LocalPlayer.Name].T[LocalPlayer.Name]:FindFirstChild("Stats") and workspace.PlayerStats[LocalPlayer.Name].T[LocalPlayer.Name].Stats:FindFirstChild("rod")
                    local reel
                    local startTime = tick()
                    while not reel and tick() - startTime < 10 do
                        reel = PlayerGui:FindFirstChild("reel")
                        task.wait(0.000000001)
                    end
                    if reel then
                        reel:Destroy()
                        LocalPlayer.Character.Humanoid:UnequipTools()
                        task.wait(0)
                        LocalPlayer.Character.Humanoid:EquipTool(Backpack:FindFirstChild(rodName and rodName.Value or "Training Rod"))
                    else
                        LocalPlayer.Character.Humanoid:UnequipTools()
                        task.wait(0)
                        LocalPlayer.Character.Humanoid:EquipTool(Backpack:FindFirstChild(rodName and rodName.Value or "Training Rod"))
                    end
                end
            end)
        end
    end
})

Tabs.Fish:AddSection("Fishing Settings")

Tabs.Fish:AddToggle("MuteReelSound", {
    Title = "Mute Reel Sound",
    Default = false,
    Description = "Deletes fishing reel sounds completely",
    Callback = function(value)
        variables.muteFishingSounds = value
        local soundPaths = {
            ["reelback"] = game:GetService("ReplicatedStorage").resources.sounds.sfx.fishing:FindFirstChild("reelback"),
            ["reelfail"] = game:GetService("ReplicatedStorage").resources.sounds.sfx.fishing:FindFirstChild("reelfail"),
            ["reeling"] = game:GetService("ReplicatedStorage").resources.sounds.sfx.fishing:FindFirstChild("reeling"),
            ["reelstarted"] = game:GetService("ReplicatedStorage").resources.sounds.sfx.fishing:FindFirstChild("reelstarted")
        }
        if value then
            for name, sound in pairs(soundPaths) do
                if sound then
                    sound:Destroy()
                    soundPaths[name] = nil
                end
            end
            Fluent:Notify({ Title = "Sound", Content = "Reel sounds deleted!", Duration = 3 })
        else
            Fluent:Notify({ Title = "Sound", Content = "Reel sounds were deleted and cannot be restored without rejoining.", Duration = 5 })
        end
    end
})

Tabs.Fish:AddToggle("AutoDropBobber", {
    Title = "Auto Drop Bobber (Enhanced)",
    Default = false,
    Description = "Instantly and stealthily moves bobber to optimal water spot",
    Callback = function(isEnabled)
        variables.AutoDrop = isEnabled

        if variables.AutoDrop then
            local function bindBobberListener()
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                if not character then
                    Fluent:Notify({ Title = "Error", Content = "Character not found! Try again.", Duration = 3 })
                    variables.AutoDrop = false
                    return false
                end

                local rod = getEquippedRod()
                if not rod then
                    Fluent:Notify({ Title = "Error", Content = "No rod equipped! Equip a rod first.", Duration = 3 })
                    variables.AutoDrop = false
                    return false
                end

                if variables.autoDropConnection then
                    variables.autoDropConnection:Disconnect()
                end

                variables.autoDropConnection = rod.ChildAdded:Connect(function(child)
                    if child.Name == "bobber" then
                        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                        local nearestWaterPosition = nil
                        local closestDistance = math.huge
                        local maxRange = 100
                        local minOffset = 1
                        local maxOffset = 5

                        local angleStep = math.pi / 8
                        local radiusStep = 5
                        for radius = 0, maxRange, radiusStep do
                            for angle = 0, 2 * math.pi, angleStep do
                                local x = radius * math.cos(angle)
                                local z = radius * math.sin(angle)
                                local checkPosition = humanoidRootPart.Position + Vector3.new(x, 0, z)
                                local rayOrigin = Vector3.new(checkPosition.X, humanoidRootPart.Position.Y + 50, checkPosition.Z)
                                local rayDirection = Vector3.new(0, -150, 0)

                                local raycastParams = RaycastParams.new()
                                raycastParams.FilterDescendantsInstances = {workspace.Terrain}
                                raycastParams.FilterType = Enum.RaycastFilterType.Whitelist

                                local rayResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
                                if rayResult and rayResult.Material == Enum.Material.Water then
                                    local hitPosition = rayResult.Position
                                    local distance = (humanoidRootPart.Position - hitPosition).Magnitude
                                    if distance < closestDistance and distance > minOffset then
                                        closestDistance = distance
                                        nearestWaterPosition = hitPosition
                                    end
                                end
                            end
                            if nearestWaterPosition then break end
                        end

                        if nearestWaterPosition then
                            local distanceToWater = (humanoidRootPart.Position - nearestWaterPosition).Magnitude
                            local dynamicOffset = math.clamp(distanceToWater / 10, minOffset, maxOffset)
                            local offsetDirection = (nearestWaterPosition - humanoidRootPart.Position).Unit
                            local finalPosition = nearestWaterPosition + offsetDirection * dynamicOffset + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))

                            local tweenInfo = TweenInfo.new(0.1 + math.random(0, 20) / 100, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            TweenService:Create(child, tweenInfo, {CFrame = CFrame.new(finalPosition)}):Play()

                            print("Water found at:", nearestWaterPosition, "Distance:", distanceToWater)
                            Fluent:Notify({ 
                                Title = "Auto Drop", 
                                Content = string.format("Bobber moved %.1f studs to water!", distanceToWater), 
                                Duration = 2 
                            })
                        else
                            print("No water found within", maxRange, "studs.")
                            Fluent:Notify({ Title = "Auto Drop", Content = "No water found within " .. maxRange .. " studs!", Duration = 3 })
                        end
                    end
                end)
                return true
            end

            if bindBobberListener() then
                Fluent:Notify({ Title = "Auto Drop", Content = "Enhanced Auto Drop Bobber enabled!", Duration = 2 })
            end

            local characterConnection
            characterConnection = LocalPlayer.CharacterAdded:Connect(function(newChar)
                if variables.AutoDrop then
                    task.wait(1)
                    if not bindBobberListener() then
                        characterConnection:Disconnect()
                    end
                else
                    characterConnection:Disconnect()
                end
            end)

            local lastRod = getEquippedRod()
            task.spawn(function()
                while variables.AutoDrop do
                    local currentRod = getEquippedRod()
                    if currentRod ~= lastRod then
                        lastRod = currentRod
                        if currentRod then
                            bindBobberListener()
                        end
                    end
                    task.wait(0.1)
                end
            end)

        else
            if variables.autoDropConnection then
                variables.autoDropConnection:Disconnect()
                variables.autoDropConnection = nil
                print("Enhanced AutoDropper turned off.")
                Fluent:Notify({ Title = "Auto Drop", Content = "Enhanced Auto Drop Bobber disabled!", Duration = 2 })
            end
        end
    end
})

    -- Teleport Tab (Fixed and Organized)
local teleportCategory = "Rods"
local selectedTeleport = ""

Tabs.Teleport:AddDropdown("TeleportCategory", {
    Title = "Category",
    Values = {"Rods", "Islands", "NPCs", "Totems", "EventZones", "SubLocations", "CastLocations", "MountainLocations", "Levers"},
    Multi = false,
    Default = "Rods",
    Callback = function(value)
        teleportCategory = value
        local locations = {}
        for loc in pairs(teleportData[value]) do 
            table.insert(locations, loc) 
        end
        table.sort(locations) -- Sort alphabetically for better UX
        Options.TeleportLocation:SetValues(locations)
        selectedTeleport = locations[1] or ""
    end
})

Tabs.Teleport:AddDropdown("TeleportLocation", {
    Title = "Location",
    Values = {},
    Multi = false,
    Default = "",
    Callback = function(value) 
        selectedTeleport = value 
    end
})

Tabs.Teleport:AddButton({
    Title = "Teleport",
    Callback = function()
        if teleportData[teleportCategory] and teleportData[teleportCategory][selectedTeleport] then
            teleportTo(teleportData[teleportCategory][selectedTeleport])
        else
            Fluent:Notify({ Title = "Error", Content = "Select a valid location!", Duration = 2 })
        end
    end
})

Tabs.Teleport:AddSection("Tp To Player")

Tabs.Teleport:AddDropdown("TeleportToPlayer", {
    Title = "Players",
    Values = {},
    Multi = false,
    Default = "",
    Callback = function(selectedPlayer)
        local target = Players:FindFirstChild(selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            teleportTo(target.Character.HumanoidRootPart.CFrame)
        end
    end
})

do
    local playerList = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then table.insert(playerList, player.Name) end
    end
    Options.TeleportToPlayer:SetValues(playerList)
end

Tabs.Teleport:AddButton({
    Title = "Discover All Locations",
    Callback = function()
        for key in pairs(teleportData) do
            for loc in pairs(teleportData[key]) do
                ReplicatedStorage.events.discoverlocation:FireServer(loc)
            end
        end
        Fluent:Notify({ Title = "Success", Content = "All locations discovered!", Duration = 2 })
    end
})

-- Initial population of the location dropdown
do
    local initialLocations = {}
    for loc in pairs(teleportData["Rods"]) do 
        table.insert(initialLocations, loc) 
    end
    table.sort(initialLocations)
    Options.TeleportLocation:SetValues(initialLocations)
    selectedTeleport = initialLocations[1] or ""
end

-- Automation Tab
Tabs.Automation:AddParagraph({
    Title = "Notice",
    Content = "Automation tools for selling items, collecting treasures, using items, and enchanting."
})

Tabs.Automation:AddSection("Auto Sell")

-- Existing Auto Sell Features
Tabs.Automation:AddToggle("AutoSell", {
    Title = "Auto Sell",
    Default = false,
    Description = "Automatically sells all items",
    Callback = function(value)
        variables.autoselling = value
        if value then
            task.spawn(function()
                while variables.autoselling and task.wait(variables.autoSellDelay) do
                    pcall(function()
                        game:GetService("ReplicatedStorage").events.SellAll:InvokeServer()
                    end)
                end
            end)
        end
    end
})

Tabs.Automation:AddSlider("AutoSellDelay", {
    Title = "Auto Sell Delay [Seconds]",
    Description = "Time between auto-sells",
    Default = 60,
    Min = 0,
    Max = 600,
    Rounding = 1,
    Callback = function(value)
        variables.autoSellDelay = value
    end
})

Tabs.Automation:AddButton({
    Title = "Sell All",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").events.SellAll:InvokeServer()
        end)
    end
})

Tabs.Automation:AddButton({
    Title = "Sell Hand",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").events.Sell:InvokeServer()
        end)
    end
})

Tabs.Automation:AddToggle("AutoSellHand", {
    Title = "Auto Sell Held Item",
    Default = false,
    Description = "Automatically sells held item",
    Callback = function(value)
        variables.autosellingHand = value
        if value then
            task.spawn(function()
                while variables.autosellingHand and task.wait(0.1) do
                    pcall(function()
                        game:GetService("ReplicatedStorage").events.Sell:InvokeServer()
                    end)
                end
            end)
        end
    end
})

Tabs.Automation:AddSection("Auto Collects")

-- Auto Collect Treasure
Tabs.Automation:AddToggle("AutoCollectTreasure", {
    Title = "Auto Collect Treasure",
    Description = "Automatically collects treasure chests when enabled.",
    Default = false,
    Callback = function(Value)
        _G.AutoCollectTreasure = Value
    end
})

spawn(function()
    local lastCollectionTime = 0
    while task.wait(1) do -- Increased from 0.1 to 1 second
        if _G.AutoCollectTreasure and tick() - lastCollectionTime >= 2 then
            pcall(function()
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.HumanoidRootPart
                if not hrp then return end

                -- Narrow scope to chests folder
                for _, v in pairs(workspace.world.chests:GetChildren()) do
                    if v:IsA("Part") and v:FindFirstChild("ChestSetup") then
                        hrp.CFrame = v.CFrame
                        local prompt = v:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                            prompt.HoldDuration = 0
                            fireproximityprompt(prompt)
                        end
                        task.wait(0.5) -- Delay between collections
                        lastCollectionTime = tick()
                    end
                end
            end)
        end
    end
end)

-- Auto Fully (Treasure Map)
Tabs.Automation:AddToggle("AutoFully", {
    Title = "Auto (Fully)",
    Description = "Automatically repairs the Treasure Map.",
    Default = true,
    Callback = function(Value)
        _G.AutoFully = Value
    end
})

spawn(function()
    while task.wait(0.1) do
        if _G.AutoFully and _G.AutoCollectTreasure then
            pcall(function()
                local player = game.Players.LocalPlayer
                for _, v in pairs(player.Backpack:GetChildren()) do 
                    if v.Name == "Treasure Map" then
                        local humanoid = player.Character and player.Character.Humanoid
                        local hrp = player.Character and player.Character.HumanoidRootPart
                        if humanoid and hrp then
                            humanoid:EquipTool(v)
                            hrp.CFrame = CFrame.new(-2824.359, 214.311, 1518.130)
                            humanoid:EquipTool(v)
                            workspace.world.npcs:WaitForChild("Jack Marrow").treasure.repairmap:InvokeServer()
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto Use Fillionaire
Tabs.Automation:AddToggle("AutoUseFillionaire", {
    Title = "Auto Use Fillionaire",
    Description = "Automatically solves the Fillionaire puzzle.",
    Default = false,
    Callback = function(Value)
        _G.AutoUseFillionaire = Value
    end
})

spawn(function()
    while task.wait(0.1) do
        if _G.AutoUseFillionaire then
            pcall(function()
                local player = game.Players.LocalPlayer
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:UnequipTools()
                    local fillionaire = player.Backpack:FindFirstChild("Fillionaire")
                    if fillionaire then
                        local fillionaireLink = tostring(fillionaire.link.Value)
                        local fillionaireAmount = ReplicatedStorage.playerstats[player.Name].Inventory[fillionaireLink].Stack.Value
                        for _ = 1, fillionaireAmount do
                            humanoid:EquipTool(fillionaire)
                            task.wait(0.1)
                        end
                        task.wait(1)

                        local mainGui = player.PlayerGui.Fillionaire.Main
                        for _, child in ipairs(mainGui:GetChildren()) do
                            if child.Name == "Template" and child.Visible then
                                local playerNumbers = child:FindFirstChild("PlayerNumbers")
                                if playerNumbers then
                                    for i = 1, 4 do
                                        local numberButton = playerNumbers:FindFirstChild(tostring(i))
                                        if numberButton and numberButton:IsA("GuiButton") then
                                            if getconnections then
                                                for _, v in pairs(getconnections(numberButton.MouseButton1Click)) do
                                                    v:Invoke()
                                                end
                                            else
                                                firesignal(numberButton.MouseButton1Click)
                                            end
                                        end
                                    end
                                end
                                task.wait(0.1)
                                child:Destroy()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

Tabs.Automation:AddSection("Auto Totem Use")

-- Totem Automation
Tabs.Automation:AddParagraph({
    Title = "[🌠] Totem",
    Content = "Automate totem usage."
})

Tabs.Automation:AddDropdown("ChooseTotem", {
    Title = "Choose Totem",
    Values = { 
        "Sundial Totem", "Aurora Totem", "Tempest Totem", "Smokescreen Totem", 
        "Windset Totem", "Eclipse Totem", "Meteor Totem", "Blizzard Totem", 
        "Avalanche Totem", "Zeus Storm Totem", "Poseidon's Wrath Totem"
    },
    Default = "",
    Callback = function(Value)
        _G.ChooseTotem = Value
    end
})

Tabs.Automation:AddToggle("AutoUseTotem", {
    Title = "Auto Use Totem",
    Description = "Automatically uses the selected totem.",
    Default = false,
    Callback = function(Value)
        _G.AutoUseTotem = Value
    end
})

local totemList = {
    "Sundial Totem", "Aurora Totem", "Tempest Totem", "Smokescreen Totem",
    "Windset Totem", "Eclipse Totem", "Meteor Totem", "Blizzard Totem",
    "Avalanche Totem", "Zeus Storm Totem", "Poseidon's Wrath Totem"
}

spawn(function()
    local lastUse = 0
    while task.wait(0.5) do -- Increased from 0.1 to 0.5 seconds
        if _G.AutoUseTotem and _G.ChooseTotem and tick() - lastUse > 1 then -- Added debounce
            pcall(function()
                local player = game.Players.LocalPlayer
                for _, v in pairs(player.Backpack:GetChildren()) do
                    if v.Name == _G.ChooseTotem then
                        local humanoid = player.Character and player.Character.Humanoid
                        if humanoid then
                            humanoid:EquipTool(v)
                            game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
                            lastUse = tick()
                            task.wait(0.01)
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto Enchant Section
Tabs.Automation:AddParagraph({
    Title = "[✨] Auto Enchant",
    Content = "Automate rod enchanting process."
})

Tabs.Automation:AddSection("Auto Enchant")

-- Assuming enchantdata is already defined elsewhere
local enchantNames = {}
for enchantName, _ in pairs(enchantdata) do
    table.insert(enchantNames, enchantName)
end
table.sort(enchantNames)
if #enchantNames == 0 then
    table.insert(enchantNames, "No enchants available")
end

-- Enchant selection dropdown
Tabs.Automation:AddDropdown("EnchantSelectDropDown", {
    Title = "Selected Enchant",
    Description = "Select an enchant to auto-apply",
    Values = enchantNames,
    Default = enchantNames[1],
    Callback = function(selectedEnchant)
        genv.SelectedEnchant = selectedEnchant
    end
})

-- Auto Enchant toggle
genv.AutoEnchantToggle = Tabs.Automation:AddToggle("AutoEnchantToggle", {
    Title = "Auto Enchant",
    Default = false,
    Description = "Automatically enchants your rod",
    Callback = function(isEnabled)
        genv.AutoEnchant = isEnabled
        if not isEnabled then return end

        if not genv.SelectedEnchant or genv.SelectedEnchant == "No enchants available" then
            Fluent:Notify({Title = "Auto Enchant", Content = "Select a valid enchant!", Duration = 5})
            genv.AutoEnchantToggle:SetValue(false)
            return
        end

        local player = game.Players.LocalPlayer
        if not (player and player.Character and player.Character.HumanoidRootPart) then
            Fluent:Notify({Title = "Auto Enchant", Content = "Character not loaded!", Duration = 5})
            genv.AutoEnchantToggle:SetValue(false)
            return
        end

        local relicCheck = enchantdata[genv.SelectedEnchant]
        if relicCheck then
            if relicCheck.IsExalted and not workspace[player.Name]:FindFirstChild("Exalted Relic") then
                Fluent:Notify({Title = "Auto Enchant", Content = "Need Exalted Relic!", Duration = 5})
                genv.AutoEnchantToggle:SetValue(false)
                return
            elseif not relicCheck.IsExalted and not workspace[player.Name]:FindFirstChild("Enchant Relic") then
                Fluent:Notify({Title = "Auto Enchant", Content = "Need Enchant Relic!", Duration = 5})
                genv.AutoEnchantToggle:SetValue(false)
                return
            end
        end

        if game:GetService("ReplicatedStorage").world.cycle.Value ~= "Night" then
            Fluent:Notify({Title = "Auto Enchant", Content = "Must be night time!", Duration = 5})
            genv.AutoEnchantToggle:SetValue(false)
            return 
        end

        local equippedRod = getEquippedRod()
        if equippedRod and game:GetService("ReplicatedStorage").playerstats[player.Name].Rods[equippedRod.Name].Value == genv.SelectedEnchant then
            Fluent:Notify({Title = "Auto Enchant", Content = "Already have this enchant!", Duration = 5})
            genv.AutoEnchantToggle:SetValue(false)
            return 
        end

        teleportTo(CFrame.new(1310, -799, -82))
        task.wait(2)

        task.spawn(function()
            local attempts = 0
            while genv.AutoEnchant and attempts < 50 do
                attempts = attempts + 1
                task.wait(0.5)
                pcall(function()
                    local altar = workspace.world.interactables:FindFirstChild("Enchant Altar")
                    if altar and altar:FindFirstChild("ProximityPrompt") and altar.ProximityPrompt.Enabled then
                        fireproximityprompt(altar.ProximityPrompt)
                        task.wait(0.5)
                    end

                    if player.PlayerGui.over:FindFirstChild("prompt") then
                        local confirmButton = player.PlayerGui.over.prompt.confirm
                        if getconnections then
                            for _, v in pairs(getconnections(confirmButton.MouseButton1Click)) do
                                v:Function()
                            end
                        else
                            firesignal(confirmButton.MouseButton1Click)
                        end
                        task.wait(0.5)
                    end

                    local currentRod = getEquippedRod()
                    if currentRod and game:GetService("ReplicatedStorage").playerstats[player.Name].Rods[currentRod.Name].Value == genv.SelectedEnchant then
                        genv.AutoEnchantToggle:SetValue(false)
                        Fluent:Notify({Title = "Auto Enchant", Content = "Success: " .. genv.SelectedEnchant .. " applied!", Duration = 5})
                    end
                end)
            end
            if attempts >= 50 then
                genv.AutoEnchantToggle:SetValue(false)
                Fluent:Notify({Title = "Auto Enchant", Content = "Failed: Max attempts reached!", Duration = 5})
            end
        end)
    end
})

-- Events Tab Enhancements
Tabs.Events:AddSection("Teleport To Events")
Tabs.Events:AddParagraph({
    Title = "[🌊] Event Zone",
    Content = "Monitor and teleport to event zones."
})

local EventZone = Tabs.Events:AddParagraph({
    Title = "[🐢] Event Zone Status",
    Content = "Select an event zone to check its status."
})

-- Event Zone Status Checker
task.spawn(function()
    local lastZone = nil
    local lastCheck = tick()
    while task.wait(3) do -- Increased from 1 to 3 seconds
        pcall(function()
            local zoneExists = false
            if _G.ChooseEventZone then
                if game.Workspace.zones.fishing:FindFirstChild(_G.ChooseEventZone) then
                    EventZone:SetContent("Table Data: [🟢] " .. _G.ChooseEventZone .. " is active!")
                    zoneExists = true
                    if _G.AutoTeleportToEventZone and _G.ChooseEventZone ~= lastZone then
                        local zone = game.Workspace.zones.fishing:FindFirstChild(_G.ChooseEventZone)
                        if zone then
                            zone.CanCollide = true
                            if not zone:FindFirstChild("RodEquipCheck") then
                                local rodpart = Instance.new("Part", zone)
                                rodpart.Name = "RodEquipCheck"
                                equipRod()
                            end
                            local offset = Vector3.new(0, 74, 0)
                            if _G.ChooseEventZone == "Megalodon Default" then
                                offset = Vector3.new(0, 3, 0)
                            elseif _G.ChooseEventZone == "Isonade" or _G.ChooseEventZone == "The Depths - Serpent" or 
                                   _G.ChooseEventZone == "Great Hammerhead Shark" or _G.ChooseEventZone == "Great White Shark" or 
                                   _G.ChooseEventZone == "Whale Shark" then
                                offset = Vector3.new(0, 115, 15)
                            end
                            local targetCFrame = CFrame.new(zone.Position + offset)
                            teleportTo(targetCFrame)
                            Fluent:Notify({
                                Title = "Event Zone",
                                Content = "Teleported to " .. _G.ChooseEventZone .. "!",
                                Duration = 3
                            })
                            lastZone = _G.ChooseEventZone
                        end
                    end
                else
                    EventZone:SetContent("Table Data: [❌] " .. _G.ChooseEventZone .. " is not active.")
                end
            end
            if not zoneExists and not _G.ChooseEventZone then
                EventZone:SetContent("Select an event zone to check its status.")
            end
        end)
    end
end)

-- Event Zone Dropdown
_G.ChooseEventZone = "Isonade"
Tabs.Events:AddDropdown("ChooseEventZone", {
    Title = "Choose Event Zone",
    Values = {
        "Isonade",
        "The Depths - Serpent",
        "Great Hammerhead Shark",
        "Great White Shark",
        "Whale Shark",
        "Kraken Pool",
        "Whales Pool",
        "Orcas Pool",
        "Forsaken Veil - Scylla",
        "Megalodon Default"
    },
    Multi = false,
    Default = "Isonade",
    Callback = function(Value)
        _G.ChooseEventZone = Value
        Fluent:Notify({
            Title = "Event Zone",
            Content = "Selected: " .. Value,
            Duration = 3
        })
    end
})

-- Auto Teleport Toggle
Tabs.Events:AddToggle("AutoTeleportToEventZone", {
    Title = "Auto Teleport To Event Zone",
    Description = "Teleports once to the selected event zone when enabled or changed.",
    Default = false,
    Callback = function(Value)
        _G.AutoTeleportToEventZone = Value
        if Value then
            pcall(function()
                local zone = game.Workspace.zones.fishing:FindFirstChild(_G.ChooseEventZone)
                if zone then
                    zone.CanCollide = true
                    if not zone:FindFirstChild("RodEquipCheck") then
                        local rodpart = Instance.new("Part", zone)
                        rodpart.Name = "RodEquipCheck"
                        equipRod()
                    end
                    local offset = Vector3.new(0, 74, 0)
                    if _G.ChooseEventZone == "Megalodon Default" then
                        offset = Vector3.new(0, 3, 0)
                    elseif _G.ChooseEventZone == "Isonade" or _G.ChooseEventZone == "The Depths - Serpent" or 
                           _G.ChooseEventZone == "Great Hammerhead Shark" or _G.ChooseEventZone == "Great White Shark" or 
                           _G.ChooseEventZone == "Whale Shark" then
                        offset = Vector3.new(0, 115, 15)
                    end
                    local targetCFrame = CFrame.new(zone.Position + offset)
                    teleportTo(targetCFrame)
                    Fluent:Notify({
                        Title = "Event Zone",
                        Content = "Teleported to " .. _G.ChooseEventZone .. "!",
                        Duration = 3
                    })
                else
                    Fluent:Notify({
                        Title = "Event Zone",
                        Content = _G.ChooseEventZone .. " is not currently active!",
                        Duration = 3
                    })
                end
            end)
        end
    end
})

    -- Character Tab
    Tabs.Character:AddParagraph({
        Title = "Notice",
        Content = "Character modification tools."
    })
    
    Tabs.Character:AddToggle("FreezeCharacter", {
        Title = "Freeze Character",
        Default = false,
        Description = "Locks your character in place.",
        Callback = function(isEnabled)
            variables.FreezeCharacter = isEnabled
            local oldpos = nil
            if isEnabled then
                task.spawn(function()
                    while variables.FreezeCharacter and task.wait() do
                        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        local hrp = character:WaitForChild("HumanoidRootPart")
                        if not oldpos then oldpos = hrp.CFrame end
                        hrp.CFrame = oldpos
                        hrp.Velocity = Vector3.zero
                    end
                end)
            end
        end
    })

    Tabs.Character:AddToggle("AntiDrown", {
        Title = "Infinite Oxygen",
        Default = false,
        Callback = function(value)
            pcall(function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("Resources") then return end
                if value then
                    character.Resources.oxygen.Enabled = false
                    character.Resources["oxygen(peaks)"].Enabled = false
                    local CharAddedAntiDrownCon = LocalPlayer.CharacterAdded:Connect(function(newChar)
                        newChar:WaitForChild("Resources")
                        newChar.Resources.oxygen.Enabled = false
                        newChar.Resources["oxygen(peaks)"].Enabled = false
                    end)
                else
                    character.Resources.oxygen.Enabled = true
                    character.Resources["oxygen(peaks)"].Enabled = true
                end
            end)
        end
    })

    Tabs.Character:AddToggle("NoFreezing", {
        Title = "No Temperature Effects",
        Default = false,
        Callback = function(value)
            pcall(function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("Resources") then return end
                if value then
                    character.Resources.temperature.Enabled = false
                    character.Resources["temperature(extreme)"].Enabled = false
                    local AntiTempCharConn = LocalPlayer.CharacterAdded:Connect(function(newChar)
                        newChar:WaitForChild("Resources")
                        newChar.Resources.temperature.Enabled = false
                        newChar.Resources["temperature(extreme)"].Enabled = false
                    end)
                else
                    character.Resources.temperature.Enabled = true
                    character.Resources["temperature(extreme)"].Enabled = true
                end
            end)
        end
    })

    Tabs.Character:AddToggle("WalkOnWaterNew", {
        Title = "Walk on Water",
        Default = false,
        Description = "Makes water surfaces solid.",
        Callback = function(v)
            local ZoneFolder = workspace:FindFirstChild("zones")
            if ZoneFolder then
                for _, part in pairs(ZoneFolder:WaitForChild("fishing"):GetChildren()) do
                    if part:IsA("Part") then
                        part.CanCollide = v
                    end
                end
            end
        end
    })

    Tabs.Character:AddButton({
        Title = "Die",
        Callback = function()
            ReplicatedStorage:WaitForChild("events"):WaitForChild("drown"):FireServer(0)
            Fluent:Notify({ Title = "Action", Content = "Character killed!", Duration = 3 })
        end
    })

    Tabs.Character:AddToggle("HideIdentity", {
        Title = "Hide LocalPlayer Identity",
        Default = false,
        Description = "Hides your identity with a rainbow effect.",
        Callback = function(isEnabled)
            if isEnabled then
                genv.ToggledTest = true
                local function createRainbowGradient(parent)
                    if not parent then return nil end
                    local gradient = Instance.new("UIGradient", parent)
                    gradient.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(242, 138, 54)),
                        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(242, 54, 107)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(134, 54, 242)),
                        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(54, 187, 242)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(54, 242, 173))
                    }
                    return gradient
                end

                local function lockText(target, value)
                    if target and (target:IsA("TextLabel") or target:IsA("TextButton")) then
                        target.Text = value
                        local conn = target:GetPropertyChangedSignal("Text"):Connect(function()
                            if target.Text ~= value then target.Text = value end
                        end)
                        table.insert(genv.lockConnections or {}, conn)
                    end
                end

                local function setupCharacter(character)
                    local hrp = character:WaitForChild("HumanoidRootPart")
                    local userGui = hrp:WaitForChild("user", 5)
                    if not userGui then return end

                    for _, v in ipairs(character:GetDescendants()) do
                        if v:IsA("CharacterMesh") or v:IsA("Accessory") or v:IsA("SpecialMesh") or (v:IsA("Decal") and v.Name == "face") then
                            v:Destroy()
                        elseif v:IsA("BasePart") then
                            v.Material = Enum.Material.Neon
                            v.Color = Color3.fromRGB(255, 255, 255)
                        end
                    end
                    if character:FindFirstChild("Shirt") then character.Shirt:Destroy() end
                    if character:FindFirstChild("Pants") then character.Pants:Destroy() end

                    local hud = PlayerGui:WaitForChild("hud", 5)
                    local safezone = hud and hud:WaitForChild("safezone", 5)
                    if not safezone then return end

                    genv.lockConnections = genv.lockConnections or {}
                    local gradients = {
                        createRainbowGradient(userGui:FindFirstChild("user")),
                        createRainbowGradient(userGui:FindFirstChild("level")),
                        createRainbowGradient(userGui:FindFirstChild("streak")),
                        createRainbowGradient(userGui:FindFirstChild("title")),
                        createRainbowGradient(safezone:FindFirstChild("coins")),
                        createRainbowGradient(safezone:FindFirstChild("lvl"))
                    }

                    lockText(userGui:FindFirstChild("user"), "ICEDHUB")
                    lockText(userGui:FindFirstChild("level"), "Level: ∞")
                    lockText(userGui:FindFirstChild("streak"), "∞")
                    lockText(userGui:FindFirstChild("title"), "❄️")
                    lockText(safezone:FindFirstChild("coins"), "ICEDHUB★ C$")
                    lockText(safezone:FindFirstChild("lvl"), "Level: ∞")

                    genv.MoneyLog = safezone:WaitForChild("StatChangeList").ChildAdded:Connect(function(v)
                        if v:IsA("TextLabel") then v.Text = "ICED❄️" end
                    end)

                    task.spawn(function()
                        local multi, val = 0.7, 0
                        while genv.ToggledTest and task.wait() do
                            val = val + RunService.RenderStepped:Wait() * multi
                            if val > 0.5 then multi = -multi elseif val < -0.5 then multi = -multi end
                            for _, grad in pairs(gradients) do
                                if grad then grad.Offset = Vector2.new(val, 0) end
                            end
                        end
                    end)
                end

                genv.Cow = LocalPlayer.CharacterAdded:Connect(setupCharacter)
                if LocalPlayer.Character then setupCharacter(LocalPlayer.Character) end
            else
                if genv.ToggledTest then
                    genv.ToggledTest = false
                    if genv.Cow then genv.Cow:Disconnect() end
                    if genv.MoneyLog then genv.MoneyLog:Disconnect() end
                    for _, conn in pairs(genv.lockConnections or {}) do conn:Disconnect() end
                    genv.lockConnections = nil
                    Fluent:Notify({ Title = "Identity", Content = "Disabled. Use 'Die' to fully reset.", Duration = 5 })
                end
            end
        end
    })

    -- Gifting Tab
    Tabs.Gifting:AddParagraph({
        Title = "Notice",
        Content = "Tools for gifting items to other players."
    })

Tabs.Gifting:AddSection("Gifting Players")

    local selectedPlayer = ""
    local currentPlayerList = {}
    local giftingOptions = {}

    local function UpdatePlayerList()
        local newPlayerList = {}
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then table.insert(newPlayerList, player.Name) end
        end
        currentPlayerList = newPlayerList
        if giftingOptions.PlayerSelect then giftingOptions.PlayerSelect:SetValues(newPlayerList) end
    end

    local function TradeEquipped()
        if selectedPlayer == "" then
            Fluent:Notify({ Title = "Error", Content = "Select a player first!", Duration = 3 })
            return
        end
        local targetPlayer = Players:FindFirstChild(selectedPlayer)
        if targetPlayer then
            local equippedTool = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
            if equippedTool and equippedTool:FindFirstChild("offer") then
                equippedTool.offer:FireServer(targetPlayer)
            else
                Fluent:Notify({ Title = "Error", Content = "Hold an item first!", Duration = 3 })
            end
        end
    end

    local function GiftAll()
    if selectedPlayer == "" then
        Fluent:Notify({ Title = "Error", Content = "Select a player first!", Duration = 3 })
        getgenv().giftloop = false
        return
    end
    local targetPlayer = Players:FindFirstChild(selectedPlayer)
    if targetPlayer then
        while getgenv().giftloop and task.wait(2) do -- Increased from 0.5 to 2 seconds
            for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
                if not getgenv().giftloop then break end
                if item:FindFirstChild("offer") then
                    LocalPlayer.PlayerGui.hud.safezone.backpack.events.equip:FireServer(item)
                    task.wait(0.5) -- Delay between equip and offer
                    item.offer:FireServer(targetPlayer)
                    task.wait(0.5) -- Delay after offer
                end
            end
        end
    end
end

    local function startAutoConfirm()
        PlayerGui.hud.safezone.bodyannouncements.ChildAdded:Connect(function(child)
            if getgenv().autoconfirm and child:IsA("Frame") and child.Name == "offer" then
                local confirmButton = child:FindFirstChild("confirm")
                local shouldStop = false
                child.AncestryChanged:Connect(function(_, parent) if not parent then shouldStop = true end end)
                if confirmButton then
                    confirmButton.AncestryChanged:Connect(function(_, parent) if not parent then shouldStop = true end end)
                    while not shouldStop and getgenv().autoconfirm and task.wait(0.01) do
                        if confirmButton.Visible then
                            local pos = confirmButton.AbsolutePosition
                            local size = confirmButton.AbsoluteSize
                            local x = pos.X + size.X / 2
                            local y = pos.Y + size.Y / 2 + 58
                            VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, LocalPlayer, 0)
                            VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, LocalPlayer, 0)
                        end
                    end
                end
            end
        end)
    end

    giftingOptions.PlayerSelect = Tabs.Gifting:AddDropdown("PlayerSelect", {
        Title = "Select Player",
        Values = currentPlayerList,
        Multi = false,
        Default = "",
        Callback = function(Value) 
            selectedPlayer = Value 
        end
    })
    UpdatePlayerList()

    Tabs.Gifting:AddButton({ 
        Title = "Refresh Player List", 
        Callback = UpdatePlayerList 
    })

    Tabs.Gifting:AddToggle("AutoGift", {
        Title = "Auto Gift All Items",
        Default = false,
        Callback = function(Value)
            getgenv().giftloop = Value
            if Value then task.spawn(GiftAll) end
        end
    })

    Tabs.Gifting:AddButton({ 
        Title = "Gift Equipped Fish", 
        Callback = TradeEquipped 
    })

    Tabs.Gifting:AddToggle("AutoConfirm", {
        Title = "Auto Confirm Gifts",
        Default = false,
        Callback = function(Value)
            getgenv().autoconfirm = Value
            if Value then startAutoConfirm() end
        end
    })

    Players.PlayerAdded:Connect(function(player)
        if player ~= LocalPlayer then
            table.insert(currentPlayerList, player.Name)
            giftingOptions.PlayerSelect:SetValues(currentPlayerList)
            Fluent:Notify({ Title = "Player Joined", Content = player.Name .. " joined!", Duration = 3 })
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        for i, name in ipairs(currentPlayerList) do
            if name == player.Name then
                table.remove(currentPlayerList, i)
                giftingOptions.PlayerSelect:SetValues(currentPlayerList)
                Fluent:Notify({ Title = "Player Left", Content = player.Name .. " left!", Duration = 3 })
                break
            end
        end
    end)
    
-- Market Tab
Tabs.Market:AddParagraph({
    Title = "Notice",
    Content = "Tools for interacting with the in-game market. Use responsibly!"
})

Tabs.Market:AddSection("Buying Stuff😭")

-- Variables for Market Tab
local marketVariables = {
    SelectedRod = "",
    AvailableRods = {},
    RodDataMap = {}
}

-- Store current CFrame for teleport return
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local currentCFrame = character:WaitForChild("HumanoidRootPart").CFrame

-- Buy Luck Button
Tabs.Market:AddButton({
    Title = "Buy Luck",
    Description = "Purchases luck from Merlin",
    Callback = function()
        local luck = workspace:FindFirstChild("world")
            and workspace.world:FindFirstChild("npcs")
            and workspace.world.npcs:FindFirstChild("Merlin")
            and workspace.world.npcs.Merlin:FindFirstChild("Merlin")

        if luck then
            workspace.world.npcs.Merlin.Merlin.luck:InvokeServer()
            Fluent:Notify({ Title = "Market", Content = "Purchased luck from Merlin!", Duration = 3 })
        else
            teleportTo(CFrame.new(-932, 224, -988))
            Fluent:Notify({ Title = "Market", Content = "Teleported to Merlin. Waiting for luck...", Duration = 3 })
            repeat task.wait() until workspace.world.npcs.Merlin and workspace.world.npcs.Merlin.Merlin
            teleportTo(currentCFrame)
            Fluent:Notify({ Title = "Market", Content = "Returned to original position.", Duration = 3 })
        end
    end
})

-- Buy Relic Button
Tabs.Market:AddButton({
    Title = "Buy Relic",
    Description = "Purchases a relic from Merlin",
    Callback = function()
        local power = workspace:FindFirstChild("world")
            and workspace.world:FindFirstChild("npcs")
            and workspace.world.npcs:FindFirstChild("Merlin")
            and workspace.world.npcs.Merlin:FindFirstChild("Merlin")

        if power then
            workspace.world.npcs.Merlin.Merlin.power:InvokeServer()
            Fluent:Notify({ Title = "Market", Content = "Purchased relic from Merlin!", Duration = 3 })
        else
            teleportTo(CFrame.new(-932, 224, -988))
            Fluent:Notify({ Title = "Market", Content = "Teleported to Merlin. Waiting for relic...", Duration = 3 })
            repeat task.wait() until workspace.world.npcs.Merlin and workspace.world.npcs.Merlin.Merlin
            teleportTo(currentCFrame)
            Fluent:Notify({ Title = "Market", Content = "Returned to original position.", Duration = 3 })
        end
    end
})

-- Rod Purchase Section
-- Function to refresh rod list with error handling
local function refreshRodList()
    marketVariables.AvailableRods = {}
    marketVariables.RodDataMap = {}

    local success, playerStats = pcall(function()
        return workspace:FindFirstChild("PlayerStats") 
            and workspace.PlayerStats:FindFirstChild(player.Name) 
            and workspace.PlayerStats[player.Name]:FindFirstChild("T") 
            and workspace.PlayerStats[player.Name].T:FindFirstChild(player.Name)
    end)

    if not success or not playerStats then
        Fluent:Notify({ Title = "Market", Content = "Error: Player stats not found!", Duration = 3 })
        return
    end

    local coins = playerStats.Stats and playerStats.Stats:FindFirstChild("coins") and playerStats.Stats.coins.Value or 0
    local ownedRods = playerStats.Rods or Instance.new("Folder")

    for rodName, rodData in pairs(roddata) do
        if rodData.Price ~= "inf" and rodData.Price ~= "No Price" and tonumber(rodData.Price) then
            if not ownedRods:FindFirstChild(rodName) then
                local displayName = rodName .. " ($" .. rodData.Price .. ")"
                table.insert(marketVariables.AvailableRods, displayName)
                marketVariables.RodDataMap[displayName] = {rodName, rodData.Price}
            end
        end
    end
    table.sort(marketVariables.AvailableRods)
end

-- Initial population of rod list
refreshRodList()

-- Dropdown for selecting rods
local rodDropdown = Tabs.Market:AddDropdown("RodSelect", {
    Title = "Select Rod",
    Values = marketVariables.AvailableRods,
    Multi = false,
    Default = marketVariables.AvailableRods[1] or "",
    Callback = function(value)
        if not value or value == "" then 
            marketVariables.SelectedRod = ""
            return 
        end
        marketVariables.SelectedRod = value
    end
})

-- Buy Selected Rod Button
Tabs.Market:AddButton({
    Title = "Buy Selected Rod",
    Description = "Purchases the rod selected in the dropdown",
    Callback = function()
        if not marketVariables.SelectedRod or marketVariables.SelectedRod == "" then
            Fluent:Notify({ Title = "Market", Content = "Please select a rod first!", Duration = 3 })
            return
        end

        local rodName = marketVariables.RodDataMap[marketVariables.SelectedRod][1]
        local rodPrice = marketVariables.RodDataMap[marketVariables.SelectedRod][2]
        local playerStats = workspace.PlayerStats[player.Name].T[player.Name]
        local coins = playerStats.Stats and playerStats.Stats.coins and playerStats.Stats.coins.Value or 0

        if tonumber(rodPrice) > coins then
            Fluent:Notify({ Title = "Market", Content = "Not enough coins for " .. rodName .. "!", Duration = 3 })
            return
        end

        if teleportData.Rods[rodName] then
            teleportTo(teleportData.Rods[rodName])
            task.wait(1)
            game.ReplicatedStorage.events.purchase:FireServer(rodName, "Rod", rodPrice, 1)
            Fluent:Notify({ Title = "Market", Content = "Purchased " .. rodName .. "!", Duration = 3 })
            task.wait(0.5)
            refreshRodList()
            rodDropdown:SetValues(marketVariables.AvailableRods)
            rodDropdown:SetValue(marketVariables.AvailableRods[1] or "")
        else
            Fluent:Notify({ Title = "Error", Content = "Rod location not found in teleport data!", Duration = 3 })
        end
    end
})

-- Refresh rod list every 5 seconds
task.spawn(function()
    while task.wait(5) do
        refreshRodList()
        rodDropdown:SetValues(marketVariables.AvailableRods)
        if not marketVariables.SelectedRod or not table.find(marketVariables.AvailableRods, marketVariables.SelectedRod) then
            rodDropdown:SetValue(marketVariables.AvailableRods[1] or "")
        end
    end
end)

-- Config Tab
Tabs.Config:AddParagraph({
    Title = "Notice",
    Content = "Configuration settings for character movement, environment, visuals, notifications, and game modifications."
})

local Config = {
    ['Toggle Walk Speed'] = false,
    ['Set Walk Speed'] = 50,
    ['Toggle Jump Power'] = false,
    ['Set Jump Power'] = 50,
    -- New config variables for game modifications
    ['Disable Cutscenes'] = false,
    ['Disable Crypt Gas'] = false,
    ['Disable Temperature Veil'] = false,
    ['Prevent Death Screen'] = false
}

local AllFuncs = {
    ['Toggle Walk Speed'] = function()
        while task.wait(0.1) do
            pcall(function()
                local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = Config['Toggle Walk Speed'] and Config['Set Walk Speed'] or 16
                end
            end)
            if not Config['Toggle Walk Speed'] then break end
        end
    end,
    ['Toggle Jump Power'] = function()
        while task.wait(0.1) do
            pcall(function()
                local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.JumpPower = Config['Toggle Jump Power'] and Config['Set Jump Power'] or 50
                end
            end)
            if not Config['Toggle Jump Power'] then break end
        end
    end,
    -- New functions for game modifications
    ['Disable Cutscenes'] = function()
        local function modulefunc(file, funcs, disabled)
            local blankfunc = function() end
            local moduleScriptCloneFolder = game:GetService("ReplicatedStorage"):FindFirstChild("ModuleScriptClone")
            
            if not moduleScriptCloneFolder then
                moduleScriptCloneFolder = Instance.new("Folder")
                moduleScriptCloneFolder.Name = "ModuleScriptClone"
                moduleScriptCloneFolder.Parent = game:GetService("ReplicatedStorage")
            end
            
            local clonedFile = moduleScriptCloneFolder:FindFirstChild(file.Name)
            if not clonedFile then
                clonedFile = file:Clone()
                clonedFile.Parent = moduleScriptCloneFolder
            end
            
            local originalModule = require(file)
            
            if disabled then
                for _, func in pairs(funcs) do
                    originalModule[func] = blankfunc
                end
            end
        end
        
        local controller = game:GetService("ReplicatedStorage").client.legacyControllers.CutsceneController
        if Config['Disable Cutscenes'] then
            modulefunc(controller, {"ShowBars", "Start", "DisableAllScreens", "StartCutscene", "Fade"}, true)
            Fluent:Notify({ Title = "Config", Content = "Cutscenes disabled!", Duration = 3 })
        end
    end,
    ['Disable Crypt Gas'] = function()
        local function disabledeathscript(value, name)
            local resources = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Resources
            local script = resources and resources:FindFirstChild(name)
            if script then
                script:Destroy()
            end
        end
        if Config['Disable Crypt Gas'] then
            disabledeathscript(true, "gas")
            Fluent:Notify({ Title = "Config", Content = "Crypt Gas disabled!", Duration = 3 })
        end
    end,
    ['Disable Temperature Veil'] = function()
        local function disabledeathscript(value, name)
            local resources = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Resources
            local script = resources and resources:FindFirstChild(name)
            if script then
                script:Destroy()
            end
        end
        if Config['Disable Temperature Veil'] then
            disabledeathscript(true, "temperature(heat)")
            Fluent:Notify({ Title = "Config", Content = "Temperature Veil disabled!", Duration = 3 })
        end
    end,
    ['Prevent Death Screen'] = function()
        if Config['Prevent Death Screen'] then
            local blocked = {
                [game:GetService("ReplicatedStorage").events.drown] = {"FireServer", true},
            }
            local oldmetamethod
            oldmetamethod = hookmetamethod(game, "__namecall", function(self, ...)
                local calledmethod = getnamecallmethod()
                for method, methodinfo in pairs(blocked) do
                    if self == method and calledmethod == methodinfo[1] and methodinfo[2] then return end
                end
                return oldmetamethod(self, ...)
            end)
            Fluent:Notify({ Title = "Config", Content = "Death Screen prevention activated!", Duration = 3 })
        end
    end
}

Tabs.Config:AddSection("Movement Settings")

Tabs.Config:AddToggle("ToggleWalkSpeed", {
    Title = "Toggle Walk Speed",
    Default = false,
    Callback = function(val)
        Config['Toggle Walk Speed'] = val
        if val then task.spawn(AllFuncs['Toggle Walk Speed']) end
    end
})

Tabs.Config:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Min = 1,
    Max = 500,
    Default = 50,
    Rounding = 1,
    Callback = function(val)
        Config['Set Walk Speed'] = val
    end
})

Tabs.Config:AddToggle("ToggleJumpPower", {
    Title = "Toggle Jump Power",
    Default = false,
    Callback = function(val)
        Config['Toggle Jump Power'] = val
        if val then task.spawn(AllFuncs['Toggle Jump Power']) end
    end
})

Tabs.Config:AddSlider("JumpPower", {
    Title = "Jump Power",
    Min = 1,
    Max = 500,
    Default = 50,
    Rounding = 1,
    Callback = function(val)
        Config['Set Jump Power'] = val
    end
})

Tabs.Config:AddSection("Visual Settings")

local hideUIConnection
Tabs.Config:AddToggle("HideUI", {
    Title = "Hide UI",
    Default = false,
    Description = "Toggles visibility of the game's HUD",
    Callback = function(isEnabled)
        local hud = LocalPlayer.PlayerGui:FindFirstChild("hud")
        if hud and hud:IsA("ScreenGui") then
            if isEnabled then
                hud.Enabled = false
                if not hideUIConnection then
                    hideUIConnection = hud:GetPropertyChangedSignal("Enabled"):Connect(function()
                        hud.Enabled = false
                    end)
                end
            else
                if hideUIConnection then
                    hideUIConnection:Disconnect()
                    hideUIConnection = nil
                end
                hud.Enabled = true
            end
        end
    end
})

Tabs.Config:AddColorpicker("RenderScreenColor", {
    Title = "Change Render Screen Color",
    Default = Color3.fromRGB(0, 0, 0),
    Callback = function(selectedColor)
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        local guh = playerGui:FindFirstChild("guh")
        if guh and guh:FindFirstChild("Frame") then
            guh.Frame.BackgroundColor3 = selectedColor
        end
    end
})

Tabs.Config:AddToggle("Blackscreen", {
    Title = "Low Rendering Screen",
    Default = false,
    Description = "Disables 3D rendering for performance",
    Callback = function(isEnabled)
        genv.whiteScreenToggle = isEnabled
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        local blackScreenGui = playerGui:FindFirstChild("guh")
        
        if isEnabled then
            if not blackScreenGui then
                blackScreenGui = Instance.new("ScreenGui")
                blackScreenGui.Name = "guh"
                blackScreenGui.DisplayOrder = 999
                blackScreenGui.ResetOnSpawn = false
                blackScreenGui.Parent = playerGui
                
                local frame = Instance.new("Frame", blackScreenGui)
                frame.Position = UDim2.new(0, 0, 0, -60)
                frame.Size = UDim2.new(1, 0, 2, 0)
                frame.BackgroundColor3 = Color3.new(0, 0, 0)
            end
            blackScreenGui.Enabled = true
            game:GetService("RunService"):Set3dRenderingEnabled(false)
        else
            if blackScreenGui then
                blackScreenGui.Enabled = false
            end
            game:GetService("RunService"):Set3dRenderingEnabled(true)
        end
    end
})

local rainConnection
Tabs.Config:AddToggle("DisableRain", {
    Title = "Disable Rain",
    Default = true,
    Description = "Hides rain effects",
    Callback = function(isEnabled)
        genv.hideRainToggle = isEnabled

        if rainConnection then
            rainConnection:Disconnect()
            rainConnection = nil
        end

        if isEnabled then
            local lastCheck = tick()
            rainConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if tick() - lastCheck < 1 then return end -- Check every 1 second
                lastCheck = tick()
                pcall(function()
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
            end)
        else
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
    end
})

local underwaterConnections = {}
Tabs.Config:AddToggle("DisableUnderwaterScreen", {
    Title = "Disable Underwater Screen",
    Default = true,
    Description = "Removes underwater visual effects",
    Callback = function(isEnabled)
        for _, conn in pairs(underwaterConnections) do
            if conn.Connected then conn:Disconnect() end
        end
        underwaterConnections = {}

        if isEnabled then
            local lighting = game:GetService("Lighting")
            for _, effectName in pairs({"underwaterbl", "underwatercc"}) do
                local effect = lighting:FindFirstChild(effectName)
                if effect then
                    table.insert(underwaterConnections, effect:GetPropertyChangedSignal("Enabled"):Connect(function()
                        if effect.Enabled then effect.Enabled = false end
                    end))
                end
            end
        end
    end
})

local terrainClearConnection
Tabs.Config:AddToggle("ClearTerrain", {
    Title = "Clear All Terrain [Improve FPS]",
    Default = false,
    Description = "Clears all terrain to improve performance",
    Callback = function(isEnabled)
        genv.clearTerrainToggle = isEnabled

        if terrainClearConnection then
            terrainClearConnection:Disconnect()
            terrainClearConnection = nil
        end

        if isEnabled then
            terrainClearConnection = game:GetService("RunService").RenderStepped:Connect(function()
                workspace.Terrain:ClearAllChildren()
            end)
        end
    end
})

local wavesConnection
Tabs.Config:AddToggle("DisableWaves", {
    Title = "Disable Waves [Improve FPS]",
    Default = true,
    Description = "Disables water waves for better performance",
    Callback = function(isEnabled)
        genv.disableWavesToggle = isEnabled
        local wavesPath = workspace:FindFirstChild("active") and workspace.active:FindFirstChild("constant") 
            and workspace.active.constant:FindFirstChild("Waves") and workspace.active.constant.Waves:FindFirstChild("Waves")
        if wavesPath and wavesPath:FindFirstChild("waves") then
            wavesPath.waves.Enabled = not isEnabled
        end
    end
})

local auroraConnection
Tabs.Config:AddToggle("DisableAurora", {
    Title = "Disable Aurora Borealis [Improve FPS]",
    Default = true,
    Description = "Disables aurora beams for better performance",
    Callback = function(isEnabled)
        genv.disableAuroraToggle = isEnabled

        if auroraConnection then
            auroraConnection:Disconnect()
            auroraConnection = nil
        end

        if isEnabled then
            local lastCheck = tick()
            auroraConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if tick() - lastCheck < 1 then return end -- Check every 1 second
                lastCheck = tick()
                pcall(function()
                    local aurora = workspace:FindFirstChild("active") 
                        and workspace.active:FindFirstChild("constant") 
                        and workspace.active.constant:FindFirstChild("Aurora Borealis") 
                        and workspace.active.constant["Aurora Borealis"]:FindFirstChild("Aurora Borealis")
                    if aurora and aurora:IsA("Folder") then
                        for _, beam in ipairs(aurora:GetChildren()) do
                            if beam:IsA("Beam") then
                                beam.Enabled = false
                            end
                        end
                    end
                end)
            end)
        end
    end
})

Tabs.Config:AddSection("Environment Settings")

local guiConfig = guiConfig or {}
local disablewaterfunc = disablewaterfunc or function() end
local disablewater = nil
local antigp = nil

Tabs.Config:AddToggle("DisableWaterFog", {
    Title = "Disable Water Fog",
    Default = false,
    Callback = function(Value)
        guiConfig.disablewaterfog = Value
        if typeof(saveGuiConfig) == "function" then
            saveGuiConfig()
        end
        if Value then
            if disablewater then 
                disablewater:Disconnect()
            end
            disablewater = game:GetService("RunService").RenderStepped:Connect(disablewaterfunc)
        else
            if disablewater then
                disablewater:Disconnect()
                disablewater = nil
            end
        end
    end
})

Tabs.Config:AddToggle("AntiGamePaused", {
    Title = "Anti Game Paused",
    Default = false,
    Callback = function(Value)
        guiConfig.antigp = Value
        if typeof(saveGuiConfig) == "function" then
            saveGuiConfig()
        end
        if Value then
            local Players = game:GetService("Players")
            if Players.LocalPlayer then
                if antigp then 
                    antigp:Disconnect()
                end
                antigp = game:GetService("RunService").RenderStepped:Connect(function()
                    Players.LocalPlayer.GameplayPaused = false
                end)
            end
        else
            if antigp then
                antigp:Disconnect()
                antigp = nil
            end
        end
    end
})

Tabs.Config:AddToggle("AutoBalance Monthuke", {
    Title = "Auto Balance Nuke",
    Default = true,
    Description = "Automatically balances the nuke minigame",
    Callback = function(isEnabled)
        variables.AutoBalanceNuke = isEnabled
        genv.AutoBalanceNuke = isEnabled
        local StartMinigame
        if genv.getgc then
            task.spawn(function()
                for i, v in pairs(getgc(true)) do
                    if type(v) == "function" then
                        local name = debug.info(v, "n")
                        if name == "StartMinigame" then
                            StartMinigame = v
                        elseif name == "LoopMinigame" then
                            if debug.setupvalue then
                                task.spawn(function()
                                    while true do
                                        if variables.AutoBalanceNuke then
                                            local success, result = pcall(function()
                                                debug.setupvalue(v, 13, os.clock() - 10)
                                            end)
                                            if not success then
                                                break
                                            end
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
            if variables.AutoBalanceNuke then
                task.wait(1)
                if LocalPlayer.PlayerGui:FindFirstChild("NukeMinigame") then
                    if variables.AutoBalanceNukeConnection then
                        variables.AutoBalanceNukeConnection:Disconnect()
                    end
                    variables.AutoBalanceNukeConnection = LocalPlayer.PlayerGui.NukeMinigame.Center.Marker.Pointer.Frame:GetPropertyChangedSignal("AbsoluteRotation"):Connect(function()
                        local rot = LocalPlayer.PlayerGui.NukeMinigame.Center.Marker.Pointer.Frame.AbsoluteRotation
                        if rot < -35 then
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                        elseif rot > 35 then
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                        end
                    end)
                end
            else
                if variables.AutoBalanceNukeConnection then
                    variables.AutoBalanceNukeConnection:Disconnect()
                    variables.AutoBalanceNukeConnection = nil
                end
            end
        end
    end
})

Tabs.Config:AddToggle("AutoOpenHeldItem", {
    Title = "Auto Open Held Item",
    Default = false,
    Description = "Automatically activates the held item",
    Callback = function(isEnabled)
        variables.AutoOpenItem = isEnabled
        genv.AutoOpenItem = isEnabled
        while variables.AutoOpenItem do
            local item = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if item then
                item:Activate()
            else
                Fluent:Notify({Title = "Auto Open Item", Content = "No item found to activate.", Duration = 5})
                variables.AutoOpenItem = false
                genv.AutoOpenItem = false
                return
            end
            task.wait()
        end
    end
})

Tabs.Config:AddSection("Webhook Notifications")

Tabs.Config:AddToggle("WebhookToggle", {
    Title = "Enable Webhook",
    Default = false,
    Description = "Sends fishing updates to Discord",
    Callback = function(value)
        WebhookConfig.Enabled = value
        Fluent:Notify({
            Title = "Webhook",
            Content = value and "Webhook notifications enabled!" or "Webhook notifications disabled!",
            Duration = 3
        })
    end
})

Tabs.Config:AddInput("WebhookURL", {
    Title = "Webhook URL",
    Default = "",
    Placeholder = "Enter Discord Webhook URL",
    Callback = function(value)
        WebhookConfig.URL = value
        Fluent:Notify({
            Title = "Webhook",
            Content = "Webhook URL updated!",
            Duration = 3
        })
    end
})

Tabs.Config:AddSection("Game Modifications")

Tabs.Config:AddToggle("DisableCutscenes", {
    Title = "Disable Cutscenes",
    Default = false,
    Description = "Prevents cutscenes from playing",
    Callback = function(val)
        Config['Disable Cutscenes'] = val
        if val then 
            task.spawn(AllFuncs['Disable Cutscenes'])
            -- Reapply on character respawn
            LocalPlayer.CharacterAdded:Connect(function()
                if Config['Disable Cutscenes'] then
                    task.spawn(AllFuncs['Disable Cutscenes'])
                end
            end)
        end
    end
})

Tabs.Config:AddToggle("DisableCryptGas", {
    Title = "Disable Crypt Gas",
    Default = false,
    Description = "Prevents damage from Crypt Gas",
    Callback = function(val)
        Config['Disable Crypt Gas'] = val
        if val then 
            task.spawn(AllFuncs['Disable Crypt Gas'])
            -- Reapply on character respawn
            LocalPlayer.CharacterAdded:Connect(function()
                if Config['Disable Crypt Gas'] then
                    task.spawn(AllFuncs['Disable Crypt Gas'])
                end
            end)
        end
    end
})

Tabs.Config:AddToggle("DisableTemperatureVeil", {
    Title = "Disable Temperature Veil",
    Default = false,
    Description = "Prevents damage from Temperature Veil",
    Callback = function(val)
        Config['Disable Temperature Veil'] = val
        if val then 
            task.spawn(AllFuncs['Disable Temperature Veil'])
            -- Reapply on character respawn
            LocalPlayer.CharacterAdded:Connect(function()
                if Config['Disable Temperature Veil'] then
                    task.spawn(AllFuncs['Disable Temperature Veil'])
                end
            end)
        end
    end
})

Tabs.Config:AddToggle("PreventDeathScreen", {
    Title = "Prevent Death Screen",
    Default = false,
    Description = "Blocks the death screen from appearing",
    Callback = function(val)
        Config['Prevent Death Screen'] = val
        if val then 
            task.spawn(AllFuncs['Prevent Death Screen'])
        end
    end
})

-- Final Setup
Window:SelectTab(1)

Fluent:Notify({
    Title = "Iced Hub",
    Content = "The script has been loaded successfully! ❄️",
    Duration = 8
})
