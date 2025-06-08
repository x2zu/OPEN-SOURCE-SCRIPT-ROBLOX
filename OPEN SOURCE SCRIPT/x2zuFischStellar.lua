-- maybe someday will be usefull lol
-- local player = game.Players.LocalPlayer
-- local screenGui = Instance.new("ScreenGui")
-- screenGui.Parent = player:WaitForChild("PlayerGui")

-- -- Main popup frame with blur effect
-- local blurEffect = Instance.new("BlurEffect")
-- blurEffect.Size = 10
-- blurEffect.Parent = game.Lighting

-- local popup = Instance.new("Frame")
-- popup.Size = UDim2.new(0, 300, 0, 100)
-- popup.Position = UDim2.new(1, 10, 1, -150) 
-- popup.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
-- popup.BackgroundTransparency = 0.1
-- popup.BorderSizePixel = 0
-- popup.Parent = screenGui

-- -- Sleek corner rounding
-- local corner = Instance.new("UICorner")
-- corner.CornerRadius = UDim.new(0, 20)
-- corner.Parent = popup

-- -- Cool glow effect with outline (now dark blue)
-- local glow = Instance.new("ImageLabel")
-- local glowSize = 20
-- glow.Size = UDim2.new(1, glowSize * 2, 1, glowSize * 2)
-- glow.Position = UDim2.new(0, -glowSize, 0, -glowSize)
-- glow.Image = "rbxassetid://5028857084"
-- glow.ImageColor3 = Color3.fromRGB(0, 0, 139)  -- Dark blue glow color
-- glow.BackgroundTransparency = 1
-- glow.ImageTransparency = 0.8
-- glow.Parent = popup

-- -- Outline effect for the popup
-- local stroke = Instance.new("UIStroke")
-- stroke.Color = Color3.fromRGB(0, 0, 139)  -- Dark blue outline color
-- stroke.Thickness = 4  -- Set outline thickness
-- stroke.Parent = popup

-- -- Animated gradient
-- local uiGradient = Instance.new("UIGradient")
-- uiGradient.Color = ColorSequence.new{
--     ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 139)),  -- Dark blue
--     ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 255)),  -- Blue
--     ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 139))  -- Dark blue
-- }
-- uiGradient.Parent = popup

-- -- Animated gradient rotation
-- local gradientRotation = 0
-- game:GetService("RunService").RenderStepped:Connect(function()
--     gradientRotation = (gradientRotation + 1) % 360
--     uiGradient.Rotation = gradientRotation
-- end)

-- -- Stylish text
-- local label = Instance.new("TextLabel")
-- label.Size = UDim2.new(0.75, 0, 1, 0)
-- label.Position = UDim2.new(0.18, 0, 0, 0)
-- label.Text = "Loading.. please wait!"
-- label.TextColor3 = Color3.fromRGB(255, 255, 255)
-- label.Font = Enum.Font.GothamBold
-- label.TextSize = 18
-- label.TextWrapped = true
-- label.TextXAlignment = Enum.TextXAlignment.Left
-- label.BackgroundTransparency = 1
-- label.Parent = popup

-- -- Cool icon with pulse effect
-- local icon = Instance.new("ImageLabel")
-- icon.Size = UDim2.new(0, 40, 0, 40)
-- icon.Position = UDim2.new(0, 10, 0.5, -20)
-- icon.Image = "rbxassetid://85779221265543"
-- icon.BackgroundTransparency = 1
-- icon.ScaleType = Enum.ScaleType.Fit
-- icon.Parent = popup

-- local tweenService = game:GetService("TweenService")

-- -- Enhanced animations
-- local slideInTween = tweenService:Create(popup, 
--     TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
--     {Position = UDim2.new(1, -320, 1, -120)}
-- )

-- local slideOutTween = tweenService:Create(popup, 
--     TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
--     {Position = UDim2.new(1, 10, 1, -120)}
-- )

-- -- Pulse animation for icon
-- local function pulseIcon()
--     local pulseTween = tweenService:Create(icon,
--         TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true),
--         {Size = UDim2.new(0, 45, 0, 45)}
--     )
--     pulseTween:Play()
-- end

-- -- Execute animations
-- slideInTween:Play()
-- pulseIcon()

-- wait(2)

-- slideOutTween:Play()
-- wait(0.7)
-- blurEffect:Destroy()
-- screenGui:Destroy()
-- Ads
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
AdFrame.BorderColor3 = Color3.fromRGB(0, 0, 139) -- Biru Gelap

-- Gradient untuk Background AdFrame
UIGradientFrame.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), -- Putih di atas
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 139)) -- Biru Gelap di bawah
}
UIGradientFrame.Parent = AdFrame

DiscordLabel.Name = "DiscordLabel"
DiscordLabel.Parent = AdFrame
DiscordLabel.Size = UDim2.new(1, 0, 0.6, 0)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "Stellar"
DiscordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordLabel.TextSize = 22
DiscordLabel.TextWrapped = true

UIGradientText.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), -- Putih di atas
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(70, 130, 180)), -- Gradasi Biru Muda
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 139)) -- Biru Gelap di bawah
}
UIGradientText.Parent = DiscordLabel

CopyButton.Name = "CopyButton"
CopyButton.Parent = AdFrame
CopyButton.Size = UDim2.new(0.4, 0, 0.2, 0)
CopyButton.Position = UDim2.new(0.1, 0, 0.7, 0)
CopyButton.Text = "Copy Link Discord"
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 139) -- Biru Gelap
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
        setclipboard("https://discord.gg/FmMuvkaWvG")
        task.wait()
        CopyButton.Text = "Copied To Discord Link"
        task.wait(0.6)
        CopyButton.Text = "Copy Link Discord"
    end
end)

ExitButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

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


-- Fluent UI Setup with Locked Responsive Scaling
local StellarLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/loader/refs/heads/main/VentureData/StellarUI.lua"))()

local Window = StellarLibrary:CreateWindow({Title = "TEST"})

print([[  
  ∧,,,∧
(  ̳• · • ̳)
/    づ You want my heart? Don't skid please :D
  ∧,,,∧
(  ̳• · • ̳)
/    づ♡ Ok here's my heart

🟢 Successfully Loaded!
]])
local Info = Window:AddTab({ Title = "Information", Icon = "rbxassetid://10723415903" })
local Fish = Window:AddTab({ Title = "Fishing", Icon = "anchor" })
local Items = Window:AddTab({ Title = "Market", Icon = "rbxassetid://10734952273" })
local Teleport = Window:AddTab({Title = "Worlds", Icon = "rbxassetid://10709811445"})
local Event = Window:AddTab({ Title = "Event", Icon = "rbxassetid://103886955707876" })
local Automatically = Window:AddTab({Title = "Automatically", Icon = "rbxassetid://104768258304566"})
local Exclusives = Window:AddTab({ Title = "Exclusives", Icon = "rbxassetid://10734966248" })
local Misc = Window:AddTab({Title = "Misc", Icon = "rbxassetid://10734976739"})
local Settings = Window:AddTab({Title = "Settings", Icon = "rbxassetid://10734950020"})
local Options = StellarLibrary.Options
-- Final Setup
task.spawn(function()
    wait(0.5)
    StellarLibrary:Notify({
        Title = "Stellar",
        Content = "The script has been loaded successfully!",
        Duration = 4 -- Set to nil to make the notification not disappear
    })
end) 
local InformationSection1 = Info:AddSection({ Title = "Announcements" })
InformationSection1:AddParagraph({
    Title = "Information",
    Content = "This script is new and currently under development. Features may change over time."
})
local InformationSection2 = Info:AddSection({ Title = "Blacklist" })

InformationSection2:AddParagraph({
    Title = "Blacklist",
    Content = [[
Tropicana (oggsunny Noob Developer)
Reason: Attempted to bypass using `print`; lacks proper development skills and copies code from GPT and Stellar.
    ]]
})


-- local ValuesSection = Info:AddSection({ Title = "Values Inventory" })

-- -- Load FishData
-- local FishData = loadstring(game:HttpGet("https://raw.githubusercontent.com/ProjektEta/Vixie.lua/refs/heads/main/Tools/Fisch/FishData.lua"))()

