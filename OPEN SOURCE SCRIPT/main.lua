

if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ZayrosFISHIT") ~= nil then
	game.Players.LocalPlayer.PlayerGui.ZayrosFISHIT:Destroy()
end

-- Instance

local ZayrosFISHIT = Instance.new("ScreenGui")
local FrameUtama = Instance.new("Frame")
local ExitBtn = Instance.new("TextButton")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local UICorner = Instance.new("UICorner")
local UICorner_2 = Instance.new("UICorner")
local SideBar = Instance.new("Frame")
local Logo = Instance.new("ImageLabel")
local UICorner_3 = Instance.new("UICorner")
local Tittle = Instance.new("TextLabel")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local MainMenuSaidBar = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local MAIN = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
local Player = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
local SpawnBoat = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
local TpIsland = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")
local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")
local Settings = Instance.new("TextButton")
local UICorner_8 = Instance.new("UICorner")
local UITextSizeConstraint_7 = Instance.new("UITextSizeConstraint")
local Line = Instance.new("Frame")
local Line_2 = Instance.new("Frame")
local Tittle_2 = Instance.new("TextLabel")
local UITextSizeConstraint_8 = Instance.new("UITextSizeConstraint")
local MainFrame = Instance.new("ScrollingFrame")
local SellAllFrame = Instance.new("Frame")
local UICorner_9 = Instance.new("UICorner")
local SellAllButton = Instance.new("TextButton")
local SellAllText = Instance.new("TextLabel")
local AutoFishFrame = Instance.new("Frame")
local UICorner_10 = Instance.new("UICorner")
local AutoFishText = Instance.new("TextLabel")
local UITextSizeConstraint_9 = Instance.new("UITextSizeConstraint")
local AutoFishButton = Instance.new("TextButton")
local UITextSizeConstraint_10 = Instance.new("UITextSizeConstraint")
local AutoFishWarna = Instance.new("Frame")
local UICorner_11 = Instance.new("UICorner")
local PlayerFrame = Instance.new("ScrollingFrame")
local WalkSpeedFrame = Instance.new("Frame")
local UICorner_12 = Instance.new("UICorner")
local WalkSpeedText = Instance.new("TextLabel")
local UITextSizeConstraint_11 = Instance.new("UITextSizeConstraint")
local WalkSpeedWarna = Instance.new("Frame")
local UICorner_13 = Instance.new("UICorner")
local WalkSpeedTextBox = Instance.new("TextBox")
local UICorner_14 = Instance.new("UICorner")
local UITextSizeConstraint_12 = Instance.new("UITextSizeConstraint")
local TpPlayerInputFrame = Instance.new("Frame")
local UICorner_15 = Instance.new("UICorner")
local TpPlayerInputText = Instance.new("TextLabel")
local TPPlayerBackgroundInput = Instance.new("Frame")
local UICorner_16 = Instance.new("UICorner")
local WalkSpeedFrameButton = Instance.new("Frame")
local UICorner_17 = Instance.new("UICorner")
local WalkSpeedAcceptText = Instance.new("TextLabel")
local SetWalkSpeedButton = Instance.new("TextButton")
local UICorner_18 = Instance.new("UICorner")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local NoOxygenDamageFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local NoOxygenText = Instance.new("TextLabel")
local NoOxygenWarna = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local NoOxygenButton = Instance.new("TextButton")
local UITextSizeConstraint_13 = Instance.new("UITextSizeConstraint")
local TPEventFrame = Instance.new("ScrollingFrame")
local AnnouncementBelumAdaEventText = Instance.new("TextLabel")
local UITextSizeConstraint_14 = Instance.new("UITextSizeConstraint")
local TPEvent = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UITextSizeConstraint_15 = Instance.new("UITextSizeConstraint")


--Properties:

ZayrosFISHIT.Name = "ZayrosFISHIT"
ZayrosFISHIT.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ZayrosFISHIT.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

FrameUtama.Name = "FrameUtama"
FrameUtama.Parent = ZayrosFISHIT
FrameUtama.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FrameUtama.BackgroundTransparency = 0.200
FrameUtama.BorderColor3 = Color3.fromRGB(0, 0, 0)
FrameUtama.BorderSizePixel = 0
FrameUtama.Position = UDim2.new(0.313479632, 0, 0.228434503, 0)
FrameUtama.Size = UDim2.new(0.373040766, 0, 0.54153353, 0)

FrameUtama.Active = true
FrameUtama.Draggable = true

