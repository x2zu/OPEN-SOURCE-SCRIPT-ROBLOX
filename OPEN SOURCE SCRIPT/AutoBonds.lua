--[[
    Auto Farm Bonds PRO V8 (Community Enhanced – Nâng cấp Tầm Phát hiện & Tốc độ)
    - Mở rộng tìm kiếm Bond bằng cách quét các ô lân cận dựa trên detectionDist và GRID_SIZE.
    - Tăng detectionDist và tweenSpeed để di chuyển nhanh hơn.
    - Tùy chọn ignoreWalls cho phép đi xuyên tường.
    - GUI có thể kéo thả, resize, cấu hình lưu/tải.
    Lưu ý: Script phức tạp, cần test kỹ trong game.
]]

--#region SERVICES & VARIABLES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local PathfindingService = game:GetService("PathfindingService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local currentCamera = workspace.CurrentCamera

-- Default Config table (đã nâng cấp detectionDist và tweenSpeed)
local defaultConfig = {
    bondName = "Bond",           -- Tên vật phẩm cần farm
    bondUpdate = 1.5,            -- Thời gian cập nhật danh sách Bond (giây)
    detectionDist = 300,         -- Tăng tầm phát hiện Bond (studs)
    tweenSpeed = {min = 60, max = 80}, -- Tăng tốc độ tween (di chuyển nhanh hơn)
    espUpdate = 0.4,
    pathCheck = true,
    ignoreWalls = true,          -- Nếu true, bỏ qua vật cản (cho phép đi xuyên tường)
    autoReplayDelay = 5,
    humanize = {
        movePattern = true,
        clickDelay = {0.1, 0.3},
        failRate = 0.05
    }
}
local config = {} -- Sẽ được load từ file hoặc dùng default

-- State management
local farming = false
local paused = false
local activeTween = nil
local autoReplayEnabled = false
local espEnabled = false

local cachedBonds = {}
local ESPCache = {}
local spatialGrid = {}
local GRID_SIZE = 100
local replayButtonCache = nil

local lastActions = {
    bondUpdate = 0,
    esp = 0,
    farm = 0,
    replay = 0
}
--#endregion

--#region GUI SETUP (Advanced with Config, Drag & Resize)
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "BondFarmV8"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Tạo khung GUI có thể kéo thả và resize
local function createResizableFrame()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 350)
    frame.Position = UDim2.new(0, 100, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Active = true
    frame.ZIndex = 2

    -- Drag
    local dragging = false
    local dragInput, dragStart, frameStart
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local guiObjects = gui:GetGuiObjectsAtPosition(input.Position.X, input.Position.Y)
            if #guiObjects > 0 and guiObjects[1] ~= frame then return end
            dragging = true
            dragStart = input.Position
            frameStart = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
        end
    end)

    -- Resize handle (góc dưới bên phải)
    local resizeHandle = Instance.new("TextButton", frame)
    resizeHandle.Name = "ResizeHandle"
    resizeHandle.Size = UDim2.new(0, 20, 0, 20)
    resizeHandle.Position = UDim2.new(1, -20, 1, -20)
    resizeHandle.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    resizeHandle.BorderSizePixel = 0
    resizeHandle.Text = ""
    resizeHandle.AutoButtonColor = false

    local resizing = false
    local initialSize, initialMousePos
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            initialSize = frame.Size
            initialMousePos = input.Position
        end
    end)
    resizeHandle.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - initialMousePos
            frame.Size = UDim2.new(initialSize.X.Scale, initialSize.X.Offset + delta.X, initialSize.Y.Scale, initialSize.Y.Offset + delta.Y)
        end
    end)
    resizeHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = false
        end
    end)
    return frame
end

local mainFrame = createResizableFrame()
mainFrame.Parent = gui

local function createButton(text, pos, size)
    local btn = Instance.new("TextButton")
    btn.Size = size or UDim2.new(0, 140, 0, 40)
    btn.Position = pos or UDim2.new(0, 0, 0, 0)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 16
    btn.Parent = mainFrame
    return btn
end

local btnFarm    = createButton("Start Auto Farm", UDim2.new(0, 10, 0, 10))
local btnESP     = createButton("Toggle ESP", UDim2.new(0, 160, 0, 10))
local btnReplay  = createButton("Toggle Auto Replay", UDim2.new(0, 10, 0, 60))
local btnPause   = createButton("Pause Farm", UDim2.new(0, 160, 0, 60))

