if getgenv().already_executed then
    warn("Allux: Already executed!")
    return
end
getgenv().already_executed = true
if not game:IsLoaded() then
    game.Loaded:Wait()
end
local vim = game:GetService("VirtualInputManager")
local re = game:GetService("ReplicatedStorage")
local vr = game:GetService("VirtualUser")
local lp = game.Players.LocalPlayer
getgenv().config = {
    auto_equip_rod = nil,
    auto_thorown_rod = nil,
    auto_shake = nil,
    auto_reel = nil,
    auto_reel_perfect_catch = nil,
    auto_sell_all = nil,
    auto_sell_in_hand = nil,
    disable_oxygen = nil,
    walk_on_water = nil,
    auto_trade_all_items = nil,
    auto_accept_trade = nil,
    anti_afk = nil,
    remove_fog = nil,
    auto_fail_catch = nil
}
if not isfolder("Allux/Config") then
    makefolder("Allux/Config")
end
local function save_config()
    local config_name = "Allux/Config/fisch_cfg.json"
    local json_config = game:GetService("HttpService"):JSONEncode(getgenv().config)
    writefile(config_name, json_config)
end
local function load_config()
    local config_name = "Allux/Config/fisch_cfg.json"
    if isfile(config_name) then
        local json_config = readfile(config_name)
        getgenv().config = game:GetService("HttpService"):JSONDecode(json_config)
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
    Title = game:GetService("MarketplaceService"):GetProductInfo(16732694052).Name .. " | Ancestral v1.0",
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
local Tabs = { -- https://lucide.dev/icons/
Information = Window:AddTab({ Title = "Information", Icon = "rbxassetid://10723415903" }),
CharacterTab = Window:AddTab({ Title = "Character", Icon = "rbxassetid://10747373176" }),
Config = Window:AddTab({ Title = "Config", Icon = "rbxassetid://121667411319639" }),
Main = Window:AddTab({ Title = "Fishing", Icon = "rbxassetid://10734941354" }),
Items = Window:AddTab({ Title = "Market", Icon = "rbxassetid://10734952273" }),
Forge = Window:AddTab({ Title = "Forge", Icon = "rbxassetid://104768258304566" }), 
Event = Window:AddTab({ Title = "Event", Icon = "rbxassetid://103886955707876" }),
Teleports = Window:AddTab({ Title = "Worlds", Icon = "rbxassetid://10709811445" }),
Visual = Window:AddTab({ Title = "Visual", Icon = "rbxassetid://97855077268525" }), 
Exclusives = Window:AddTab({ Title = "Exclusives", Icon = "rbxassetid://10734966248" }), 
Misc = Window:AddTab({ Title = "Misc", Icon = "rbxassetid://10734976739" }),
}
local AutoEquipRod = Tabs.Main:AddToggle(
    "Toggle",
    {
        Title = "Auto Equip Rod",
        Default = getgenv().config.auto_equip_rod or false,
        Callback = function(Value)
            getgenv().config.auto_equip_rod = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_equip_rod do
                        task.wait()
                        local rod_name = re.playerstats[lp.Name].Stats.rod.Value
                        local equipped_rod = lp.Character:FindFirstChild(rod_name)
                        local back_pack = lp:WaitForChild("Backpack")
                        if back_pack:FindFirstChild(rod_name) and not equipped_rod then
                            task.wait(0.2)
                            lp.Character.Humanoid:EquipTool(back_pack:FindFirstChild(rod_name))
                        end
                    end
                end
            )
        end
    }
)
local Autocast = Tabs.Main:AddToggle(
    "Toggle",
    {
        Title = "Auto Cast",
        Default = getgenv().config.auto_throw_rod or false,
        Callback = function(Value)
            getgenv().config.auto_thorown_rod = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_thorown_rod do
                        task.wait()
                        local rod_name = re.playerstats[lp.Name].Stats.rod.Value
                        local equipped_rod = lp.Character:FindFirstChild(rod_name)
                        if equipped_rod then
                            equipped_rod.events.cast:FireServer(100)
                        end
                    end
                end
            )
        end
    }
)
local AutoShake = Tabs.Main:AddToggle(
    "Toggle",
    {
        Title = "Auto Shake",
        Default = getgenv().config.auto_shake or false,
        Callback = function(Value)
            getgenv().config.auto_shake = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_shake do
                        task.wait()
                        local shake_button =
                            lp:WaitForChild("PlayerGui"):FindFirstChild("shakeui") and
                            lp:WaitForChild("PlayerGui").shakeui:FindFirstChild("safezone"):FindFirstChild("button")
                        if shake_button then
                            shake_button.Size = UDim2.new(1001, 0, 1001, 0)
                            vr:Button1Down(Vector2.new(1, 1))
                            vr:Button1Up(Vector2.new(1, 1))
                        end
                    end
                end
            )
        end
    }
)
local AutoReel = Tabs.Main:AddToggle(
    "Toggle",
    {
        Title = "Auto Reel",
        Default = getgenv().config.auto_reel or false,
        Callback = function(Value)
            getgenv().config.auto_reel = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_reel do
                        task.wait()
                        if not getgenv().config.auto_reel_perfect_catch then
                            if not getgenv().config.auto_fail_catch then
                                if lp:WaitForChild("PlayerGui"):FindFirstChild("reel") then
                                    task.wait(1)
                                    re.events.reelfinished:FireServer(100, false)
                                end
                            end
                        end
                    end
                end
            )
        end
    }
)
local AutoPerfectCatch = Tabs.Main:AddToggle(
    "Toggle",
    {
        Title = "Perfect Catch",
        Default = getgenv().config.auto_reel_perfect_catch or false,
        Callback = function(Value)
            getgenv().config.auto_reel_perfect_catch = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_reel_perfect_catch do
                        task.wait()
                        if not getgenv().config.auto_fail_catch then
                            if lp:WaitForChild("PlayerGui"):FindFirstChild("reel") then
                                task.wait(1)
                                re.events.reelfinished:FireServer(100, true)
                            end
                        end
                    end
                end
            )
        end
    }
)
Window:SelectTab(1)
Fluent:Notify({Title = "Fisch:", Content = "Executed!", Duration = 5})