ExitBtn.Name = "ExitBtn"
ExitBtn.Parent = FrameUtama
ExitBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 34)
ExitBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
ExitBtn.BorderSizePixel = 0
ExitBtn.Position = UDim2.new(0.900729239, 0, 0.0375426635, 0)
ExitBtn.Size = UDim2.new(0.0630252063, 0, 0.0884955749, 0)
ExitBtn.Font = Enum.Font.SourceSansBold
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.TextScaled = true
ExitBtn.TextSize = 14.000
ExitBtn.TextWrapped = true

UITextSizeConstraint.Parent = ExitBtn
UITextSizeConstraint.MaxTextSize = 14

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = ExitBtn

UICorner_2.Parent = FrameUtama

SideBar.Name = "SideBar"
SideBar.Parent = FrameUtama
SideBar.BackgroundColor3 = Color3.fromRGB(83, 83, 83)
SideBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
SideBar.BorderSizePixel = 0
SideBar.Size = UDim2.new(0.376050383, 0, 1, 0)
SideBar.ZIndex = 2

Logo.Name = "Logo"
Logo.Parent = SideBar
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
Logo.BorderSizePixel = 0
Logo.Position = UDim2.new(0.0729603693, 0, 0.0375426523, 0)
Logo.Size = UDim2.new(0.167597771, 0, 0.0884955749, 0)
Logo.ZIndex = 2
Logo.Image = "rbxassetid://136555589792977"

UICorner_3.CornerRadius = UDim.new(0, 10)
UICorner_3.Parent = Logo

Tittle.Name = "Tittle"
Tittle.Parent = SideBar
Tittle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tittle.BackgroundTransparency = 1.000
Tittle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tittle.BorderSizePixel = 0
Tittle.Position = UDim2.new(0.309023052, 0, 0.0375426523, 0)
Tittle.Size = UDim2.new(0.65363127, 0, 0.0884955749, 0)
Tittle.ZIndex = 2
Tittle.Font = Enum.Font.SourceSansBold
Tittle.Text = "Zayros FISHIT"
Tittle.TextColor3 = Color3.fromRGB(255, 255, 255)
Tittle.TextScaled = true
Tittle.TextSize = 20.000
Tittle.TextWrapped = true
Tittle.TextXAlignment = Enum.TextXAlignment.Left

UITextSizeConstraint_2.Parent = Tittle
UITextSizeConstraint_2.MaxTextSize = 20

MainMenuSaidBar.Name = "MainMenuSaidBar"
MainMenuSaidBar.Parent = SideBar
MainMenuSaidBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainMenuSaidBar.BackgroundTransparency = 1.000
MainMenuSaidBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainMenuSaidBar.BorderSizePixel = 0
MainMenuSaidBar.Position = UDim2.new(0, 0, 0.16519174, 0)
MainMenuSaidBar.Size = UDim2.new(1, 0, 0.781710923, 0)

UIListLayout.Parent = MainMenuSaidBar
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0.0500000007, 0)

MAIN.Name = "MAIN"
MAIN.Parent = MainMenuSaidBar
MAIN.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MAIN.BorderColor3 = Color3.fromRGB(0, 0, 0)
MAIN.BorderSizePixel = 0
MAIN.Size = UDim2.new(0.916201115, 0, 0.113207549, 0)
MAIN.Font = Enum.Font.SourceSansBold
MAIN.Text = "MAIN"
MAIN.TextColor3 = Color3.fromRGB(255, 255, 255)
MAIN.TextScaled = true
MAIN.TextSize = 14.000
MAIN.TextWrapped = true

UICorner_4.Parent = MAIN

UITextSizeConstraint_3.Parent = MAIN
UITextSizeConstraint_3.MaxTextSize = 14

Player.Name = "Player"
Player.Parent = MainMenuSaidBar
Player.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Player.BorderColor3 = Color3.fromRGB(0, 0, 0)
Player.BorderSizePixel = 0
Player.Size = UDim2.new(0.916201115, 0, 0.113207549, 0)
Player.Font = Enum.Font.SourceSansBold
Player.Text = "PLAYER"
Player.TextColor3 = Color3.fromRGB(255, 255, 255)
Player.TextScaled = true
Player.TextSize = 14.000
Player.TextWrapped = true

UICorner_5.Parent = Player

UITextSizeConstraint_4.Parent = Player
UITextSizeConstraint_4.MaxTextSize = 14

SpawnBoat.Name = "SpawnBoat"
SpawnBoat.Parent = MainMenuSaidBar
SpawnBoat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SpawnBoat.BorderColor3 = Color3.fromRGB(0, 0, 0)
SpawnBoat.BorderSizePixel = 0
SpawnBoat.Size = UDim2.new(0.916201115, 0, 0.113207549, 0)
SpawnBoat.Font = Enum.Font.SourceSansBold
SpawnBoat.Text = "SPAWN BOAT"
SpawnBoat.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnBoat.TextScaled = true
SpawnBoat.TextSize = 14.000
SpawnBoat.TextWrapped = true