-- -- Format angka jadi ribuan
-- local function FormatNumber(n)
--     return tostring(math.floor(n)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
-- end

-- -- Hitung total value inventory ikan
-- local function GetPlayerFishValue(playerName)
--     local data = workspace.PlayerStats 
--         and workspace.PlayerStats:FindFirstChild(playerName) 
--         and workspace.PlayerStats[playerName]:FindFirstChild("T") 
--         and workspace.PlayerStats[playerName].T:FindFirstChild(playerName)

--     if not data then return 0 end
--     local inventory = data:FindFirstChild("Inventory")
--     if not inventory then return 0 end

--     local totalValue = 0
--     for _, item in pairs(inventory:GetChildren()) do
--         local fishData = FishData.Fish[item.Value]
--         if fishData then
--             local price = fishData.Price

--             if item:FindFirstChild("Weight") and fishData.WeightPool and fishData.WeightPool[2] then
--                 price = math.ceil(fishData.Price / fishData.WeightPool[2] * item.Weight.Value * 10)
--             end

--             if item:FindFirstChild("Shiny") and item.Shiny.Value then price *= 1.85 end
--             if item:FindFirstChild("Sparkling") and item.Sparkling.Value then price *= 1.85 end
--             if item:FindFirstChild("Mutation") and FishData.Mutations[item.Mutation.Value] then
--                 price *= tonumber(FishData.Mutations[item.Mutation.Value].PriceMultiply)
--             end

--             local stack = item:FindFirstChild("Stack") and item.Stack.Value or 1
--             totalValue += price * stack
--         end
--     end

--     return totalValue
-- end

-- local playerName = game.Players.LocalPlayer.Name
-- local paragraph = ValuesSection:AddParagraph({
--     Title = "Inventory Value",
--     Content = "Click 'Update' to refresh."
-- })

-- -- Tombol Update
-- ValuesSection:AddButton({
--     Title = "Update Values",
--     Callback = function()
--         local value = GetPlayerFishValue(playerName)
--         paragraph:Set(string.format("Username: %s\nC$: %s C$", playerName, FormatNumber(value)))
--     end
-- })

-- -- Tombol Kirim Notifikasi
-- ValuesSection:AddButton({
--     Title = "Check Values Inventory",
--     Description = "Notify current inventory value",
--     Callback = function()
--         local value = GetPlayerFishValue(playerName)
--         StellarLibrary:Notify({
--             Title = "Inventory Value",
--             Content = FormatNumber(value) .. " C$",
--             Duration = 4
--         })
--     end
-- })

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
    StellarLibrary:Notify({Title = "Equip Error", Content = "No rod found in backpack!", Duration = 3})
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

local function startCatching()
    local reelBar = PlayerGui:FindFirstChild("reel") and PlayerGui.reel:FindFirstChild("bar")
    if reelBar and variables.isAutoCatch then
        local reelfinished = ReplicatedStorage:WaitForChild("events"):WaitForChild("reelfinished ")
        reelfinished:FireServer(variables.perfectValue or 100, true)
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


local MainLeft = Fish:AddSection({Title = "Fishing"})
local MainRight = Fish:AddSection({Title = "Fish Settings"})

MainLeft:AddToggle("AutoThrowRod", {
    Title = "Auto Cast",
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
                rod_name = rod_name and rod_name.Value

                if rod_name then
                    local equipped_rod = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(rod_name)
                    if equipped_rod then
                        equipped_rod.events.cast:FireServer(getgenv().config.auto_cast_power or 100)
                    end
                end
            end
        end)
    end 
})
local lureSpeedLabel -- UI label untuk menampilkan Lure Speed

MainLeft:AddToggle("AutoThrowRod", {
    Title = "Auto Cast",
    Default = getgenv().config and getgenv().config.auto_throw_rod or false,
    Callback = function(Value)
        getgenv().config = getgenv().config or {}
        getgenv().config.auto_throw_rod = Value

        local function save_config()
            print("[Config] Auto Throw Rod set to:", Value)
        end
        save_config()

        -- Tampilkan atau sembunyikan label sesuai toggle
        if Value then
            if not lureSpeedLabel then
                lureSpeedLabel = MainLeft:AddLabel("Lure Speed: Fetching...")
            else
                lureSpeedLabel:SetVisible(true)
            end
        elseif lureSpeedLabel then
            lureSpeedLabel:SetVisible(false)
        end

        spawn(function()
            while getgenv().config.auto_throw_rod do
                task.wait()

                local playerStats = workspace:FindFirstChild("PlayerStats")
                local stats = playerStats
                    and playerStats:FindFirstChild(LocalPlayer.Name)
                    and playerStats[LocalPlayer.Name]:FindFirstChild("T")
                    and playerStats[LocalPlayer.Name].T:FindFirstChild(LocalPlayer.Name)
                    and playerStats[LocalPlayer.Name].T[LocalPlayer.Name]:FindFirstChild("Stats")

                local rod_name = stats and stats:FindFirstChild("rod")
                rod_name = rod_name and rod_name.Value

                if rod_name then
                    local equipped_rod = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(rod_name)
                    if equipped_rod then
                        -- Ambil dan tampilkan lure speed
                        local lure_speed = equipped_rod:FindFirstChild("lureSpeed")
                        if lure_speed and lureSpeedLabel then
                            lureSpeedLabel:SetText("Lure Speed: " .. tostring(math.floor(lure_speed.Value * 100) / 100))
                        end
                        -- Auto cast
                        equipped_rod.events.cast:FireServer(getgenv().config.auto_cast_power or 100)
                    end
                end
            end
        end)
    end
})


