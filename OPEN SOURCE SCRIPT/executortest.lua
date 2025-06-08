local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CheckerPanelGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.05, 0)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3
UIStroke.Parent = MainFrame

local function AnimateUIStroke()
    while true do
        for hue = 0, 1, 0.01 do
            UIStroke.Color = Color3.fromHSV(hue, 1, 1)
            task.wait(0.05)
        end
    end
end

spawn(AnimateUIStroke)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0.1, 0)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundTransparency = 0.8
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0.2, 0)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Text = "🔬 Executor Checker Panel"
Title.Size = UDim2.new(0.85, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "❌"
CloseButton.Size = UDim2.new(0.15, 0, 1, 0)
CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0) -- Darker red color
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TopBar

local UICorner_Close = Instance.new("UICorner")
UICorner_Close.CornerRadius = UDim.new(1, 0)
UICorner_Close.Parent = CloseButton

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 0.85, 0)
ScrollingFrame.Position = UDim2.new(0, 0, 0.15, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.ScrollBarImageTransparency = 0.7
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2.2, 0)
ScrollingFrame.Parent = MainFrame

local Version = Instance.new("TextLabel")
Version.Text = "Version 2.0"
Version.Size = UDim2.new(1, 0, 0.1, 0)
Version.Position = UDim2.new(0, 0, 0.9, 0)
Version.BackgroundTransparency = 1
Version.TextColor3 = Color3.fromRGB(255, 255, 255)
Version.Font = Enum.Font.GothamBold
Version.TextSize = 14
Version.Parent = ScrollingFrame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local function CreateButton(text, position, scriptUrl)
    local Button = Instance.new("TextButton")
    Button.Text = text
    Button.Size = UDim2.new(0.9, 0, 0.08, 0)
    Button.Position = UDim2.new(0.05, 0, position, 0)
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 16
    Button.Parent = ScrollingFrame

    local UICorner_Button = Instance.new("UICorner")
    UICorner_Button.CornerRadius = UDim.new(0.2, 0)
    UICorner_Button.Parent = Button

    Button.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
end

CreateButton("📌 UNC Test Official", 0.02, "https://rawscripts.net/raw/Universal-Script-UNC-Test-13114")
CreateButton("📌 sUNC Test", 0.12, "https://gitlab.com/sens3/nebunu/-/raw/main/HummingBird8's_sUNC_yes_i_moved_to_gitlab_because_my_github_acc_got_brickedd/sUNCm0m3n7.lua")
CreateButton("🍒 CET (Cherry's Environment Test)", 0.22, "https://raw.githubusercontent.com/InfernusScripts/Executor-Tests/refs/heads/main/Environment/Test.lua")
CreateButton("🛡 Vulnerability Test", 0.32, "https://raw.githubusercontent.com/zryr/Vulnerability-Check/refs/heads/main/Script")
CreateButton("⚙️ Require Support", 0.42, "https://raw.githubusercontent.com/RealBatu20/AI-Scripts-2025/refs/heads/main/RequireChecker.lua")
CreateButton("🆔 Identity Test", 0.52, "https://raw.githubusercontent.com/InfernusScripts/Executor-Tests/main/Identity/Test.lua")
CreateButton("📈 Level Test", 0.62, "https://raw.githubusercontent.com/vvult/HIdentity/refs/heads/main/HIdentity")
CreateButton("🧊 3D Visualization Test", 0.72, "https://raw.githubusercontent.com/1Softworks/3D-Visualization-Test/refs/heads/main/3dtest.lua")
CreateButton("🚄 Execution Speed Test", 0.82, "https://raw.githubusercontent.com/realdefinity/tests/main/executiontest")

local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

print("✅ UI Loaded Successfully")