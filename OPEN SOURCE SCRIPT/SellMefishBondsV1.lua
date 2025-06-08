--==============================================================
--  Bond‑Auto‑Farm (MaximGun‑Version, mit modifiziertem Air‑Teleport)
--  ▸ Fullscreen‑Blocker & Anti‑Tamper
--  ▸ CoreGui‑Hiding (für *alle* CoreGuis)
--  ▸ Komplette Control‑Sperre (Tastatur, Maus, Kamera, Bewegung)
--  ▸ Initialer Air‑Teleport (2 Sek.) direkt nach Sitzen in die MaximGun
--  ▸ Air‑Teleport (1 Sek.) alle 5 eingesammelten Bonds
--==============================================================

--// Streaming & Sim‑Radius ------------------------------------
pcall(function()
    workspace.StreamingEnabled  = false
    workspace.SimulationRadius   = math.huge
end)

--// Services --------------------------------------------------
local Players      = game:GetService("Players")
local Replicated   = game:GetService("ReplicatedStorage")
local Workspace    = game:GetService("Workspace")
local Lighting     = game:GetService("Lighting")
local StarterGui   = game:GetService("StarterGui")
local CAS          = game:GetService("ContextActionService")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

--// Player‑Objekte --------------------------------------------
local Player   = Players.LocalPlayer
local char     = Player.Character or Player.CharacterAdded:Wait()
local hrp      = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

--// Remotes ---------------------------------------------------
local ActivateRemote    = Replicated:WaitForChild("Packages")
                                     :WaitForChild("RemotePromise")
                                     :WaitForChild("Remotes")
                                     :WaitForChild("C_ActivateObject")
local EndDecisionRemote = Replicated:WaitForChild("Remotes")
                                     :WaitForChild("EndDecision")

--// Executor‑Hilfen ------------------------------------------
local queue_on_tp = (syn and syn.queue_on_teleport)
                 or queue_on_teleport
                 or (fluxus and fluxus.queue_on_teleport)

--// Daten‑Container ------------------------------------------
local bondData, seenKeys, collectedKeys = {}, {}, {}
local collectedCt = 0
local startTime   = tick()

--// Overlay‑Referenzen ---------------------------------------
local overlayGui, statusLabel, foundLabel, collectedLabel, estimatedLabel, discordBtn, copiedLabel

