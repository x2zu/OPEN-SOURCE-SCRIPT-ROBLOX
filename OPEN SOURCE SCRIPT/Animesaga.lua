
-- Anime Saga Script

-- Hệ thống kiểm soát logs
local LogSystem = {
    Enabled = true, -- Mặc định bật logs
    WarningsEnabled = true -- Mặc định bật cả warnings
}

-- Ghi đè hàm print để kiểm soát logs
local originalPrint = print
print = function(...)
    if LogSystem.Enabled then
        originalPrint(...)
    end
end

-- Ghi đè hàm warn để kiểm soát warnings
local originalWarn = warn
warn = function(...)
    if LogSystem.WarningsEnabled then
        originalWarn(...)
    end
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- Tải thư viện Fluent
local success, err = pcall(function()
    Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
end)

if not success then
    warn("Lỗi khi tải thư viện Fluent: " .. tostring(err))
    -- Thử tải từ URL dự phòng
    pcall(function()
        Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Fluent.lua"))()
        SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
        InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    end)
end

if not Fluent then
    error("Không thể tải thư viện Fluent. Vui lòng kiểm tra kết nối internet hoặc executor.")
    return
end

-- Hệ thống lưu trữ cấu hình
local ConfigSystem = {}
ConfigSystem.FileName = "AnimeSagaConfig_" .. game:GetService("Players").LocalPlayer.Name .. ".json"
ConfigSystem.DefaultConfig = {
    -- Các cài đặt mặc định
    UITheme = "Amethyst",
    LogsEnabled = true,
    WarningsEnabled = true,
    -- Dán thêm các key trạng thái toggle ở đây
    AutoPlayEnabled = false,
    AutoFollowEnemy = false,
    AutoCombat = false,
    AutoSkill1 = false,
    AutoSkill2 = false,
    AutoSkill3 = false,
}
ConfigSystem.CurrentConfig = {}

-- Cache cho ConfigSystem để giảm lượng I/O
ConfigSystem.LastSaveTime = 0
ConfigSystem.SaveCooldown = 2 -- 2 giây giữa các lần lưu
ConfigSystem.PendingSave = false

-- Hàm để lưu cấu hình
ConfigSystem.SaveConfig = function()
    -- Kiểm tra thời gian từ lần lưu cuối
    local currentTime = os.time()
    if currentTime - ConfigSystem.LastSaveTime < ConfigSystem.SaveCooldown then
        -- Đã lưu gần đây, đánh dấu để lưu sau
        ConfigSystem.PendingSave = true
        return
    end
    
    local success, err = pcall(function()
        local HttpService = game:GetService("HttpService")
        writefile(ConfigSystem.FileName, HttpService:JSONEncode(ConfigSystem.CurrentConfig))
    end)
    
    if success then
        ConfigSystem.LastSaveTime = currentTime
        ConfigSystem.PendingSave = false
    else
        warn("Lưu cấu hình thất bại:", err)
    end
end

-- Hàm để tải cấu hình
ConfigSystem.LoadConfig = function()
    local success, content = pcall(function()
        if isfile(ConfigSystem.FileName) then
            return readfile(ConfigSystem.FileName)
        end
        return nil
    end)
    
    if success and content then
        local success2, data = pcall(function()
            local HttpService = game:GetService("HttpService")
            return HttpService:JSONDecode(content)
        end)
        
        if success2 and data then
            -- Merge with default config to ensure all settings exist
            for key, value in pairs(ConfigSystem.DefaultConfig) do
                if data[key] == nil then
                    data[key] = value
                end
            end
            
        ConfigSystem.CurrentConfig = data
        
        -- Cập nhật cài đặt log
        if data.LogsEnabled ~= nil then
            LogSystem.Enabled = data.LogsEnabled
        end
        
        if data.WarningsEnabled ~= nil then
            LogSystem.WarningsEnabled = data.WarningsEnabled
        end
        
        return true
        end
    end
    
    -- Nếu tải thất bại, sử dụng cấu hình mặc định
        ConfigSystem.CurrentConfig = table.clone(ConfigSystem.DefaultConfig)
        ConfigSystem.SaveConfig()
        return false
    end

-- Thiết lập timer để lưu định kỳ nếu có thay đổi chưa lưu
spawn(function()
    while wait(5) do
        if ConfigSystem.PendingSave then
            ConfigSystem.SaveConfig()
        end
    end
end)

