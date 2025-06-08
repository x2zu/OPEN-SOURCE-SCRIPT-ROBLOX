--[[[ hutao hub cracked-ez ez (blox fruit coming soon)
-- d4rkv1br4nt was here.. LOL
--]]

repeat task.wait() until game:IsLoaded()

local TimeStart = tick()


local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()


local cloneref = cloneref or function(o) return o end

local COREGUI = cloneref(game:GetService("CoreGui"))
local Players = cloneref(game:GetService("Players"))
local Workspace = cloneref(game:GetService("Workspace"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local LocalPlayer = cloneref(game.Players.LocalPlayer)
local Player = cloneref(game.Players.LocalPlayer)
local HttpService = cloneref(game:GetService("HttpService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local virtualInput = cloneref(game:GetService("VirtualInputManager"))
local Character = cloneref(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
local Humanoid = cloneref(Character:WaitForChild("Humanoid"))
local HumanoidRootPart = cloneref(Character:WaitForChild("HumanoidRootPart"))
local runService = cloneref(game:GetService("RunService"))

local player = cloneref(game:GetService("Players").LocalPlayer)
local playerGui = cloneref(player:WaitForChild("PlayerGui"))

queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

local Window = Fluent:CreateWindow({
    Title = "Hutao Hub (cracked)",
    SubTitle = "Fisch",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 350),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "box" }),
        Fish = Window:AddTab({ Title = "Fishing", Icon = "waves" }),
        Purchase = Window:AddTab({ Title = "Auto Buy", Icon = "shopping-cart"}),
        Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
        Event = Window:AddTab({ Title = "Event", Icon = "cherry" }),
        Appraise = Window:AddTab({ Title = "NPC" , Icon = "user"}),
        Misc = Window:AddTab({ Title = "Misc", Icon = "aperture" }),
        Server = Window:AddTab({ Title = "Server", Icon = "server" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Window:Minimize()

function SendNotif(title, content, time)
    Fluent:Notify({
            Title = title,
            Content = content,
            Duration = time
    })
    end

local Options = Fluent.Options

do

    function TeleportToPlayer(playerName)
        local targetPlayer = game.Players:FindFirstChild(playerName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
        end
end

function GetOtherPlayers()
        local players = {}
        for _, Player in ipairs(game.Players:GetPlayers()) do
            if Player ~= game.Players.LocalPlayer then
                table.insert(players, Player.Name)
            end
        end
        return players
end

function isButtonActive()
    local shakeui = me.PlayerGui:FindFirstChild("shakeui")
    if shakeui then
        local button = shakeui.safezone:FindFirstChild("button")
        return button ~= nil  
    end
    return false
end


local teleportMethod = "Instant"  -- Set this to either "Instant" or "Tween"
local moveSpeed = 100 -- Default speed for smooth movement
local arrivalThreshold = 1 -- How close to target before stopping
local slowDownDistance = 20 -- Distance within which to slow down

function TeleportPlayer(TargetCFrame)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:FindFirstChild("HumanoidRootPart")

    if rootPart then
        local targetPosition = TargetCFrame.Position

        -- "Instant" teleport method
        if teleportMethod == "Instant" then
            rootPart.CFrame = CFrame.new(targetPosition)
            return
        end

        -- "Tween" (smooth movement) teleport method with conditional damping
        while (rootPart.Position - targetPosition).Magnitude > arrivalThreshold do
            local currentPos = rootPart.Position
            local distance = (targetPosition - currentPos).Magnitude

            -- Adjust speed only when within the slowdown distance
            local adjustedSpeed = distance < slowDownDistance and math.clamp(distance * 0.5, 5, moveSpeed) or moveSpeed

            local direction = (targetPosition - currentPos).Unit
            local newPosition = currentPos + direction * adjustedSpeed * game:GetService("RunService").Heartbeat:Wait()
            rootPart.CFrame = CFrame.new(newPosition)
        end
    end
end

local AutoFreeze = false

local bodyVelocity, bodyGyro
local initialCFrame

function rememberPosition()
    -- Check if AutoFreeze is enabled
    if AutoFreeze then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")
        
        -- Initialize BodyVelocity and BodyGyro only once
        if not bodyVelocity then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVelocity.Parent = rootPart
        end

        if not bodyGyro then
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyGyro.D = 100
            bodyGyro.P = 10000
            bodyGyro.Parent = rootPart
        end

        -- Set initial CFrame if not already set
        if not initialCFrame then
            initialCFrame = rootPart.CFrame
            bodyGyro.CFrame = initialCFrame
        end
        
        -- Lock the player's position
        rootPart.CFrame = initialCFrame
    else
        -- Cleanup when AutoFreeze is disabled
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        if bodyGyro then
            bodyGyro:Destroy()
            bodyGyro = nil
        end
        initialCFrame = nil
    end
end

    --------------------------------------------------------------------------------FISH------------------------------------------------------------------------------------------

        
local discord = "https://discord.com/invite/PXCD5NCY9t"

Tabs.Main:AddParagraph({
        Title = "-----[Universal]-----",
        Content = ""
    })
 
Tabs.Main:AddButton({
            Title = "Infinite Get Money Free",
            Description = "use it before patch",
            Callback = function()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
                game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RE/DailyReward/Claim"):FireServer()
            end
        })
   
Tabs.Main:AddButton({
            Title = "Infinite Yield",
            Description = "Best script for all games",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end
        })
        
           
Tabs.Main:AddButton({
        Title = "Copy Discord Invite (for updates)",
        Callback = function()
            setclipboard(discord)
        end
})
        
Tabs.Main:AddButton({
        Title = "Respawn",
        Callback = function()
            LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
            wait()
        end
})

Tabs.Main:AddButton({
        Title = "Open Console",
        Callback = function()
            game.StarterGui:SetCore("DevConsoleVisible", true)
            wait()
        end
})

Tabs.Main:AddButton({
    Title = "Anti-Lag (Smooth parts)",
    Callback = function()
        local ToDisable = {
    Textures = true,
    VisualEffects = true,
    Parts = true,
    Particles = true,
    Sky = true
}


local ToEnable = {
    FullBright = false
}

local Stuff = {}

for _, v in next, game:GetDescendants() do
    if ToDisable.Parts then
        if v:IsA("Part") or v:IsA("Union") or v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            table.insert(Stuff, 1, v)
        end
    end

    if ToDisable.Particles then
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Explosion") or v:IsA("Sparkles") or v:IsA("Fire") then
            v.Enabled = false
            table.insert(Stuff, 1, v)
        end
    end

    if ToDisable.VisualEffects then
        if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
            v.Enabled = false
            table.insert(Stuff, 1, v)
        end
    end

    if ToDisable.Textures then
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Texture = ""
            table.insert(Stuff, 1, v)
        end
    end

    if ToDisable.Sky then
        if v:IsA("Sky") then
            v.Parent = nil
            table.insert(Stuff, 1, v)
        end
    end
end

game:GetService("TestService"):Message("Effects Disabler Script : Successfully disabled "..#Stuff.." assets / effects. Settings :")

for i, v in next, ToDisable do
    print(tostring(i)..": "..tostring(v))
end

if ToEnable.FullBright then
    local Lighting = game:GetService("Lighting")

    Lighting.FogColor = Color3.fromRGB(255, 255, 255)
    Lighting.FogEnd = math.huge
    Lighting.FogStart = math.huge
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.Brightness = 5
    Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
    Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.Outlines = true
end
    end
})   
--------------------------------------------------------------------------------MAIN------------------------------------------------------------------------------------------

local EventsSection = Tabs.Fish:AddSection("Automatic Menu")

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local GuiService = game:GetService("GuiService")
local virtualInput = game:GetService("VirtualInputManager")
local isAutoClicking = false
local tappingMethod = "UI Nav"  -- Set default to UI Nav for this version

function click_this_gui(to_click)
    -- Check if to_click is valid and visible at the beginning
    if to_click and to_click:IsA("GuiObject") and to_click.Visible then
        if tappingMethod == "Cursor" then
            -- Cursor method (using mouse click positions)
            local inset = GuiService:GetGuiInset()
            local absoluteSize = to_click.AbsoluteSize
            local offset = { x = absoluteSize.X / 2, y = absoluteSize.Y / 2 }

            local x = to_click.AbsolutePosition.X + offset.x
            local y = to_click.AbsolutePosition.Y + offset.y

            virtualInput:SendMouseButtonEvent(x + inset.X, y + inset.Y, 0, true, playerGui, 1)  -- Mouse down
            virtualInput:SendMouseButtonEvent(x + inset.X, y + inset.Y, 0, false, playerGui, 1) -- Mouse up

        elseif tappingMethod == "UI Nav" then
            -- UI Nav method (using SelectedObject and Return key)
            if to_click and to_click:IsA("GuiObject") then
                GuiService.SelectedObject = to_click
            else
                game:GetService("GuiService").SelectedObject = nil
            end
            if GuiService.SelectedObject == to_click and to_click and to_click.Visible then
                virtualInput:SendKeyEvent(true, Enum.KeyCode.Return, false, game)  -- Key down
                virtualInput:SendKeyEvent(false, Enum.KeyCode.Return, false, game) -- Key up
            end
        else
            game:GetService("GuiService").SelectedObject = nil
        end
    else
        -- If to_click is invalid or invisible, do nothing instead of warning
        return
    end
end

function autoClick()
    local shakeUI = playerGui:FindFirstChild("shakeui")
    if not shakeUI then return end

    local button = shakeUI.safezone and shakeUI.safezone:FindFirstChild("button")
    if button and button:IsA("ImageButton") and isAutoClicking then
        click_this_gui(button)
    end
end

-- Set up the Auto Shake toggle
local Toggle = Tabs.Fish:AddToggle("AutoShake", {Title = "Auto Shake", Default = false})
local autoClickCoroutine

Toggle:OnChanged(function(value)
    isAutoClicking = value
    if value then
        autoClickCoroutine = coroutine.create(function()
            while isAutoClicking do
                autoClick()
                if tappingMethod == "Cursor" then
                task.wait(0.000000000000001)  -- Fast click rate
                elseif tappingMethod == "UI Nav" then
                task.wait(0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001)
                end
            end
        end)
        coroutine.resume(autoClickCoroutine)
    else
        isAutoClicking = false
        if autoClickCoroutine then
            autoClickCoroutine = nil  
        end
    end
end)

Options.AutoShake:SetValue(false)

-- Dropdown for selecting tapping method
local Dropdown = Tabs.Fish:AddDropdown("ShakeTap", {
    Title = "Shake tapping method",
    Values = {"UI Nav", "Cursor"},
    Multi = false,
    Default = "UI Nav",
})

Dropdown:OnChanged(function(value)
    tappingMethod = value
end)

-- Define player
local player = game:GetService("Players").LocalPlayer

-- Initial reeling method selection
local reelingmethod = "Safe Reeling"

-- Dropdown for selecting tapping method
local Dropdown = Tabs.Fish:AddDropdown("ReelingMethod", {
    Title = "Reeling Method",
    Values = {"Safe Reeling","Safe Reeling Perfect","Instant Perfect", "Instant not perfect"},
    Multi = false,
    Default = "Safe Reeling",
})

Dropdown:OnChanged(function(value)
    reelingmethod = value
end)

-- Reel GUI Path
local isAutoCatch = false
local Toggle = Tabs.Fish:AddToggle("AutoCatch", {Title = "Auto Reel", Default = false })

Toggle:OnChanged(function(value)
    isAutoCatch = value
end)

Toggle:SetValue(false)

function startCatching()
    local reelBar = player.PlayerGui:FindFirstChild("reel") and player.PlayerGui.reel:FindFirstChild("bar")
    if reelBar and isAutoCatch then
        game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, true)
    end
end

function startCatchingNot() 
    local reelBar = player.PlayerGui:FindFirstChild("reel") and player.PlayerGui.reel:FindFirstChild("bar")
    if reelBar and isAutoCatch then
        game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, false)
    end
end

function syncPositions() 
    local reel = player.PlayerGui:FindFirstChild("reel")
    if not reel then return end 

    local bar = reel:FindFirstChild("bar")
    if not bar then return end

    local fish = bar:FindFirstChild("fish")
    local playerBar = bar:FindFirstChild("playerbar")

    if fish and playerBar and isAutoCatch then
        task.wait(3)
        playerBar.Position = fish.Position 
    end
end

function syncPositionsPerfect() 
    local reel = player.PlayerGui:FindFirstChild("reel")
    if not reel then return end 

    local bar = reel:FindFirstChild("bar")
    if not bar then return end

    local fish = bar:FindFirstChild("fish")
    local playerBar = bar:FindFirstChild("playerbar")

    if fish and playerBar and isAutoCatch then
        playerBar.Position = fish.Position 
    end
end

runService.RenderStepped:Connect(function()
    if isAutoCatch then
        if reelingmethod == "Safe Reeling" then
            syncPositions()
          elseif reelingmethod == "Safe Reeling Perfect" then
               syncPositionsPerfect()
        elseif reelingmethod == "Instant Perfect" then
            startCatching()
        elseif reelingmethod == "Instant not perfect" then
            startCatchingNot()
        end
    end
end)


local isAutoCasting = false

local targetPositionX = 55
local targetPositionY = 208
local stopCasting = false
local castDelay = 1.6  

function isRodEquipped()
    if player.Character then
        return player.Character:FindFirstChildWhichIsA("Tool") and player.Character:FindFirstChildWhichIsA("Tool").Name:lower():find("rod")
    end
    return false
end

function equipRod()
    local backpack = player.Backpack
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and string.find(tool.Name:lower(), "rod", 1, true) then
            if player.Character and not player.Character:FindFirstChild(tool.Name) then
                player.Character.Humanoid:EquipTool(tool)
            end
            return tool
        end
    end
    return nil
end

function simulateCasting()
    virtualInput:SendMouseButtonEvent(targetPositionX, targetPositionY, 0, true, player.PlayerGui, 1) -- Mouse down
    wait(math.random(1, 1.1))
    virtualInput:SendMouseButtonEvent(targetPositionX, targetPositionY, 0, false, player.PlayerGui, 1) -- Mouse up
end

function reelCasting()
    while isAutoCasting do
        if not stopCasting then
            local equippedTool = nil
            if not isRodEquipped() then
                equippedTool = equipRod()
            else
                equippedTool = player.Character:FindFirstChildWhichIsA("Tool")
            end

            if equippedTool then
                simulateCasting()
            end
        end

        wait(castDelay)
    end
end

function monitorUIChanges()
    local gui = player.PlayerGui

    gui.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "playerbar" or descendant.Name == "reel" or descendant.Name == "shakeui" then
            stopCasting = true
        end
    end)

    gui.DescendantRemoving:Connect(function(descendant)
        if descendant.Name == "playerbar" or descendant.Name == "reel" or descendant.Name == "shakeui" then
            stopCasting = false
        end
    end)
end

local Toggle = Tabs.Fish:AddToggle("AutoCast", {Title = "Auto Rod Casting", Default = false})

Toggle:OnChanged(function(value)
    isAutoCasting = value
    AutoFreeze = value
    if value then
        monitorUIChanges()  
        coroutine.wrap(reelCasting)() 
    end
end)

Options.AutoCast:SetValue(false)


runService.RenderStepped:Connect(rememberPosition)

local isAutoShake = false

local Toggle = Tabs.Fish:AddToggle("CenterShake", {Title = "Always Center Shake", Default = false})

Toggle:OnChanged(function(value)
    isAutoShake = value
end)

Options.CenterShake:SetValue(false)

-- Function to center and resize the button
function centerButton(button)
    if isAutoShake and button:IsA("ImageButton") then
        button.AnchorPoint = Vector2.new(0.5, 0.5)
        button.Position = UDim2.new(0.5, 0, 0.5, 0)
        button.Size = UDim2.new(0, 100, 0, 100)
    end
end

-- Set up listener for when 'shakeui' is added
playerGui.ChildAdded:Connect(function(child)
    if child.Name == "shakeui" then
        local safezone = child:WaitForChild("safezone", 5)  -- Optional timeout for safety
        if safezone then
            -- Listen for 'button' being added inside 'safezone'
            safezone.ChildAdded:Connect(function(newChild)
                if newChild.Name == "button" then
                    centerButton(newChild)
                end
            end)
        end
    end
end)

-- Check if 'shakeui' and 'button' already exist on script load
local shakeUI = playerGui:FindFirstChild("shakeui")
if shakeUI then
    local button = shakeUI:FindFirstChild("safezone") and shakeUI.safezone:FindFirstChild("button")
    if button then
        centerButton(button)
    end
end

local WaterZoneNames = {}


-- Dropdown for selecting WaterZone
local Dropdown = Tabs.Fish:AddDropdown("WaterZone", {
    Title = "Select location to Fish",
    Values = WaterZoneNames,
    Multi = false,
    Default = "",
})

local selectedZone = nil
Dropdown:OnChanged(function(value)
    selectedZone = workspace.zones.fishing:FindFirstChild(value)
end)


function refreshWaterZoneNames()
    WaterZoneNames = {}

    local uniqueZones = {}
    for _, zone in ipairs(workspace.zones.fishing:GetChildren()) do
        if not uniqueZones[zone.Name] then
            table.insert(WaterZoneNames, zone.Name)
            uniqueZones[zone.Name] = true
        end
    end

    Dropdown:SetValues(WaterZoneNames)
end

refreshWaterZoneNames()

workspace.zones.fishing.ChildAdded:Connect(refreshWaterZoneNames)
workspace.zones.fishing.ChildRemoved:Connect(refreshWaterZoneNames)

local Toggle = Tabs.Fish:AddToggle("ZoneFishing", {Title = "Enable long distance fishing[Patched]", Default = false})

local renderSteppedConnection

Toggle:OnChanged(function(value)
    ZoneCasting = value
    if value then
        renderSteppedConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local playerTool = player.Character and player.Character:FindFirstChildWhichIsA("Tool")
            if playerTool then
                local bobber = playerTool:FindFirstChild("bobber")
                if bobber then
                    local ropeConstraint = bobber:FindFirstChild("RopeConstraint")
                    if ropeConstraint then
                        ropeConstraint.Length = 999999999999
                        wait(0.5)
                        if selectedZone then
                            local centerPosition = selectedZone.Position
                            bobber.Position = centerPosition + Vector3.new(0, 0, -20)
                            wait(1)
                            ropeConstraint.Enabled = false
                        end
                    end
                end
            end
        end)
    else
        if renderSteppedConnection then
            renderSteppedConnection:Disconnect()
            renderSteppedConnection = nil
        end
    end
end)


Options.ZoneFishing:SetValue(false)

Tabs.Fish:AddButton({
    Title = "Teleport to Safe Zone Fishing",
    Description = "Use this if you don't want to get caught long distance fishing lol",
    Callback = function()
        local newPart = Instance.new("Part")
        newPart.Size = Vector3.new(10, 1, 10) 
        newPart.Position = Vector3.new(-657, 1224, -50)
        newPart.Anchored = true 
        
        newPart.BrickColor = BrickColor.new("Dark purple")
        
        newPart.Parent = workspace
        
        local player = game.Players.LocalPlayer 
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local teleportPosition = newPart.Position + Vector3.new(0, newPart.Size.Y / 2, 0)
            player.Character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
        end
    end
})
   
local EventsSection = Tabs.Fish:AddSection("Rod Menu")

local player = game:GetService("Players").LocalPlayer
local playerGui = player.PlayerGui
local rodsContainer = playerGui.hud.safezone.equipment.rods.scroll.safezone
local virtualInput = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")

local Dropdown = Tabs.Fish:AddDropdown("equipRod", {
    Title = "Equip Rod",
    Values = {},
    Multi = false,
    Default = "",
})

local rodNames = {}
for _, frame in pairs(rodsContainer:GetChildren()) do
    if frame:IsA("Frame") and frame.Name:find("Rod") then
        table.insert(rodNames, frame.Name)
    end
end

Dropdown:SetValues(rodNames)


Tabs.Fish:AddButton({
    Title = "Equip selected Rod",
    Description = "Equipping the selected Rod in the Equip Rod dropdown",
    Callback = function()
        local selectedRodName = Dropdown.Value
        local equipmentBag = player.Backpack:FindFirstChild("Equipment") or player.Backpack:FindFirstChild("Equipment Bag")

        if not selectedRodName or not rodsContainer:FindFirstChild(selectedRodName) then
            return
        end

        if not equipmentBag then
            return
        end

        local wasAutoCastEnabled = Options.AutoCast.Value
        if wasAutoCastEnabled then
            Options.AutoCast:SetValue(false)
        end

        player.Character.Humanoid:EquipTool(equipmentBag)

        local equipRodButton = rodsContainer[selectedRodName]:FindFirstChild("equip")
        if not equipRodButton or not equipRodButton:IsA("TextButton") then
            
            return
        end
        wait(1)  
        GuiService.SelectedObject = equipRodButton

        if GuiService.SelectedObject == equipRodButton then
            virtualInput:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            virtualInput:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            player.Character.Humanoid:UnequipTools()
            task.wait(0.5)
           GuiService.SelectedObject = nil
            wait(1)  

            local rodTool = player.Backpack:FindFirstChildWhichIsA("Tool")
            if rodTool and rodTool.Name:find("Rod") then
                player.Character.Humanoid:EquipTool(rodTool)
            else
                
            end
        else
            
        end
          
        if wasAutoCastEnabled then
            Options.AutoCast:SetValue(true)
        end

    end
})

-- Initialize the dropdown and variables
local SelectedBait = nil
local EquipRandomBait = false

local dropdown = Tabs.Fish:AddDropdown("SelectBaitEquip", {
    Title = "Select Bait to Equip",
    Values = {},  -- We'll populate this dynamically
    Multi = false,
    Default = "",
})

-- Set the SelectedBait variable when dropdown value changes
dropdown:OnChanged(function(value)
    SelectedBait = value
end)

-- Initialize the Toggle for Auto Equip Random Bait
local Toggle = Tabs.Fish:AddToggle("AutoEquipBait", {
    Title = "Equip Random Bait",
    Default = false,
})

Toggle:OnChanged(function(value)
    EquipRandomBait = value
end)

-- Populate the dropdown with available baits
function populateBaits()
    local baitFrame = game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.equipment.bait.scroll.safezone
    local baitNames = {}

    -- Loop through the bait frames and get their names
    for _, bait in pairs(baitFrame:GetChildren()) do
        if bait:IsA("Frame") then
            table.insert(baitNames, bait.Name)  -- Assuming the bait name is stored as the frame name
        end
    end

    -- Update the dropdown values
    dropdown:SetValues(baitNames)
end

-- Function to select a random bait from the list
function selectRandomBait()
    local baitFrame = game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.equipment.bait.scroll.safezone
    local baitNames = {}

    -- Get all available baits
    for _, bait in pairs(baitFrame:GetChildren()) do
        if bait:IsA("Frame") then
            table.insert(baitNames, bait.Name)
        end
    end

    -- Pick a random bait if available
    if #baitNames > 0 then
        local randomBait = baitNames[math.random(1, #baitNames)]
        return randomBait
    else
        return nil
    end
end

-- Monitor the selected bait and equip random bait if it disappears
game:GetService("RunService").RenderStepped:Connect(function()
    if EquipRandomBait then
        if SelectedBait and not game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.equipment.bait.scroll.safezone:FindFirstChild(SelectedBait) then
            -- If the selected bait is not found, equip a random bait
            local randomBait = selectRandomBait()
            if randomBait then
                SelectedBait = randomBait
                -- Fire the server with the random bait
                local args = { [1] = SelectedBait }
                game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.equipment.bait.scroll.safezone.e:FireServer(unpack(args))
                print("Equipped random bait: " .. SelectedBait)
            end
        end
    end
end)

-- Call the function to populate the baits when the UI is loaded or at the start
populateBaits()

-- Add the button to equip the selected bait
Tabs.Fish:AddButton({
    Title = "Equip selected bait",
    Description = "Equipping the selected bait from dropdown",
    Callback = function()
        if SelectedBait and SelectedBait ~= "" then
            -- Fire the server with the selected bait name
            local args = { [1] = SelectedBait }
            game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.equipment.bait.scroll.safezone.e:FireServer(unpack(args))
        else
            print("Please select a bait.")
        end
    end
})




local CrabRelated = Tabs.Fish:AddSection("Crab")

local Toggle = Tabs.Fish:AddToggle("AutoPlace", {Title = "Auto Place Crab Cage", Default = false})

function equipCrabCage()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local backpack = player.Backpack
    local crabCage = character:FindFirstChild("Crab Cage") or backpack:FindFirstChild("Crab Cage")

    if crabCage and crabCage.Parent == backpack then
        crabCage.Parent = character
    end

    return character:FindFirstChild("Crab Cage")
end

local autoPlaceConnection

Toggle:OnChanged(function(value)
    if value then
        autoPlaceConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local crabCage = equipCrabCage()
            if crabCage and crabCage:FindFirstChild("Deploy") then
                crabCage.Deploy:FireServer() 
            else
                SendNotif("Auto Place Crab Cage", "No more crab cage available turning off toggle", 4)
                Options.AutoPlace:SetValue(false) 
            end
        end)
    else
        if autoPlaceConnection then
            autoPlaceConnection:Disconnect()
            autoPlaceConnection = nil
        end
    end
end)


local Toggle = Tabs.Fish:AddToggle("CollectCrab", {Title = "Auto Collect Crab Cage", Default = false})

local connection

Toggle:OnChanged(function(value)
    if value then
        local plr = game.Players.LocalPlayer

            while value do
               for i, v in pairs(workspace.active:GetChildren()) do
                   if v.Name == plr.Name then
                        fireproximityprompt(v.Prompt)
                        task.wait()
                   end
               end
              task.wait(1)
           end

        connection = game:GetService("RunService").RenderStepped:Connect(function()
            local player = game.Players.LocalPlayer
            local cageObject = workspace.active:FindFirstChild(player.Name)
            
            if cageObject then
                local cage = cageObject:FindFirstChild("Cage")
                local prompt = cageObject:FindFirstChild("Prompt")
                local innerCage = cage and cage:FindFirstChild("cage")
                
                if cage and prompt and innerCage and prompt.Enabled then
                    local character = player.Character
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    
                    if rootPart then
                        rootPart.CFrame = innerCage.CFrame
                    end
                end
            end
        end)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)

Options.CollectCrab:SetValue(false)


    
    --------------------------------------------------------------------------------FISH------------------------------------------------------------------------------------------


     --------------------------------------------------------------------------------AUTOBUY------------------------------------------------------------------------------------------

     Tabs.Purchase:AddParagraph({
        Title = "IMPORTANT: PLEASE READ BEFORE USE",
        Content = "Auto Buying only works if you're near at the Product or Seller use Teleport also this doesnt auto stop your buying process unless because of Limiter walking away or untoggle to stop auto buying",
        })

local BuyBaitCrates = 0
Tabs.Purchase:AddInput("BaitCrateShopping", {
    Title = "How many bait crates to purchase",
    Default = BuyBaitCrates, 
    Placeholder = "Input number",
    Numeric = true, 
    Finished = true, 
    Callback = function(Value)
        BuyBaitCrates = tonumber(Value) or 0
    end
})

local Toggle = Tabs.Purchase:AddToggle("AutoBuyBait", {Title = "Auto Buy Bait Crate", Default = false})
local autoBuyConnection

local BaitCratePrice = 120

-- Function to get current coins from the text "2,866,032 C$"
function getCurrentCoins()
    local coinsText = game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.coins.Text
    local coinsAmount = tonumber(coinsText:gsub(",", ""):match("(%d+)")) or 0
    return coinsAmount
end

-- Function to check the number of Bait Crates in inventory
function getCurrentBaitCratesInInventory()
    local inventory = game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.backpack.inventory.scroll.safezone
    local baitCrate = inventory:FindFirstChild("Bait Crate")
    if baitCrate and baitCrate.stack then
        -- Extract number from "132 x" format, assuming the number is before ' x'
        local currentStack = tonumber(baitCrate.stack.Text:match("^(%d+)"))
        return currentStack or 0
    end
    return 0
end

Toggle:OnChanged(function(value)
    if value then
        local initialStack = getCurrentBaitCratesInInventory()
        local targetStack = initialStack + BuyBaitCrates

        autoBuyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local currentCoins = getCurrentCoins()

            -- Check if player has enough coins to buy Bait Crate
            if currentCoins < BaitCratePrice then
                -- Not enough coins, stop the purchase and toggle
                Options.AutoBuyBait:SetValue(false)
                return
            end

            local currentBaitCratesInInventory = getCurrentBaitCratesInInventory()

            -- Stop the loop if the target stack is reached
            if currentBaitCratesInInventory >= targetStack then
                Options.AutoBuyBait:SetValue(false)
                return
            end

            -- Attempt to buy more Bait Crates
            local firstBaitCrate = workspace.world.interactables["Bait Crate"]
            local baitCratePrompt = nil
            
            for _, child in pairs(firstBaitCrate:GetChildren()) do
                if child:IsA("Model") and child:FindFirstChild("purchaserompt") then
                    baitCratePrompt = child.purchaserompt
                    break  
                end
            end
            
            if baitCratePrompt then
                fireproximityprompt(baitCratePrompt, 1, true)
                
                local baitPurchaseButton = game:GetService("Players").LocalPlayer.PlayerGui.over.prompt:FindFirstChild("confirm")
                if baitPurchaseButton then
                    firesignal(baitPurchaseButton.MouseButton1Click, game.Players.LocalPlayer)
                end
            end
        end)
    else
        if autoBuyConnection then
            autoBuyConnection:Disconnect()
            autoBuyConnection = nil
        end
    end
end)

     Tabs.Purchase:AddButton({
        Title = "Teleport to Bait seller",
        Description = "",
        Callback = function()
            TeleportPlayer(CFrame.new(386, 137, 332))
        end
    })



local Buycrabcages = 0
Tabs.Purchase:AddInput("CageShopping", {
    Title = "How many crab cages to purchase",
    Default = Buycrabcages, 
    Placeholder = "Input number",
    Numeric = true, 
    Finished = true, 
    Callback = function(Value)
        Buycrabcages = tonumber(Value) or 0
    end
})

local Toggle = Tabs.Purchase:AddToggle("AutoBuyCrab", {Title = "Auto Buy Crab Cage", Default = false})
local autoBuyConnection

function getCurrentStack()
    -- Get the current stack count from the 'stack' text and extract the number
    local stackText = game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.backpack.inventory.scroll.safezone["Crab Cage"].stack.Text
    local stackCount = tonumber(stackText:match("(%d+)")) or 0 -- Extract the number before " x"
    return stackCount
end

Toggle:OnChanged(function(value)
    if value then
        -- Get the initial stack count and calculate the target stack count
        local initialStack = getCurrentStack()
        local targetStack = initialStack + Buycrabcages

        autoBuyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local currentStack = getCurrentStack()
            
            -- Stop the loop and toggle if the current stack reaches or exceeds the target
            if currentStack >= targetStack then
                Options.AutoBuyCrab:SetValue(false) -- Stop the toggle using the provided method
                return
            end
            
            local firstCrabCage = workspace.world.interactables["Crab Cage"]
            local crabCagePrompt = nil
            
            for _, child in pairs(firstCrabCage:GetChildren()) do
                if child:IsA("Model") and child:FindFirstChild("purchaserompt") then
                    crabCagePrompt = child.purchaserompt
                    break  
                end
            end
            
            if crabCagePrompt then
                fireproximityprompt(crabCagePrompt, 1, true)
                local crabPurchaseButton = game:GetService("Players").LocalPlayer.PlayerGui.over.prompt:FindFirstChild("confirm")
                if crabPurchaseButton then
                    firesignal(crabPurchaseButton.MouseButton1Click, game.Players.LocalPlayer)
                end
            end
        end)
    else
        if autoBuyConnection then
            autoBuyConnection:Disconnect()
            autoBuyConnection = nil
        end
    end
end)

Options.AutoBuyCrab:SetValue(false)
Tabs.Purchase:AddButton({
    Title = "Teleport to Crab Cage seller",
    Description = "",
    Callback = function()
        local player = game.Players.LocalPlayer
        local cageObject = workspace.active:FindFirstChild(player.Name)

        local cagePosition 

        if cageObject then
            local cage = cageObject:FindFirstChild("Cage")
            local innerCage = cage and cage:FindFirstChild("cage")

            if innerCage then
                cagePosition = innerCage.Position 
            end
        end
        if not cagePosition then
            cagePosition = Vector3.new(474, 151, 234) 
        end

        TeleportPlayer(CFrame.new(cagePosition))
    end
})

local BuyCoralGeodes = 0
Tabs.Purchase:AddInput("CoralGeodeShopping", {
    Title = "How many Coral Geodes to purchase",
    Default = BuyCoralGeodes, 
    Placeholder = "Input number",
    Numeric = true, 
    Finished = true, 
    Callback = function(Value)
        BuyCoralGeodes = tonumber(Value) or 0
    end
})

local Toggle = Tabs.Purchase:AddToggle("AutoBuyCoralGeode", {Title = "Auto Buy Coral Geode", Default = false})
local autoBuyConnection

local CoralGeodePrice = 600  -- Price per Coral Geode

-- Function to get current coins
function getCurrentCoins()
    local coinsText = game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.coins.Text
    local coinsAmount = tonumber(coinsText:gsub(",", ""):match("(%d+)")) or 0
    return coinsAmount
end

-- Function to get current Coral Geode count in inventory
function getCurrentCoralGeodesInInventory()
    local inventory = game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.backpack.inventory.scroll.safezone
    local coralGeode = inventory:FindFirstChild("Coral Geode")
    if coralGeode and coralGeode.stack then
        local currentStack = tonumber(coralGeode.stack.Text:match("^(%d+)"))
        return currentStack or 0
    end
    return 0
end

Toggle:OnChanged(function(value)
    if value then
        -- Determine the target stack based on the input amount and current stack in inventory
        local initialStack = getCurrentCoralGeodesInInventory()
        local targetStack = initialStack + BuyCoralGeodes

        autoBuyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local currentCoins = getCurrentCoins()
            local currentStack = getCurrentCoralGeodesInInventory()

            -- Stop buying if current stack reaches or exceeds target
            if currentStack >= targetStack then
                Options.AutoBuyCoralGeode:SetValue(false)
                return
            end

            -- Stop if player doesn’t have enough coins to buy Coral Geode
            if currentCoins < CoralGeodePrice then
                Options.AutoBuyCoralGeode:SetValue(false)
                return
            end

            -- Purchase Coral Geode if prompt exists
            local coralGeodePrompt = workspace.world.interactables["Coral Geode"]:FindFirstChild("purchaserompt")
            if coralGeodePrompt then
                fireproximityprompt(coralGeodePrompt, 1, true)
                
                local coralGeodePurchaseButton = game:GetService("Players").LocalPlayer.PlayerGui.over.prompt:FindFirstChild("confirm")
                if coralGeodePurchaseButton then
                    firesignal(coralGeodePurchaseButton.MouseButton1Click, game.Players.LocalPlayer)
                end
            end
        end)
    else
        if autoBuyConnection then
            autoBuyConnection:Disconnect()
            autoBuyConnection = nil
        end
    end
end)

Options.AutoBuyCoralGeode:SetValue(false)

Tabs.Purchase:AddButton({
    Title = "Teleport to Coral Geode seller",
    Description = "",
    Callback = function()
        TeleportPlayer(CFrame.new(-1646, -214, -2850))
    end
})

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local currentCFrame = character:WaitForChild("HumanoidRootPart").CFrame

local EventsSection = Tabs.Purchase:AddSection("Skin Crate Menu")
    
Tabs.Purchase:AddButton({
    Title = "Buy Moosewood Skin Crate",
    Description = "",
    Callback = function()
        local args = {
    [1] = "Moosewood"
}

game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RF/SkinCrates/Purchase"):InvokeServer(unpack(args))
    end
})

Tabs.Purchase:AddButton({
    Title = "Buy Desolate Skin Crate",
    Description = "",
    Callback = function()
        local args = {
    [1] = "Desolate"
}

game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RF/SkinCrates/Purchase"):InvokeServer(unpack(args))
    end
})

Tabs.Purchase:AddButton({
    Title = "Buy Ancient Skin Crate",
    Description = "",
    Callback = function()
        local args = {
    [1] = "Ancient"
}

game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RF/SkinCrates/Purchase"):InvokeServer(unpack(args))
    end
})

Tabs.Purchase:AddButton({
    Title = "Spin Crate",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").packages.Net:FindFirstChild("RF/SkinCrates/RequestSpin"):InvokeServer()
    end
})      
        
        
        
      --------------------------------------------------------------------------------AUTOBUY------------------------------------------------------------------------------------------

      --------------------------------------------------------------------------------APPRAISE------------------------------------------------------------------------------------------

      --------------------------------------------------------------------------------APPRAISE------------------------------------------------------------------------------------------
    







--------------------------------------------------------------------------------TELEPORT------------------------------------------------------------------------------------------
local space = Tabs.Teleport:AddSection("Custom fishing position")

local savedCFrame = nil
local savedWithPart = false
local saveFileName = "HutaoHub/Fisch/lastPosition.txt"
local spawnedPart = nil

if not isfolder("HutaoHub/Fisch") then
    makefolder("HutaoHub/Fisch")
end

function writePositionToFile(position, withPart)
    if position then
        local rotX, rotY, rotZ = position:ToOrientation()
        local data = {
            X = position.Position.X,
            Y = position.Position.Y,
            Z = position.Position.Z,
            RotX = rotX,
            RotY = rotY,
            RotZ = rotZ,
            WithPart = withPart
        }
        writefile(saveFileName, game.HttpService:JSONEncode(data))
        SendNotif("Teleport Notify", "Position saved successfully.", 2)
    end
end

function readPositionFromFile()
    if isfile(saveFileName) then
        local data = game.HttpService:JSONDecode(readfile(saveFileName))
        return CFrame.new(data.X, data.Y, data.Z) * CFrame.Angles(data.RotX, data.RotY, data.RotZ), data.WithPart
    else
        SendNotif("Teleport Notify", "No saved position file found.", 2)
        return nil, false
    end
end

-- Button to save position with part
Tabs.Teleport:AddButton({
    Title = "Save Position with Part",
    Description = "Saves the player's position and spawns a 10x1x10 part",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        if not spawnedPart then
            spawnedPart = Instance.new("Part")
            spawnedPart.Size = Vector3.new(10, 1, 10)
            spawnedPart.Anchored = true
            spawnedPart.Parent = workspace
        end
        spawnedPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, -character.HumanoidRootPart.Size.Y / 2 - 0.5, 0)
        savedCFrame = spawnedPart.CFrame
        savedWithPart = true
        writePositionToFile(savedCFrame, savedWithPart)
    end
})

-- Button to save position without part
Tabs.Teleport:AddButton({
    Title = "Save Position without Part",
    Description = "Saves the player's position without spawning a part",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        savedCFrame = character.HumanoidRootPart.CFrame
        savedWithPart = false
        writePositionToFile(savedCFrame, savedWithPart)
    end
})

-- Button to teleport to the last saved position
Tabs.Teleport:AddButton({
    Title = "Teleport to Last Saved Position",
    Description = "Teleports the player to the last saved position",
    Callback = function()
        local loadedCFrame, loadedWithPart = readPositionFromFile()

        if loadedCFrame then
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()

            if loadedWithPart then
                if not spawnedPart then
                    spawnedPart = Instance.new("Part")
                    spawnedPart.Size = Vector3.new(10, 1, 10)
                    spawnedPart.Anchored = true
                    spawnedPart.Parent = workspace
                end
                spawnedPart.CFrame = loadedCFrame
            else
                if spawnedPart then
                    spawnedPart:Destroy()
                    spawnedPart = nil
                end
            end

            -- Use the loaded CFrame directly for teleporting
            TeleportPlayer(loadedCFrame)

            SendNotif("Teleport Notify", "Teleported to the last saved position", 2)
        else
            SendNotif("Teleport Notify", "No saved position found.", 2)
        end
    end
})

local Locations = {
    ["Brinepool"] = CFrame.new(-1794, -143, -3315),
    ["Desolate Deep"] = CFrame.new(-1659, -214, -2847),
    ["Desolate Pocket"] = CFrame.new(-1500, -235, -2856),
    ["Keepers Altar"] = CFrame.new(1297, -805, -298),
    ["MooseWood"] = CFrame.new(384, 134, 232),
    ["Mushgrove Swamp"] = CFrame.new(2438, 132, -689),
    ["Deep Ocean"] = CFrame.new(-4665, 135, 1758),
    ["Roslit"] = CFrame.new(-1482, 138, 738),
    ["Roslit Volcano"] = CFrame.new(-1907, 165, 316),
    ["Snowcap"] = CFrame.new(2618, 146, 2402),
    ["Sunstone"] = CFrame.new(-918, 135, -1123),
    ["Terrapin"] = CFrame.new(-189, 143, 1926),
    ["Vertigo"] = CFrame.new(-117, -515, 1138),
    ["Statue of Sovereignty"] = CFrame.new(26, 159, -1037),
    ["Forsaken Shores"] = CFrame.new(-2655, 183, 1671),
    ["The Depths"] = CFrame.new(502, -707, 1234),
    ["Anchient Isle"] = CFrame.new(6056, 196, 283),
    ["Grand Reef"] = CFrame.new(-3596, 154, 522)
}

local subLocations = {
    ["Desolate Shop"] = CFrame.new(-994, -245, -2723),
    ["Enchant Altar"] = CFrame.new(1312, -802, -87),
    ["Gamma"] = CFrame.new(2231, -792, 1012),
    ["Anchient Temple"] = CFrame.new(-3155, -755, 2202),
    ["Rod Crafting"] = CFrame.new(-3162, -746, 1685),
    ["Vertigo Gate"] = CFrame.new(16, -706, 1225),
    ["Input Abyssal Relic"] = CFrame.new(1206, -715, 1315),
    ["Input Hexed Relic"] = CFrame.new(1050, -631, 1318),
    ["Input Relic in New Rod"] = CFrame.new(2730, 130, -825)
}

local NPCLocations = {
    ["Appraiser"] = CFrame.new(444, 151, 210),
    ["Witch (Event Pot)"] = CFrame.new(405, 135, 317),
    ["Merchant"] = CFrame.new(467, 151, 231),
    ["Merlin (Relic Seller)"] = CFrame.new(-932, 224, -988),
    ["Lantern Guy"] = CFrame.new(-39, -247, 199),
    ["Jack Marrow"] = CFrame.new(-2825, 214, 1516)
}

local RodLocation = {
    ["Trident Rod(150k)"] = CFrame.new(-1484, -226, -2202),
    ["Kings Rod(120k)"] = CFrame.new(1379, -807, -302),
    ["Magma Rod(need pufferfish)"] = CFrame.new(-1847, 166, 161),
    ["Destiny Rod(190k)"] = CFrame.new(988, 131, -1238),
    ["Nocturnal Rod(11k)"] = CFrame.new(-144, -515, 1142),
    ["Reinforced Rod(20k)"] = CFrame.new(-991, -244, -2693),
    ["Magnet Rod(15k)"] = CFrame.new(-197, 133, 1932),
    ["Carbon Rod(2k)"] = CFrame.new(450, 151, 224),
    ["Steady Rod(7k)"] = CFrame.new(-1511, 142, 762),
    ["Scurvy Rod(50k)"] = CFrame.new(-141, -512, 1145),
    ["Aurora Rod(90k+500k)"] = CFrame.new(-141, -512, 1145),
    ["Rod Of The Depths(750k)"] = CFrame.new(1703, -903, 1443),
    ["Stone Rod(3K)"] = CFrame.new(5498, 144, -317),
    ["Phoenix Rod(40K)"] = CFrame.new(5965, 270, 847),
    ["Arctic Rod(25K)"] = CFrame.new(19580, 133, 5303),
    ["Summit Rod(300K)"] = CFrame.new(20211, 737, 5708),
    ["Avalanche Rod(35K)"] = CFrame.new(19769, 414, 5415),
    ["Heavenly Rod(1,75M)"] = CFrame.new(20025, -466, 7114)
}

local TotemLocation = {
    ["Sundial (Day/Night)"] = CFrame.new(-1147, 135, -1074),
    ["Smokescreen (Fog)"] = CFrame.new(2793, 140, -629),
    ["Windset (Windy)"] = CFrame.new(2852, 180, 2703),
    ["Aurora Totem(Luck)"] = CFrame.new(-1811, -137, -3282),
    ["Tempest (Rainy)"] = CFrame.new(36, 135, 1946),
    ["Meteor Totem(75k)"] =CFrame.new(-1948, 274, 228),
    ["Avalanche Totem(150K)"] = CFrame.new(19709, 469, 6057)
}

local CastLocation = {
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
    ["Anchient Pond"] = CFrame.new(6039, 197, 338),
    ["Anchient WaterFall"] = CFrame.new(5808, 136, 408),
    ["Northern Cave"] = CFrame.new(19841, 439, 5613),
    ["Northern Canal"] = CFrame.new(20295, 272, 5516),
    ["Grand Reef Ocean"] = CFrame.new(-3589, 132, 572)
}

local MountainLocation = {
    ["Top of the Mountain"] = CFrame.new(20006, 1137, 5533),
    ["Blue Energy Crystal"] = CFrame.new(20215, 211, 5447),
    ["Green Energy Crystal"] = CFrame.new(19873, 448, 5556),
    ["Yellow Energy Crystal"] = CFrame.new(19498, 335, 5551),
    ["Moosewood Button"] = CFrame.new(400, 135, 265),
    ["Anchient Isle Button"] = CFrame.new(5506, 147, -315),
    ["Snowcap Button"] = CFrame.new(2930, 281, 2594),
    ["Roslitbay Button"] = CFrame.new(-1715, 149, 737),
    ["Forsaken Button"] = CFrame.new(-2566, 181, 1353)
}

local LeversLocation = {
    ["Entrance"] = CFrame.new(19870, 629, 5375),
    ["Lever 1"] = CFrame.new(19854, 476, 4970),
    ["Lever 2"] = CFrame.new(19880, 425, 5380),
    ["Lever 3"] = CFrame.new(19600, 544, 5613),
    ["Lever 4"] = CFrame.new(19436, 690, 5856),
    ["Lever 5"] = CFrame.new(20194, 854, 5645),
    ["Lever 6"] = CFrame.new(19965, 587, 5573),
}

local LeversLocationNames = {}
for name in pairs(LeversLocation) do
    table.insert(LeversLocationNames, name)
end

local MountainLocationNames = {}
for name in pairs(MountainLocation) do
    table.insert(MountainLocationNames, name)
end

local CastLocationNames = {}
for name in pairs(CastLocation) do
    table.insert(CastLocationNames, name)
end

local TotemLocationNames = {}
for name in pairs(TotemLocation) do
    table.insert(TotemLocationNames, name)
end

local RodLocationNames = {}
for name in pairs(RodLocation) do
    table.insert(RodLocationNames, name)
end


local RodLocationNames = {}
for name in pairs(RodLocation) do
    table.insert(RodLocationNames, name)
end


local subLocationsNames = {}
for name in pairs(subLocations) do
    table.insert(subLocationsNames, name)
end

local LocationNames = {}
for name in pairs(Locations) do
    table.insert(LocationNames, name)
end

local space = Tabs.Teleport:AddSection("TP Settings")

local TeleportMethodDD = Tabs.Teleport:AddDropdown("TPMethod", {
    Title = "Teleport Method",
    Values = {"Tween", "Instant"},
    Multi = false,
    Default = teleportMethod,
})

TeleportMethodDD:OnChanged(function(value)
    teleportMethod = value
end)

local Slider = Tabs.Teleport:AddSlider("TweenSpeed", {
    Title = "Change Tween Speed",
    Description = "Change tween teleporting speed",
    Default = moveSpeed,
    Min = 10,
    Max = 1000,
    Rounding = 1,
    Callback = function(Value)
        moveSpeed = Value
    end
})

Slider:SetValue(moveSpeed)

local space = Tabs.Teleport:AddSection("Locations")

local Dropdown = Tabs.Teleport:AddDropdown("TPLocation", {
    Title = "Teleport to Location",
    Values = LocationNames,
    Multi = false,
    Default = "Select Location",
})

Tabs.Teleport:AddButton({
    Title = "Teleport to selected location",
    Description = "",
    Callback = function()
    local selectedLocation = Dropdown.Value
    local PositionLoc = Locations[selectedLocation]
    if PositionLoc then
        TeleportPlayer(PositionLoc) 
    else 
  end
        if selectedLocation == "Deep Ocean" and not spawnedPart then 
            local part = Instance.new("Part")
            part.Size = Vector3.new(10, 1, 10) 
            part.Position = Vector3.new(-4665, 131, 1758) 
            part.Anchored = true 
            part.Parent = workspace 
    
            spawnedPart = true 
            TeleportPlayer(Locations[Value])
        else
        end
            end
        })
      
      local space = Tabs.Teleport:AddSection("")

local SubLocationsDD = Tabs.Teleport:AddDropdown("TPSubLocation", {
    Title = "Teleport to Sub-location",
    Values = subLocationsNames,
    Multi = false,
    Default = "Select Sub Location",
})

Tabs.Teleport:AddButton({
    Title = "Teleport to selected Sub-location",
    Description = "",
    Callback = function()
    local selectedSub = SubLocationsDD.Value
    local Position = subLocations[selectedSub]
    if Position then
        TeleportPlayer(Position) 
    else

    end
    end
 })
        
     local space = Tabs.Teleport:AddSection("")


    local spawnedPart = false
Dropdown:OnChanged(function(Value)
 
    end)
    


local NPCNames = {}
for name in pairs(NPCLocations) do
    table.insert(NPCNames, name)
end



local NPCDrop = Tabs.Teleport:AddDropdown("TPLocation", {
    Title = "Teleport to NPC",
    Values = NPCNames,
    Multi = false,
    Default = "Select NPC",
})


Tabs.Teleport:AddButton({
    Title = "Teleport to selected NPC",
    Description = "",
    Callback = function()
    local selectedNPC = NPCDrop.Value
    local Position = NPCLocations[selectedNPC]
    if Position then
        TeleportPlayer(Position) 
    else

    end
    end
 })

 local space = Tabs.Teleport:AddSection("")

 local RodDD = Tabs.Teleport:AddDropdown("TPRods", {
    Title = "Teleport to Rod Location",
    Values = RodLocationNames,
    Multi = false,
    Default = "Select Rod",
})

Tabs.Teleport:AddButton({
    Title = "Teleport to selected Rod Location",
    Description = "",
    Callback = function()
    local selectedLocation = RodDD.Value
    local RodLoc = RodLocation[selectedLocation]
    if RodLoc then
        TeleportPlayer(RodLoc) 
    else 

    end
            end
        })
        
        local space = Tabs.Teleport:AddSection("")
        
      local TotemDD = Tabs.Teleport:AddDropdown("TPTotem", {
    Title = "Teleport to Totem Location",
    Values = TotemLocationNames,
    Multi = false,
    Default = "Select Totem",
})



Tabs.Teleport:AddButton({
    Title = "Teleport to selected Totem Location",
    Description = "",
    Callback = function()
    local selectedLocation = TotemDD.Value
    local TotemLoc = TotemLocation[selectedLocation]
    if TotemLoc then
        TeleportPlayer(TotemLoc) 
    else 

    end
            end
        })

local space = Tabs.Teleport:AddSection("")
        
      local CastDD = Tabs.Teleport:AddDropdown("TPCast", {
    Title = "Teleport to Cast Zone Location",
    Values = CastLocationNames,
    Multi = false,
    Default = "Select Zone",
})



Tabs.Teleport:AddButton({
    Title = "Teleport to selected Zone Location",
    Description = "",
    Callback = function()
    local selectedLocation = CastDD.Value
    local CastLoc = CastLocation[selectedLocation]
    if CastLoc then
        TeleportPlayer(CastLoc) 
    else 

    end
            end
        })
        
Tabs.Event:AddParagraph({
        Title = "-----[Event Menu]-----",
        Content = ""
    })
                     
      local MountainDD = Tabs.Event:AddDropdown("TPMountain", {
    Title = "Teleport to Puzzle Heaven",
    Values = MountainLocationNames,
    Multi = false,
    Default = "Select Zone",
})



Tabs.Event:AddButton({
    Title = "Teleport to selected Puzzle Location",
    Description = "",
    Callback = function()
    local selectedLocation = MountainDD.Value
    local MountainLoc = MountainLocation[selectedLocation]
    if MountainLoc then
        TeleportPlayer(MountainLoc) 
    else 

    end
            end
        })
        
        local space = Tabs.Event:AddSection("")
        
     local LeversDD = Tabs.Event:AddDropdown("TPLevers", {
    Title = "Teleport to Puzzle Rod Northen",
    Values = LeversLocationNames,
    Multi = false,
    Default = "Select Zone",
})



Tabs.Event:AddButton({
    Title = "Teleport to selected Puzzle Location",
    Description = "",
    Callback = function()
    local selectedLocation = LeversDD.Value
    local LeversLoc = LeversLocation[selectedLocation]
    if LeversLoc then
        TeleportPlayer(LeversLoc) 
    else 

    end
            end
        })
        
        local space = Tabs.Event:AddSection("")
        
 local WorldEventTPDropdownUI = Tabs.Event:AddDropdown("WorldEventTPDropdownUI", {
        Title = "Select World Event",
        Values = {"Strange Whirlpool", "Great Hammerhead Shark", "Great White Shark", "Whale Shark", "The Depths - Serpent", "Megalodon", "Ancient Algae Pool", "Mushgrove Algae Pool", "Forsaken Algae Pool", "Snowcap Algae Pool"},
        Multi = false,
        Default = nil,
    })
    WorldEventTPDropdownUI:OnChanged(function(Value)
        SelectedWorldEvent = Value
        if SelectedWorldEvent == "Strange Whirlpool" then
            local offset = Vector3.new(25, 135, 25)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("Isonade")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found Strange Whirlpool") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing.Isonade.Position + offset)                           -- Strange Whirlpool
            WorldEventTPDropdownUI:SetValue(nil)
        elseif SelectedWorldEvent == "Great Hammerhead Shark" then
            local offset = Vector3.new(0, 135, 0)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("Great Hammerhead Shark")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found Great Hammerhead Shark") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing["Great Hammerhead Shark"].Position + offset)         -- Great Hammerhead Shark
            WorldEventTPDropdownUI:SetValue(nil)
        elseif SelectedWorldEvent == "Great White Shark" then
            local offset = Vector3.new(0, 135, 0)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("Great White Shark")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found Great White Shark") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing["Great White Shark"].Position + offset)               -- Great White Shark
            WorldEventTPDropdownUI:SetValue(nil)
        elseif SelectedWorldEvent == "Whale Shark" then
            local offset = Vector3.new(0, 135, 0)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("Whale Shark")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found Whale Shark") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing["Whale Shark"].Position + offset)                     -- Whale Shark
            WorldEventTPDropdownUI:SetValue(nil)
        elseif SelectedWorldEvent == "The Depths - Serpent" then
            local offset = Vector3.new(0, 50, 0)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("The Depths - Serpent")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found The Depths - Serpent") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing["The Depths - Serpent"].Position + offset)            -- The Depths - Serpent
            WorldEventTPDropdownUI:SetValue(nil)
        elseif SelectedWorldEvent == "Megalodon" then
            local offset = Vector3.new(0, 50, 0)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("Megalodon Default")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found Megalodon Default") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing["Megalodon Default"].Position + offset)            -- Megalodon Default
            WorldEventTPDropdownUI:SetValue(nil)    
         elseif SelectedWorldEvent == "Ancient Algae Pool" then
            local offset = Vector3.new(0, 135, 0)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("Ancient Algae Pool")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found Ancient Algae Pool") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing["Ancient Algae Pool"].Position + offset)               -- Ancient Algae Pool
            WorldEventTPDropdownUI:SetValue(nil)
        elseif SelectedWorldEvent == "Mushgrove Algae Pool" then
            local offset = Vector3.new(0, 135, 0)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("Mushgrove Algae Pool")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found Mushgrove Algae Pool") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing["Mushgrove Algae Pool"].Position + offset)                     -- Mushgrove Algae Pool
            WorldEventTPDropdownUI:SetValue(nil)
        elseif SelectedWorldEvent == "Forsaken Algae Pool" then
            local offset = Vector3.new(0, 50, 0)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("Forsaken Algae Pool")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found Forsaken Algae Pool") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing["Forsaken Algae Pool"].Position + offset)            -- Forsaken Algae Pool
            WorldEventTPDropdownUI:SetValue(nil)
        elseif SelectedWorldEvent == "Snowcap Algae Pool" then
            local offset = Vector3.new(0, 50, 0)
            local WorldEvent = game.Workspace.zones.fishing:FindFirstChild("Snowcap Algae Pool")
            if not WorldEvent then WorldEventTPDropdownUI:SetValue(nil) return ShowNotification("Not found Snowcap Algae Pool") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.zones.fishing["Snowcap Algae Pool"].Position + offset)            -- Snowcap Algae Pool
            WorldEventTPDropdownUI:SetValue(nil)    
        end
    end)

    local space = Tabs.Teleport:AddSection("")
    
    Tabs.Event:AddButton({
        Title = "Teleport to Traveler Merchant",
        Description = "Teleports to the Traveler Merchant.",
        Callback = function()
            local Merchant = game.Workspace.active:FindFirstChild("Merchant Boat")
            if not Merchant then return ShowNotification("Not found Merchant") end
            HumanoidRootPart.CFrame = CFrame.new(game.Workspace.active["Merchant Boat"].Boat["Merchant Boat"].r.HandlesR.Position)
        end
    })
--------------------------------------------------------------------------------TELEPORT------------------------------------------------------------------------------------------







--------------------------------------------------------------------------------MISC------------------------------------------------------------------------------------------

Tabs.Misc:AddParagraph({
        Title = "-----[Misc Menu]-----",
        Content = ""
    })
    
local Toggle = Tabs.Misc:AddToggle("FishingCollide", {Title = "Water Walk", Default = false})

function updateCanCollide(value)
    local fishingZone = workspace:FindFirstChild("zones"):FindFirstChild("fishing")
    if fishingZone then
        for _, descendant in ipairs(fishingZone:GetDescendants()) do
            if descendant:IsA("Part") then
                descendant.CanCollide = value
            end
        end
    end
end


Toggle:OnChanged(function(value)
    updateCanCollide(value)
end)

Options.FishingCollide:SetValue(false)

Tabs.Misc:AddButton({
    Title = "Unlimited Oxygen",
    Description = "Cannot be undone unless rejoining.",
    Callback = function()
        local playerName = game.Players.LocalPlayer.Name
        
        local oxygenLimiterPath = workspace:FindFirstChild(playerName)
        
        if oxygenLimiterPath then
            local client = oxygenLimiterPath:FindFirstChild("client")
            
            if client then
                local oxygen = client:FindFirstChild("oxygen")
                
                if oxygen then
                    oxygen:Destroy()
                    SendNotif("HutaoHub", "Oxygen is now unlimited", 2)
                else
                    
                end
            else
                
            end
        else
            
        end
    end
})

Tabs.Misc:AddButton({
    Title = "Unlimited Oxygen Northen",
    Description = "Cannot be undone unless rejoining.",
    Callback = function()
        local playerName = game.Players.LocalPlayer.Name
        
        local oxygenLimiterPath = workspace:FindFirstChild(playerName)
        
        if oxygenLimiterPath then
            local client = oxygenLimiterPath:FindFirstChild("client")
            
            if client then
                local oxygen = client:FindFirstChild("oxygen(peaks)")
                
                if oxygen then
                    oxygen:Destroy()
                    SendNotif("HutaoHub", "Oxygen is now unlimited", 2)
                else
                    
                end
            else
                
            end
        else
            
        end
    end
})

    local RemoveFog = Tabs.Misc:AddToggle("RemoveFog", {Title = "Remove Fog", Default = false })
    RemoveFog:OnChanged(function()
        if Options.RemoveFog.Value == true then
            if game:GetService("Lighting"):FindFirstChild("Sky") then
                game:GetService("Lighting"):FindFirstChild("Sky").Parent = game:GetService("Lighting").bloom
            end
        else
            if game:GetService("Lighting").bloom:FindFirstChild("Sky") then
                game:GetService("Lighting").bloom:FindFirstChild("Sky").Parent = game:GetService("Lighting")
            end
        end
    end)
    
    local DayOnly = Tabs.Misc:AddToggle("DayOnly", {Title = "Day Only", Default = false })
    DayOnly:OnChanged(function()
        if Options.DayOnly.Value == true then
            DayOnlyLoop = RunService.Heartbeat:Connect(function()
				game:GetService("Lighting").TimeOfDay = "12:00:00"
			end)
		else
			if DayOnlyLoop then
				DayOnlyLoop:Disconnect()
				DayOnlyLoop = nil
			end
        end
    end)

local WannaBeYours = Tabs.Misc:AddSection("Totem")

local AutoAuroraTotem = false
local AuroraActive = false
local me = game:GetService("Players").LocalPlayer
local middle = me.Character and me.Character:FindFirstChild("Humanoid")
local sundialTotem, auroraTotem = nil, nil

function isReelBarActive()
    local reel = me.PlayerGui:FindFirstChild("reel")
    if reel then
        local bar = reel:FindFirstChild("bar")
        return bar ~= nil
    end
    return false
end

-- Improved totem checker function
function totems()
    sundialTotem, auroraTotem = nil, nil  -- Reset the variables
    for _, item in ipairs(me.Backpack:GetChildren()) do
        if item:IsA("Tool") then  -- Ensure it's a Tool
            if item.Name == "Sundial Totem" then
                sundialTotem = item
            elseif item.Name == "Aurora Totem" then
                auroraTotem = item  -- Store Aurora Totem if found
            end
        end
    end
end

function begin()
    local wasAutoCastEnabled = Options.AutoCast.Value
    if wasAutoCastEnabled and not isReelBarActive() then
        Options.AutoCast:SetValue(false)
    end
    
    while AutoAuroraTotem do
        totems()  -- Check for Sundial and Aurora Totems

        -- If Aurora Totem is not found, disable AutoTotem and exit the function
        if not auroraTotem then
            SendNotif("Totem Notify", "Aurora Totem not found. Disabling AutoTotem.", 3)
            Options.AutoTotem:SetValue(false)  -- Disable AutoTotem
            if wasAutoCastEnabled then
                Options.AutoCast:SetValue(true)  -- Enable AutoCast
            end
            return  -- Exit the function
        end

        -- If Sundial Totem is not found, disable AutoTotem and exit the function
        if not sundialTotem then
            SendNotif("Totem Notify", "Sundial Totem not found. Disabling AutoTotem.", 3)
            Options.AutoTotem:SetValue(false)  -- Disable AutoTotem
            if wasAutoCastEnabled then
                Options.AutoCast:SetValue(true)  -- Enable AutoCast
            end
            return  -- Exit the function
        end

        local weather = me.PlayerGui.hud.safezone.worldstatuses["2_weather"].label.Text
        local cycle = me.PlayerGui.hud.safezone.worldstatuses["3_cycle"].label.Text

        -- If it's Daytime, pop Sundial Totem to change cycle to Night
        if cycle == "Day" then
            -- Wait until the reel bar is inactive
            repeat task.wait() until not isReelBarActive()
            
            middle:EquipTool(sundialTotem)
            sundialTotem:Activate()
            SendNotif("Totem Notify", "Sundial Totem Popped!!", 3)

            -- Wait until cycle changes to Night
            while cycle == "Day" do
                wait(1)  -- Wait for 1 second to prevent freezing the script
                cycle = me.PlayerGui.hud.safezone.worldstatuses["3_cycle"].label.Text  -- Update the cycle
            end
        end

        -- If it's Night and not Aurora Borealis weather, pop Aurora Totem
        if cycle == "Night" and weather ~= "Aurora Borealis" then
            -- Wait until the reel bar is inactive
            repeat task.wait() until not isReelBarActive()

            middle:EquipTool(auroraTotem)
            auroraTotem:Activate()
            SendNotif("Totem Notify", "Aurora Totem Popped!! 🌌", 3)
            AuroraActive = true

            -- Wait for Aurora Borealis to appear (weather change)
            while weather ~= "Aurora Borealis" do
                wait(1)
                weather = me.PlayerGui.hud.safezone.worldstatuses["2_weather"].label.Text
            end

            -- Once Aurora Borealis appears, stop the loop and restart from Day
            SendNotif("Totem Notify", "Aurora Borealis Active. Waiting for Day...", 3)
            if wasAutoCastEnabled then
                Options.AutoCast:SetValue(true)
            end
            -- Wait for the next day cycle
            while cycle ~= "Day" do
                wait(1)
                cycle = me.PlayerGui.hud.safezone.worldstatuses["3_cycle"].label.Text
            end
        end

        wait(1)  -- Prevent overload
    end

    -- Re-enable AutoCast after Aurora Borealis is active
end

local Toggle = Tabs.Misc:AddToggle("AutoTotem", {Title = "Auto Aurora Totem", Default = false})

Toggle:OnChanged(function(value)
    AutoAuroraTotem = value
    if AutoAuroraTotem then
        begin()
    end
end)


local WannaBeYours = Tabs.Misc:AddSection("Favorite")

-- Function to favorite tools that match the name (case-insensitive)
function favoriteFish(inputName)
    local player = game:GetService("Players").LocalPlayer
    local backpack = player.Backpack

    -- Convert inputName to lowercase for case-insensitive comparison
    local lowerInputName = inputName:lower()

    -- Loop through all tools in the player's backpack
    for _, tool in pairs(backpack:GetChildren()) do
        -- Check if the tool's name contains the inputName (case-insensitive)
        if tool:IsA("Tool") and tool.Name:lower():find(lowerInputName) then
            -- Fire the server to favorite this individual tool
            game:GetService("Players").LocalPlayer.PlayerGui.hud.safezone.backpack.events.favourite:FireServer(tool)
        end
    end
end

local favorite = nil
-- Input callback to store the input value
local FavoriteFish = Tabs.Misc:AddInput("AutoFavorite", {
    Title = "Favorite Fish",
    Default = "",
    Placeholder = "Input name",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
        -- Store the value entered by the user
        favorite = Value
    end
})

-- Button callback to favorite the tools based on the input name
Tabs.Misc:AddButton({
    Title = "Favorite All",
    Description = "Favorites the fish that contain the name you input (case-insensitive)",
    Callback = function()
        -- Get the value from the input field and call the favoriteFish function
        local inputName = favorite or ""
        if inputName ~= "" then
            favoriteFish(inputName)
        else
            SendNotif("Favorite Notify", "Please input a valid name", 3)
        end
    end
})



local WannaBeYours = Tabs.Misc:AddSection("Performance ")

Tabs.Misc:AddButton({
    Title = "Remove Cages from Sight",
    Description = "Click to make all Cage parts invisible and reduce performance impact",
    Callback = function()
        for _, player in pairs(workspace.active:GetChildren()) do
            if player:IsA("Model") and player:FindFirstChild("Cage") then
                local playerCage = player.Cage
                
                spawn(function()
                    for _, child in pairs(playerCage:GetChildren()) do
                        if child.Name == "cage" or child.Name == "Part" then
                            child.Transparency = 1
                            child.CanCollide = false
                            child.CanTouch = false
                            child.Anchored = true
                            child.Material = Enum.Material.SmoothPlastic
                        end
                    end
                end)
            end
        end
    end
})

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Flag to track the blackscreen state
local isBlackscreenActive = false

-- Add Toggle for black screen and 3D rendering
local ToggleMainName = Tabs.Misc:AddToggle("BlackScreenToggle", {Title = "Toggle Blackscreen", Description = "Disable 3D Rendering to optimize GPU", Default = false})

ToggleMainName:OnChanged(function(value)
    if value then
        -- Show black screen and disable 3D rendering
        if not isBlackscreenActive then
            -- Create the blackscreen GUI
            local blackScreenGui = Instance.new("ScreenGui")
            blackScreenGui.Name = "BlackScreenGui"
            blackScreenGui.ResetOnSpawn = false
            blackScreenGui.DisplayOrder = -10  -- Keep it in the background
            blackScreenGui.IgnoreGuiInset = true -- Ensure full coverage
            blackScreenGui.Parent = CoreGui

            -- Create a ViewportFrame as a black overlay
            local viewport = Instance.new("ViewportFrame")
            viewport.Size = UDim2.new(1, 0, 1, 0)
            viewport.BackgroundColor3 = Color3.new(0, 0, 0) -- Pure black
            viewport.BorderSizePixel = 0
            viewport.BackgroundTransparency = 0 -- Fully opaque
            viewport.Parent = blackScreenGui

            -- Disable 3D rendering
            RunService:Set3dRenderingEnabled(false)
            isBlackscreenActive = true
        end
    else
        -- Remove black screen and enable 3D rendering
        if isBlackscreenActive then
            CoreGui:FindFirstChild("BlackScreenGui"):Destroy()
            RunService:Set3dRenderingEnabled(true)
            isBlackscreenActive = false
        end
    end
end)

-- Optionally, set the default value to false if the toggle state should start as off
Options.BlackScreenToggle:SetValue(false)


local WannaBeYours = Tabs.Misc:AddSection("Trading Misc")

-- Define the toggle for "Auto Accept Trade"
local AutoAccept = Tabs.Misc:AddToggle("AutoAccept", {Title = "Auto Accept Trade", Default = false})

-- Listen for toggle changes
AutoAccept:OnChanged(function(value)
    if value then
        -- If enabled, start continuous checking on every frame
        autoAcceptConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local player = game:GetService("Players").LocalPlayer
            local playerGui = player:FindFirstChild("PlayerGui")
            local hud = playerGui and playerGui:FindFirstChild("hud")
            local safezone = hud and hud:FindFirstChild("safezone")
            local bodyAnnouncements = safezone and safezone:FindFirstChild("bodyannouncements")
            local offer = bodyAnnouncements and bodyAnnouncements:FindFirstChild("offer")
            local confirmButton = offer and offer:FindFirstChild("confirm")

            -- If the confirm button is available and visible, auto-accept the trade
            if confirmButton and confirmButton.Visible then
                firesignal(confirmButton.MouseButton1Click, player)
            end
        end)
    else
        -- If disabled, stop the continuous checking
        if autoAcceptConnection then
            autoAcceptConnection:Disconnect()
            autoAcceptConnection = nil
        end
    end
end)