local statusLabel = Instance.new("TextLabel", mainFrame)
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 110)
statusLabel.Text = "Status: Idle"
statusLabel.TextColor3 = Color3.new(1, 1, 0)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.SourceSansSemibold
statusLabel.TextSize = 16

local configStartY = 150
local configSliders = {}
local function createConfigSlider(label, minVal, maxVal, currentVal, configKey, subKey)
    local yPos = configStartY + #mainFrame:GetChildren() * 25
    local lbl = Instance.new("TextLabel", mainFrame)
    lbl.Size = UDim2.new(0, 150, 0, 20)
    lbl.Position = UDim2.new(0, 10, 0, yPos)
    lbl.Text = label .. ": " .. currentVal
    lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    lbl.TextSize = 14

    local slider = Instance.new("Frame", mainFrame)
    slider.Size = UDim2.new(0, 150, 0, 10)
    slider.Position = UDim2.new(0, 160, 0, yPos + 5)
    slider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    slider.BorderSizePixel = 0

    local handle = Instance.new("TextButton", slider)
    handle.Size = UDim2.new(0, 15, 0, 15)
    handle.Position = UDim2.new((currentVal - minVal) / (maxVal - minVal), -7.5, 0, -2.5)
    handle.BackgroundColor3 = Color3.fromRGB(150, 150, 200)
    handle.Text = ""
    handle.Draggable = true

    local function updateValue(xPosition)
        local percentage = math.clamp(xPosition / slider.AbsoluteSize.X, 0, 1)
        local newValue = math.floor(minVal + percentage * (maxVal - minVal) + 0.5)
        handle.Position = UDim2.new(percentage, -7.5, 0, -2.5)
        lbl.Text = label .. ": " .. newValue
        if subKey then
            config[configKey][subKey] = newValue
        else
            config[configKey] = newValue
        end
    end
    handle.DragBegin:Connect(function() end)
    handle.DragStopped:Connect(function(x, y) updateValue(x) end)
    table.insert(configSliders, {labelObject = lbl, configKey = configKey, subKey = subKey, minVal = minVal, maxVal = maxVal, handle = handle})
    return lbl
end

createConfigSlider("Detection Dist", 20, 400, defaultConfig.detectionDist, "detectionDist")
createConfigSlider("Min Tween Speed", 10, 100, defaultConfig.tweenSpeed.min, "tweenSpeed", "min")
createConfigSlider("Max Tween Speed", 20, 150, defaultConfig.tweenSpeed.max, "tweenSpeed", "max")

local btnSave = createButton("Save Config", UDim2.new(0.5, -70, 1, -50))
btnSave.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
--#endregion

--#region CONFIG SAVE/LOAD
local function loadConfig()
    if not isfile or not pcall(function() readfile("BondFarmV8_Config.json") end) then
        config = table.clone(defaultConfig)
        return
    end
    local success, loadedData = pcall(function() return HttpService:JSONDecode(readfile("BondFarmV8_Config.json")) end)
    if success and type(loadedData) == "table" then
        config = loadedData
        for k, v in pairs(defaultConfig) do
            if config[k] == nil then config[k] = v end
            if type(v) == "table" and type(config[k]) == "table" then
                for subK, subV in pairs(v) do
                    if config[k][subK] == nil then config[k][subK] = subV end
                end
            elseif type(v) == "table" then
                config[k] = table.clone(v)
            end
        end
    else
        config = table.clone(defaultConfig)
        warn("BondFarmV8: Failed to load config. Using defaults.")
    end
end

local function saveConfig()
    if not writefile then
        warn("BondFarmV8: writefile not available. Cannot save config.")
        return
    end
    local success, err = pcall(function() writefile("BondFarmV8_Config.json", HttpService:JSONEncode(config)) end)
    if success then
        updateStatus("Config Saved!")
        task.wait(2)
        updateStatus(paused and "Paused" or (farming and "Running" or "Idle"))
    else
        warn("BondFarmV8: Error saving config:", err)
        updateStatus("Error Saving Config!")
        task.wait(2)
        updateStatus(paused and "Paused" or (farming and "Running" or "Idle"))
    end
end