UICorner_6.Parent = SpawnBoat

UITextSizeConstraint_5.Parent = SpawnBoat
UITextSizeConstraint_5.MaxTextSize = 14

TpIsland.Name = "TpIsland"
TpIsland.Parent = MainMenuSaidBar
TpIsland.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TpIsland.BorderColor3 = Color3.fromRGB(0, 0, 0)
TpIsland.BorderSizePixel = 0
TpIsland.Size = UDim2.new(0.916201115, 0, 0.113207549, 0)
TpIsland.Font = Enum.Font.SourceSansBold
TpIsland.Text = "TP ISLAND"
TpIsland.TextColor3 = Color3.fromRGB(255, 255, 255)
TpIsland.TextScaled = true
TpIsland.TextSize = 14.000
TpIsland.TextWrapped = true

UICorner_7.Parent = TpIsland

UITextSizeConstraint_6.Parent = TpIsland
UITextSizeConstraint_6.MaxTextSize = 14

Settings.Name = "Settings"
Settings.Parent = MainMenuSaidBar
Settings.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Settings.BorderColor3 = Color3.fromRGB(0, 0, 0)
Settings.BorderSizePixel = 0
Settings.Position = UDim2.new(0.0418994427, 0, 0.71981132, 0)
Settings.Size = UDim2.new(0.916201115, 0, 0.113207549, 0)
Settings.Font = Enum.Font.SourceSansBold
Settings.Text = "SETTINGS"
Settings.TextColor3 = Color3.fromRGB(255, 255, 255)
Settings.TextScaled = true
Settings.TextSize = 14.000
Settings.TextWrapped = true

UICorner_8.Parent = Settings

UITextSizeConstraint_7.Parent = Settings
UITextSizeConstraint_7.MaxTextSize = 14

Line.Name = "Line"
Line.Parent = SideBar
Line.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0, 0, 0.144542769, 0)
Line.Size = UDim2.new(1, 0, 0.0029498525, 0)
Line.ZIndex = 2

Line_2.Name = "Line"
Line_2.Parent = FrameUtama
Line_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Line_2.BorderSizePixel = 0
Line_2.Position = UDim2.new(0.376050383, 0, 0.144542769, 0)
Line_2.Size = UDim2.new(0.623949528, 0, 0.0029498525, 0)
Line_2.ZIndex = 2

Tittle_2.Name = "Tittle"
Tittle_2.Parent = FrameUtama
Tittle_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tittle_2.BackgroundTransparency = 1.000
Tittle_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tittle_2.BorderSizePixel = 0
Tittle_2.Position = UDim2.new(0.420367569, 0, 0.0375426523, 0)
Tittle_2.Size = UDim2.new(0.443547368, 0, 0.0884955749, 0)
Tittle_2.ZIndex = 2
Tittle_2.Font = Enum.Font.SourceSansBold
Tittle_2.Text = ""
Tittle_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Tittle_2.TextScaled = true
Tittle_2.TextSize = 20.000
Tittle_2.TextWrapped = true

UITextSizeConstraint_8.Parent = Tittle_2
UITextSizeConstraint_8.MaxTextSize = 20

MainFrame.Name = "MainFrame"
MainFrame.Parent = FrameUtama
MainFrame.Active = true
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 1.000
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.376050383, 0, 0.147492632, 0)
MainFrame.Size = UDim2.new(0.623949528, 0, 0.641952515, 0)
MainFrame.Visible = false
MainFrame.ZIndex = 2
MainFrame.ScrollBarThickness = 6

SellAllFrame.Name = "SellAllFrame"
SellAllFrame.Parent = MainFrame
SellAllFrame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
SellAllFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
SellAllFrame.BorderSizePixel = 0
SellAllFrame.Position = UDim2.new(0.0437710434, 0, 0.209508449, 0)
SellAllFrame.Size = UDim2.new(0.898000002, 0, 0.105999999, 0)

UICorner_9.Parent = SellAllFrame

SellAllButton.Name = "SellAllButton"
SellAllButton.Parent = SellAllFrame
SellAllButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SellAllButton.BackgroundTransparency = 1.000
SellAllButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
SellAllButton.BorderSizePixel = 0
SellAllButton.Size = UDim2.new(1, 0, 1, 0)
SellAllButton.ZIndex = 2
SellAllButton.Font = Enum.Font.SourceSansBold
SellAllButton.Text = ""
SellAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SellAllButton.TextSize = 14.000

