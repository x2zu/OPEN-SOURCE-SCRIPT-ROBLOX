-- Create and setup ScreenGui
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local targetNameLabel = Instance.new("TextLabel")
local targetNameInput = Instance.new("TextBox")
local sendButton = Instance.new("TextButton")  -- Button to send all items on click
local statusLabel = Instance.new("TextLabel")

screenGui.Name = "TradeOfferGui"
screenGui.Parent = game.Players.LocalPlayer.PlayerGui

-- Frame Setup
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
frame.BorderSizePixel = 2
frame.Parent = screenGui

-- Add UICorner for rounded corners
local frameUICorner = Instance.new("UICorner")
frameUICorner.CornerRadius = UDim.new(0, 15)
frameUICorner.Parent = frame

-- Target name input label
targetNameLabel.Size = UDim2.new(0, 380, 0, 30)
targetNameLabel.Position = UDim2.new(0, 10, 0, 40)
targetNameLabel.Text = "Enter Target Account Name:"
targetNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
targetNameLabel.BackgroundTransparency = 1
targetNameLabel.TextSize = 16
targetNameLabel.Parent = frame

-- Target name input box
targetNameInput.Size = UDim2.new(0, 380, 0, 30)
targetNameInput.Position = UDim2.new(0, 10, 0, 70)
targetNameInput.PlaceholderText = "e.g., Mangtti_stock"
targetNameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
targetNameInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
targetNameInput.BorderSizePixel = 2
targetNameInput.Parent = frame

-- "Send All Items" button
sendButton.Size = UDim2.new(0, 380, 0, 40)
sendButton.Position = UDim2.new(0, 10, 0, 110)
sendButton.Text = "Send All Items"
sendButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.TextSize = 16
sendButton.Parent = frame

-- Status label
statusLabel.Size = UDim2.new(0, 380, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 160)
statusLabel.Text = "Status: Waiting for input..."
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.BackgroundTransparency = 1
statusLabel.TextSize = 14
statusLabel.Parent = frame

-- Dragging functionality
local dragging = false
local dragStart = nil
local startPos = nil

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Script variables
local targetName = ""  -- Default target account is empty

-- Function to send trade offer to target account
function sendTradeOffer(targetName)
    if targetName == "" then
        statusLabel.Text = "Status: Please enter the target account name!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Red for error
        return
    end
    
    local target = game.Players:FindFirstChild(targetName)
    if target then
        statusLabel.Text = "Status: Sending all items..."
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)  -- Green when sending

        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
            if v:FindFirstChild("offer") then
                -- Equip item (like "GIFT")
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                wait(0.01)  -- Set equip delay to 0.01 seconds

                -- Send trade offer
                local targetCharacter = target.Character
                if targetCharacter and targetCharacter:FindFirstChild("TradeOffer") then
                    fireproximityprompt(targetCharacter.TradeOffer)  -- Send trade offer immediately
                end
            end
        end
    else
        statusLabel.Text = "Status: Target account not found!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Red if target account not found
    end
end

-- Set HoldDuration to 0 for all ProximityPrompts (remove cooldown)
for i, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
    if v.ClassName == "ProximityPrompt" then
        v.HoldDuration = 0  -- Set HoldDuration to 0 to remove delay
    end
end

-- Start trade offer when target account joins the game
game.Players.PlayerAdded:Connect(function(player)
    if player.Name == targetName then
        sendTradeOffer(targetName)  -- Start trade offer immediately when target account joins
    end
end)

-- Button click event - Send All Items
sendButton.MouseButton1Click:Connect(function()
    targetName = targetNameInput.Text  -- Get entered target name
    sendTradeOffer(targetName)  -- Start sending all trade offers
end)