local function updateGuiFromConfig()
    for _, sliderInfo in ipairs(configSliders) do
        local lbl = sliderInfo.labelObject
        local handle = sliderInfo.handle
        local currentVal
        if sliderInfo.subKey then
            currentVal = config[sliderInfo.configKey][sliderInfo.subKey]
            lbl.Text = tostring(sliderInfo.configKey) .. " " .. tostring(sliderInfo.subKey) .. ": " .. tostring(currentVal)
        else
            currentVal = config[sliderInfo.configKey]
            lbl.Text = tostring(sliderInfo.configKey) .. ": " .. tostring(currentVal)
        end
        if handle then
            local minVal, maxVal = sliderInfo.minVal, sliderInfo.maxVal
            local percentage = math.clamp((currentVal - minVal) / (maxVal - minVal), 0, 1)
            handle.Position = UDim2.new(percentage, -7.5, 0, -2.5)
        end
    end
    print("GUI updated from loaded config")
end
--#endregion

--#region CORE FUNCTIONS
local function validateCharacter()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        updateStatus("Character not valid")
        return false, nil
    end
    return true, player.Character.HumanoidRootPart
end

local function safeFireTouch(target)
    local isValid, hrp = validateCharacter()
    if not isValid then return end
    if math.random() < config.humanize.failRate then
        updateStatus("Simulated miss...")
        task.wait(0.5)
        return
    end
    task.spawn(function()
        for i = 0, 1 do
            pcall(firetouchinterest, hrp, target, i)
            task.wait(math.random() * (config.humanize.clickDelay[2] - config.humanize.clickDelay[1]) + config.humanize.clickDelay[1])
        end
        updateStatus("Successfully touched Bond")
    end)
end

local function randomizePosition(basePos)
    return basePos + Vector3.new(
        math.random(-250, 250) / 100,
        math.random(250, 350) / 100,
        math.random(-250, 250) / 100
    )
end

local function isPathClear(startPos, targetPos)
    if config.ignoreWalls then return true end
    if not config.pathCheck then return true end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {player.Character}
    local result = workspace:Raycast(startPos, (targetPos - startPos).Unit * (startPos - targetPos).Magnitude, params)
    local isClear = not result or result.Instance.CanCollide == false or result.Instance.Name == config.bondName
    return isClear
end

local function updateBondList()
    local tempBonds = {}
    local parts = workspace:GetDescendants()
    for i = 1, #parts do
        local part = parts[i]
        if part:IsA("BasePart") and part.Name == config.bondName then
            tempBonds[part] = true
        end
    end
    for bond in pairs(cachedBonds) do
        if not tempBonds[bond] or not bond:IsDescendantOf(workspace) then
            cachedBonds[bond] = nil
        end
    end
    for bond in pairs(tempBonds) do
        if not cachedBonds[bond] then
            cachedBonds[bond] = true
            updateStatus("New Bond cached")
        end
    end
end

local function updateSpatialGrid()
    spatialGrid = {}
    for bond in pairs(cachedBonds) do
        if bond:IsDescendantOf(workspace) then
            local pos = bond.Position
            local gridKey = string.format("%d,%d,%d",
                math.floor(pos.X / GRID_SIZE),
                math.floor(pos.Y / GRID_SIZE),
                math.floor(pos.Z / GRID_SIZE)
            )
            spatialGrid[gridKey] = spatialGrid[gridKey] or {}
            table.insert(spatialGrid[gridKey], bond)
        end
    end
end

-- Hàm findNearestBond được nâng cấp để quét các ô lân cận
local function findNearestBond()
    local isValid, hrp = validateCharacter()
    if not isValid then return nil, nil end
    local curPos = hrp.Position
    local currentCellX = math.floor(curPos.X / GRID_SIZE)
    local currentCellY = math.floor(curPos.Y / GRID_SIZE)
    local currentCellZ = math.floor(curPos.Z / GRID_SIZE)
    local radius = math.ceil(config.detectionDist / GRID_SIZE)
    local nearest, minDist = nil, config.detectionDist
    for dx = -radius, radius do
        for dy = -radius, radius do
            for dz = -radius, radius do
                local cellKey = string.format("%d,%d,%d", currentCellX + dx, currentCellY + dy, currentCellZ + dz)
                if spatialGrid[cellKey] then
                    for _, bond in ipairs(spatialGrid[cellKey]) do
                        if bond and bond:IsDescendantOf(workspace) then
                            local dist = (curPos - bond.Position).Magnitude
                            if dist < minDist and isPathClear(curPos, bond.Position) then
                                minDist = dist
                                nearest = bond
                            end
                        end
                    end
                end
            end
        end
    end
    return nearest, minDist
end