SellAllText.Name = "SellAllText"
SellAllText.Parent = SellAllFrame
SellAllText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SellAllText.BackgroundTransparency = 1.000
SellAllText.BorderColor3 = Color3.fromRGB(0, 0, 0)
SellAllText.BorderSizePixel = 0
SellAllText.Position = UDim2.new(0.0296296291, 0, 0.216216221, 0)
SellAllText.Size = UDim2.new(0.4148148, 0, 0.567567587, 0)
SellAllText.Font = Enum.Font.SourceSansBold
SellAllText.Text = "Sell All Then TP Back"
SellAllText.TextColor3 = Color3.fromRGB(255, 255, 255)
SellAllText.TextScaled = true
SellAllText.TextSize = 14.000
SellAllText.TextWrapped = true
SellAllText.TextXAlignment = Enum.TextXAlignment.Left

AutoFishFrame.Name = "AutoFishFrame"
AutoFishFrame.Parent = MainFrame
AutoFishFrame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
AutoFishFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoFishFrame.BorderSizePixel = 0
AutoFishFrame.Position = UDim2.new(0.0437708385, 0, 0.0418279432, 0)
AutoFishFrame.Size = UDim2.new(0.898138702, 0, 0.106191501, 0)

UICorner_10.Parent = AutoFishFrame

AutoFishText.Name = "AutoFishText"
AutoFishText.Parent = AutoFishFrame
AutoFishText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AutoFishText.BackgroundTransparency = 1.000
AutoFishText.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoFishText.BorderSizePixel = 0
AutoFishText.Position = UDim2.new(0.0296296291, 0, 0.216216221, 0)
AutoFishText.Size = UDim2.new(0.4148148, 0, 0.567567587, 0)
AutoFishText.Font = Enum.Font.SourceSansBold
AutoFishText.Text = "Auto Fish (AFK) :"
AutoFishText.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFishText.TextScaled = true
AutoFishText.TextSize = 14.000
AutoFishText.TextWrapped = true
AutoFishText.TextXAlignment = Enum.TextXAlignment.Left

UITextSizeConstraint_9.Parent = AutoFishText
UITextSizeConstraint_9.MaxTextSize = 14

AutoFishButton.Name = "AutoFishButton"
AutoFishButton.Parent = AutoFishFrame
AutoFishButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AutoFishButton.BackgroundTransparency = 1.000
AutoFishButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoFishButton.BorderSizePixel = 0
AutoFishButton.Position = UDim2.new(0.75555557, 0, 0.108108111, 0)
AutoFishButton.Size = UDim2.new(0.2074074, 0, 0.783783793, 0)
AutoFishButton.ZIndex = 2
AutoFishButton.Font = Enum.Font.SourceSansBold
AutoFishButton.Text = "OFF"
AutoFishButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFishButton.TextScaled = true
AutoFishButton.TextSize = 14.000
AutoFishButton.TextWrapped = true

UITextSizeConstraint_10.Parent = AutoFishButton
UITextSizeConstraint_10.MaxTextSize = 14

AutoFishWarna.Name = "AutoFishWarna"
AutoFishWarna.Parent = AutoFishFrame
AutoFishWarna.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AutoFishWarna.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoFishWarna.BorderSizePixel = 0
AutoFishWarna.Position = UDim2.new(0.75555557, 0, 0.135135129, 0)
AutoFishWarna.Size = UDim2.new(0.203703701, 0, 0.729729712, 0)

UICorner_11.Parent = AutoFishWarna

PlayerFrame.Name = "PlayerFrame"
PlayerFrame.Parent = FrameUtama
PlayerFrame.Active = true
PlayerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerFrame.BackgroundTransparency = 1.000
PlayerFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
PlayerFrame.BorderSizePixel = 0
PlayerFrame.Position = UDim2.new(0.376050383, 0, 0.147492632, 0)
PlayerFrame.Size = UDim2.new(0.623949528, 0, 0.852507353, 0)
PlayerFrame.ScrollBarThickness = 6
PlayerFrame.Visible =false

WalkSpeedFrame.Name = "WalkSpeedFrame"
WalkSpeedFrame.Parent = PlayerFrame
WalkSpeedFrame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
WalkSpeedFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
WalkSpeedFrame.BorderSizePixel = 0
WalkSpeedFrame.Position = UDim2.new(0.0437710434, 0, 0.0202609263, 0)
WalkSpeedFrame.Size = UDim2.new(0.898000002, 0, 0.105999999, 0)

UICorner_12.Parent = WalkSpeedFrame