---------------------------------------------------------------
--  Overlay‑GUI (Fullscreen‑Blocker + Anti‑Tamper)            --
---------------------------------------------------------------
local function createOverlay()
    if overlayGui then return end

    -- alten Blur entfernen
    local oldBlur = Lighting:FindFirstChild("OverlayBlur")
    if oldBlur then oldBlur:Destroy() end

    overlayGui = Instance.new("ScreenGui")
    overlayGui.Name           = "BondOverlay"
    overlayGui.Parent         = Player:WaitForChild("PlayerGui")
    overlayGui.IgnoreGuiInset = true
    overlayGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    overlayGui.DisplayOrder   = 9999
    overlayGui.ResetOnSpawn   = false

    -- Vollflächiger Blocker
    local blocker = Instance.new("Frame", overlayGui)
    blocker.Name                   = "ScreenBlocker"
    blocker.Size                   = UDim2.new(1,0,1,0)
    blocker.BackgroundTransparency = 1
    local blkGrad = Instance.new("UIGradient", blocker)
    blkGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(20,20,20)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(40,40,40)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(20,20,20))
    }
    blkGrad.Rotation = 90

    -- Container mit Neon‑Akzent
    local container = Instance.new("Frame", overlayGui)
    container.Name                   = "ModernContainer"
    container.AnchorPoint            = Vector2.new(0.5,0.5)
    container.Position              = UDim2.new(0.5,0,0.5,0)
    container.Size                   = UDim2.new(0.4,0,0.4,0)
    container.BackgroundTransparency = 1.3
    container.BackgroundColor3       = Color3.fromRGB(15,15,30)
    local bgGrad = Instance.new("UIGradient", container)
    bgGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15,15,30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30,15,45))
    }
    bgGrad.Rotation = 90
    local padding = Instance.new("UIPadding", container)
    padding.PaddingLeft   = UDim.new(0,24)
    padding.PaddingRight  = UDim.new(0,24)
    padding.PaddingTop    = UDim.new(0,16)
    padding.PaddingBottom = UDim.new(0,16)
    Instance.new("UIAspectRatioConstraint", container).AspectRatio = 1.0
    Instance.new("UICorner", container).CornerRadius = UDim.new(0,20)
    local stroke = Instance.new("UIStroke", container)
    stroke.Color        = Color3.fromRGB(120,50,200)
    stroke.Transparency = 1.5
    stroke.Thickness    = 2
    local layout = Instance.new("UIListLayout", container)
    layout.Padding             = UDim.new(0,12)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment   = Enum.VerticalAlignment.Top

    local function makeLabel(name, text, size)
        local lbl = Instance.new("TextLabel", container)
        lbl.Name                   = name
        lbl.Size                   = UDim2.new(1,-20,0,size+14)
        lbl.BackgroundTransparency = 1
        lbl.Font                   = Enum.Font.GothamSemibold
        lbl.TextColor3             = Color3.fromRGB(225,225,255)
        lbl.TextSize               = size
        lbl.Text                   = text
        lbl.TextStrokeTransparency = 1.7
        lbl.TextStrokeColor3       = Color3.fromRGB(80,40,200)
        local tsc = Instance.new("UITextSizeConstraint", lbl)
        tsc.MinTextSize, tsc.MaxTextSize = size-4, size+4
        return lbl
    end

    statusLabel    = makeLabel("StatusLabel",    "Status: Initializing...", 24)
    foundLabel     = makeLabel("FoundLabel",     "Bonds found: 0",         20)
    collectedLabel = makeLabel("CollectedLabel", "Bonds collected: 0",     20)
    estimatedLabel = makeLabel("EstimatedLabel","Estimated Bonds/hr: 0",  20)

    discordBtn = Instance.new("TextButton", container)
    discordBtn.Name       = "DiscordButton"
    discordBtn.Size       = UDim2.new(1,0,0,36)
    discordBtn.Font       = Enum.Font.GothamBold
    discordBtn.TextSize   = 20
    discordBtn.TextColor3 = Color3.fromRGB(255,255,255)
    discordBtn.Text       = "discord.gg/KQMzeSpNbY"
    local btnGrad = Instance.new("UIGradient", discordBtn)
    btnGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100,50,200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200,80,150))
    }
    btnGrad.Rotation = 45
    Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0,12)
    local btnStroke = Instance.new("UIStroke", discordBtn)
    btnStroke.Color        = Color3.fromRGB(150,80,220)
    btnStroke.Transparency = 1.4
    btnStroke.Thickness    = 2
    TweenService:Create(discordBtn, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()

    copiedLabel = makeLabel("CopiedLabel","Link copied!",18)
    copiedLabel.TextColor3 = Color3.fromRGB(0,255,200)
    copiedLabel.Visible    = false

    makeLabel("CreditLeft","Made by cyberseall",16).TextXAlignment   = Enum.TextXAlignment.Left
    makeLabel("CreditRight","(Rejoin If its not collecting) Credits to: Levi",16).TextXAlignment = Enum.TextXAlignment.Right

    -- Anti‑Tamper: jegliche Manipulation → Kick
    local function kick(reason) Player:Kick(reason or "UI‑Tampering detected SKID") end
    overlayGui.AncestryChanged:Connect(function(_, parent)
        if parent ~= Player:FindFirstChild("PlayerGui") then kick("Overlay moved/removed SKID") end
    end)
    overlayGui:GetPropertyChangedSignal("Enabled"):Connect(function()
        if not overlayGui.Enabled then kick("Overlay disabled SKID") end
    end)
    overlayGui.DescendantRemoving:Connect(function() kick("Overlay element deleted SKID") end)
    local pg = Player:WaitForChild("PlayerGui")
    pg.AncestryChanged:Connect(function(_, parent)
        if not parent then kick("PlayerGui removed SKID") end
    end)
    pg.ChildAdded:Connect(function(c)
        if c ~= overlayGui and c.Name == overlayGui.Name then kick("Overlay cloned SKID") end
    end)
end

createOverlay()

---------------------------------------------------------------
--  Overlay‑Helper‑Funktionen                                 --
---------------------------------------------------------------
local function setStatus(t)    if statusLabel    then statusLabel.Text    = "Status: "..t end end
local function setFound(n)     if foundLabel     then foundLabel.Text     = "Bonds found: "..n end end
local function setCollected(n)
    if collectedLabel then
        collectedLabel.Text = "Bonds collected: "..n
        if estimatedLabel then
            local elapsed = tick() - startTime
            local rate    = elapsed>0 and (n/elapsed*3600) or 0
            estimatedLabel.Text = string.format("Estimated Bonds/hr: %.1f", rate)
        end
    end
end

discordBtn.MouseButton1Click:Connect(function()
    pcall(setclipboard, "https://discord.gg/KQMzeSpNbY")
    copiedLabel.Visible = true
    task.delay(2, function() copiedLabel.Visible = false end)
end)

---------------------------------------------------------------
--  Bond‑Erfassung                                            --
---------------------------------------------------------------
local function recordBonds()
    local runtime = Workspace:WaitForChild("RuntimeItems")
    for _, item in ipairs(runtime:GetChildren()) do
        if item.Name:match("Bond") then
            local part = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if part then
                local key = string.format("%.1f_%.1f_%.1f",
                    part.Position.X, part.Position.Y, part.Position.Z)
                if not seenKeys[key] then
                    seenKeys[key] = true
                    table.insert(bondData, { item = item, pos = part.Position, key = key })
                end
            end
        end
    end
    setFound(#bondData)
end

---------------------------------------------------------------
--  Map‑Scan                                                  --
---------------------------------------------------------------
setStatus("Map Scanning")
local scanTarget  = CFrame.new(-424.449,26.055,-49040.656)
local steps, pauseScan, extraWait = 50, 0.3, 0.1
for i = 1, steps do
    hrp.CFrame = CFrame.new(hrp.Position:Lerp(scanTarget.Position, i/steps))
    task.wait(pauseScan)
    recordBonds()
    task.wait(extraWait)
end
hrp.CFrame = scanTarget
task.wait(pauseScan); recordBonds(); task.wait(extraWait)
repeat
    local before = #bondData
    recordBonds()
    task.wait(0.3)
until #bondData == before

---------------------------------------------------------------
--  Teleport zur MaximGun                                     --
---------------------------------------------------------------
setStatus("Teleporting to MaximGun")
local maximGun = Workspace:WaitForChild("RuntimeItems"):FindFirstChild("MaximGun")
assert(maximGun, "Kein Objekt 'MaximGun' gefunden")
local seat = maximGun:FindFirstChildWhichIsA("VehicleSeat")
          or maximGun:FindFirstChild("Seat")
assert(seat and (seat:IsA("VehicleSeat") or seat:IsA("Seat")),
       "Kein gültiger Seat in MaximGun")

-- Clone‑Teleport
do
    local clone = hrp:Clone()
    clone.Name     = "TP_Clone"
    clone.Parent   = Workspace
    clone.Anchored = true
    clone.CFrame   = seat.CFrame
    task.wait(1)
    hrp.CFrame     = clone.CFrame
    clone:Destroy()
end

-- Hinsetzen
seat:Sit(humanoid)

-- Weld, um HRP permanent an den Sitz zu binden
local weld = Instance.new("WeldConstraint")
weld.Part0  = hrp
weld.Part1  = seat
weld.Parent = hrp

-- Noclip aktivieren, damit Sitz und Spieler nicht mehr mit dem Boden kollidieren
local function enableNoclip(character, seat)
    if seat:IsA("BasePart") then
        seat.CanCollide = false
    end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end
enableNoclip(char, seat)

task.wait(1)

-- Initialer Air‑Teleport 50 Studs hoch, 2 Sekunden halten
seat.CFrame = seat.CFrame + Vector3.new(0,50,0)
task.wait(2)

---------------------------------------------------------------
--  Bonds einsammeln mit modifiziertem Air‑Teleport           --
---------------------------------------------------------------
setStatus("Collecting Bonds")
task.spawn(function()
    local bondsSinceAir = 0
    while true do
        local anyNew = false
        for _, entry in ipairs(bondData) do
            if not collectedKeys[entry.key] then
                anyNew = true
                -- Teleport zum Bond
                seat.CFrame = CFrame.new(entry.pos)
                task.wait(1)
                -- Einsammeln
                if (hrp.Position - entry.pos).Magnitude <= 15 then
                    ActivateRemote:FireServer(entry.item)
                    collectedKeys[entry.key] = true
                    collectedCt += 1
                    bondsSinceAir += 1
                    setCollected(collectedCt)
                    -- Air‑Teleport alle 5 Bonds
                    if bondsSinceAir % 5 == 0 then
                        seat.CFrame = CFrame.new(entry.pos + Vector3.new(0,50,0))
                        task.wait(1)
                    end
                end
            end
        end
        if not anyNew then break end
    end

    -- Abschluss
    setStatus("Done / Automatic Continue")
    task.wait(6)
    humanoid:TakeDamage(999999)

    -- Rückkehr‑Phase
    local rt = Replicated:WaitForChild("ReturnTime")
    rt:GetPropertyChangedSignal("Value"):Wait()
    EndDecisionRemote:FireServer(false)

    -- Auto‑Continue nach Server‑Hop
    if queue_on_tp then
        local loader = [[
            task.delay(math.random(5,10), function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/SellMeFish/nonono/refs/heads/main/test.lua"))()
            end)
        ]]
        queue_on_tp(loader)
    end
end)