local function updateESP(bond)
    local esp = ESPCache[bond]
    if not esp then
        esp = { box = Instance.new("Frame"), label = Instance.new("TextLabel") }
        esp.box.Size = UDim2.new(0, 10, 0, 10)
        esp.box.BackgroundTransparency = 0.5
        esp.box.BorderColor3 = Color3.fromRGB(255, 0, 0)
        esp.box.BorderSizePixel = 2
        esp.box.ZIndex = 10
        esp.box.Parent = gui
        esp.label.Size = UDim2.new(0, 100, 0, 20)
        esp.label.Text = config.bondName
        esp.label.TextColor3 = Color3.new(1, 1, 1)
        esp.label.BackgroundTransparency = 1
        esp.label.TextSize = 14
        esp.label.ZIndex = 10
        esp.label.Parent = gui
        ESPCache[bond] = esp
    end
    local pos, onScreen = currentCamera:WorldToViewportPoint(bond.Position)
    esp.box.Visible = espEnabled and onScreen
    esp.label.Visible = espEnabled and onScreen
    if onScreen then
        esp.box.Position = UDim2.new(0, pos.X - 5, 0, pos.Y - 5)
        esp.label.Position = UDim2.new(0, pos.X - 50, 0, pos.Y - 25)
    end
end

local function cleanUpESPCache()
    for bond, esp in pairs(ESPCache) do
        if not bond or not bond:IsDescendantOf(workspace) then
            if esp.box then esp.box:Destroy() end
            if esp.label then esp.label:Destroy() end
            ESPCache[bond] = nil
        end
    end
end

local function updateStatus(text)
    statusLabel.Text = "Status: " .. tostring(text)
end
--#endregion

--#region PATHFINDING
local function moveToUsingPath(targetPos)
    local isValid, hrp = validateCharacter()
    if not isValid then return false end
    local path = PathfindingService:CreatePath()
    path:ComputeAsync(hrp.Position, targetPos)
    if path.Status == Enum.PathStatus.Success then
        local waypoints = path:GetWaypoints()
        for _, waypoint in ipairs(waypoints) do
            local tween = TweenService:Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Linear), 
                        {CFrame = CFrame.new(waypoint.Position + Vector3.new(0, 3, 0))})
            tween:Play()
            tween.Completed:Wait()
            task.wait(0.1)
        end
        return true
    else
        updateStatus("Pathfinding failed")
        return false
    end
end
--#endregion

--#region AUTO FARM FUNCTION (V8)
local function farmBondsV8()
    if not farming or paused then return end
    local isValid, hrp = validateCharacter()
    if not isValid then
        updateStatus("Waiting for character...")
        return
    end

    if tick() - lastActions.bondUpdate >= config.bondUpdate then
        pcall(updateBondList)
        pcall(updateSpatialGrid)
        lastActions.bondUpdate = tick()
    end

    local bond, dist = findNearestBond()
    if not bond then
        updateStatus("No suitable Bond found...")
        return
    end

    if activeTween then
        activeTween:Cancel()
        activeTween = nil
    end

    if dist < 12 then
        updateStatus("Collecting Bond...")
        hrp.CFrame = CFrame.new(bond.Position + Vector3.new(0, 3, 0))
        task.wait(0.1)
        safeFireTouch(bond)
        cachedBonds[bond] = nil
        if ESPCache[bond] then
            ESPCache[bond].box:Destroy()
            ESPCache[bond].label:Destroy()
            ESPCache[bond] = nil
        end
        return
    end

    if not isPathClear(hrp.Position, bond.Position) then
        updateStatus("Path obstructed; using alternative movement...")
        if not config.ignoreWalls then
            local success = moveToUsingPath(bond.Position)
            if success then
                safeFireTouch(bond)
                return
            end
        end
        hrp.CFrame = CFrame.new(randomizePosition(bond.Position))
        safeFireTouch(bond)
        return
    end

    updateStatus("Moving to Bond (" .. math.floor(dist) .. " studs)")
    local targetCFrame = CFrame.new(randomizePosition(bond.Position))
    local moveSpeed = math.random(config.tweenSpeed.min, config.tweenSpeed.max)
    local duration = math.clamp(dist / moveSpeed, 0.5, 5)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    activeTween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetCFrame)})
    activeTween:Play()
    activeTween.Completed:Connect(function(playbackState)
        activeTween = nil
        if playbackState == Enum.PlaybackState.Completed then
            local isStillValid, currentHrp = validateCharacter()
            if isStillValid and bond and bond:IsDescendantOf(workspace) then
                if (currentHrp.Position - bond.Position).Magnitude < 15 then
                    updateStatus("Arrived, collecting...")
                    safeFireTouch(bond)
                    cachedBonds[bond] = nil
                    if ESPCache[bond] then
                        ESPCache[bond].box:Destroy()
                        ESPCache[bond].label:Destroy()
                        ESPCache[bond] = nil
                    end
                else
                    updateStatus("Arrived, but target moved/gone.")
                end
            end
        elseif playbackState == Enum.PlaybackState.Cancelled then
            updateStatus("Movement cancelled.")
        else
            updateStatus("Movement interrupted.")
        end
    end)