WalkSpeedText.Name = "WalkSpeedText"
WalkSpeedText.Parent = WalkSpeedFrame
WalkSpeedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedText.BackgroundTransparency = 1.000
WalkSpeedText.BorderColor3 = Color3.fromRGB(0, 0, 0)
WalkSpeedText.BorderSizePixel = 0
WalkSpeedText.Position = UDim2.new(0.0296296291, 0, 0.216216221, 0)
WalkSpeedText.Size = UDim2.new(0.4148148, 0, 0.567567587, 0)
WalkSpeedText.Font = Enum.Font.SourceSansBold
WalkSpeedText.Text = "WALK SPEED:"
WalkSpeedText.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedText.TextScaled = true
WalkSpeedText.TextSize = 14.000
WalkSpeedText.TextWrapped = true
WalkSpeedText.TextXAlignment = Enum.TextXAlignment.Left

UITextSizeConstraint_11.Parent = WalkSpeedText
UITextSizeConstraint_11.MaxTextSize = 14

WalkSpeedWarna.Name = "WalkSpeedWarna"
WalkSpeedWarna.Parent = WalkSpeedFrame
WalkSpeedWarna.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
WalkSpeedWarna.BorderColor3 = Color3.fromRGB(0, 0, 0)
WalkSpeedWarna.BorderSizePixel = 0
WalkSpeedWarna.Position = UDim2.new(0.718999982, 0, 0.135000005, 0)
WalkSpeedWarna.Size = UDim2.new(0.256999999, 0, 0.730000019, 0)

UICorner_13.Parent = WalkSpeedWarna

WalkSpeedTextBox.Name = "WalkSpeedTextBox"
WalkSpeedTextBox.Parent = WalkSpeedFrame
WalkSpeedTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedTextBox.BackgroundTransparency = 1.000
WalkSpeedTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
WalkSpeedTextBox.BorderSizePixel = 0
WalkSpeedTextBox.Position = UDim2.new(0.718999982, 0, 0.135000005, 0)
WalkSpeedTextBox.Size = UDim2.new(0.256999999, 0, 0.730000019, 0)
WalkSpeedTextBox.ZIndex = 3
WalkSpeedTextBox.Font = Enum.Font.SourceSansBold
WalkSpeedTextBox.PlaceholderColor3 = Color3.fromRGB(108, 108, 108)
WalkSpeedTextBox.PlaceholderText = "18"
WalkSpeedTextBox.Text = ""
WalkSpeedTextBox.TextColor3 = Color3.fromRGB(253, 253, 253)
WalkSpeedTextBox.TextScaled = true
WalkSpeedTextBox.TextSize = 18.000
WalkSpeedTextBox.TextWrapped = true

UICorner_14.Parent = WalkSpeedTextBox

UITextSizeConstraint_12.Parent = WalkSpeedTextBox
UITextSizeConstraint_12.MaxTextSize = 18

TpPlayerInputFrame.Name = "TpPlayerInputFrame"
TpPlayerInputFrame.Parent = PlayerFrame
TpPlayerInputFrame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
TpPlayerInputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
TpPlayerInputFrame.BorderSizePixel = 0
TpPlayerInputFrame.Position = UDim2.new(0.0404040404, 0, 0.250967681, 0)
TpPlayerInputFrame.Size = UDim2.new(0.898000002, 0, 0.105999999, 0)

UICorner_15.Parent = TpPlayerInputFrame

TpPlayerInputText.Name = "TpPlayerInputText"
TpPlayerInputText.Parent = TpPlayerInputFrame
TpPlayerInputText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TpPlayerInputText.BackgroundTransparency = 1.000
TpPlayerInputText.BorderColor3 = Color3.fromRGB(0, 0, 0)
TpPlayerInputText.BorderSizePixel = 0
TpPlayerInputText.Position = UDim2.new(0.0296296291, 0, 0.216216221, 0)
TpPlayerInputText.Size = UDim2.new(0, 112, 0, 21)
TpPlayerInputText.Font = Enum.Font.SourceSansBold
TpPlayerInputText.Text = "TP PLAYER :"
TpPlayerInputText.TextColor3 = Color3.fromRGB(255, 255, 255)
TpPlayerInputText.TextSize = 14.000
TpPlayerInputText.TextXAlignment = Enum.TextXAlignment.Left

TPPlayerBackgroundInput.Name = "TPPlayerBackgroundInput"
TPPlayerBackgroundInput.Parent = TpPlayerInputFrame
TPPlayerBackgroundInput.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TPPlayerBackgroundInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
TPPlayerBackgroundInput.BorderSizePixel = 0
TPPlayerBackgroundInput.Position = UDim2.new(0.718999982, 0, 0.135000005, 0)
TPPlayerBackgroundInput.Size = UDim2.new(0.256999999, 0, 0.730000019, 0)

UICorner_16.Parent = TPPlayerBackgroundInput