-- Tải cấu hình khi khởi động
ConfigSystem.LoadConfig()

-- Thông tin người chơi
local playerName = game:GetService("Players").LocalPlayer.Name

-- Tạo Window
local Window = Fluent:CreateWindow({
    Title = "x2zu | Anime Saga",
    SubTitle = "",
    TabWidth = 140,
    Size = UDim2.fromOffset(450, 350),
    Acrylic = true,
    Theme = ConfigSystem.CurrentConfig.UITheme or "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tạo tab Info
local InfoTab = Window:AddTab({
    Title = "Info",
    Icon = "rbxassetid://7733964719"
})

-- Thêm hỗ trợ Logo khi minimize
repeat task.wait(0.25) until game:IsLoaded()
getgenv().Image = "rbxassetid://120727887371733" -- ID tài nguyên hình ảnh logo
getgenv().ToggleUI = "LeftControl" -- Phím để bật/tắt giao diện

-- Tạo logo để mở lại UI khi đã minimize
task.spawn(function()
    local success, errorMsg = pcall(function()
        if not getgenv().LoadedMobileUI == true then 
            getgenv().LoadedMobileUI = true
            local OpenUI = Instance.new("ScreenGui")
            local ImageButton = Instance.new("ImageButton")
            local UICorner = Instance.new("UICorner")
            
            -- Kiểm tra môi trường
            if syn and syn.protect_gui then
                syn.protect_gui(OpenUI)
                OpenUI.Parent = game:GetService("CoreGui")
            elseif gethui then
                OpenUI.Parent = gethui()
            else
                OpenUI.Parent = game:GetService("CoreGui")
            end
            
            OpenUI.Name = "OpenUI"
            OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            
            ImageButton.Parent = OpenUI
            ImageButton.BackgroundColor3 = Color3.fromRGB(105,105,105)
            ImageButton.BackgroundTransparency = 0.8
            ImageButton.Position = UDim2.new(0.9,0,0.1,0)
            ImageButton.Size = UDim2.new(0,50,0,50)
            ImageButton.Image = getgenv().Image
            ImageButton.Draggable = true
            ImageButton.Transparency = 0.2
            
            UICorner.CornerRadius = UDim.new(0,200)
            UICorner.Parent = ImageButton
            
            -- Khi click vào logo sẽ mở lại UI
            ImageButton.MouseButton1Click:Connect(function()
                game:GetService("VirtualInputManager"):SendKeyEvent(true,getgenv().ToggleUI,false,game)
            end)
        end
    end)
    
    if not success then
        warn("Lỗi khi tạo nút Logo UI: " .. tostring(errorMsg))
    end
end)

-- Tự động chọn tab Info khi khởi động
Window:SelectTab(1) -- Chọn tab đầu tiên (Info)

-- Thêm section thông tin trong tab Info
local InfoSection = InfoTab:AddSection("Thông tin")

InfoSection:AddParagraph({
    Title = "Anime Saga",
    Content = "Phiên bản: 1.0 Beta\nTrạng thái: Hoạt động"
})

InfoSection:AddParagraph({
    Title = "Người phát triển",
    Content = "Script được phát triển bởi Dương Tuấn và ghjiukliop"
})
-- Tạo tab Auto Play
local AutoPlayTab = Window:AddTab({
    Title = "Auto Play",
    Icon = "rbxassetid://7734053495"
})

-- Thêm section thiết lập trong tab Settings
local SettingsTab = Window:AddTab({
    Title = "Settings",
    Icon = "rbxassetid://6031280882"
})

local SettingsSection = SettingsTab:AddSection("Thiết lập")

-- Dropdown chọn theme
SettingsSection:AddDropdown("ThemeDropdown", {
    Title = "Chọn Theme",
    Values = {"Dark", "Light", "Darker", "Aqua", "Amethyst"},
    Multi = false,
    Default = ConfigSystem.CurrentConfig.UITheme or "Dark",
    Callback = function(Value)
        ConfigSystem.CurrentConfig.UITheme = Value
        ConfigSystem.SaveConfig()
        print("Đã chọn theme: " .. Value)
    end
})

-- Auto Save Config
local function AutoSaveConfig()
    spawn(function()
        while wait(5) do -- Lưu mỗi 5 giây
            pcall(function()
                ConfigSystem.SaveConfig()
            end)
        end
    end)
end

-- Thêm event listener để lưu ngay khi thay đổi giá trị
local function setupSaveEvents()
    for _, tab in pairs({InfoTab, SettingsTab}) do
        if tab and tab._components then
            for _, element in pairs(tab._components) do
                if element and element.OnChanged then
                    element.OnChanged:Connect(function()
                        pcall(function()
                            ConfigSystem.SaveConfig()
                        end)
                    end)
                end
            end
        end
    end
end

-- Tích hợp với SaveManager
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Thay đổi cách lưu cấu hình để sử dụng tên người chơi
InterfaceManager:SetFolder("HTHubAS")
SaveManager:SetFolder("HTHubAS/" .. playerName)

-- Thêm thông tin vào tab Settings
SettingsTab:AddParagraph({
    Title = "Cấu hình tự động",
    Content = "Cấu hình của bạn đang được tự động lưu theo tên nhân vật: " .. playerName
})

SettingsTab:AddParagraph({
    Title = "Phím tắt",
    Content = "Nhấn LeftControl để ẩn/hiện giao diện"
})

-- Thực thi tự động lưu cấu hình
AutoSaveConfig()

-- Thiết lập events
setupSaveEvents()


-- Thêm section Auto Play vào tab Auto Play
local AutoPlaySection = AutoPlayTab:AddSection("Auto Play")

-- Thêm nút bật/tắt Auto Play
local autoPlayEnabled = false

AutoPlaySection:AddToggle("AutoPlayToggle", {
    Title = "Bật Auto Play",
    Default = false,
    Callback = function(Value)
        autoPlayEnabled = Value
        if autoPlayEnabled then
            print("Auto Play đã bật!")
            -- Thêm code auto play tại đây
        else
            print("Auto Play đã tắt!")
            -- Thêm code dừng auto play tại đây
        end
    end
})

-- ...existing code...

local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

LocalPlayer.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = nil
    repeat wait() until char:FindFirstChild("HumanoidRootPart")
    humanoidRootPart = char.HumanoidRootPart
    humanoid = char:WaitForChild("Humanoid")
    camera.CameraSubject = humanoid
    camera.CameraType = Enum.CameraType.Custom
end)

local followConnection

local function findNearestEnemy()
    local mobsFolder = workspace:FindFirstChild("Enemy")
    if not mobsFolder then return nil end
    local mobs = mobsFolder:FindFirstChild("Mob")
    if not mobs then return nil end

    if not humanoidRootPart then return nil end

    local nearestMob = nil
    local nearestDistance = math.huge
    for _, mob in pairs(mobs:GetChildren()) do
        if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") then
            local mobHRP = mob.HumanoidRootPart
            local dist = (mobHRP.Position - humanoidRootPart.Position).Magnitude
            if dist < nearestDistance then
                nearestDistance = dist
                nearestMob = mob
            end
        end
    end
    return nearestMob
end

-- Toggle AutoFollowEnemy trong Fluent UI
local autoFollowEnemy = ConfigSystem.CurrentConfig.AutoFollowEnemy
AutoPlaySection:AddToggle("AutoFollowEnemy", {
    Title = "Auto TP Enemy",
    Default = ConfigSystem.CurrentConfig.AutoFollowEnemy,
    Callback = function(Value)
        autoFollowEnemy = Value
        ConfigSystem.CurrentConfig.AutoFollowEnemy = Value
        ConfigSystem.SaveConfig()
        if autoFollowEnemy then
            camera.CameraSubject = humanoid
            camera.CameraType = Enum.CameraType.Custom
            followConnection = RunService.Heartbeat:Connect(function()
                if character and humanoidRootPart then
                    local nearestEnemy = findNearestEnemy()
                    if nearestEnemy and nearestEnemy:FindFirstChild("HumanoidRootPart") then
                        local enemyHRP = nearestEnemy.HumanoidRootPart
                        local targetPos = enemyHRP.Position - Vector3.new(0, 7, 0)
                        local lookDir = Vector3.new(0, 1, 0)
                        character:PivotTo(CFrame.new(targetPos, targetPos + lookDir))
                    end
                end
            end)
        else
            if followConnection then
                followConnection:Disconnect()
                followConnection = nil
            end
        end
    end
})

-- ...existing code...

-- ...existing code...

-- Auto Combat

-- Auto Combat Toggle
local autoCombat = ConfigSystem.CurrentConfig.AutoCombat
local combatThread
AutoPlaySection:AddToggle("AutoCombat", {
    Title = "Auto Combat",
    Default = ConfigSystem.CurrentConfig.AutoCombat,
    Callback = function(Value)
        autoCombat = Value
        ConfigSystem.CurrentConfig.AutoCombat = Value
        ConfigSystem.SaveConfig()
        if autoCombat then
            combatThread = task.spawn(function()
                repeat task.wait() until game:IsLoaded()
                while autoCombat do
                    local combatFunction = nil
                    local env = getgc(true)
                    for _, func in ipairs(env) do
                        if typeof(func) == "function" and debug.getinfo(func).name == "Combat" then
                            local constants = debug.getconstants(func)
                            if table.find(constants, "Humanoid") and table.find(constants, "Slash") then
                                combatFunction = func
                                break
                            end
                        end
                    end
                    if combatFunction then
                        pcall(combatFunction)
                    end
                    task.wait(0.2)
                end
            end)
        else
            if combatThread then
                task.cancel(combatThread)
            end
        end
    end
})

-- ...existing code...

-- ...existing code...

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function getPositionData()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        return hrp.CFrame, hrp.Position
    end
    return nil, nil
end


AutoPlaySection:AddParagraph({
    Title = "Auto Skill",
    Content = "Auto use skills"

})

-- Auto Skill 1 Toggle
local autoSkill1 = ConfigSystem.CurrentConfig.AutoSkill1
local skill1Thread
AutoPlaySection:AddToggle("AutoSkill1", {
    Title = "Auto Skill 1",
    Default = ConfigSystem.CurrentConfig.AutoSkill1,
    Callback = function(Value)
        autoSkill1 = Value
        ConfigSystem.CurrentConfig.AutoSkill1 = Value
        ConfigSystem.SaveConfig()
        if autoSkill1 then
            skill1Thread = task.spawn(function()
                while autoSkill1 do
                    local cf, pos = getPositionData()
                    if cf and pos then
                        local args = {"Skill1", cf, pos, "OnSkill"}
                        ReplicatedStorage.Events.Skill:FireServer(unpack(args))
                    end
                    task.wait(5)
                end
            end)
        else
            if skill1Thread then
                task.cancel(skill1Thread)
            end
        end
    end
})

-- Auto Skill 2 Toggle
local autoSkill2 = ConfigSystem.CurrentConfig.AutoSkill2
local skill2Thread
AutoPlaySection:AddToggle("AutoSkill2", {
    Title = "Auto Skill 2",
    Default = ConfigSystem.CurrentConfig.AutoSkill2,
    Callback = function(Value)
        autoSkill2 = Value
        ConfigSystem.CurrentConfig.AutoSkill2 = Value
        ConfigSystem.SaveConfig()
        if autoSkill2 then
            skill2Thread = task.spawn(function()
                while autoSkill2 do
                    local cf, pos = getPositionData()
                    if cf and pos then
                        local args = {"Skill2", cf, pos, "OnSkill"}
                        ReplicatedStorage.Events.Skill:FireServer(unpack(args))
                    end
                    task.wait(7)
                end
            end)
        else
            if skill2Thread then
                task.cancel(skill2Thread)
            end
        end
    end
})
-- Auto Skill 3 Toggle
local autoSkill3 = ConfigSystem.CurrentConfig.AutoSkill3
local skill3Thread
AutoPlaySection:AddToggle("AutoSkill3", {
    Title = "Auto Skill 3",
    Default = ConfigSystem.CurrentConfig.AutoSkill3,
    Callback = function(Value)
        autoSkill3 = Value
        ConfigSystem.CurrentConfig.AutoSkill3 = Value
        ConfigSystem.SaveConfig()
        if autoSkill3 then
            skill3Thread = task.spawn(function()
                while autoSkill3 do
                    local cf, pos = getPositionData()
                    if cf and pos then
                        local args = {"Skill3", cf, pos, "OnSkill"}
                        ReplicatedStorage.Events.Skill:FireServer(unpack(args))
                    end
                    task.wait(10)
                end
            end)
        else
            if skill3Thread then
                task.cancel(skill3Thread)
            end
        end
    end
})


AutoPlaySection:AddParagraph({
    Title = "Hướng dẫn",
    Content = "Bật tính năng Auto Play để tự động thực hiện các thao tác trong game."
})


print("x2zu | Anime Saga đã được tải thành công!")