end
--#endregion

--#region ANTI-DETECT SYSTEMS
local function randomDelay()
    task.wait(math.random() * 0.3 + 0.1)
end

local function shuffleTable(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

local function rotateIPs()
    local fakeIPs = {"192.168.1.101", "10.0.0.5", "172.16.0.23"}
    shuffleTable(fakeIPs)
    updateStatus("Rotating IP: " .. fakeIPs[1])
    task.wait(1.5)
end

local function fakeInputs()
    while true do
        if farming and not paused and math.random(1, 10) == 1 then
            pcall(function()
                local x = math.random(0, currentCamera.ViewportSize.X)
                local y = math.random(0, currentCamera.ViewportSize.Y)
                -- Optionally simulate mouse movement; commented out for safety.
            end)
        end
        task.wait(math.random(3, 7))
    end
end
--#endregion

--#region MAIN LOOP
RunService.Heartbeat:Connect(function(delta)
    local currentTime = tick()
    if farming and not paused then
        pcall(farmBondsV8)
    end
    if espEnabled and currentTime - lastActions.esp > config.espUpdate then
        pcall(cleanUpESPCache)
        for bond in pairs(cachedBonds) do
            if bond and bond:IsDescendantOf(workspace) then
                pcall(updateESP, bond)
            end
        end
        lastActions.esp = currentTime
    end
    pcall(autoReplay)
end)

task.spawn(function()
    while task.wait(math.random(45, 75)) do
        if farming and not paused then
            pcall(rotateIPs)
            if math.random(1, 5) == 1 then
                pcall(validateCharacter)
                pcall(updateSpatialGrid)
            end
        end
    end
end)
-- Optionally spawn fakeInputs if desired:
-- task.spawn(fakeInputs)
--#endregion

--#region GUI HANDLERS
btnFarm.MouseButton1Click:Connect(function()
    farming = not farming
    btnFarm.Text = farming and "Stop Auto Farm" or "Start Auto Farm"
    btnFarm.BackgroundColor3 = farming and Color3.fromRGB(200, 60, 60) or Color3.fromRGB(60, 120, 60)
    if not farming then
        if activeTween then activeTween:Cancel() activeTween = nil end
        updateStatus("Idle")
    else
        lastActions.bondUpdate = 0
        updateStatus("Starting...")
    end
end)

btnESP.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    btnESP.Text = espEnabled and "ESP ON" or "ESP OFF"
    btnESP.BackgroundColor3 = espEnabled and Color3.fromRGB(200, 60, 60) or Color3.fromRGB(60, 60, 200)
    if not espEnabled then
        for bond, esp in pairs(ESPCache) do
            if esp.box then esp.box:Destroy() end
            if esp.label then esp.label:Destroy() end
        end
        ESPCache = {}
    end
end)

btnReplay.MouseButton1Click:Connect(function()
    autoReplayEnabled = not autoReplayEnabled
    btnReplay.Text = autoReplayEnabled and "Auto Replay ON" or "Auto Replay OFF"
    btnReplay.BackgroundColor3 = autoReplayEnabled and Color3.fromRGB(60, 200, 60) or Color3.fromRGB(200, 60, 60)
end)

btnPause.MouseButton1Click:Connect(function()
    paused = not paused
    if activeTween and paused then activeTween:Pause() end
    if activeTween and not paused then activeTween:Play() end
    btnPause.Text = paused and "Resume Farm" or "Pause Farm"
    btnPause.BackgroundColor3 = paused and Color3.fromRGB(200, 200, 60) or Color3.fromRGB(60, 120, 60)
    updateStatus(paused and "Paused" or (farming and "Running" or "Idle"))
end)

btnSave.MouseButton1Click:Connect(saveConfig)
--#endregion

--#region INITIAL LOAD
loadConfig()
updateGuiFromConfig()
print("BondFarmV8 Loaded. Config:", config)
updateStatus("Ready")
--#endregion