WalkSpeedFrameButton.Name = "WalkSpeedFrameButton"
WalkSpeedFrameButton.Parent = PlayerFrame
WalkSpeedFrameButton.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
WalkSpeedFrameButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
WalkSpeedFrameButton.BorderSizePixel = 0
WalkSpeedFrameButton.Position = UDim2.new(0.652999997, 0, 0.159999996, 0)
WalkSpeedFrameButton.Size = UDim2.new(0.289999992, 0, 0.0680000037, 0)

UICorner_17.Parent = WalkSpeedFrameButton

WalkSpeedAcceptText.Name = "WalkSpeedAcceptText"
WalkSpeedAcceptText.Parent = WalkSpeedFrameButton
WalkSpeedAcceptText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedAcceptText.BackgroundTransparency = 1.000
WalkSpeedAcceptText.BorderColor3 = Color3.fromRGB(0, 0, 0)
WalkSpeedAcceptText.BorderSizePixel = 0
WalkSpeedAcceptText.Position = UDim2.new(0.0368366279, 0, -0.0509649925, 0)
WalkSpeedAcceptText.Size = UDim2.new(0.967370987, 0, 0.943781316, 0)
WalkSpeedAcceptText.Font = Enum.Font.SourceSansBold
WalkSpeedAcceptText.Text = "SET WALKSPEED"
WalkSpeedAcceptText.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedAcceptText.TextScaled = true
WalkSpeedAcceptText.TextWrapped = true

SetWalkSpeedButton.Name = "SetWalkSpeedButton"
SetWalkSpeedButton.Parent = WalkSpeedFrameButton
SetWalkSpeedButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SetWalkSpeedButton.BackgroundTransparency = 1.000
SetWalkSpeedButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
SetWalkSpeedButton.BorderSizePixel = 0
SetWalkSpeedButton.Position = UDim2.new(0.111111112, 0, 0, 0)
SetWalkSpeedButton.Size = UDim2.new(0.888888896, 0, 1, 0)
SetWalkSpeedButton.Font = Enum.Font.SourceSans
SetWalkSpeedButton.Text = ""
SetWalkSpeedButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SetWalkSpeedButton.TextSize = 14.000

UICorner_18.Parent = SetWalkSpeedButton

UIAspectRatioConstraint.Parent = FrameUtama
UIAspectRatioConstraint.AspectRatio = 1.245

NoOxygenDamageFrame.Name = "NoOxygenDamageFrame"
NoOxygenDamageFrame.Parent = PlayerFrame
NoOxygenDamageFrame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
NoOxygenDamageFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
NoOxygenDamageFrame.BorderSizePixel = 0
NoOxygenDamageFrame.Position = UDim2.new(0.0404040329, 0, 0.422246426, 0)
NoOxygenDamageFrame.Size = UDim2.new(0.898000002, 0, 0.105999999, 0)

UICorner.Parent = NoOxygenDamageFrame

NoOxygenText.Name = "NoOxygenText"
NoOxygenText.Parent = NoOxygenDamageFrame
NoOxygenText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NoOxygenText.BackgroundTransparency = 1.000
NoOxygenText.BorderColor3 = Color3.fromRGB(0, 0, 0)
NoOxygenText.BorderSizePixel = 0
NoOxygenText.Position = UDim2.new(0.0296296291, 0, 0.216216221, 0)
NoOxygenText.Size = UDim2.new(0, 112, 0, 21)
NoOxygenText.Font = Enum.Font.SourceSansBold
NoOxygenText.Text = "NO OXYGEN DAMAGE :"
NoOxygenText.TextColor3 = Color3.fromRGB(255, 255, 255)
NoOxygenText.TextSize = 14.000
NoOxygenText.TextXAlignment = Enum.TextXAlignment.Left

NoOxygenWarna.Name = "NoOxygenWarna"
NoOxygenWarna.Parent = NoOxygenDamageFrame
NoOxygenWarna.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
NoOxygenWarna.BorderColor3 = Color3.fromRGB(0, 0, 0)
NoOxygenWarna.BorderSizePixel = 0
NoOxygenWarna.Position = UDim2.new(0.718999982, 0, 0.135000005, 0)
NoOxygenWarna.Size = UDim2.new(0.256999999, 0, 0.730000019, 0)

UICorner_2.Parent = NoOxygenWarna

NoOxygenButton.Name = "NoOxygenButton"
NoOxygenButton.Parent = NoOxygenDamageFrame
NoOxygenButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NoOxygenButton.BackgroundTransparency = 1.000
NoOxygenButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
NoOxygenButton.BorderSizePixel = 0
NoOxygenButton.Position = UDim2.new(0.73773706, 0, 0.108108483, 0)
NoOxygenButton.Size = UDim2.new(0.2074074, 0, 0.783783793, 0)
NoOxygenButton.ZIndex = 2
NoOxygenButton.Font = Enum.Font.SourceSansBold
NoOxygenButton.Text = "OFF"
NoOxygenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoOxygenButton.TextScaled = true
NoOxygenButton.TextSize = 14.000
NoOxygenButton.TextWrapped = true