-- List of blacklisted item keywords
local blacklistedKeywords = {"Rod", "Bag", "Radar", "GPS", "Gear", "Flipper", "Cage", "Bestiary", "Glider"}

-- List of priority keywords for shiny tools
local priorityKeywords = {"Shiny", "Sparkling", "Mythical", "Aurora", "Relic"}

-- Function to check if the item's name contains any blacklisted keywords
function isBlacklisted(itemName)
    for _, keyword in ipairs(blacklistedKeywords) do
        if itemName:find(keyword) then
            return true
        end
    end
    return false
end

-- Function to check if the item has any of the priority keywords
function isPriorityItem(itemName)
    for _, keyword in ipairs(priorityKeywords) do
        if itemName:find(keyword) then
            return true
        end
    end
    return false
end

-- Get the local player
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Variable to store the previously equipped tool (to prevent re-equipping the same tool)
local previousTool = nil
local tradeOfferConnection = nil  -- Declare tradeOfferConnection globally
local offerSpamConnection = nil  -- Connection for spamming the offer event

-- Create the dropdown and set initial player list
local Dropdown = Tabs.Misc:AddDropdown("SelectPlayerOFFER", {
    Title = "Select Player",
    Values = GetOtherPlayers(),  -- Assuming GetOtherPlayers is defined elsewhere
    Multi = false,
    Default = "",
})