MainLeft:AddToggle("AutoShake", {
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

MainLeft:AddToggle("AutoCatch", {
    Title = "Auto Reel",
    Default = false,
    Callback = function(value)
        variables.isAutoCatch = value
    end
})

local reelingMethod = "Safe Reeling Perfect"
MainRight:AddDropdown("ReelingMethod", {
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
MainRight:AddSlider("PerfectValue", {
    Title = "Perfect Catch Value",
    Description = "Adjusts the perfect value sent when catching",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Callback = function(value)
        variables.perfectValue = value
    end
})
MainRight:AddSlider("AutoCastPower", {
    Title = "Auto Cast Power",
    Description = "Adjust power for auto casting the rod",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Callback = function(value)
        getgenv().config = getgenv().config or {}
        getgenv().config.auto_cast_power = value
    end
})


MainLeft:AddToggle("FishingToggle", {
    Title = "Instant Reel",
    Description = "Enable Instant Perfect",
    Default = false,
    Callback = function(value)
        variables.isFishing = value
        if value then
            task.spawn(function()
                while variables.isFishing and task.wait(2) do
                    local statRoot = workspace:FindFirstChild("PlayerStats")
                        and workspace.PlayerStats:FindFirstChild(LocalPlayer.Name)
                        and workspace.PlayerStats[LocalPlayer.Name]:FindFirstChild("T")
                        and workspace.PlayerStats[LocalPlayer.Name].T:FindFirstChild(LocalPlayer.Name)
                        and workspace.PlayerStats[LocalPlayer.Name].T[LocalPlayer.Name]:FindFirstChild("Stats")
                    local rodStat = statRoot and statRoot:FindFirstChild("rod")
                    local rodName = rodStat and rodStat.Value

                    local reel
                    local startTime = tick()
                    while not reel and tick() - startTime < 10 do
                        reel = PlayerGui:FindFirstChild("reel")
                        task.wait(0.1)
                    end

                    -- Destroy reel GUI if found
                    if reel then
                        reel:Destroy()
                    end

                    -- Unequip current tool
                    LocalPlayer.Character.Humanoid:UnequipTools()
                    task.wait()

                    -- Equip the rod tool only if it exists in backpack
                    if rodName then
                        local tool = Backpack:FindFirstChild(rodName)
                        if tool then
                            LocalPlayer.Character.Humanoid:EquipTool(tool)
                        end
                    end
                end
            end)
        end
    end
})

MainRight:AddParagraph({
    Title = "Instant Reel Guide",
    Content = "To use Instant Reel:\n- Enable Auto Reel\n- Enable Instant Perfect\n\nThese features work together to activate Instant Reel automatically."
})
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RepliStorage = game:GetService("ReplicatedStorage")
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
--	local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    local VirtualInputManager = Instance.new("VirtualInputManager") -- fak u
    local VirtualUser = game:GetService("VirtualUser")
    local StarterGui = game:GetService("StarterGui")
    local CoreGui = game:GetService("CoreGui")
--	local GuiService = game:GetService("GuiService")
    local CollectionService = game:GetService("CollectionService")
    local UserInputService = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
    local CorePackages = game:GetService("CorePackages")
    local VeryImportantPart = Instance.new("Part") -- fake zone for tricking temperature/oxygen scripts

local LocalPlayer = Players.LocalPlayer
local Utils = {}
--local CurrentTool: Tool? 
--Variable
local InstantBob = false
local InstantBobConnection

MainLeft:AddToggle("InstantBobber", {
    Title = "Instant Bobber",
    Default = false,
    Description = "Instan pivot bobber ke permukaan air di bawah",
    Callback = function(Value)
        InstantBob = Value

        if InstantBob then
            InstantBobConnection = RunService.RenderStepped:Connect(function()
                local success, err = pcall(function()
                    local Character = LocalPlayer.Character
                    if not Character then return end

                    local Tool = Character:FindFirstChildOfClass("Tool")
                    if not Tool then return end

                    local Bobber = Tool:FindFirstChild("bobber")
                    if not Bobber then return end

                    local Params = RaycastParams.new()
                    Params.FilterType = Enum.RaycastFilterType.Include
                    Params.FilterDescendantsInstances = { workspace.Terrain }

                    local RayResult = workspace:Raycast(Bobber.Position, Vector3.new(0, -10, 0), Params)
                    if RayResult and RayResult.Instance and RayResult.Instance:IsA("Terrain") then
                        Bobber:PivotTo(CFrame.new(RayResult.Position))
                    end
                end)
                
                if not success then
                    warn("[InstantBobber Error]:", err)
                end
            end)
        elseif InstantBobConnection then
            InstantBobConnection:Disconnect()
            InstantBobConnection = nil
        end
    end
})

-- Other Settings
local OtherSettings = Fish:AddSection({Title = "Other Settings"})
OtherSettings:AddToggle("MuteReelSound", {
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
        end
    end
})
local AutoFishTest = OtherSettings:AddToggle("AutoFishSpeedTest", {
    Title = "Fishing Speed Test [F9]",
    Default = false,
    Description = "Measure average catch speed",
    Callback = function(state)
        if state then
            task.spawn(function()
                local getRod = function()
                    local rod = nil
                    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v.ToolTip == "fisch" then
                            rod = v
                        end
                    end
                    for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                        if v:IsA("Tool") and v.ToolTip == "fisch" then
                            rod = v
                        end
                    end
                    return rod
                end

                local isBusy = function()
                    return LocalPlayer.PlayerGui:FindFirstChild("shakeui") or LocalPlayer.PlayerGui:FindFirstChild("reel")
                end

                local isCounting = false
                local tickCount = nil
                local inCount = true
                local catchCount = 0
                local catchData = {}
                local totalCatchTime = 0
                local averageCount = 10

                print("[ Auto Fishing Speed Test ]")
                print("Rod: " .. getRod().Name .. " | Ping: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString())

                while state and task.wait() do
                    if inCount then
                        if #catchData >= averageCount then
                            inCount = false
                            for _, v in ipairs(catchData) do
                                totalCatchTime += v
                            end
                            print("Average Catch Time: " .. tostring(totalCatchTime / averageCount) .. "s")
                            break
                        else
                            local rod = getRod()
                            local bobber = rod and rod:FindFirstChild("bobber")

                            if bobber and isBusy() then
                                if not isCounting then
                                    isCounting = true
                                    tickCount = tick()
                                end
                            elseif not bobber and not isBusy() then
                                if isCounting then
                                    isCounting = false
                                    local duration = tick() - tickCount
                                    catchCount += 1
                                    print("[" .. catchCount .. "] Catch in " .. tostring(duration) .. "s")
                                    table.insert(catchData, duration)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})

local LocalPlayer = Players.LocalPlayer
local animatorDisabled = false

local function SetAnimatorState(character, state)
    local humanoid = character:WaitForChild("Humanoid")
    local existingAnimator = humanoid:FindFirstChildOfClass("Animator")

    if state then
        if existingAnimator then
            existingAnimator:Destroy()
        end
    else
        if not existingAnimator then
            local newAnimator = Instance.new("Animator")
            newAnimator.Name = "Animator"
            newAnimator.Parent = humanoid
        end
    end
end

OtherSettings:AddToggle("ToggleAnimator", {
    Title = "Disable Animator",
    Description = "Disable Animator Feature",
    Default = false,
    Callback = function(state)
        animatorDisabled = state
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        SetAnimatorState(character, animatorDisabled)
    end
})

-- LocalPlayer.CharacterAdded:Connect(function(character)
--     character:WaitForChild("Humanoid")
--     SetAnimatorState(character, animatorDisabled)
-- end)
-- local Players = game:GetService("Players")
-- local player = Players.LocalPlayer
-- local backpack = player.PlayerGui.hud.safezone.backpack

-- local function toggleHotbarRarityStars(state)
--     local hotbar = backpack.hotbar
--     for _, item in pairs(hotbar:GetChildren()) do
--         local rarityStar = item:FindFirstChild("raritystar")
--         if rarityStar then
--             rarityStar.Visible = state
--         end
--     end
-- end

-- -- Fungsi untuk atur visibilitas raritystar di inventory
-- local function toggleInventoryRarityStars(state)
--     local inventoryScroll = backpack.inventory.scroll
--     for _, item in pairs(inventoryScroll:GetChildren()) do
--         local rarityStar = item:FindFirstChild("raritystar")
--         if rarityStar then
--             rarityStar.Visible = state
--         end
--     end
-- end

-- -- Toggle UI
-- local ToggleLeft = OtherSettings:AddToggle("HideRarityStar", {
--     Title = "Hide Rarity Star",
--     Default = true
-- })

-- ToggleLeft:OnChanged(function(value)
--     toggleHotbarRarityStars(value)
--     toggleInventoryRarityStars(value)
-- end)

-- -- Inisialisasi saat load
-- toggleHotbarRarityStars(ToggleLeft.Value)
-- toggleInventoryRarityStars(ToggleLeft.Value)

local player = game:GetService("Players").LocalPlayer
local backpack = player.PlayerGui.hud.safezone.backpack

-- local ShowFishPrices = OtherSettings:AddToggle("ShowFishPrices", {
--     Title = "Show Fish Prices",
--     Default = true
-- })

-- local ok, data = pcall(function()
--     return loadstring(game:HttpGet("https://raw.githubusercontent.com/isMoons/loader/refs/heads/main/StellarData/FishOnly.lua"))()
-- end)

-- if not ok or type(data) ~= "table" or type(data.DataFish) ~= "table" then
--     warn("Gagal mengambil data dari GitHub.")
--     return
-- end

-- local FishPrices = data.DataFish

-- local function removeLabel(frame)
--     local label = frame:FindFirstChild("PriceLabel")
--     if label then label:Destroy() end
-- end

-- local function setLabel(frame, name)
--     if not ShowFishPrices.Value then return removeLabel(frame) end
--     local basePrice = FishPrices[name]
--     if not basePrice then return end

--     local stack = frame:FindFirstChild("Stack") and frame.Stack.Value or 1
--     local totalPrice = math.floor(basePrice * stack)

--     local label = frame:FindFirstChild("PriceLabel") or Instance.new("TextLabel", frame)
--     label.Name = "PriceLabel"
--     label.AnchorPoint = Vector2.new(0.5, 0)
--     label.Position = UDim2.new(0.5, 0, 0, 2)
--     label.Size = UDim2.new(1, 0, 0, 12)
--     label.BackgroundTransparency = 1
--     label.BorderSizePixel = 0
--     label.TextScaled = false
--     label.TextWrapped = true
--     label.TextXAlignment = Enum.TextXAlignment.Center
--     label.Font = Enum.Font.GothamBold
--     label.TextSize = 11
--     label.Text = tostring(totalPrice)
--     label.TextColor3 = Color3.fromRGB(80, 255, 80)
-- end

-- local function updatePrices(container)
--     for _, item in pairs(container:GetChildren()) do
--         if item:IsA("Frame") or item:IsA("ImageButton") then
--             setLabel(item, item.Name)
--         end
--     end
-- end

-- local function calculateInventoryValue()
--     local inventory = backpack.inventory.scroll
--     local total = 0

--     for _, item in pairs(inventory:GetChildren()) do
--         local name = item.Name
--         local basePrice = FishPrices[name]
--         if basePrice then
--             local price = basePrice

--             local weight = item:FindFirstChild("Weight") and item.Weight.Value
--             local maxWeight = data.WeightPool and data.WeightPool[2]
--             if weight and maxWeight then
--                 price = math.ceil(price / maxWeight * weight * 10)
--             end

--             if item:FindFirstChild("Shiny") and item.Shiny.Value then price *= 1.85 end
--             if item:FindFirstChild("Sparkling") and item.Sparkling.Value then price *= 1.85 end

--             if item:FindFirstChild("Mutation") and data.Mutations and data.Mutations[item.Mutation.Value] then
--                 price *= tonumber(data.Mutations[item.Mutation.Value].PriceMultiply or 1)
--             end

--             local stack = item:FindFirstChild("Stack") and item.Stack.Value or 1
--             total += price * stack
--         end
--     end

--     return math.floor(total)
-- end

-- local function notifyTotalValue()
--     local total = calculateInventoryValue()
--     StellarLibrary:Notify({
--         Title = "Inventory Value",
--         Content = "Total: " .. tostring(total),
--         Duration = 4
--     })
-- end

-- ShowFishPrices:OnChanged(function(state)
--     updatePrices(backpack.hotbar)
--     updatePrices(backpack.inventory.scroll)
--     if state then
--         notifyTotalValue()
--     end
-- end)


-- updatePrices(backpack.hotbar)
-- updatePrices(backpack.inventory.scroll)
-- notifyTotalValue()

-- #Granding Level Tab (Bug)

-- local goalLevel, levelKickEnabled

-- local KickSection = Fish:AddSection({ Title = "Grinding Level" })

-- KickSection:AddInput("SetKickLevel", {
--     Title = "Level to Kick",
--     Default = "",
--     Numeric = true,
--     Callback = function(v)
--         goalLevel = tonumber(v)
--         StellarLibrary:Notify({
--             Title = "Kick Config",
--             Content = goalLevel and ("Will kick at level " .. goalLevel) or "Invalid level.",
--             Duration = 3
--         })
--     end
-- })

-- KickSection:AddToggle("EnableLevelKick", {
--     Title = "Enable Auto Kick",
--     Default = false,
--     Callback = function(state)
--         levelKickEnabled = state
--     end
-- })

-- -- Ambil level dari leaderstats
-- local function getCurrentLevel()
--     local stats = game.Players.LocalPlayer:FindFirstChild("leaderstats")
--     local level = stats and stats:FindFirstChild("Level")
--     return level and tonumber(level.Value)
-- end

-- -- Monitoring thread
-- task.spawn(function()
--     while task.wait(1) do
--         if levelKickEnabled and goalLevel then
--             local current = getCurrentLevel()
--             if current and current >= goalLevel then
--                 game.Players.LocalPlayer:Kick("Reached level " .. current .. " — kicked automatically.")
--                 break
--             end
--         end
--     end
-- end)


-- Market Tabs
local RodsDropdown = Items:AddSection({Title = "Rods"})
local rodsFolder = game:GetService("ReplicatedStorage").resources.items.rods
local event = game:GetService("ReplicatedStorage").events.purchase 

-- Mengumpulkan nama semua pancingan dalam folder
local rodNames = {}
for _, rod in pairs(rodsFolder:GetChildren()) do
    if rod:IsA("Folder") then
        table.insert(rodNames, rod.Name)
    end
end
local RodAmountInput = RodsDropdown:AddInput("RodAmountInput", {
    Title = "Amount",
    Default = "1",
})
local RodDropdown = RodsDropdown:AddDropdown("RodSelection", {
    Title = "Select a Rod",
    Description = "Choose a fishing rod from the shop to purchase.", 
    Values = rodNames,
    Multi = false,
    Default = 1,
})

RodsDropdown:AddButton({
    Title = "Buy Selected rod",
    Description = "Click this button to purchase the selected fishing rod.", 
    Callback = function()
        local selectedRod = RodDropdown.Value
        local amount = tonumber(RodAmountInput.Value) or 1
        if selectedRod then
            event:FireServer(selectedRod, "Rod", nil, amount)
        else
            warn("No Rod selected!")
        end
    end
})
RodDropdown:AddButton({
    Title = "Buy All Rods",
    Description = "Click this button to purchase all fishing rods in the shop.",
    Callback = function()
        if rodsFolder then
            event:FireServer(rodsFolder, "Rod", 1)
        else
            warn("No Rods Found")
        end
    end
})

local ItemsDropdown = Items:AddSection({Title = "Items"})
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
local BuyAmountInput = ItemsDropdown:AddInput("BuyAmountInput", {
 Title = "Amount",
 Default = "1",
})

-- Dropdown untuk memilih item
local ItemDropdown = ItemsDropdown:AddDropdown("ItemSelection", {
 Title = "Select an Item",
 Description = "Choose an item from the shop to purchase.", -- Deskripsi ditambahkan
 Values = itemNames,
 Default = 1,
})

-- Tombol untuk membeli item yang dipilih
ItemsDropdown:AddButton({
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
-- ItemsDropdown:AddButton({
--     Title = "Buy All Items 1",
--     Description = "Buy all items in once time.",
--     Callback = function()
--         if itemsFolder then
--             event:FireServer
-- })
local TotemSection = Items:AddSection({Title = "Totem"})
local itemsFolder = game.ReplicatedStorage:WaitForChild("resources"):WaitForChild("items"):WaitForChild("items")
local totemNames = {}

for _, category in pairs(itemsFolder:GetChildren()) do
    if category:IsA("Folder") then
        local innerFolder = category:FindFirstChild(category.Name)
        if innerFolder and innerFolder:FindFirstChild("Totem") then
            table.insert(totemNames, category.Name)
        end
    end
end

local BuyTotemAmount = TotemSection:AddInput("BuyTotemAmount", {
    Title = "Amount",
    Default = "1",
})

local TotemDropdown = TotemSection:AddDropdown("TotemSelection", {
    Title = "Select Totem",
    Description = "Choose totem to purchase.",
    Values = totemNames,
    Default = 1,
})

TotemSection:AddButton({
    Title = "Buy Selected Totem",
    Description = "Click to purchase selected totem.",
    Callback = function()
        local selected = TotemDropdown.Value
        local amount = tonumber(BuyTotemAmount.Value) or 1
        if selected then
            game:GetService("ReplicatedStorage").events.purchase:FireServer(selected, "Item", nil, amount)
        end
    end
})
local BaitBuySection = Items:AddSection({Title = "Bait Crate"})
local baitCrates = {
    "Common Crate", "Bait Crate", "Carbon Crate",
    "Quality Bait Crate", "Volcanic Geode", "Coral Geode"
}
local purchaseEvent = ReplicatedStorage.events.purchase


local BaitAmountInput = BaitBuySection:AddInput("BaitAmountInput", {
    Title = "Amount",
    Default = "1",
})
local BaitCrateDropdown = BaitBuySection:AddDropdown("SelectBaitCrate", {
    Title = "Select Bait Crate",
    Description = "Choose a bait crate to purchase.",
    Values = baitCrates,
    Multi = false,
    Default = 1,
})

-- Tombol beli crate
BaitBuySection:AddButton({
    Title = "Buy Selected Bait Crate",
    Description = "Click this button to purchase the selected bait crate.",
    Callback = function()
        local selectedCrate = BaitCrateDropdown.Value
        local amount = tonumber(BaitAmountInput.Value) or 1

        if selectedCrate then
            purchaseEvent:FireServer(selectedCrate, "Item", nil, amount)
        else
            warn("No bait crate selected!")
        end
    end
})
--[[#Naaellx Code]]
local SEA1_ID = 16732694052
local SEA2_ID = 72907489978215

local currentPlaceId = game.PlaceId
local HumanoidRootPart = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

if currentPlaceId == SEA1_ID then
    local IslandTeleport = Teleport:AddSection({Title = "Island"})
    local TpSpotsFolder = Workspace:FindFirstChild("world"):WaitForChild("spawns"):WaitForChild("TpSpots")
    local IslandSpots = {}
    local SpotNames = {}
    local SelectedIsland = nil

    for _, v in pairs(TpSpotsFolder:GetChildren()) do
        if not SpotNames[v.Name] then
            table.insert(IslandSpots, v.Name)
            SpotNames[v.Name] = true
        end
    end

    table.sort(IslandSpots, function(a, b)
        return a:lower() < b:lower()
    end)

    local IslandDropdown = IslandTeleport:AddDropdown("IslandTPDropdown", {
        Title = "Select Island",
        Values = IslandSpots,
        Callback = function(value)
            SelectedIsland = value
        end
    })

    IslandTeleport:AddButton({
        Title = "Teleport to Island",
        Callback = function()
            local target = TpSpotsFolder:FindFirstChild(SelectedIsland)
            if target and HumanoidRootPart then
                HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 5, 0)
            end
        end
    })

elseif currentPlaceId == SEA2_ID then
    local Sea2Spots = {
        ["WAVEBORNE"] = Vector3.new(366.208130, 88.572540, 772.958008),
        ["PINE SHOAL"] = Vector3.new(1180.223999, 81.172531, 488.504517),
        ["EMBERREACH"] = Vector3.new(2379.284424, 83.922630, 498.383850),
        ["AZURE LAGOON"] = Vector3.new(1319.698242, 79.672539, 2104.331299),
        ["THE CURSED SHORES"] = Vector3.new(-214.631897, 84.302124, 1963.922485),
        ["ISLE OF NEW BEGINING"] = Vector3.new(-353.710083, 80.627434, -440.677399),
        ["LUSHGROVE"] = Vector3.new(1116.802124, 105.685226, -584.745178)
    }

    local function getTeleportNames(teleportTable)
        local names = {}
        for name, _ in pairs(teleportTable) do
            table.insert(names, name)
        end
        table.sort(names, function(a, b) return a:lower() < b:lower() end)
        return names
    end

    local secondSeaNames = getTeleportNames(Sea2Spots)
    local TeleSecond = Teleport:AddSection({Title = "Second Sea Island"})

    local SelectedSecond = nil
    local SecondSeaDropdown = TeleSecond:AddDropdown("SecondSeaDropdown", {
        Title = "Select Area",
        Values = secondSeaNames,
        Callback = function(value)
            SelectedSecond = value
        end
    })

    TeleSecond:AddButton({
        Title = "Teleport To Island",
        Callback = function()
            if SelectedSecond and Sea2Spots[SelectedSecond] and HumanoidRootPart then
                HumanoidRootPart.CFrame = CFrame.new(Sea2Spots[SelectedSecond]) + Vector3.new(0, 5, 0)
            end
        end
    })
end
local FishingZoneSection = Teleport:AddSection({Title = "Fishing Zone"})
local FishingZones = {}
local ZoneNames = {}
local FishingFolder = workspace.zones.fishing
local SelectedZone = nil

for _, zone in ipairs(FishingFolder:GetChildren()) do
    if not ZoneNames[zone.Name] then
        table.insert(FishingZones, zone.Name)
        ZoneNames[zone.Name] = true
    end
end

table.sort(FishingZones, function(a, b)
    return a:lower() < b:lower()
end)

FishingZoneSection:AddDropdown("FishingTPDropdown", {
    Title = "Fishing Zones",
    Values = FishingZones,
    Callback = function(selected)
        SelectedZone = selected
    end
})

FishingZoneSection:AddButton({
    Title = "Teleport to Zone",
    Callback = function()
        local zone = FishingFolder:FindFirstChild(SelectedZone)
        local char = game.Players.LocalPlayer.Character
        if zone and zone:IsA("BasePart") and char and char.PrimaryPart then
            char:SetPrimaryPartCFrame(zone.CFrame)
        end
    end
})

local NpcSection = Teleport:AddSection({Title = "NPC"})

local NpcFolder = Workspace:FindFirstChild("world"):WaitForChild("npcs")
local npcList = {}
local npcPositions = {}

for _, npc in pairs(NpcFolder:GetChildren()) do
    if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
        table.insert(npcList, npc.Name)
        npcPositions[npc.Name] = npc.HumanoidRootPart.Position
    end
end

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
table.sort(npcList, function(a, b)
    return a:lower() < b:lower()
end)

-- Dropdown NPC
local NpcTPDropdownUI = NpcSection:AddDropdown("NpcTPDropdownUI", {
    Title = "NPC Teleport",
    Values = npcList,
    Multi = false,
    Default = nil,
})

local function teleportToNPC(Value)
    if Value and HumanoidRootPart then
        xpcall(function()
            local targetPosition = npcPositions[Value]
            if targetPosition then
                HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
                NpcTPDropdownUI:SetValue(nil)
            else
                warn("NPC position not found!")
            end
        end, function(err)
            warn("Teleport Error: ", err)
        end)
    end
end
NpcSection:AddButton({
    Title = "Teleport To NPC",
    Callback = function()
        teleportToNPC(NpcTPDropdownUI.Value)
    end
})
local AutoSecond = Teleport:AddSection({Title = "Auto Second Sea"})
local ToggleEnabled = false
AutoSecond:AddToggle("BossTeleport", {
    Title = "Auto Second Sea",
    Default = false,
    Callback = function(state)
        ToggleEnabled = state
    end
})

task.spawn(function()
    while task.wait(0.5) do
        if not ToggleEnabled then continue end

        local stats = workspace:FindFirstChild("PlayerStats") and workspace.PlayerStats:FindFirstChild(LocalPlayer.Name)
        if stats and stats:FindFirstChild("T") and stats.T:FindFirstChild(LocalPlayer.Name) then
            stats = stats.T[LocalPlayer.Name].Stats
        else
            continue
        end

        local boss = workspace.active.bosses:FindFirstChild("cthulu")
        if not boss then continue end

        local bossPlayers = boss:GetAttribute("players")
        local userIdStr = tostring(LocalPlayer.UserId)

        if not bossPlayers then
            boss:SetAttribute("players", "")
        elseif bossPlayers:find(userIdStr) then
            ReplicatedStorage.events.keepersTorchHit:FireServer(true)
        elseif stats:FindFirstChild("crypt_bargate_opened") and not bossPlayers:find(userIdStr) then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1536, -1693, 5896)
            ReplicatedStorage.packages.Net["RE/CthuluAttack"]:FireServer()
        end
    end
end)
AutoSecond:AddButton({
    Title = "Kill Cthulu",
    Description = "Instantly fires kill request to Cthulu",
    Callback = function()
        for _ = 1, 100 do
            ReplicatedStorage.packages.Net["RE/CthuluAttack"]:FireServer()
            task.wait() -- tanpa delay berlebihan
        end
    end
})
-- Player Teleports
local PlayerTeleport = Teleport:AddSection({Title = "Player Teleport"})
local PlayerDropdown = PlayerTeleport:AddDropdown("TeleportToPlayerDropdown", {
    Title = "Players",
    Values = {"Select Players"},
    Multi = false,
    Default = nil,
})

-- Update list player
local function UpdatePlayerList()
    local playerNames = {}
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then 
            table.insert(playerNames, player.Name)
        end
    end
    
    if #playerNames == 0 then
        playerNames = {"No players online"}
    end
    
    PlayerDropdown:SetValues(playerNames) 
end
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)
--Button Teleport mek
PlayerTeleport:AddButton({
    Title = "Teleport to Player",
    Description = "Click to teleport to the selected player.",
    Callback = function()
        local selectedPlayerName = PlayerDropdown.Value
        if selectedPlayerName and selectedPlayerName ~= "No players online" then
            local targetPlayer = Players:FindFirstChild(selectedPlayerName)
            if targetPlayer and targetPlayer.Character then
                -- Teleport langsung ke posisi player (tanpa batas jarak)
                local targetCFrame = targetPlayer.Character:GetPivot()
                LocalPlayer.Character:PivotTo(targetCFrame)
            else
                warn("Target player not available.")
            end
        else
            warn("No player selected or no players online.")
        end
    end
})
UpdatePlayerList()
local AutoSellSection = Automatically:AddSection({Title = "Selling"})


-- Existing Auto Sell Features
AutoSellSection:AddToggle("AutoSell", {
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

AutoSellSection:AddSlider("AutoSellDelay", {
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

AutoSellSection:AddButton({
    Title = "Sell All",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").events.SellAll:InvokeServer()
        end)
    end
})

AutoSellSection:AddButton({
    Title = "Sell Hand",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").events.Sell:InvokeServer()
        end)
    end
})

AutoSellSection:AddToggle("AutoSellHand", {
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
local AutoCollects = Automatically:AddSection({Title = "Collects"})

-- Auto Collect Treasure
AutoCollects:AddToggle("AutoCollectTreasure", {
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
AutoCollects:AddToggle("AutoFully", {
    Title = "Auto Treasure",
    Description = "Automatically repairs the Treasure Map.",
    Default = false,
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
AutoCollects:AddToggle("AutoUseFillionaire", {
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
local share = share or {}
share.LastCycle = share.LastCycle or ""
share.AutoPurchaseIfNone = share.AutoPurchaseIfNone or false
share.TotemInUse = share.TotemInUse or false
share.AutoTotemToggle = share.AutoTotemToggle or false

local TotemList = {
    "Sundial Totem", "Aurora Totem", "Tempest Totem", "Smokescreen Totem",
    "Windset Totem", "Eclipse Totem", "Meteor Totem", "Blizzard Totem",
    "Avalanche Totem", "Zeus Storm Totem", "Poseidon's Wrath Totem"
}

local autoTotemSection = Automatically:AddSection({Title = "Totems"})

for _, timeOfDay in ipairs({"Day", "Night"}) do
    autoTotemSection:AddDropdown(timeOfDay .. "Totem", {
        Title = "Select " .. timeOfDay .. " Totem",
        Values = TotemList,
        Default = "",
        PlaceHolder = "Select Totem - " .. timeOfDay,
        Multiple = false,
        Callback = function(selected)
            share["Selected" .. timeOfDay .. "Totem"] = selected
        end
    })
end

autoTotemSection:AddToggle("AutoTotemToggle", {
    Title = "Auto Totem",
    Default = share.AutoTotemToggle,
    Callback = function(enabled)
        share.AutoTotemToggle = enabled
        if not enabled then return end

        task.spawn(function()
            while share.AutoTotemToggle do
                task.wait(1)
                local cycle = ReplicatedStorage.world.cycle.Value
                if cycle == share.LastCycle then continue end
                local totemName = share["Selected" .. cycle .. "Totem"]
                if not totemName or totemName == "" then continue end

                if not LocalPlayer.Backpack:FindFirstChild(totemName) and share.AutoPurchaseIfNone then
                    ReplicatedStorage.events.purchase:FireServer(totemName, "Item", nil, 1)
                    task.wait(1)
                end

                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid:UnequipTools() end

                local totemTool = LocalPlayer.Backpack:FindFirstChild(totemName)
                if totemTool then totemTool.Parent = LocalPlayer.Character end

                local activeTotem = workspace[LocalPlayer.Name]:FindFirstChild(totemName)
                if activeTotem then activeTotem:Activate() end

                if humanoid then humanoid:UnequipTools() end

                share.LastCycle = cycle
                share.TotemInUse = false
            end
        end)
    end
})

local BaitSection = Automatically:AddSection({Title = "Baits"})
local BaitList = {
    "Bagel", "Worm", "Insect", "Flakes", "Garbage", "Maggot", "Shrimp", "Squid", "Seaweed",
    "Magnet", "Minnow", "Coral", "Peppermint Worm", "Super Flakes", "Coal", "Rapid Catcher",
    "Truffle Worm", "Weird Algae", "Fish Head", "Night Shrimp", "Instant Catcher",
    "Deep Coral", "Holly Berry", "Shark Head", "Aurora Bait"
}

BaitSection:AddDropdown("ChooseBait", {
    Title = "Choose Bait",
    Values = BaitList,
    Default = nil,
    Callback = function(value)
        _G.ChooseBait = value
    end
})

BaitSection:AddToggle("AutoUseBait", {
    Title = "Auto Equip Bait",
    Description = "Automatically use bait when fishing.",
    Default = false,
    Callback = function(value)
        _G.AutoUseBait = value
    end
})

task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoUseBait and _G.ChooseBait then
            pcall(function()
                game:GetService("ReplicatedStorage").packages.Net
                    :FindFirstChild("RE/Bait/Equip")
                    :FireServer(_G.ChooseBait)
            end)
        end
    end
end)

local baitCrates = {
    "Common Crate", "Bait Crate", "Carbon Crate",
    "Quality Bait Crate", "Volcanic Geode", "Coral Geode"
}

BaitSection:AddDropdown("ChooseBaitCrate", {
    Title = "Choose Bait Crate",
    Values = baitCrates,
    Value = "",
    Callback = function(value)
        _G.ChooseBaitCrate = value
    end
})

BaitSection:AddToggle("AutoOpenBaitCrate", {
    Title = "Auto Open Bait Crate",
    Description = "Automatically open a bait crate.",
    Default = false,
    Callback = function(value)
        _G.AutoOpenBaitCrate = value
    end
})

task.spawn(function()
    while task.wait(0.1) do
        if not _G.AutoOpenBaitCrate or not _G.ChooseBaitCrate then continue end
        local chosenCrate = _G.ChooseBaitCrate
        for _, tool in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if tool.Name == chosenCrate then
                pcall(function()
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                end)
                break
            end
        end
    end
end)

local EventSection = Event:AddSection({Title = "Event"})

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
    Orca_Hunting = false,
    LEGO_Studolodon = false
}
_G.SelectedTarget = nil
_G.Hunting = false
_G.Summon_Whale = false
_G.Summon_Phantom = false

-- List manual
local TargetList = {
    "Megalodon Default",
    "Megalodon Ancient",
    "Megalodon Phantom",
    "Forsaken Veil - Scylla",
    "Kraken Pool",
    "Ancient Kraken Pool",
    "Orcas Pool",
    "Whales Pool",
    "LEGO - Studolodon"
}

-- Baru ambil Zones berdasarkan TargetList yang eksis di workspace
local Zones = {}
for _, name in ipairs(TargetList) do
    if workspace.zones.fishing:FindFirstChild(name) then
        table.insert(Zones, name)
    end
end

-- Bikin Dropdown
EventSection:AddDropdown("SelectTarget", {
    Title = "Select Hunting Target",
    Values = TargetList,
    Callback = function(Value)
        _G.SelectedTarget = Value
    end
})

-- Toggle Hunting
local HuntConnection
EventSection:AddToggle("Hunting", {
    Title = "Hunt Selected Target",
    Default = false,
    Callback = function(Value)
        _G.Hunting = Value

        if Value then
            HuntConnection = task.spawn(function()
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

                            for _, tool in game.Players.LocalPlayer.Backpack:GetChildren() do
                                if tool:IsA("Tool") then
                                    for _, folder in tool:GetChildren() do
                                        if folder:IsA("Folder") and folder.Name == "events" then
                                            for _, v in game.Players.LocalPlayer.Character:GetChildren() do
                                                if v:IsA("Tool") then
                                                    v.Parent = game.Players.LocalPlayer.Backpack
                                                end
                                            end
                                            tool.Parent = game.Players.LocalPlayer.Character
                                            break
                                        end
                                    end
                                end
                            end
                        end

                        -- HeightOffset: Kalau yang ada di Zones, 20. Selain itu, 74.
                        local heightOffset = table.find(Zones, _G.SelectedTarget) and 20 or 74
                        local target_pos = CFrame.new(Target.CFrame.Position + Vector3.new(0, heightOffset, 0))
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target_pos
                    end
                end
            end)
        else
            _G.Hunting = false
        end
    end
})

local AutoSummonSection = Event:AddSection({Title = "Summon"})

local summonType = "None"

AutoSummonSection:AddDropdown("SummonTypeDropdown", {
    Title = "Summon Type",
    Values = {"None","Megalodon Default", "Phantom Meg", "Whales", "Kraken Default"},
    Default = "None",
    Callback = function(value)
        summonType = value
    end
})

AutoSummonSection:AddToggle("AutoTotemToggle", {
    Title = "Auto Totem",
    Default = share.AutoTotemToggle,
    Callback = function(enabled)
        share.AutoTotemToggle = enabled
        if not enabled then return end

        local alternateTotemIndex = 1

        task.spawn(function()
            while share.AutoTotemToggle do
                task.wait(1)

                local fishingZone = workspace.zones:FindFirstChild("fishing")
                if fishingZone then
                    local meg_phantom = fishingZone:FindFirstChild("Megalodon Phantom")
                    local whale_pool = fishingZone:FindFirstChild("Whales Pool")

                    local function hasRequiredTotems(totem1, totem2)
                        local found1, found2 = false, false
                        for _, obj in ipairs(LocalPlayer.PlayerGui.hud.safezone.backpack.hotbar:GetChildren()) do
                            if obj:IsA("ImageButton") then
                                local nameObj = obj:FindFirstChild("itemname")
                                if nameObj then
                                    if nameObj.Text == totem1 then found1 = true end
                                    if nameObj.Text == totem2 then found2 = true end
                                end
                            end
                        end
                        return found1 and found2
                    end

                    if summonType == "Phantom Meg" and meg_phantom then
                        if not hasRequiredTotems("Sundial Totem", "Eclipse Totem") then continue end
                        _G.Summon_Phantom = false
                        StellarLibrary:Notify({
                            Title = "Auto Totem",
                            Content = "Phantom Meg Pool detected. Waiting...",
                            Duration = 6.5
                        })
                        continue
                    elseif summonType == "Whales" and whale_pool then
                        if not hasRequiredTotems("Smokescreen Totem", "Tempest Totem") then continue end
                        _G.Summon_Whale = false
                        StellarLibrary:Notify({
                            Title = "Auto Totem",
                            Content = "Whale Pool detected. Waiting...",
                            Duration = 6.5
                        })
                        continue
                        elseif summonType == "Megalodon" and Meg_Hunting then
                        if not hasRequiredTotems("Sundial Totem", "Sundial Totem") then continue end
                        _G.Hunting = false
                        StellarLibrary:Notify({
                            Title = "Auto Totem",
                            Content = "Megalodon Pool detected. Waiting...",
                            Duration = 6.5
                        })
                        continue
                        elseif summonType == "Kraken Pool" and Kraken_Hunting then
                        if not hasRequiredTotems("Sundial Totem", "Sundial Totem") then continue end
                        _G.Hunting = false
                        StellarLibrary:Notify({
                            Title = "Auto Totem",
                            Content = "Kraken Pool detected. Waiting...",
                            Duration = 6.5
                        })
                        continue
                    end
                end

                local totemList = {}
                if summonType == "Phantom Meg" then
                    totemList = {"Sundial Totem", "Eclipse Totem"}
                elseif summonType == "Whales" then
                    totemList = {"Smokescreen Totem", "Tempest Totem"}
                elseif
                summonType == "Megalodon Default" then
                    totemList = {"Sundial Totem","Sundial Totem"}
                elseif
                summonType == "Kraken Pool" then
                    totemList = {"Sundial Totem","Sundial Totem"}
                elseif
            else
                    continue 
                end

                local totemToUse = totemList[alternateTotemIndex]
                if not totemToUse then continue end

                if not LocalPlayer.Backpack:FindFirstChild(totemToUse) and share.AutoPurchaseIfNone then
                    ReplicatedStorage.events.purchase:FireServer(totemToUse, "Item", nil, 1)
                    task.wait(1)
                end

                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid:UnequipTools() end

                local totemTool = LocalPlayer.Backpack:FindFirstChild(totemToUse)
                if totemTool then
                    totemTool.Parent = LocalPlayer.Character
                    local activeTotem = workspace[LocalPlayer.Name]:FindFirstChild(totemToUse)
                    if activeTotem then activeTotem:Activate() end
                end

                if humanoid then humanoid:UnequipTools() end
                alternateTotemIndex += 1
                if alternateTotemIndex > #totemList then
                    alternateTotemIndex = 1
                end
            end
        end)
    end
})

AutoSummonSection:AddParagraph({
    Title = "Beta Feature Notice",
    Content = "This summon feature is currently in testing (BETA).\nYou may encounter bugs or unexpected behavior.\n\nPlease report any issues to the developer."
})
-- Misc Section
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local LocalPlayer = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local speedValue = 16  


local FlySpeed = 50
local Flying = false
local FlyVelocity, FlyGyro

function StartFly()
    if Flying then return end
    Flying = true
    local Character = LocalPlayer.Character
    local Root = Character and Character:FindFirstChild("HumanoidRootPart")
    if not Root then return end
    
    FlyVelocity = Instance.new("BodyVelocity", Root)
    FlyVelocity.Velocity = Vector3.new(0, 0, 0)
    FlyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    
    FlyGyro = Instance.new("BodyGyro", Root)
    FlyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    FlyGyro.CFrame = Root.CFrame
    
    RunService.RenderStepped:Connect(function()
        if not Flying then return end
        local Camera = workspace.CurrentCamera
        local MoveDirection = Vector3.new()
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            MoveDirection = MoveDirection + Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            MoveDirection = MoveDirection - Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            MoveDirection = MoveDirection - Camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            MoveDirection = MoveDirection + Camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            MoveDirection = MoveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            MoveDirection = MoveDirection - Vector3.new(0, 1, 0)
        end
        
        if MoveDirection.Magnitude > 0 then
            FlyVelocity.Velocity = MoveDirection.Unit * FlySpeed
        else
            FlyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        FlyGyro.CFrame = Camera.CFrame
    end)
end

function StopFly()
    Flying = false
    if FlyVelocity then FlyVelocity:Destroy() end
    if FlyGyro then FlyGyro:Destroy() end
end

local MiscSection = Misc:AddSection({Title = "Character"})

MiscSection:AddToggle("FlyToggle", {
    Title = "Fly",
    Description = "Toggles flying on/off",
    Default = false,
    Callback = function(state)
        if state then
            StartFly()
        else
            StopFly()
        end
    end
})

local NoclipEnabled = false
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local function ToggleNoclip(state)
    NoclipEnabled = state
    if NoclipEnabled then
        RunService.Stepped:Connect(function()
            if NoclipEnabled and Character then
                for _, part in pairs(Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end


MiscSection:AddToggle("NoclipToggle", {
    Title = "Noclip",
    Description = "Allows you to walk through walls",
    Default = false,
    Callback = function(state)
        ToggleNoclip(state)
    end
})

MiscSection:AddSlider("FlySpeedSlider", {
    Title = "Flight speed",
    Description = "Changes the flying speed",
    Default = 50,
    Min = 10,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        FlySpeed = Value
    end
})

humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if humanoid.WalkSpeed ~= speedValue then
        humanoid.WalkSpeed = speedValue
    end
end)

MiscSection:AddSlider("SpeedSlider", {
    Title = "Speed",
    Description = "Changes the running speed",
    Default = 16,
    Min = 10,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        speedValue = Value  
        humanoid.WalkSpeed = speedValue
    end
})


local Input = MiscSection:AddInput("JumpInput", {
    Title = "Jump power",
    Default = "50", 
    Placeholder = "Enter jump power",
    Numeric = true, 
    Finished = false, 
    Callback = function(Value)
        humanoid.JumpPower = tonumber(Value) 
    end
})

Input:OnChanged(function()
    print("Input updated:", Input.Value)
end)
local terrain, lighting, settingsService = workspace.Terrain, game:GetService("Lighting"), settings()
local defaultProps = {
    terrain = { WaterWaveSize = terrain.WaterWaveSize, WaterWaveSpeed = terrain.WaterWaveSpeed, WaterReflectance = terrain.WaterReflectance, WaterTransparency = terrain.WaterTransparency },
    lighting = { GlobalShadows = lighting.GlobalShadows, FogEnd = lighting.FogEnd, Brightness = lighting.Brightness },
    quality = settingsService.Rendering.QualityLevel
}
local storedGameElements, terrainClearConnection, genv = {}, nil, genv or {}
local BoostFPS = Misc:AddSection({Title = "Boost FPS"})
BoostFPS:AddToggle("ClearTerrain", {
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
local connections, guiConfig, disablewaterfunc = {}, guiConfig or {}, disablewaterfunc or function() end
local function DAll() for _,c in pairs(connections) do if c.Disconnect then c:Disconnect() end end connections = {} end

local function EnableMoreFPS()
    -- Hapus workspace.active
    local active = workspace:FindFirstChild("active")
    if active then active:Destroy() end

    genv.hideRainToggle = true
    connections.Rain = game:GetService("RunService").Heartbeat:Connect(function()
        if tick() % 1 < 0.1 then pcall(function()
            local r = workspace.Camera:FindFirstChild("__RainEmitter")
            if r then if r:FindFirstChild("RainStraight") then r.RainStraight.Lifetime = NumberRange.new(0,0) end
            if r:FindFirstChild("RainTopDown") then r.RainTopDown.Lifetime = NumberRange.new(0,0) end end
        end) end
    end)

    for _,n in pairs({"underwaterbl","underwatercc"}) do
        local e = game:GetService("Lighting"):FindFirstChild(n)
        if e then table.insert(connections, e:GetPropertyChangedSignal("Enabled"):Connect(function() e.Enabled = false end)) end
    end

    genv.disableWavesToggle = true
    local w = workspace:FindFirstChild("active") and workspace.active.constant.Waves:FindFirstChild("Waves")
    if w and w:FindFirstChild("waves") then w.waves.Enabled = false end

    genv.disableAuroraToggle = true
    connections.Aurora = game:GetService("RunService").Heartbeat:Connect(function()
        if tick() % 1 < 0.1 then pcall(function()
            local a = workspace.active.constant:FindFirstChild("Aurora Borealis")
            a = a and a:FindFirstChild("Aurora Borealis")
            if a and a:IsA("Folder") then for _,b in ipairs(a:GetChildren()) do if b:IsA("Beam") then b.Enabled = false end end end
        end) end
    end)

    guiConfig.disablewaterfog = true
    if typeof(saveGuiConfig)=="function" then saveGuiConfig() end
    connections.WaterFog = game:GetService("RunService").RenderStepped:Connect(disablewaterfunc)
end

local function DisableMoreFPS()
    DAll()
    pcall(function()
        local r = workspace.Camera:FindFirstChild("__RainEmitter")
        if r then if r:FindFirstChild("RainStraight") then r.RainStraight.Lifetime = NumberRange.new(0.8,0.8) end
        if r:FindFirstChild("RainTopDown") then r.RainTopDown.Lifetime = NumberRange.new(0.8,0.8) end end
    end)
    local w = workspace:FindFirstChild("active") and workspace.active.constant.Waves:FindFirstChild("Waves")
    if w and w:FindFirstChild("waves") then w.waves.Enabled = true end
    guiConfig.disablewaterfog = false
    if typeof(saveGuiConfig)=="function" then saveGuiConfig() end
end

BoostFPS:AddToggle("MoreFPS", {Title="More FPS",Default=false,Description="Boost visual performance",Callback=function(e) if e then EnableMoreFPS() else DisableMoreFPS() end end})

BoostFPS:AddToggle("JustUI", {Title = "SHOW/HIDE UI", Default = true}):OnChanged(function(show)
    game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui").hud.safezone.Visible = show
end)
BoostFPS:AddToggle("Disable3D", {Title = "Disable 3D Rendering", Default = false}):OnChanged(function(state)
    game:GetService("RunService"):Set3dRenderingEnabled(not state)
end)

local fishConnection
BoostFPS:AddToggle("HideFish", {Title = "Hide Fish Models", Default = false}):OnChanged(function(state)
    if fishConnection then fishConnection:Disconnect() fishConnection = nil end

    if state then
        for _, v in ipairs(workspace.active:GetChildren()) do
            if v:FindFirstChild("Fish") then v:Destroy() end
        end
        fishConnection = workspace.active.ChildAdded:Connect(function(v)
            if v:FindFirstChild("Fish") then v:Destroy() end
        end)
    end
end)
BoostFPS:AddToggle("AutoDestroyCatch", {
    Title = "Hide Catch Popup",
    Default = false,
    Description = "Automatically destroys catch popups in announcements",
    Callback = function(value)
        variables.autoDestroyCatch = value
        if value then
            task.spawn(function()
                while variables.autoDestroyCatch and task.wait(1) do -- bisa ganti delay kalau mau
                    pcall(function()
                        local player = game.Players.LocalPlayer
                        local catchFolder = player:WaitForChild("PlayerGui"):WaitForChild("hud")
                            :WaitForChild("safezone"):WaitForChild("announcements")
                            :WaitForChild("announcer"):FindFirstChild("catch")
                        if catchFolder then
                            for _, v in ipairs(catchFolder:GetChildren()) do
                                v:Destroy()
                            end
                        end
                    end)
                end
            end)
        end
    end
})

local ClientSideV2 = Misc:AddSection({Title = "Client"})
local AllFuncs = {}

AllFuncs.DisableCutscenes = function()
    local function modulefunc(file, funcs)
        local blank = function() end
        local folder = game:GetService("ReplicatedStorage"):FindFirstChild("ModuleScriptClone") or Instance.new("Folder", game:GetService("ReplicatedStorage"))
        folder.Name = "ModuleScriptClone"
        local clone = folder:FindFirstChild(file.Name) or file:Clone()
        clone.Parent = folder
        local module = require(file)
        for _, f in ipairs(funcs) do module[f] = blank end
    end

    modulefunc(game.ReplicatedStorage.client.legacyControllers.CutsceneController, {
        "ShowBars", "Start", "DisableAllScreens", "StartCutscene", "Fade"
    })
    StellarLibrary:Notify({ Title = "Config", Content = "Cutscenes disabled!", Duration = 3 })
end

AllFuncs.DisableCryptGas = function()
    local res = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Resources")
    local s = res and res:FindFirstChild("gas")
    if s then s:Destroy() end
end

AllFuncs.DisableTemperatureVeil = function()
    local res = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Resources")
    local s = res and res:FindFirstChild("temperature(heat)")
    if s then s:Destroy() end
end

AllFuncs.PreventDeathScreen = function()
    local blocked = {
        [game.ReplicatedStorage.events.drown] = {"FireServer", true}
    }
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        if blocked[self] and getnamecallmethod() == blocked[self][1] then return end
        return old(self, ...)
    end)
end
ClientSideV2:AddToggle("DisableCutscenes", {
    Title = "Disable Cutscenes",
    Default = false
}):OnChanged(function(state)
    if state then AllFuncs.DisableCutscenes() end
end)

ClientSideV2:AddToggle("DisableCryptGas", {
    Title = "Disable Crypt Gas",
    Default = true
}):OnChanged(function(state)
    if state then AllFuncs.DisableCryptGas() end
end)

ClientSideV2:AddToggle("DisableTemperatureVeil", {
    Title = "Disable Temperature Veil",
    Default = true
}):OnChanged(function(state)
    if state then AllFuncs.DisableTemperatureVeil() end
end)

ClientSideV2:AddToggle("PreventDeathScreen", {
    Title = "Prevent Death Screen",
    Default = false
}):OnChanged(function(state)
    if state then AllFuncs.PreventDeathScreen() end
end)

-- Fun Tab
local FunTab = Misc:AddSection({Title = "Fun"})
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

local SkyDropdown = FunTab:AddDropdown(
"Dropdown",
{
    Title = "Select Custom Sky",
    Values = skyNames,
    Multi = false,
    Default = 1
}
)

SkyDropdown:OnChanged(function(SkyName)
currentSky = SkyName
end)

FunTab:AddButton(
{
    Title = "Change Sky",
    Description = "You have to wait a while for the sky to fully load.",
    Callback = function()
        if not currentSky or not skyTable[currentSky] then
            StellarLibrary:Notify(
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
            StellarLibrary:Notify(
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

local ClientSide = Misc:AddSection({Title = "Another Client"})

ClientSide:AddToggle("HideIdentity", {
    Title = "Protect Identity",
    Default = false,
    Description = "Hides your identity with a rainbow effect.",
    Callback = function(isEnabled)
        if isEnabled then
            genv.ToggledTest = true

            local function HSVRainbow(speed, shift)
                local h = (tick() * speed + (shift or 0)) % 1
                return Color3.fromHSV(h, 1, 1)
            end

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

                local rainbowParts = {}

                for _, v in ipairs(character:GetDescendants()) do
                    if v:IsA("CharacterMesh") or v:IsA("Accessory") or v:IsA("SpecialMesh") or (v:IsA("Decal") and v.Name == "face") then
                        v:Destroy()
                    elseif v:IsA("BasePart") then
                        v.Material = Enum.Material.Neon
                        table.insert(rainbowParts, v)
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

                lockText(userGui:FindFirstChild("user"), "Stellar")
                lockText(userGui:FindFirstChild("level"), "Level: ∞")
                lockText(userGui:FindFirstChild("streak"), "∞")
                lockText(userGui:FindFirstChild("title"), "⭐")
                lockText(safezone:FindFirstChild("coins"), "Stellar★ C$")
                lockText(safezone:FindFirstChild("lvl"), "Level: ∞")

                genv.MoneyLog = safezone:WaitForChild("StatChangeList").ChildAdded:Connect(function(v)
                    if v:IsA("TextLabel") then v.Text = "Stellar" end
                end)

                task.spawn(function()
                    local multi, val = 0.7, 0
                    while genv.ToggledTest and task.wait() do
                        val = val + RunService.RenderStepped:Wait() * multi
                        if val > 0.5 then multi = -multi elseif val < -0.5 then multi = -multi end

                        -- Animate UI gradients
                        for _, grad in pairs(gradients) do
                            if grad then grad.Offset = Vector2.new(val, 0) end
                        end

                        -- Animate rainbow on character parts
                        local rainbowColor = HSVRainbow(0.4)
                        for _, part in pairs(rainbowParts) do
                            if part and part:IsA("BasePart") then
                                part.Color = rainbowColor
                            end
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
                StellarLibrary:Notify({ Title = "Identity", Content = "Disabled. Use 'Die' to fully reset.", Duration = 5 })
            end
        end
    end
})
getgenv().name = "⭐.gg/stellar"
local Plr = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

ClientSide:AddToggle("ProtectName", {
    Title = "Protect Name",
    Default = false,
    Description = "Replaces your name with a custom alias and rainbow gradient.",
    Callback = function(isEnabled)
        if isEnabled then
            getgenv()._protectIdentity = true

            local function createRainbowGradient(obj)
                if not obj then return end
                if obj:FindFirstChildWhichIsA("UIGradient") then return end

                local gradient = Instance.new("UIGradient")
                gradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(242, 138, 54)),
                    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(242, 54, 107)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(134, 54, 242)),
                    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(54, 187, 242)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(54, 242, 173))
                }
                gradient.Parent = obj
                return gradient
            end

            local function handleTextLabel(Label)
                if Label:IsA("TextLabel") and Label.Text:find(Plr.Name) then
                    Label.Text = Label.Text:gsub(Plr.Name, getgenv().name)
                    createRainbowGradient(Label)
                    Label:GetPropertyChangedSignal("Text"):Connect(function()
                        if not getgenv()._protectIdentity then return end
                        Label.Text = Label.Text:gsub(Plr.Name, getgenv().name)
                    end)
                end
            end

            for _, obj in ipairs(game:GetDescendants()) do
                handleTextLabel(obj)
            end

            getgenv()._descAddedConn = game.DescendantAdded:Connect(function(obj)
                if not getgenv()._protectIdentity then return end
                task.defer(handleTextLabel, obj)
            end)

        else
            getgenv()._protectIdentity = false
            if getgenv()._descAddedConn then
                getgenv()._descAddedConn:Disconnect()
                getgenv()._descAddedConn = nil
            end
        end
    end
})

ClientSide:AddToggle("FreezeCharacter", {
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

ClientSide:AddToggle("AntiDrown", {
    Title = "Infinite Oxygen",
    Default = true,
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

ClientSide:AddToggle("WalkOnWaterNew", {
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
local function HideCharacterParts(character)
    if not character then return end

    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
            descendant.Transparency = 1
            descendant.CanCollide = false
        elseif descendant:IsA("Decal") then
            descendant.Transparency = 1
        elseif descendant:IsA("Accessory") and descendant:FindFirstChild("Handle") then
            descendant.Handle.Transparency = 1
            descendant.Handle.CanCollide = false
        end
    end
end

local function ShowCharacterParts(character)
    if not character then return end

    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
            descendant.Transparency = 0
            descendant.CanCollide = true
        elseif descendant:IsA("Decal") then
            descendant.Transparency = 0
        elseif descendant:IsA("Accessory") and descendant:FindFirstChild("Handle") then
            descendant.Handle.Transparency = 0
            descendant.Handle.CanCollide = true
        end
    end
end

local HidePlayersToggle = ClientSide:AddToggle("HidePlayersToggle", {
    Title = "Hide All Players",
    Description = "Toggle to hide or show other players in the game.",
    Default = false,
    Callback = function(state)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                player.CharacterAdded:Connect(function(char)
                    if state then
                        HideCharacterParts(char)
                    else
                        ShowCharacterParts(char)
                    end
                end)
                if player.Character then
                    if state then
                        HideCharacterParts(player.Character)
                    else
                        ShowCharacterParts(player.Character)
                    end
                end
            end
        end
    end
})
ClientSide:AddToggle("AntiAFK", {Title = "Anti-AFK", Default = true}):OnChanged(function(state)
    if state then
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton2(Vector2.zero)
        end)
        StellarLibrary:Notify({
            Title = "Anti-AFK",
            Content = "Anti-AFK has been enabled!",
            Duration = 3
        })
    end
end)
local PromptButtonHoldBegan = nil

local InstantPPToggle = ClientSide:AddToggle("InstantProximityPrompt", {
    Title = "Instant Interact NPC",
    Default = true,
    Description = "Instant Interact triggers Proximity Prompts instantly.",
    Callback = function(isEnabled)
        if isEnabled then
            if fireproximityprompt then
                PromptButtonHoldBegan = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
                    fireproximityprompt(prompt)
                end)
            else
                StellarLibrary:Notify({
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
ClientSide:AddButton({
    Title = "Instant Die",
    Callback = function()
        ReplicatedStorage:WaitForChild("events"):WaitForChild("drown"):FireServer(0)
        StellarLibrary:Notify({ Title = "Action", Content = "Character killed!", Duration = 3 })
    end
})
ClientSide:AddButton({
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
ClientSide:AddButton({
    Title = "Discover All Locations",
    Variant = "Primary",
    Callback = function()
        local success, event = pcall(function()
            return ReplicatedStorage:WaitForChild("events"):WaitForChild("discoverlocation")
        end)
        if not success or not event then
            StellarLibrary:Notify({
                Title = "Error",
                Content = "Failed to find discoverlocation event!",
                Duration = 3
            })
            return
        end
        local FishingZonesFolder = game:GetService("Workspace").zones.fishing
        local FishingZones = {}

        for _, zone in pairs(FishingZonesFolder:GetChildren()) do
            if zone:IsA("Model") then
                table.insert(FishingZones, zone.Name) 
            end
        end
        local Locations = {
            ["The Depths"] = {}, ["Roslit"] = {}, ["Ancient Isle"] = {}, ["Sunstone"] = {}, ["Volcanic Vents"] = {},
            ["Winter's Edge"] = {}, ["Frigid Cavern"] = {}, ["Atlantean Storm"] = {}, ["Abyssal Zenith"] = {}, ["Terrapin"] = {},
            ["Ancient Archives"] = {}, ["Snowcap"] = {}, ["Glacial Grotto"] = {}, ["All"] = {}, ["Ashfall"] = {},
            ["Overgrowth Caves"] = {}, ["Roslit Volcano"] = {}, ["Veil of the Forsaken"] = {}, ["Calm Zone"] = {}, ["Moosewood"] = {},
            ["Vertigo"] = {}, ["FischFright"] = {}, ["Challenger's Deep"] = {}, ["Keepers Altar"] = {}, ["Ocean"] = {},
            ["Archeological Site"] = {}, ["Cryogenic Canal"] = {}, ["Forsaken Shores"] = {}, ["Fischgiving"] = {}, ["Grand Reef"] = {},
            ["Brine Pool"] = {}, ["Fischmas"] = {}, ["Desolate Deep"] = {}, ["Mushgrove"] = {}, ["Golden Tide"] = {}, ["Atlantis"] = {}
        }
        for _, zoneName in ipairs(FishingZones) do
            Locations[zoneName] = {}
        end
        for key in pairs(Locations) do
            event:FireServer(key)
        end
        StellarLibrary:Notify({
            Title = "stellar",
            Content = "All Location Has Been Discover!",
            Duration = 8
        })
    end,
})
local ExclusivesSectionLeft = Exclusives:AddSection({Title = "Premium"}) 
ExclusivesSectionLeft:AddParagraph({
    Title = "Coming Soon",
    Content = "Premium feature coming soon.\nStay tuned!"
})
local ExclusivesSectionRight = Exclusives:AddSection({Title = "Economy"})
ExclusivesSectionRight:AddParagraph({
    Title = "Coming Soon",
    Content = "Premium feature coming soon.\nStay tuned!"
})
-- Local DupeFeature = Exclusives:AddSection({Title = "Dupe Feature"})
-- DupeFeature:AddDropdown({
--     Title = "Select Dupe",
--     Description = "Here is dupe feature at"
    
-- })
-- local Webhook = Settings:AddSection({Title = "Webhook"})
-- Webhook:AddInput("WebhookInput", {
--     Title = "Webhook",
--     Default = "Disable",
--     Numeric = false,
--     Finished = false,
--     Callback = function(input)
--         _G.JobID = input
--     end
-- })

local Settings = Settings:AddSection({Title = "Settings"})

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
-- Input field for Job ID
local JobInput = Settings:AddInput("JobInput", {
Title = "Job ID",
Default = "",
Placeholder = "Here",
Numeric = false,
Finished = false,
Callback = function(input)
    _G.JobID = input
end
})

-- Button to join a specific Job ID
local JoinJobButton = Settings:AddButton({
Title = "Join Job ID",
Description = "Join a specific server using Job ID.",
Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _G.JobID, game.Players.LocalPlayer)
end
})
local CopyJobIDButton = Settings:AddButton({
Title = "Copy Job ID",
Description = "Copy the current server's Job ID to clipboard.",
Callback = function()
    local jobId = tostring(game.JobId) 
    setclipboard(jobId)
    StellarLibrary:Notify({
        Title = "Success",
        Content = "Copied Job ID: " .. jobId,
        Duration = 5
    })
end
})
local ServerHop = Settings:AddButton({
    Title = "Low-Server",
    Description = "Join a old server low player in the same game.",
    Callback = function()
        HopToServer()
    end
})
local RejoinServer = Settings:AddButton({
    Title = "Rejoin Server",
    Description = "",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
})
local Rejoin = Settings:AddToggle("Rejoin", {Title = "Auto-Rejoin", Default = true})
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