UITextSizeConstraint_13.Parent = NoOxygenButton
UITextSizeConstraint_13.MaxTextSize = 14

TPEventFrame.Name = "TPEventFrame"
TPEventFrame.Parent = FrameUtama
TPEventFrame.Active = true
TPEventFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TPEventFrame.BackgroundTransparency = 1.000
TPEventFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
TPEventFrame.BorderSizePixel = 0
TPEventFrame.Position = UDim2.new(0.376050383, 0, 0.147492602, 0)
TPEventFrame.Size = UDim2.new(0.623949468, 0, 0.852507353, 0)
TPEventFrame.ZIndex = 2
TPEventFrame.ScrollBarThickness = 6
TPEventFrame.Visible = false

AnnouncementBelumAdaEventText.Name = "AnnouncementBelumAdaEventText"
AnnouncementBelumAdaEventText.Parent = TPEventFrame
AnnouncementBelumAdaEventText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AnnouncementBelumAdaEventText.BackgroundTransparency = 1.000
AnnouncementBelumAdaEventText.BorderColor3 = Color3.fromRGB(0, 0, 0)
AnnouncementBelumAdaEventText.BorderSizePixel = 0
AnnouncementBelumAdaEventText.Position = UDim2.new(0.0960065126, 0, 0.0182211399, 0)
AnnouncementBelumAdaEventText.Size = UDim2.new(0, 200, 0, 29)
AnnouncementBelumAdaEventText.Font = Enum.Font.SourceSansBold
AnnouncementBelumAdaEventText.Text = "Belum Ada Event Sekarang"
AnnouncementBelumAdaEventText.TextColor3 = Color3.fromRGB(255, 255, 255)
AnnouncementBelumAdaEventText.TextScaled = true
AnnouncementBelumAdaEventText.TextSize = 14.000
AnnouncementBelumAdaEventText.TextWrapped = true

UITextSizeConstraint_14.Parent = AnnouncementBelumAdaEventText
UITextSizeConstraint_14.MaxTextSize = 14

TPEvent.Name = "TPEvent"
TPEvent.Parent = MainMenuSaidBar
TPEvent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TPEvent.BorderColor3 = Color3.fromRGB(0, 0, 0)
TPEvent.BorderSizePixel = 0
TPEvent.Size = UDim2.new(0.916201115, 0, 0.113207549, 0)
TPEvent.Font = Enum.Font.SourceSansBold
TPEvent.Text = "TP EVENT"
TPEvent.TextColor3 = Color3.fromRGB(255, 255, 255)
TPEvent.TextScaled = true
TPEvent.TextSize = 14.000
TPEvent.TextWrapped = true

UICorner.Parent = TPEvent

UITextSizeConstraint_15.Parent = TPEvent
UITextSizeConstraint_15.MaxTextSize = 14

-- Function

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("ZayrosFISHIT")
local Rs = game:GetService("ReplicatedStorage")

local EquipRod = Rs.Packages._Index["sleitnick_net@0.2.0"].net["RE/EquipToolFromHotbar"]
local UnEquipRod = Rs.Packages._Index["sleitnick_net@0.2.0"].net["RE/UnequipToolFromHotbar"]
local RequestFishing = Rs.Packages._Index["sleitnick_net@0.2.0"].net["RF/RequestFishingMinigameStarted"]
local ChargeRod = Rs.Packages._Index["sleitnick_net@0.2.0"].net["RF/ChargeFishingRod"]
local FishingComplete = Rs.Packages._Index["sleitnick_net@0.2.0"].net["RE/FishingCompleted"]
local CancelFishing = Rs.Packages._Index["sleitnick_net@0.2.0"].net["RF/CancelFishingInputs"]
local Oxygen = Rs.Packages._Index["sleitnick_net@0.2.0"].net["URE/UpdateOxygen"]


_G.AutoFishing = false
_G.OxygenBypass = false

local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
	local args = {...}
	local method = getnamecallmethod()

	if self == Oxygen and method == "FireServer" and args[1] == 20 then
		if _G.OxygenBypass then
			return oldNamecall(self, 0)
		else
			return oldNamecall(self, 20)
		end
	end

	return oldNamecall(self, unpack(args))
end)




local pages = {
	Main = MainFrame,
	Player = PlayerFrame,
	TPEvent = TPEventFrame
}

local autoFishThread = nil