-- Toggle for Auto Trade Offer
local AutoTradeOffer = Tabs.Misc:AddToggle("AutoTrade", {Title = "Auto Trade Selected Player (all items)", Default = false})

AutoTradeOffer:OnChanged(function(value)
    if value then
        -- Reset previousTool when the toggle is turned on again
        previousTool = nil

        -- Create a connection to RenderStepped to continuously try to trade
        tradeOfferConnection = runService.RenderStepped:Connect(function()
            -- Get the selected player name from the dropdown
            local selectedPlayer = Dropdown.Value

            if selectedPlayer and selectedPlayer ~= "" then
                -- Loop through the Backpack to find valid tools
                local backpack = LocalPlayer.Backpack

                -- Create a table of valid tools (not blacklisted and not the previous tool unless it's a priority item)
                local validTools = {}
                for _, playerTool in ipairs(backpack:GetChildren()) do
                    if playerTool:IsA("Tool") and not isBlacklisted(playerTool.Name) then
                        -- Prioritize tools with the priority keywords
                        if isPriorityItem(playerTool.Name) then
                            -- If the tool has a priority keyword, prioritize it
                            table.insert(validTools, playerTool)
                        elseif playerTool.Name ~= previousTool then
                            -- Allow non-priority tools if it's not the previous one
                            table.insert(validTools, playerTool)
                        end
                    end
                end

                -- If we have any valid tools and no tool is already equipped
                if #validTools > 0 then
                    -- Check if the player already has a tool equipped (we'll check the character's tools)
                    local characterTools = LocalPlayer.Character:GetChildren()
                    local currentEquippedTool = nil
                    for _, tool in ipairs(characterTools) do
                        if tool:IsA("Tool") then
                            currentEquippedTool = tool
                            break
                        end
                    end
                    
                    -- If a tool is equipped, unequip it first
                    if currentEquippedTool then
                        currentEquippedTool.Parent = backpack  -- Unequip the current tool
                    end

                    -- Pick a random tool from the valid tools
                    local randomTool = validTools[math.random(1, #validTools)]

                    -- Equip the selected tool by moving it to the character
                    randomTool.Parent = LocalPlayer.Character

                    -- Make sure the tool is equipped before firing the event
                    local offerEvent = LocalPlayer.Character:FindFirstChild(randomTool.Name) and LocalPlayer.Character[randomTool.Name]:FindFirstChild("offer")
                    if offerEvent then
                        -- Fire the event with the selected player name
                        local args = {
                            [1] = game:GetService("Players"):WaitForChild(selectedPlayer) -- Player Name from dropdown
                        }

                        -- Start spamming the offer event for this tool
                        offerSpamConnection = runService.RenderStepped:Connect(function()
                            -- Wait until the tool is removed from the backpack or unequipped from the character
                            local equippedTool = LocalPlayer.Character:FindFirstChild(randomTool.Name)
                            local toolInBackpack = backpack:FindFirstChild(randomTool.Name)
                            if equippedTool then
                                -- Keep spamming the offer event while the tool is equipped
                                offerEvent:FireServer(unpack(args))
                            elseif not equippedTool and not toolInBackpack then
                                -- If the tool is no longer equipped or in the backpack, stop spamming
                                if offerSpamConnection then
                                    offerSpamConnection:Disconnect()
                                    offerSpamConnection = nil
                                end

                                -- Recurse to equip a new tool and start the offer spam again
                                previousTool = randomTool.Name
                                AutoTradeOffer:Set(true)  -- Trigger AutoTradeOffer again to spam the new tool
                            end
                        end)

                        -- Update the previous tool to the current one (to prevent re-equipping it)
                        previousTool = randomTool.Name
                    end
                end
            end
        end)
    else
        -- Reset previousTool when the toggle is turned off
        previousTool = nil

        -- Disconnect RenderStepped when the toggle is off
        if tradeOfferConnection then
            tradeOfferConnection:Disconnect()
            tradeOfferConnection = nil
        end

        -- Stop spamming the offer event when the toggle is turned off
        if offerSpamConnection then
            offerSpamConnection:Disconnect()
            offerSpamConnection = nil
        end
    end
end)


local WannaBeYours = Tabs.Misc:AddSection("Character Misc")

local LocalPlayer = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local velocityHandlerName = "VelocityHandler"
local gyroHandlerName = "GyroHandler"
local flySpeed = 1 

Tabs.Misc:AddInput("FlySpeed", {
    Title = "Change Fly Speed",
    Default = "1",
    Placeholder = "Enter Fly Speed",
    Numeric = true, 
    Finished = true, 
    Callback = function(Value)
        flySpeed = tonumber(Value) or flySpeed
    end
})

local Toggle = Tabs.Misc:AddToggle("Fly", {Title = "Fly", Default = false})
local isFlying = false
local mfly1, mfly2 

local function getRoot(character)
    return character:FindFirstChild("HumanoidRootPart")
end

local function startFlying()
	isFlying = true
	FLYING = true
	local root = getRoot(LocalPlayer.Character)
	local camera = workspace.CurrentCamera
	local v3none = Vector3.new()
	local v3zero = Vector3.new(0, 0, 0)
	local v3inf = Vector3.new(9e9, 9e9, 9e9)

	local controlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
	local bv = Instance.new("BodyVelocity")
	bv.Name = velocityHandlerName
	bv.Parent = root
	bv.MaxForce = v3zero
	bv.Velocity = v3zero

	local bg = Instance.new("BodyGyro")
	bg.Name = gyroHandlerName
	bg.Parent = root
	bg.MaxTorque = v3inf
	bg.P = 1000
	bg.D = 50

	mfly1 = LocalPlayer.CharacterAdded:Connect(function()
		local bv = Instance.new("BodyVelocity")
		bv.Name = velocityHandlerName
		bv.Parent = root
		bv.MaxForce = v3zero
		bv.Velocity = v3zero

		local bg = Instance.new("BodyGyro")
		bg.Name = gyroHandlerName
		bg.Parent = root
		bg.MaxTorque = v3inf
		bg.P = 1000
		bg.D = 50
	end)

	mfly2 = RunService.RenderStepped:Connect(function()
		root = getRoot(LocalPlayer.Character)
		camera = workspace.CurrentCamera
		if LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") and root:FindFirstChild(velocityHandlerName) and root:FindFirstChild(gyroHandlerName) then
			local humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
			local VelocityHandler = root:FindFirstChild(velocityHandlerName)
			local GyroHandler = root:FindFirstChild(gyroHandlerName)

			VelocityHandler.MaxForce = v3inf
			GyroHandler.MaxTorque = v3inf
			if not vfly then humanoid.PlatformStand = true end
			GyroHandler.CFrame = camera.CFrame
			VelocityHandler.Velocity = v3none

			local direction = controlModule:GetMoveVector()

			if direction.X ~= 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * direction.X * flySpeed * 50
			end
			if direction.Z ~= 0 then
				VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * direction.Z * flySpeed * 50
			end
		end
	end)
end

local function stopFlying()
	FLYING = false
	isFlying = false

	local root = getRoot(LocalPlayer.Character)
	if root:FindFirstChild(velocityHandlerName) then
		root:FindFirstChild(velocityHandlerName):Destroy()
	end
	if root:FindFirstChild(gyroHandlerName) then
		root:FindFirstChild(gyroHandlerName):Destroy()
	end
	
	local humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
	if humanoid then humanoid.PlatformStand = false end
	
	if mfly1 then mfly1:Disconnect() end
	if mfly2 then mfly2:Disconnect() end
end

Toggle:OnChanged(function(value)
	if value then
		startFlying()
	else
		stopFlying()
	end
end)

Options.Fly:SetValue(false)


local Toggle = Tabs.Misc:AddToggle("Noclip", {Title = "Noclip", Default = false })

Toggle:OnChanged(function(noclip)
    loopnoclip = noclip
    local function loopnoclipfix()
        if LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end

    while loopnoclip do
        pcall(loopnoclipfix)
        task.wait(0.1) 
    end
end)

Options.Noclip:SetValue(false)



--------------------------------------------------------------------------------MISC--------------------------------------------------------------------------------------


------------------------------APPRAISE

Tabs.Appraise:AddParagraph({
        Title = "IMPORTANT: PLEASE READ BEFORE USE",
        Content = "To use Auto Appraise and More like Buy Relic or Luck Selling Fish you need to use Infinite Range NPC Below or just go to npcs lol ",
        })

local ToggleRefreshedNpc = Tabs.Appraise:AddToggle("RefreshedNpc", {Title = "Infinite Range NPC", Description = "Use this to be able to Use NPC Functions anywhere for Appraise, Merchant, Merlin, Jack Marrow", Default = false})

ToggleRefreshedNpc:OnChanged(function(isEnabled)
    if isEnabled then
        task.spawn(function()
            local NPCLocations = {
                ["Merlin"] = CFrame.new(-932, 224, -988),
                ["Jack Marrow"] = CFrame.new(-2825, 214, 1516),
                ["Appraiser"] = CFrame.new(444, 151, 210),
                ["Marc Merchant"] = CFrame.new(467, 151, 231)
            }

            -- Save the initial position of the player
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = character:WaitForChild("HumanoidRootPart")
            local originalPosition = rootPart.CFrame

            -- Proximity prompt function
            local function triggerProximityPrompt(pp)
                local camera = workspace.CurrentCamera
                local originalCameraType = camera.CameraType
                local originalCFrame = camera.CFrame

                local targetPart
                if pp.Parent:IsA("Model") and pp.Parent:FindFirstChild("Head") then
                    targetPart = pp.Parent.Head
                elseif pp.Parent:IsA("Part") then
                    targetPart = pp.Parent
                else
                    return
                end

                -- Save original ProximityPrompt properties
                local originalEnabled = pp.Enabled
                local originalHoldDuration = pp.HoldDuration
                local originalLineOfSight = pp.RequiresLineOfSight
                local originalMaxActivationDistance = pp.MaxActivationDistance

                -- Adjust ProximityPrompt properties to ensure it's shown
                pp.Enabled = true
                pp.MaxActivationDistance = math.huge
                pp.RequiresLineOfSight = false
                pp.HoldDuration = 0

                -- Set camera to focus on the prompt's parent part (NPC's head or part)
                camera.CameraType = Enum.CameraType.Scriptable
                camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPart.Position)
                task.wait(0.05)  -- Give it a moment to set the camera position

                -- Trigger the ProximityPrompt
                pp:InputHoldBegin()
                task.wait(0.05)
                pp:InputHoldEnd()

                -- Wait a short time before resetting camera properties
                task.wait(0.5)  -- Allow the prompt to show before the next trigger

                -- Reset camera to follow the LocalPlayer
                camera.CameraType = Enum.CameraType.Custom
                camera.CFrame = CFrame.new(rootPart.Position)  -- Set the camera back to the player's position

                -- Restore original ProximityPrompt properties
                pp.Enabled = originalEnabled
                pp.HoldDuration = originalHoldDuration
                pp.RequiresLineOfSight = originalLineOfSight
                pp.MaxActivationDistance = originalMaxActivationDistance
            end

            -- Function to check if the NPC has loaded and is persistent
            local function isNpcPersistent(npc)
                return npc and npc.ModelStreamingMode == Enum.ModelStreamingMode.Persistent
            end

            -- Table to keep track of NPC statuses (persistent or not)
            local npcStatuses = {}
            for npcName in pairs(NPCLocations) do
                npcStatuses[npcName] = false
            end

            -- Loop to continuously teleport and trigger proximity prompts
            while Options.RefreshedNpc.Value do
                for npcName, targetCFrame in pairs(NPCLocations) do
                    if not Options.RefreshedNpc.Value then break end

                    -- the NPC's location
                    TeleportPlayer(targetCFrame)
                    task.wait(2) -- Wait for teleportation and NPC loading

                    -- Wait until the NPC is fully accessible
                    local npc = workspace.world.npcs:FindFirstChild(npcName)
                    if not npc then
                        warn(npcName .. " not found in the workspace.world.npcs after teleportation.")
                        continue
                    end

                    -- Ensure the NPC is set to Persistent
                    npc.ModelStreamingMode = Enum.ModelStreamingMode.Persistent

                    -- Check if NPC is already persistent
                    if isNpcPersistent(npc) then
                        -- Find the ProximityPrompt of the NPC
                        local proximityPrompt = npc:FindFirstChildWhichIsA("ProximityPrompt", true)

                        -- If the ProximityPrompt exists, trigger it
                        if proximityPrompt then
                            
                            triggerProximityPrompt(proximityPrompt)

                            -- Mark NPC as triggered
                            npcStatuses[npcName] = true
                            
                        else
                            
                        end
                    else
                        task.wait(2)
                    end
                end

                -- Check if all NPCs are persistent and have been triggered
                local allTriggered = true
                for npcName, status in pairs(npcStatuses) do
                    if not status then
                        allTriggered = false
                        break
                    end
                end

                -- If all NPCs are triggered and persistent, turn off the toggle
                if allTriggered then
                 SendNotif("System Notify", "You can now use NPC Interaction in Infinite Range such as (Buy Luck/Relic, Selling Fish, Appraise, Repair Map)", 5)
                 Options.RefreshedNpc:SetValue(false)
                    break
                end

                -- Wait for a short time before checking again
                task.wait(2)
            end
            TeleportPlayer(originalPosition)
        end)
    end
end)

Options.RefreshedNpc:SetValue(false)

local space = Tabs.Appraise:AddSection("Jack Marrow")


-- Declare necessary variables
local player = game:GetService("Players").LocalPlayer
local Backpack = player:WaitForChild("Backpack")
local Toggle = Tabs.Appraise:AddToggle("AutoTreasure", {Title = "Auto Treasure Chest", Default = false})

-- Flag to check if we've teleported to the repair location
local hasTeleportedToRepair = false

-- Function to equip Treasure Map
function EquipTreasureMap()
    local treasureMap = Backpack:FindFirstChild("Treasure Map")
    if treasureMap then
        player.Character.Humanoid:EquipTool(treasureMap)
        return true
    else
        warn("No Treasure Map found in backpack.")
        return false
    end
end

-- Function to repair the Treasure Map and teleport once to specified coordinates
function RepairTreasureMap()
    if not hasTeleportedToRepair then
        local repairLocation = CFrame.new(-2825, 214, 1516)
        TeleportPlayer(repairLocation)
        hasTeleportedToRepair = true
    end

    -- Check if "Jack Marrow" exists before invoking the server
    local jackMarrow = workspace.world.npcs:FindFirstChild("Jack Marrow")
    while not jackMarrow do
        wait(0.5)  -- Wait and retry until Jack Marrow is available
        jackMarrow = workspace.world.npcs:FindFirstChild("Jack Marrow")
    end

    -- Now that Jack Marrow exists, invoke the server
    jackMarrow.treasure.repairmap:InvokeServer()
end

-- Function to teleport to the coordinates from the map
function TeleportToTreasure()
    local coordinatesText = player.PlayerGui["Treasure Map"].Main.CoordinatesLabel.Text
    local x, y, z = coordinatesText:match("X ([%d.-]+), Y ([%d.-]+), Z ([%d.-]+)")
    
    if x and y and z then
        local targetPosition = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
        TeleportPlayer(CFrame.new(targetPosition))
    else
        warn("Failed to parse coordinates from text.")
    end
end

-- Function to find and activate the nearest Treasure Chest proximity prompt
function ActivateNearestChestPrompt()
    local closestPrompt
    local closestDistance = math.huge
    local playerPosition = player.Character.PrimaryPart.Position

    -- Loop through all chests in the world
    for _, chest in pairs(workspace.world.chests:GetChildren()) do
        if chest:FindFirstChild("ProximityPrompt") then
            local distance = (chest.Position - playerPosition).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPrompt = chest.ProximityPrompt
            end
        end
    end

    -- Fire the closest proximity prompt
    if closestPrompt then
        fireproximityprompt(closestPrompt, 1, true)
    else
        warn("No Treasure Chest ProximityPrompt found.")
    end
end

-- Toggle function
Toggle:OnChanged(function(value)
    while value and Backpack:FindFirstChild("Treasure Map") do
        if EquipTreasureMap() then
            RepairTreasureMap()
            TeleportToTreasure()
            ActivateNearestChestPrompt()
        end
        wait(1)  -- Adjust delay as needed
    end
end)

Options.AutoTreasure:SetValue(false)


local space = Tabs.Appraise:AddSection("Appraiser")

local FishData = {["Emperor Jellyfish"] = 8000, ["Angelfish"] = 20, ["Oyster"] = 5, ["Sand Dollar"] = 2, ["White Perch"] = 12, ["Smallmouth Bass"] = 17, ["Great Hammerhead Shark"] = 5000, ["Seaweed"] = 3, ["Napoleonfish"] = 350, ["Sea Bass"] = 60, ["Midnight Axolotl"] = 30, ["Trout"] = 50, ["Rabbitfish"] = 60, ["Swamp Bass"] = 60, ["Captain's Goldfish"] = 25, ["Largemouth Bass"] = 45, ["Walleye"] = 40, ["Brine Phantom"] = 6500, ["Rock"] = 210, ["Glacier Pike"] = 35, ["Arctic Char"] = 60, ["Manta Ray"] = 10000, ["Lobster"] = 28, ["Blackfish"] = 20, ["Brine Shrimp"] = 3, ["Globe Jellyfish"] = 240, ["Pollock"] = 50, ["Chinfish"] = 40, ["Bowfin"] = 60, ["Cod"] = 100, ["Sea Turtle"] = 1500, ["Driftwood"] = 6, ["Pumpkinseed"] = 5, ["Cockatoo Squid"] = 20, ["Arapaima"] = 2000, ["Nessie"] = 40000, ["Pyrogrub"] = 600, ["Lurkerfish"] = 20, ["Stalactite"] = 130, ["Bone"] = 25, ["Mahi Mahi"] = 150, ["Axolotl"] = 15, ["Grey Carp"] = 70, ["Goldfish"] = 7, ["Sunfish"] = 10000, ["Zombiefish"] = 30, ["Phantom Ray"] = 60, ["Voidfin Mahi"] = 155, ["Umbral Shark"] = 1550, ["Buccaneer Barracuda"] = 250, ["Boot"] = 12, ["Eel"] = 45, ["Spiderfish"] = 10, ["Bluefin Tuna"] = 2200, ["Eyefestation"] = 6500, ["Carbon Crate"] = 160, ["Corsair Grouper"] = 200, ["Mackerel"] = 40, ["Night Shrimp"] = 2, ["Stingray"] = 300, ["Isonade"] = 13000, ["Ribbon Eel"] = 150, ["Minnow"] = 6, ["Crown Bass"] = 60, ["Alligator"] = 3000, ["Quality Bait Crate"] = 120, ["Enchant Relic"] = 210, ["Olm"] = 4, ["Shipwreck Barracuda"] = 300, ["Spectral Serpent"] = 130000, ["Rockstar Hermit Crab"] = 12, ["Banditfish"] = 200, ["Swamp Scallop"] = 14, ["Longtail Bass"] = 40, ["Bluefish"] = 9, ["Prawn"] = 5, ["Ringle"] = 4, ["Horseshoe Crab"] = 90, ["Scallop"] = 5, ["Nurse Shark"] = 1500, ["Bream"] = 27, ["Abyssacuda"] = 110, ["Scurvy Sailfish"] = 700, ["Snook"] = 70, ["Wiifish"] = 400, ["Crab"] = 14, ["Whiptail Catfish"] = 30, ["Oarfish"] = 2500, ["Common Crate"] = 80, ["Haddock"] = 40, ["Slate Tuna"] = 600, ["Porgy"] = 30, ["Shrimp"] = 2, ["Bait Crate"] = 80, ["Skipjack Tuna"] = 160, ["Bull Shark"] = 1300, ["Ember Snapper"] = 120, ["Anchovy"] = 3, ["Log"] = 75, ["White Bass"] = 25, ["Coelacanth"] = 100, ["Barbed Shark"] = 9500, ["Twilight Eel"] = 200, ["Fish Barrel"] = 150, ["Shortfin Mako Shark"] = 1000, ["Lingcod"] = 140, ["Sturgeon"] = 800, ["Anglerfish"] = 20, ["Gazerfish"] = 140, ["Red Snapper"] = 70, ["Whale Shark"] = 100000, ["Obsidian Salmon"] = 180, ["Tire"] = 110, ["Fangborn Gar"] = 380, ["Obsidian Swordfish"] = 2500, ["Swordfish"] = 2500, ["Mullet"] = 20, ["Salmon"] = 100, ["Sailfish"] = 600, ["Ember Perch"] = 15, ["Cutlass Fish"] = 250, ["Galleon Goliath"] = 200, ["Sardine"] = 3, ["Pike"] = 35, ["Pond Emperor"] = 2500, ["Pufferfish"] = 20, ["Cookiecutter Shark"] = 15, ["Voltfish"] = 16, ["Redeye Bass"] = 15, ["Golden Seahorse"] = 8, ["Sockeye Salmon"] = 70, ["Basalt"] = 210, ["Magma Tang"] = 30, ["Skelefish"] = 10, ["Carp"] = 50, ["Suckermouth Catfish"] = 170, ["Squid"] = 25, ["Halibut"] = 2000, ["Ghoulfish"] = 120, ["Glassfish"] = 4, ["Dolphin"] = 2000, ["Sawfish"] = 6000, ["Sea Pickle"] = 10, ["Great White Shark"] = 12000, ["Clownfish"] = 6, ["Dweller Catfish"] = 160, ["Perch"] = 12, ["Chub"] = 30, ["Sea Urchin"] = 9, ["Cursed Eel"] = 250, ["Fungal Cluster"] = 9, ["Herring"] = 11, ["Grayling"] = 20, ["Blue Tang"] = 15, ["Flounder"] = 55, ["Butterflyfish"] = 15, ["Yellow Boxfish"] = 20, ["Dumbo Octopus"] = 40, ["Mythic Fish"] = 14, ["Catfish"] = 150, ["Sweetfish"] = 5, ["Lapisjack"] = 400, ["Sea Mine"] = 3250, ["Red Tang"] = 15, ["Gudgeon"] = 3, ["Whisker Bill"] = 1000, ["Burbot"] = 35, ["Ice"] = 60, ["Colossal Squid"] = 12000, ["Reefrunner Snapper"] = 250, ["Handfish"] = 60, ["Flying Fish"] = 50, ["Bluegill"] = 6, ["Red Drum"] = 25, ["Coral Geode"] = 180, ["Amberjack"] = 400, ["Trumpetfish"] = 20, ["Mussel"] = 2, ["Glacierfish"] = 600, ["Alligator Gar"] = 450, ["Moonfish"] = 5000, ["Yellowfin Tuna"] = 1360, ["Candy Fish"] = 10, ["Volcanic Geode"] = 200, ["Barracuda"] = 110, ["Rubber Ducky"] = 7, ["Marsh Gar"] = 380, ["King Oyster"] = 10, ["Keepers Guardian"] = 400, ["Mushgrove Crab"] = 14, ["Pale Tang"] = 15, ["Chinook Salmon"] = 400, ["Golden Smallmouth Bass"] = 45}
local statFolder,Filtered
local WeightVal,DelayVal = 100, 0.8
local fishDone = {}
local MutList = {"Any", "Albino", "Darkened", "Electric", "Frozen", "Ghastly", "Glossy", "Midas", "Mosaic", "Mythical", "Negative", "Silver", "Sinister", "Translucent", "Hexed", "Sunken", "Abyssal"}

function getAllOwnedFish()
    local OwnedList = {}
    for _, fish in ipairs(player.Backpack:GetChildren()) do
        if fish:FindFirstChild("fishscript") then
            OwnedList[fish.Name] = true -- Use dictionary for uniqueness
        end
    end

    -- Convert dictionary keys to array
    local resultList = {}
    for fishName in pairs(OwnedList) do
        table.insert(resultList, fishName)
    end
    return resultList
end

local allOwnedFish = getAllOwnedFish()

local MutationListed = {}

-- Dropdown to select mutations
local MutationList = Tabs.Appraise:AddDropdown("MutationListDropdown", {
    Title = "Mutation Target",
    Description = "Select Mutation Target",
    Values = MutList,
    Multi = true,  
    Default = {},  
})

MutationList:OnChanged(function(Value)
    local Values = {}
    for mutation, state in next, Value do
        if state then
            table.insert(Values, mutation)  
        end
    end
    MutationListed = Values  
end)


-- Fish Selection Dropdown
local FishSelection = Tabs.Appraise:AddDropdown("FishSelection", {
    Title = "Selected Fish",
    Description = "Select Fish Target",
    Values = allOwnedFish,
    Multi = true,
    Default = {},
})

FishSelection:OnChanged(function(Value)
    -- Equip the selected fish automatically
    if #Value > 0 then
        local selectedFish = Value[1] -- Take the first selected fish from the dropdown
        local player = game.Players.LocalPlayer -- Ensure 'player' refers to the local player
        for _, fish in ipairs(player.Backpack:GetChildren()) do
            if fish.Name == selectedFish then
                -- Equip the fish if it's found in the backpack
                player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(fish)
                break
            end
        end
    end
end)

-- Auto Appraise Toggle
local AutoToggle = Tabs.Appraise:AddToggle("AutoToggle", {Title = "Auto Appraise", Default = false})
AutoToggle:OnChanged(function(Value)
    
end)
Options.AutoToggle:SetValue(false)

-- Appraise All Toggle
local AppraiseAll = Tabs.Appraise:AddToggle("AppraiseAll", {Title = "Appraise All Selected Fish", Default = false})
AppraiseAll:OnChanged(function(Value)
   
end)
Options.AppraiseAll:SetValue(false)

-- Weight Target Dropdown
local WeightTarget = Tabs.Appraise:AddDropdown("WeightTarget", {
    Title = "Weight Target",
    Description = "Select Weight Target",
    Values = {"Big", "Giant"},
    Multi = true,
    Default = {}, 
})

local WeightListed = {}

WeightTarget:OnChanged(function(Value)
    WeightListed = {} 
    for Weight, State in next, Value do
        if State then  
            table.insert(WeightListed, Weight)
        end
    end

end)

-- Weight Filter Toggle
local WeightToggle = Tabs.Appraise:AddToggle("WeightToggle", {Title = "Weight Filter Toggle", Default = false})
WeightToggle:OnChanged(function(Value)
   
end)
Options.WeightToggle:SetValue(false)

-- Mutation Toggle
local MutationToggle = Tabs.Appraise:AddToggle("MutationToggle", {Title = "Mutation Toggle", Default = false})
MutationToggle:OnChanged(function(Value)

end)
Options.MutationToggle:SetValue(false)

-- Require Sparkling Toggle
local SparklingToggle = Tabs.Appraise:AddToggle("SparklingToggle", {Title = "Require Sparkling", Default = false})
SparklingToggle:OnChanged(function(Value)
    fishDone = {} -- Reset appraised list when Sparkling requirement changes
end)
Options.SparklingToggle:SetValue(false)

-- Require Shiny Toggle
local ShinyToggle = Tabs.Appraise:AddToggle("ShinyToggle", {Title = "Require Shiny", Default = false})
ShinyToggle:OnChanged(function(Value)
    fishDone = {} -- Reset appraised list when Shiny requirement changes
end)
Options.ShinyToggle:SetValue(false)
-- Function to get the currently held fish tool
function getHeldFish()
    -- Iterate through the player's character to find a fish tool
    for _, tool in ipairs(player.Character:GetChildren()) do
        if tool:IsA("Tool") then
            return tool  -- Return the fish tool
        end
    end
    return nil  -- Return nil if no fish tool is held
end

function switchFish()
    -- Iterate through all fish in the player's backpack
    for _, fish in ipairs(player.Backpack:GetChildren()) do
        -- Check if the fish is in the selection list and hasn't been appraised
        if table.find(FishSelection.Value, fish.Name) and not table.find(fishDone, fish) then
            -- Equip the fish
            print("Equipping:", fish.Name)  -- Debugging print
            player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(fish)
            return
        end
    end
end

-- Function to categorize fish by weight
function getWeightCategory(fish)
    local fishName = fish.Name
    local statFolder = fish.link.Value
    local weight = statFolder.Weight.Value
    local Big = FishData[fishName] / 10
    local Giant = (FishData[fishName] / 10) * 1.99
    if weight > Giant then
        return "Giant"
    elseif weight > Big then
        return "Big"
    else
        return "Regular"
    end
end

LocalPlayer.Backpack.ChildAdded:Connect(function(instance)
	if instance:isA("Tool") and not instance:FindFirstChild("link") then
		repeat task.wait() until instance:FindFirstChild("link")
		local oldtools = getHeldFish()
		if oldtools then oldtools.Parent = player.Backpack end
		if AutoToggle.Value then
			player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(instance)
		end
	end
end)

function applyFilter(fish)
    local statFolder = fish.link.Value  -- Assuming fish.link.Value is the folder containing stats

    -- Weight Filter Check
    if WeightToggle.Value and next(WeightListed) ~= nil then
        -- Check if the fish's weight category is in the selected weight targets
        if not table.find(WeightListed, getWeightCategory(fish)) then
            return false  -- Filter out fish that do not match the weight target
        end
    end

    -- Sparkling Filter Check
    if SparklingToggle.Value then
        if not statFolder:FindFirstChild("Sparkling") then
            return false  -- Filter out fish that are not sparkling
        end
    end

    -- Shiny Filter Check
    if ShinyToggle.Value then
        if not statFolder:FindFirstChild("Shiny") then
            return false  -- Filter out fish that are not shiny
        end
    end

    -- Mutation Filter Check
    if MutationToggle.Value and next(MutationListed) ~= nil then
        -- Try to find Mutation in different places (statFolder, linked folder, etc.)
        local Mutation = nil
        
        -- Check if there's a "Mutation" directly in the statFolder or the fish object
        if statFolder then
            Mutation = statFolder:FindFirstChild("Mutation") 
        else
            print("Stat Folder Mutaion not Found") -- Look in the stat folder
        end

        local Any = table.find(MutationListed, "Any")

        -- If no mutation exists, and "Any" is not selected, return false
        if not Mutation then
            if not Any then
                return false  -- No mutation found, and "Any" is not selected, so filter out
            else
                return true  -- Pass if 'Any' is selected
            end
        else
            -- If "Any" mutation is selected, accept all mutations
            if Any then
                return true
            end

            -- Check if the fish's mutation matches any of the selected mutations
            for _, selectedMutation in ipairs(MutationListed) do
                -- If we find a match, return true immediately
                if selectedMutation == Mutation.Value then
                    return true  -- Accept fish with the correct mutation
                end
            end

            -- If no mutation matches any in the list, return false
            return false  -- Filter out fish that do not match any of the selected mutations
        end
    end

    -- If all filters are passed
    return true
end


-- Auto appraise function to handle appraising the fish
function AutoAppraise()
    if not AutoToggle.Value then return end
    local fish = getHeldFish()  -- Get the currently held fish
    if fish then
        local isFiltered = applyFilter(fish)
        if isFiltered then 
            -- If AppraiseAll is enabled and the fish hasn't been appraised yet
            if AppraiseAll.Value and not table.find(fishDone, fish) then
                table.insert(fishDone, fish)  -- Mark fish as appraised
                switchFish()  -- Switch to next fish
            end
            return
        end

        -- Appraise the current fish if it passes the filter
        local success, errorMsg = pcall(function()
            workspace.world.npcs.Appraiser.appraiser.appraise:InvokeServer()
        end)
        if not success then
        end
        task.wait(tonumber(DelayVal))  -- Delay before trying again
    elseif not fish and AppraiseAll.Value then
        switchFish()
    end
end

RunService.Heartbeat:Connect(AutoAppraise)

local space = Tabs.Appraise:AddSection("Merlin")

Tabs.Appraise:AddButton({
    Title = "Buy Luck",
    Description = "",
    Callback = function()
        local luck = workspace:FindFirstChild("world")
            and workspace.world:FindFirstChild("npcs")
            and workspace.world.npcs:FindFirstChild("Merlin")
            and workspace.world.npcs.Merlin:FindFirstChild("Merlin")

        if luck then
            workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Merlin"):WaitForChild("Merlin"):WaitForChild("luck"):InvokeServer()
        else
            TeleportPlayer(CFrame.new(-932, 224, -988))
            repeat task.wait() until luck
            TeleportPlayer(currentCFrame)
        end
    end
})

Tabs.Appraise:AddButton({
    Title = "Buy Relic",
    Description = "",
    Callback = function()
        local power = workspace:FindFirstChild("world")
            and workspace.world:FindFirstChild("npcs")
            and workspace.world.npcs:FindFirstChild("Merlin")
            and workspace.world.npcs.Merlin:FindFirstChild("Merlin")

        if power then
            workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Merlin"):WaitForChild("Merlin"):WaitForChild("power"):InvokeServer()
        else
            TeleportPlayer(CFrame.new(-932, 224, -988))
            repeat task.wait() until power
            TeleportPlayer(currentCFrame)
        end
    end
})


local Sells = Tabs.Appraise:AddSection("Merchant")



Tabs.Appraise:AddButton({
    Title = "Sell Equipped Fish",
    Description = "Please equip a fish to sell just like in Merchant",
    Callback = function()
        Window:Dialog({
            Title = "Sell Equipped Fish?",
            Content = "Do you want to sell this fish?",
            Buttons = {
                {
                    Title = "Yes!",
                    Callback = function()
                        game:GetService("ReplicatedStorage").events.Sell:InvokeServer()
                    end
                },
                {
                    Title = "Nuhh Uhh",
                    Callback = function()
                        -- Optional: Code for this button
                    end
                }
            }
        })
    end
})

Tabs.Appraise:AddButton({
    Title = "Sell All Fish",
    Description = "Selling all fish in your inventory like Merchant",
    Callback = function()
        Window:Dialog({
            Title = "Sell all your fish??",
            Content = "Do you really want to sell them all??",
            Buttons = {
                {
                    Title = "Yes!",
                    Callback = function()
                         game:GetService("ReplicatedStorage").events.SellAll:InvokeServer()
                    end
                },
                {
                    Title = "Nuhh Uhh",
                    Callback = function()
                        -- Optional: Code for this button
                    end
                }
            }
        })
    end
})


-------------------------------APPRAISE




------------------------------------------------------------------------SERVER----------------------------------------------------------------------------
        Tabs.Server:AddButton({
    Title = "Rejoin",
    Description = "Rejoining on this current server",
    Callback = function()
        Window:Dialog({
            Title = "Rejoin this server?",
            Content = "Do you want to rejoin this server? ",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        game.Players.LocalPlayer:Kick("\nYou have been Banned! Skibidi Exploiter!!")
                        wait()
                        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                    end
                }
            }
        })
    end
})

