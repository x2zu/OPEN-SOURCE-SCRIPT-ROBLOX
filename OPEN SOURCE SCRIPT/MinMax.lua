local ClickButton = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local IconButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")

ClickButton.Name = "ClickButton"
ClickButton.Parent = game.CoreGui
ClickButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ClickButton.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ClickButton
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 50, 0, 50)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

IconButton.Parent = MainFrame
IconButton.BackgroundTransparency = 1
IconButton.Size = UDim2.new(1, 0, 1, 0)
IconButton.Image = "rbxassetid://73407780444753"
IconButton.ScaleType = Enum.ScaleType.Fit

local isMinimized = false
IconButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "LeftControl", false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "LeftControl", false, game)
end)