function toggleFishing(state)
	if state == true then
		print("AutoFishing: ON")
		_G.AutoFishing = true

		-- Spawn thread AutoFishing
		autoFishThread = task.spawn(function()
			while _G.AutoFishing do
				pcall(function()
					-- Pastikan equip rod dulu
					local char = character or character:Wait()
					local equippedTool = char:FindFirstChild("!!!EQUIPPED_TOOL!!!")

					if not equippedTool then
						-- Reset state dulu biar server mau accept equip baru
						CancelFishing:InvokeServer()
						EquipRod:FireServer(1)
					end

					-- Lanjut proses memancing
					print("Mulai pancing")
					ChargeRod:InvokeServer(workspace:GetServerTimeNow())
					RequestFishing:InvokeServer(-1.2379989624023438, 0.9800224985802423)
					task.wait(0.4)
					FishingComplete:FireServer()
				end)
			end
		end)

	else
		print("AutoFishing: OFF")
		_G.AutoFishing = false

		pcall(function()
			print("Calling Cancel + UnEquip")
			CancelFishing:InvokeServer()
			UnEquipRod:FireServer() -- ✅ pake remote yang benar sekarang
		end)
	end
end


function showPanel(pageName)
	for _, panel in pairs(pages) do
		panel.Visible = false
	end

	-- Tampilkan panel yang dipilih
	local selectedPanel = pages[pageName]
	if selectedPanel then
		selectedPanel.Visible = true

		-- Ganti judulnya
		Tittle_2.Text = pageName
	end
end

local function createEventButton(eventModel)
	local button = Instance.new("TextButton")
	button.Name = eventModel.Name
	button.Text = "TP to " .. eventModel.Name
	button.Size = UDim2.new(1, 0, 0, 30)
	button.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSansBold
	button.TextScaled = true
	button.TextWrapped = true
	button.Parent = TPEventFrame
	button.ZIndex = 2

	button.MouseButton1Click:Connect(function()
		local part = eventModel:FindFirstChildWhichIsA("BasePart")
		if part then
			character:WaitForChild("HumanoidRootPart").CFrame = part.CFrame + Vector3.new(0, 5, 0)
		end
	end)
end

local function removeEventButton(eventName)
	local button = TPEventFrame:FindFirstChild(eventName)
	if button then
		button:Destroy()
	end
end

local function updateAnnouncementTextVisibility()
	local foundEvent = false
	for _, child in pairs(TPEventFrame:GetChildren()) do
		if child:IsA("TextButton") then
			foundEvent = true
			break
		end
	end
	AnnouncementBelumAdaEventText.Visible = not foundEvent
end

local success, propsFolder = pcall(function()
	return workspace:WaitForChild("Props", 3) -- tunggu max 3 detik
end)

if success and propsFolder then
	-- Listener: Tambah event baru
	propsFolder.ChildAdded:Connect(function(child)
		if child:IsA("Model") then
			createEventButton(child)
			updateAnnouncementTextVisibility()
		end
	end)

	-- Listener: Hapus event
	propsFolder.ChildRemoved:Connect(function(child)
		removeEventButton(child.Name)
		updateAnnouncementTextVisibility()
	end)

	-- Cek event saat start script
	for _, child in ipairs(propsFolder:GetChildren()) do
		if child:IsA("Model") then
			createEventButton(child)
		end
	end
	updateAnnouncementTextVisibility()
else
	-- Jika Props tidak ditemukan, tampilkan teks
	AnnouncementBelumAdaEventText.Visible = true
end

-- Button Functional

AutoFishButton.MouseButton1Click:Connect(function()
	if _G.AutoFishing then
		toggleFishing(false)
		AutoFishButton.Text = "AutoFishing: OFF"
	else
		toggleFishing(true)
		AutoFishButton.Text = "AutoFishing: ON"
	end
end)

ExitBtn.MouseButton1Click:Connect(function()
	ZayrosFISHIT:Destroy()

end)

MAIN.MouseButton1Click:Connect(function()
	showPanel("Main")
end)

Player.MouseButton1Click:Connect(function()
	showPanel("Player")
end)

TPEvent.MouseButton1Click:Connect(function()
	showPanel("TPEvent")
end)

showPanel("Main")

NoOxygenButton.MouseButton1Click:Connect(function()
	_G.OxygenBypass = not _G.OxygenBypass

	if _G.OxygenBypass then
		NoOxygenButton.Text = "NoOxygen: ON"
	else
		NoOxygenButton.Text = "NoOxygen: OFF"
	end
end)

SetWalkSpeedButton.MouseButton1Click:Connect(function()
	local input = WalkSpeedTextBox.Text
	local speed = tonumber(input)
	if speed and character:FindFirstChildOfClass("Humanoid") then
		character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
	end
end)