Tabs.Server:AddButton({
            Title = "Serverhop",
            Description = "Join to another server",
            Callback = function()
                Window:Dialog({
                    Title = "Join to another server?",
                    Content = "Do you want to join to another server?",
                    Buttons = {
                        {
                            Title = "Confirm",
                            Callback = function()
                                loadstring(game:HttpGet("https://raw.githubusercontent.com/FreeGamesScript23/Aug2006/main/ServerHop.lua", true))()
            task.wait()
                            end
                        },
                        {
                            Title = "Cancel",
                            Callback = function()
                                
                            end
                        }
                    }
                })
            end
        })
    
------------------------------------------------------------------------SERVER--------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
end
        

local gui = Instance.new("ScreenGui")
gui.Name = "Gui"
gui.Parent = game.CoreGui

local button = Instance.new("ImageButton")
button.Name = "HutaoHub"
button.Parent = gui 
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.BorderColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 0
button.Position = UDim2.new(0, 10, 0, 10)
button.Size = UDim2.new(0, 50, 0, 50)
button.Image = "rbxassetid://17576103507"
button.ScaleType = Enum.ScaleType.Crop

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)  
UICorner.Parent = button

local isOpen = false
local isDraggable = false
local dragConnection

button.MouseButton1Click:Connect(function()
        Window:Minimize()
end)

function setDraggable(draggable)
        if draggable then
            button.Draggable = true 
        else
            button.Draggable = false
        end
end

function toggleButtonVisibility(visible)
        button.Visible = visible
end

Tabs.Settings:AddParagraph({
            Title = "To open Window from Chat just say:",
            Content = "/e ash"
        })

function fetchAvatarUrl(userId)
    local url = "https://thumbnails.roblox.com/v1/users/avatar?userIds=" .. userId .. "&size=420x420&format=Png&isCircular=false"
    local response = HttpService:JSONDecode(game:HttpGet(url))
    if response and response.data and #response.data > 0 then
        return response.data[1].imageUrl
    else
        return "https://www.example.com/default-avatar.png" 
    end
    end
    

    local avatarUrl = fetchAvatarUrl(LocalPlayer.UserId)
    

    function getCurrentTime()
    local hour = tonumber(os.date("!%H", os.time() + 8 * 3600)) 
    local minute = os.date("!%M", os.time() + 8 * 3600)
    local second = os.date("!%S", os.time() + 8 * 3600)
    local day = os.date("!%d", os.time() + 8 * 3600)
    local month = os.date("!%m", os.time() + 8 * 3600)
    local year = os.date("!%Y", os.time() + 8 * 3600)
    
    local suffix = "AM"
    if hour >= 12 then
        suffix = "PM"
        if hour > 12 then
            hour = hour - 12
        end
    elseif hour == 0 then
        hour = 12
    end
    
    return string.format("%02d-%02d-%04d %02d:%02d:%02d %s", month, day, year, hour, minute, second, suffix)
    end
    

    local Input = Tabs.Settings:AddInput("Input", {
    Title = "Send FeedBack",
    Default = "",
    Placeholder = "Send your feedback to Candy",
    Numeric = false, 
    Finished = false, 
    Callback = function(Value)
        
    end
    })
    
    function sendFeedbackToDiscord(feedbackMessage)
    local response = request({
        Url = "https://discord.com/api/webhooks/1284715654619861055/BMPZY7FUVk8jmIF3zJtfSLvi1ADaikD9HnCF9m5D1lqJLsmC9UMarH7K6hTA-Nr2iYlZ",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({
            embeds = {{
                title = LocalPlayer.Name .. " (" .. LocalPlayer.UserId .. ")",
                description = "Hi " .. LocalPlayer.Name .. " Send a Feedback! in " .. Ash_Device,
                color = 16711935,
                footer = { text = "Timestamp: " .. getCurrentTime() },
                author = { name = "User Send a Feedback in \nGame Place:\n" .. GameName .. " (" .. game.PlaceId .. ")" },  
                fields = {
                    { name = "Feedback: ", value = feedbackMessage, inline = true }
                },
                thumbnail = {
                    url = avatarUrl
                }
            }}
        })
    })
    
    if response and response.StatusCode == 204 then
        SendNotif("Feedback has been sent to Candy", "Thank you", 3)
    else
        warn("Failed to send feedback to Discord:", response)
    end
    end
    

    local lastFeedbackTime = 0
    local cooldownDuration = 60  
    

    function canSendFeedback()
    local currentTime = os.time()
    return (currentTime - lastFeedbackTime >= cooldownDuration)
    end
    

    function updateLastFeedbackTime()
    lastFeedbackTime = os.time()
    end
    

    Tabs.Settings:AddButton({
    Title = "Send FeedBack",
    Description = "Tap to Send",
    Callback = function()
        if not canSendFeedback() then
            SendNotif("You cant spam this message", "Try again Later Lol", 3)
            return
        end
        
        local feedbackMessage = Input.Value  
        

        if feedbackMessage and feedbackMessage ~= "" then
            sendFeedbackToDiscord(feedbackMessage)
            updateLastFeedbackTime()  
        else
            SendNotif("You cant send empty feedback loll", "Try again later", 3)
        end
    end
    })
    
local DraggableToggle = Tabs.Settings:AddToggle("Draggable Button", {Title = "Draggable Button", Default = false})

DraggableToggle:OnChanged(function(value)
        isDraggable = value
        setDraggable(isDraggable)
end)

local VisibilityToggle = Tabs.Settings:AddToggle("Button Visibility", {Title = "Toggle Window Visibility", Default = true})

VisibilityToggle:OnChanged(function(value)
        toggleButtonVisibility(value)
end)
        
local selectedTheme = "Darker"  -- Default theme
 
-- Dropdown to select a theme
local selectedTheme = "Darker"  --  default  selectedTheme
 
-- Dropdown to select a theme
local Dropdown = Tabs.Settings:AddDropdown("Dropdown", {
    Title = "theme",
    Values = {"Dark", "Darker", "Light", "Aqua", "Amethyst", "Rose"},
    Multi = false,
    Default = 1,
   Callback = function(selected)
    selectedTheme = selected
    Theme = selectedTheme
    print("Darker" .. Theme)
end
})
 
-- Button to change theme
Tabs.Settings:AddButton({
    Title = "Change color)",
    Description = "Choose a theme and change system colors",
    Callback = function()
        -- Change theme according to selected values from Dropdown
        if selectedTheme == "Darker" then
            Theme = "Dark"
        elseif selectedTheme == "Darker" then
            Theme = "Darker"
        elseif selectedTheme == "Light" then
            Theme = "Light"
        elseif selectedTheme == "Aqua" then
            Theme = "Aqua"
        elseif selectedTheme == "Amethyst" then
            Theme = "Amethyst"
        elseif selectedTheme == "Rose" then
            Theme = "Rose"
        else
            -- If no values are selected, use the default theme.
            Theme = "Dark"
        end
 
        -- sample display or change your system theme
        print("selected theme: " .. Theme)
    end
})


SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:SetFolder("")
SaveManager:SetFolder("/Fisch")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

SaveManager:LoadAutoloadConfig()

local TimeEnd = tick()
local TotalTime = math.abs(TimeStart - TimeEnd)
local FormattedTime = string.format("%.2f", TotalTime)
SendNotif("HutaoHub", "Successfully loaded the script in " .. FormattedTime .. "s.", 3)

Window:Minimize()
Window:Minimize()

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
    queueteleport("loadstring(game:HttpGet('https://pastebin.com/raw/ffJG6jq8'))()")
end)