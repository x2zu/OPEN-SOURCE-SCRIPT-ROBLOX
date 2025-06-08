
loadstring(game:HttpGet(("https://raw.githubusercontent.com/Shade-vex/shadevex/refs/heads/main/menu-for-you-hub.txt")))()

       local Window = MakeWindow({
         Hub = {
         Title = "Hutao Hub",
         Animation = "Hutao Hub"
         },
        Key = {
        KeySystem = false,
        Title = "Loading Cat V2",
        Description = "Script by Kzu123",
        KeyLink = "https://discord.gg/DmN8sE7Y",
        Keys = {"Loading-Cat-V2"},
        Notifi = {
        Notifications = true,
        CorrectKey = "Đang chạy script...",
       Incorrectkey = "Key không tồn tại",
       CopyKeyLink = "Đã sao chép link",
      }
    }
  })

       MinimizeButton({
       Image = "http://www.roblox.com/asset/?id=96813908648032",   
       Size = {50, 50},
       Color = Color3.fromRGB(10, 10, 10),
       Corner = true,
       Stroke = false,
       StrokeColor = Color3.fromRGB(255, 0, 0)
      })
      
------ Tab

     local Tab1o = MakeTab({Name = "Discord"})
     local Tab2o = MakeTab({Name = "Functions"})
     local Tab4o = MakeTab({Name = "Teleport"})
     local Tab0o = MakeTab({Name = "Player"})
     local Tab3o = MakeTab({Name = "Vision"})
     local Tab5o = MakeTab({Name = "Setting"})


----- Discord


   Section = AddSection(Tab1o, {"Tham gia discord "})          



AddButton(Tab1o, {
    Name = "Discord",
    Callback = function()
        local url = "https://discord.gg/vts37ePM" 

        -- Mở link trên trình duyệt bằng setclipboard
        setclipboard(url)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Mở Discord",
            Text = "Link đã được sao chép vào clipboard! Hãy dán vào trình duyệt.",
            Duration = 5
        })

        -- Kick người chơi khỏi game
        game.Players.LocalPlayer:Kick("Tham gia Discord để tiếp tục sử dụng menu!")
    end
})


   Section = AddSection(Tab1o, {"Script creator"})          
   Section = AddSection(Tab1o, {"• YanghoVN"})          
   Section = AddSection(Tab1o, {"• Kzu123"})          
   Section = AddSection(Tab1o, {"• RimuruHRB"})         




   Section = AddSection(Tab0o, {"Player"})












local ESPEnabled = false
local runService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Hàm tạo ESP 7 màu
local function createHighlight(player)
	if player == Players.LocalPlayer then return end
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	if not char:FindFirstChild("ESP_Highlight") then
		local hl = Instance.new("Highlight")
		hl.Name = "ESP_Highlight"
		hl.FillTransparency = 1
		hl.OutlineTransparency = 0
		hl.Adornee = char
		hl.Parent = char

		-- Rainbow cycle
		local hue = 0
		task.spawn(function()
			while ESPEnabled and hl.Parent == char do
				hue = (hue + 1) % 360
				hl.OutlineColor = Color3.fromHSV(hue / 360, 1, 1)
				task.wait(0.1)
			end
			if hl then hl:Destroy() end
		end)
	end
end

-- Hàm cập nhật tất cả ESP
local function updateAllESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= Players.LocalPlayer then
			createHighlight(p)
		end
	end
end

-- Tự động thêm ESP khi người chơi mới vào hoặc respawn
Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function()
		if ESPEnabled then
			wait(1)
			createHighlight(p)
		end
	end)
end)

for _, p in pairs(Players:GetPlayers()) do
	p.CharacterAdded:Connect(function()
		if ESPEnabled then
			wait(1)
			createHighlight(p)
		end
	end)
end

-- Nút bật/tắt
AddButton(Tab0o, {
	Name = "Player Glows",
	Callback = function()
		ESPEnabled = not ESPEnabled
		if ESPEnabled then
			updateAllESP()
		else
			for _, p in pairs(Players:GetPlayers()) do
				if p.Character and p.Character:FindFirstChild("ESP_Highlight") then
					p.Character.ESP_Highlight:Destroy()
				end
			end
		end
	end
})






       AddButton(Tab0o, {
     Name = "Aimlock Player",
    Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/b/refs/heads/main/Aimlock.txt"))()
  end
  })   







AddButton(Tab0o, {
    Name = "Coercion Weld",
    Callback = function()
        -- Chạy script từ link
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/weld.lua.txt"))()

        -- Hook SetCore để chặn thông báo khác
        local originalSetCore = game:GetService("StarterGui").SetCore
        local blocked = {"SendNotification"}

        hookfunction(originalSetCore, function(self, method, ...)
            if table.find(blocked, method) then
                return -- chặn không cho hiển thị
            end
            return originalSetCore(self, method, ...)
        end)
    end
})










AddButton(Tab0o, {
    Name = "Fly Bypass-Max",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/Script/refs/heads/main/test-fly.txt"))()

        -- Thông báo chính
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Loading 1%",
            Text = "^v^",
            Duration = 3
        })

        -- Thông báo phụ 1
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Loading 50%",
            Text = ":3",
            Duration = 3
        })

        -- Thông báo phụ 2
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Loading 100%",
            Text = "Thank for ON script :>",
            Duration = 3
        })
    end
})






       AddButton(Tab0o, {
     Name = "Indicators",
    Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/GG.txt"))()
  end
  })   









local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local enabled = false
local particles = {}

function createSmoke(part)
	local smoke = Instance.new("ParticleEmitter")
	smoke.Name = "DarkAura"
	smoke.Texture = "rbxassetid://771221224" -- Khí đen
	smoke.Color = ColorSequence.new(Color3.new(0,0,0))
	smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 0)})
	smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 1)})
	smoke.Lifetime = NumberRange.new(1)
	smoke.Rate = 50
	smoke.Speed = NumberRange.new(1, 3)
	smoke.Rotation = NumberRange.new(0, 360)
	smoke.RotSpeed = NumberRange.new(-180, 180)
	smoke.VelocitySpread = 180
	smoke.Parent = part
	table.insert(particles, smoke)
end

function toggleAura()
	enabled = not enabled

	if enabled then
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				createSmoke(part)
			end
		end
	else
		for _, p in ipairs(particles) do
			if p and p.Parent then p:Destroy() end
		end
		particles = {}
	end
end

AddButton(Tab0o, {
	Name = "Dark Aura",
	Callback = function()
		toggleAura()
	end
})






       AddButton(Tab0o, {
     Name = "Aura for player",
    Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/0Happy.txt"))()
  end
  })   



   Section = AddSection(Tab2o, {"Functions"})

       AddButton(Tab2o, {
     Name = "Bypass Anti-cheat",
    Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/bypass%20anti%20cheat.txt"))()
  end
  })




-- Biến kiểm soát
local autoClickEnabled = false
local attackRange = 50 -- Tăng tầm đánh lên 50m

-- Hàm Auto Click
local function startAutoClick()
    autoClickEnabled = not autoClickEnabled

    if autoClickEnabled then
        print("🔹 Auto Click: BẬT")

        spawn(function()
            while autoClickEnabled do
                pcall(function()
                    local vim = game:GetService("VirtualInputManager")
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0) -- Nhấp chuột
                    wait(0.1)
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end)
                wait(0.1)
            end
        end)
    else
        print("🔹 Auto Click: TẮT")
    end
end

-- Hàm Tăng Tầm Đánh
local function extendHitbox()
    local combatFramework = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework)
    local combatData = getupvalues(combatFramework)[2]

    if combatData and combatData.activeController then
        local controller = combatData.activeController
        if controller then
            local rigLib = require(game.ReplicatedStorage.CombatFramework.RigLib)
            rigLib.getBladeHits = function(_, targets, range)
                return rigLib.getBladeHits(_, targets, attackRange) -- Tăng tầm đánh lên 50m
            end
        end
    end
end

-- Kết hợp Auto Click + Tăng Tầm Đánh
local function toggleAutoAttack()
    startAutoClick() -- Bật Auto Click
    extendHitbox() -- Tăng tầm đánh
end

-- Thêm nút bật/tắt vào menu
AddButton(Tab2o, {
    Name = "Melle Attack",
    Callback = function()
        toggleAutoAttack()
    end
})








AddButton(Tab2o, {
    Name = "Gun Aura",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/Gun_Aura_Open_Source.txt"))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Gun Aura [Pro]",
            Text = "Script by RimuruHRB",
            Duration = 3
        })
    end
})




















local runService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local cameraUnlocked = false
local cameraConnection = nil
local characterConnection = nil

local function enableUnlockCamera()
    if cameraConnection then cameraConnection:Disconnect() end
    if characterConnection then characterConnection:Disconnect() end

    cameraConnection = runService.RenderStepped:Connect(function()
        pcall(function()
            if player.CameraMode ~= Enum.CameraMode.Classic then
                player.CameraMode = Enum.CameraMode.Classic
            end
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") then
                if camera.CameraSubject ~= character.Humanoid then
                    camera.CameraSubject = character.Humanoid
                end
            end
        end)
    end)

    -- Mỗi lần hồi sinh thì gắn lại camera
    characterConnection = player.CharacterAdded:Connect(function(char)
        wait(0.2) -- chờ nhân vật load xong
        pcall(function()
            player.CameraMode = Enum.CameraMode.Classic
            local hum = char:WaitForChild("Humanoid", 2)
            if hum then
                camera.CameraSubject = hum
            end
        end)
    end)
end

local function disableUnlockCamera()
    if cameraConnection then cameraConnection:Disconnect() end
    if characterConnection then characterConnection:Disconnect() end
end

AddButton(Tab2o, {
    Name = "Unlock Camera",
    Callback = function()
        cameraUnlocked = not cameraUnlocked
        if cameraUnlocked then
            StarterGui:SetCore("SendNotification", {
                Title = "Unlock Camera ON",
                Text = "script by RimuruHRB",
                Duration = 3
            })
            enableUnlockCamera()
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Unlock Camera OFF",
                Text = "script by RimuruHRB",
                Duration = 3
            })
            disableUnlockCamera()
        end
    end
})







       AddButton(Tab2o, {
     Name = "AimNPC & UnlockCam",
    Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/Dead-Rails-Aimlock-NPC.txt"))()
  end
  })   






--// Biến cần dùng
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local noclipEnabled = false
local noclipConnection
local isCoordVisible = false

--// Nút Bật Noclip
AddButton(Tab2o, {
    Name = "Noclip fix bug",
    Callback = function()
        noclipEnabled = not noclipEnabled
        if noclipEnabled then
            if noclipConnection then noclipConnection:Disconnect() end
            noclipConnection = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            Notify("Noclip", "Đã bật noclip.")
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            Notify("Noclip", "Đã tắt noclip.")
        end
    end
})












local sunEnabled = false
local lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local function applyFullBright()
    lighting.FogEnd = 1e10
    lighting.FogStart = 1e10
    lighting.FogColor = Color3.new(1, 1, 1)
    lighting.Brightness = 4
    lighting.ClockTime = 14
    lighting.TimeOfDay = "14:00:00"
    lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    lighting.GlobalShadows = false

    local atm = lighting:FindFirstChildOfClass("Atmosphere")
    if atm then atm:Destroy() end
end

local function resetLighting()
    lighting.FogEnd = 1000
    lighting.FogStart = 0
    lighting.FogColor = Color3.new(0, 0, 0)
    lighting.Brightness = 1
    lighting.ClockTime = 0
    lighting.OutdoorAmbient = Color3.new(0, 0, 0)
    lighting.GlobalShadows = true
end

local connection

local function toggleSun()
    sunEnabled = not sunEnabled

    if sunEnabled then
        applyFullBright()
        connection = RunService.RenderStepped:Connect(function()
            applyFullBright()
        end)
    else
        if connection then connection:Disconnect() end
        resetLighting()
    end
end

AddButton(Tab2o, {
    Name = "full bright",
    Callback = function()
        toggleSun()
    end
})






--// Nút Bật Tọa Độ
local coordGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
coordGui.Name = "CoordDisplay"
coordGui.Enabled = false

local label = Instance.new("TextLabel", coordGui)
label.Size = UDim2.new(0, 300, 0, 50)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundTransparency = 0.3
label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Text = "Tọa độ: Đang tải..."

RunService.RenderStepped:Connect(function()
    if coordGui.Enabled then
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local pos = hrp.Position
            label.Text = string.format("Tọa độ: X: %.1f | Y: %.1f | Z: %.1f", pos.X, pos.Y, pos.Z)
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    coordGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end)

AddButton(Tab2o, {
    Name = "Coordinates",
    Callback = function()
        isCoordVisible = not isCoordVisible
        coordGui.Enabled = isCoordVisible
        Notify("Toạ độ", isCoordVisible and "Đã bật hiển thị tọa độ." or "Đã tắt hiển thị tọa độ.")
    end
})






local Player = game.Players.LocalPlayer
local Gui = Player:WaitForChild("PlayerGui")

-- Tạo GUI thông báo bị banned
local function showBannedMessage()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = Gui
    screenGui.Name = "BannedGui"
    
    local frame = Instance.new("Frame")
    frame.Parent = screenGui
    frame.Size = UDim2.new(0.5, 0, 0.3, 0)
    frame.Position = UDim2.new(0.25, 0, 0.35, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Màu nền là màu đen thay vì đỏ
    frame.BorderSizePixel = 0
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "HAHA NOOB"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Màu chữ trắng
    label.TextScaled = true
    label.BackgroundTransparency = 1
    
    -- Kết thúc trò chơi sau khi hiển thị thông báo
    wait(0.1) -- Chờ 0.1 giây
    Player:Kick("You have been banned for cheating.")
end

-- Thực hiện fake ban khi người chơi nhập lệnh hoặc sự kiện nào đó
AddButton(Tab2o, {
    Name = "Kill aura",
    Callback = function()
        showBannedMessage()
    end
})        


local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId

local function switchServer()
    local success, servers = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)

    if success and servers and servers.data then
        for _, server in pairs(servers.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                TeleportService:TeleportToPlaceInstance(PlaceId, server.id, game.Players.LocalPlayer)
                return
            end
        end
    end
end

-- Đảm bảo Tab2o tồn tại
if not Tab2o then
    Tab2o = AddTab("Server")
end

-- Tạo nút đổi server
AddButton(
    Tab2o,
    {
        Name = "Change server",
        Callback = function()
            switchServer()
        end
    })



   Section = AddSection(Tab3o, {"Observation Ability"})          





local espEnabled = false -- Trạng thái bật/tắt ESP

local function createESP(player)
    if player == game.Players.LocalPlayer then return end -- Không hiển thị bản thân

    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = character.HumanoidRootPart
    billboard.Size = UDim2.new(0, 200, 0, 50) -- Kích thước mặc định lớn
    billboard.StudsOffset = Vector3.new(0, 3, 0) -- Đặt ở giữa nhân vật
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(0, 255, 0) -- Màu xanh lá 
    textLabel.TextScaled = false
    textLabel.TextSize = 20 -- Giữ nguyên kích thước chữ
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextStrokeTransparency = 0.2 -- Viền chữ giúp dễ nhìn hơn

    billboard.Parent = character.HumanoidRootPart

    -- Cập nhật vị trí & giữ nguyên kích thước theo khoảng cách
    spawn(function()
        while espEnabled and character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") do
            local humanoid = character:FindFirstChild("Humanoid")
            local localPlayer = game.Players.LocalPlayer
            if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (localPlayer.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                
                -- Giữ nguyên kích thước 20 dù ở xa hay gần
                local size = 20
                billboard.Size = UDim2.new(0, size * 10, 0, size * 2)

                -- Hiển thị thông tin máu & khoảng cách
                textLabel.Text = string.format("[%s] HP: %d | %dm", player.Name, math.floor(humanoid.Health), math.floor(distance))
            end
            wait(0.1)
        end
        billboard:Destroy()
    end)
end

-- Hàm bật/tắt ESP
local function toggleESP()
    espEnabled = not espEnabled

    if espEnabled then
        -- Thêm ESP cho tất cả người chơi
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                createESP(player)
            end
        end

        -- Lắng nghe người chơi mới tham gia
        game.Players.PlayerAdded:Connect(function(player)
            if espEnabled then createESP(player) end
        end)
    else
        -- Xóa toàn bộ ESP khi tắt
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for _, gui in pairs(player.Character.HumanoidRootPart:GetChildren()) do
                    if gui:IsA("BillboardGui") then gui:Destroy() end
                end
            end
        end
    end
end

-- Nút bật/tắt ESP
AddButton(Tab3o, {
    Name = "ESP Player",
    Callback = function()
        toggleESP()
    end
})   










local espEnabled = false
local espObjects = {}
local allowedNames = {
    ["NikolaTesla"] = true,
    ["EasterBunny"] = true
}

local function createESP(target)
    local adornee = target:IsA("Model") and target:FindFirstChildWhichIsA("BasePart") or target
    local humanoid = target:FindFirstChildWhichIsA("Humanoid")
    if not adornee or not humanoid then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = adornee
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255) -- Màu trắng
    label.TextStrokeTransparency = 0.2 -- Viền mờ tạo sáng
    label.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 20
    label.Font = Enum.Font.SourceSansBold

    billboard.Parent = game.CoreGui
    table.insert(espObjects, billboard)

    spawn(function()
        while espEnabled and adornee and adornee.Parent and humanoid and humanoid.Health > 0 do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local dist = (char.HumanoidRootPart.Position - adornee.Position).Magnitude
                label.Text = string.format("%s | %d/%d HP | %dm", target.Name, humanoid.Health, humanoid.MaxHealth, math.floor(dist))
            end
            wait(0.2)
        end
        billboard:Destroy()
    end)
end

local function toggleNikolaESP()
    espEnabled = not espEnabled

    if espEnabled then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("Model") or obj:IsA("BasePart")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end

        workspace.DescendantAdded:Connect(function(obj)
            if espEnabled and (obj:IsA("Model") or obj:IsA("BasePart")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end)
    else
        for _, gui in pairs(espObjects) do
            if gui and gui.Parent then
                gui:Destroy()
            end
        end
        espObjects = {}
    end
end

-- Nút bật/tắt
AddButton(Tab3o, {
    Name = "ESP Final Boss",
    Callback = function()
        toggleNikolaESP()
    end
})







local espEnabled = false
local espObjects = {}
local allowedNames = {
    ["Unicorn"] = true
}

local function createGlowEffect(model)
    local glow = Instance.new("Highlight")
    glow.Parent = model
    glow.FillColor = Color3.fromRGB(255, 255, 255) -- Màu trắng
    glow.OutlineColor = Color3.fromRGB(255, 255, 255) -- Màu trắng
    glow.OutlineTransparency = 0.5
    glow.FillTransparency = 0.5
    return glow
end

local function createESP(target)
    local adornee = target:IsA("Model") and target:FindFirstChildWhichIsA("BasePart") or target
    local humanoid = target:FindFirstChildWhichIsA("Humanoid")
    if not adornee or not humanoid then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = adornee
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255) -- Màu trắng
    label.TextStrokeTransparency = 0.2
    label.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 20
    label.Font = Enum.Font.SourceSansBold

    billboard.Parent = game.CoreGui
    table.insert(espObjects, billboard)

    -- Tạo hiệu ứng phát sáng
    local glow = createGlowEffect(target)
    table.insert(espObjects, glow)

    spawn(function()
        while espEnabled and adornee and adornee.Parent and humanoid and humanoid.Health > 0 do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local dist = (char.HumanoidRootPart.Position - adornee.Position).Magnitude
                label.Text = string.format("%s | %d/%d HP | %dm", target.Name, humanoid.Health, humanoid.MaxHealth, math.floor(dist))
            end
            wait(0.2)
        end
        billboard:Destroy()
        if glow and glow.Parent then
            glow:Destroy()
        end
    end)
end

local function toggleUnicornESP()
    espEnabled = not espEnabled

    if espEnabled then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("Model") or obj:IsA("BasePart")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end

        workspace.DescendantAdded:Connect(function(obj)
            if espEnabled and (obj:IsA("Model") or obj:IsA("BasePart")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end)
    else
        for _, gui in pairs(espObjects) do
            if gui and gui.Parent then
                gui:Destroy()
            end
        end
        espObjects = {}
    end
end

-- Nút bật/tắt
AddButton(Tab3o, {
    Name = "ESP Unicorn",
    Callback = function()
        toggleUnicornESP()
    end
})





local espEnabled = false
local espObjects = {}
local allowedNames = {
    ["Vampire"] = true,
    ["Model_RifleOutlaw"] = true,
    ["Model_ShotgunOutlaw"] = true,
    ["Model_RevolverOutlaw"] = true,
    ["Model_Walker"] = true,
    ["Model_Runner"] = true,
    ["Werewolf"] = true
}

local function createESP(target)
    local adornee = target:IsA("Model") and target:FindFirstChildWhichIsA("BasePart") or target
    if not adornee then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = adornee
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 0, 0) -- Màu đỏ
    label.TextStrokeTransparency = 1 -- Không viền
    label.TextSize = 18
    label.Font = Enum.Font.SourceSansBold
    label.Text = target.Name

    billboard.Parent = game.CoreGui
    table.insert(espObjects, billboard)

    spawn(function()
        while espEnabled and adornee and adornee.Parent do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local dist = (char.HumanoidRootPart.Position - adornee.Position).Magnitude
                label.Text = string.format("%s | %dm", target.Name, math.floor(dist))
            end
            wait(0.2)
        end
        billboard:Destroy()
    end)
end

local function toggleNPCEsp()
    espEnabled = not espEnabled

    if espEnabled then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end

        workspace.DescendantAdded:Connect(function(obj)
            if espEnabled and (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end)
    else
        for _, gui in pairs(espObjects) do
            if gui and gui.Parent then
                gui:Destroy()
            end
        end
        espObjects = {}
    end
end

-- Nút bật/tắt
AddButton(Tab3o, {
    Name = "ESP Monster (NPC)",
    Callback = function()
        toggleNPCEsp()
    end
})                      










local espEnabled = false
local espObjects = {}
local allowedNames = {
    ["Wolf"] = true
}

local function createESP(target)
    local adornee = target:IsA("Model") and target:FindFirstChildWhichIsA("BasePart") or target
    if not adornee then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = adornee
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(169, 169, 169) -- Màu xám
    label.TextStrokeTransparency = 1 -- Không viền
    label.TextSize = 18
    label.Font = Enum.Font.SourceSansBold
    label.Text = target.Name

    billboard.Parent = game.CoreGui
    table.insert(espObjects, billboard)

    spawn(function()
        while espEnabled and adornee and adornee.Parent do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local dist = (char.HumanoidRootPart.Position - adornee.Position).Magnitude
                label.Text = string.format("%s | %dm", target.Name, math.floor(dist))
            end
            wait(0.2)
        end
        billboard:Destroy()
    end)
end

local function toggleWolfEsp()
    espEnabled = not espEnabled

    if espEnabled then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end

        workspace.DescendantAdded:Connect(function(obj)
            if espEnabled and (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end)
    else
        for _, gui in pairs(espObjects) do
            if gui and gui.Parent then
                gui:Destroy()
            end
        end
        espObjects = {}
    end
end

-- Nút bật/tắt
AddButton(Tab3o, {
    Name = "ESP Wolf",
    Callback = function()
        toggleWolfEsp()
    end
})                      













local espEnabled = false
local espObjects = {}
local allowedNames = {
    ["Electrocutioner"] = true,
    ["Jade Sword"] = true,
    ["StrangeMask"] = true,
    ["MaximGun"] = true,
    ["Revolver"] = true,
    ["Mauser"] = true,
    ["Navy Revolver"] = true,
    ["Bolt Action Rifle"] = true,
    ["Shotgun"] = true,
    ["Rifle"] = true,
    ["Sawed-Off Shotgun"] = true,
    ["Cavalry Sword"] = true,
    ["Tomahawk"] = true,
    ["Cannon"] = true,
    ["Vampire Knife"] = true,
    ["Holy Water"] = true,
    ["Crucifix"] = true
}

-- Hàm tạo màu 7 sắc cầu vồng
local function rainbowColor(t)
    local r = math.sin(t) * 127 + 128
    local g = math.sin(t + 2) * 127 + 128
    local b = math.sin(t + 4) * 127 + 128
    return Color3.fromRGB(r, g, b)
end

local function createESP(target)
    local adornee = target:IsA("Model") and target:FindFirstChildWhichIsA("BasePart") or target
    if not adornee then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = adornee
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0.2
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextSize = 18
    label.Font = Enum.Font.SourceSansBold
    label.Text = "Vũ khí"

    billboard.Parent = game.CoreGui
    table.insert(espObjects, billboard)

    spawn(function()
        local t = 0
        while espEnabled and adornee and adornee.Parent do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local dist = (char.HumanoidRootPart.Position - adornee.Position).Magnitude
                label.Text = string.format("%s | %dm", target.Name, math.floor(dist))
                label.TextColor3 = rainbowColor(t)
                t = t + 0.1
            end
            wait(0.1)
        end
        billboard:Destroy()
    end)
end

local function toggleWeaponESP()
    espEnabled = not espEnabled

    if espEnabled then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end

        workspace.DescendantAdded:Connect(function(obj)
            if espEnabled and (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end)
    else
        for _, gui in pairs(espObjects) do
            if gui and gui.Parent then
                gui:Destroy()
            end
        end
        espObjects = {}
    end
end

-- Nút bật/tắt
AddButton(Tab3o, {
    Name = "ESP Sword & Gun",
    Callback = function()
        toggleWeaponESP()
    end
})



local espEnabled = false
local espObjects = {}
local allowedNames = {
    RevolverAmmo = true,
    RifleAmmo = true,
    ShotgunShells = true,
    TurretAmmo = true,
    CannonBalls = true
}

local function createESP(target)
    local adornee = target:IsA("Model") and target:FindFirstChildWhichIsA("BasePart") or target
    if not adornee then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = adornee
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 0) -- Chữ vàng
    label.TextStrokeTransparency = 0.2
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextSize = 18
    label.Font = Enum.Font.SourceSansBold
    label.Text = "Ammo"

    billboard.Parent = game.CoreGui
    table.insert(espObjects, billboard)

    spawn(function()
        while espEnabled and adornee and adornee.Parent do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local dist = (char.HumanoidRootPart.Position - adornee.Position).Magnitude
                label.Text = string.format("%s | %dm", target.Name, math.floor(dist))
            end
            wait(0.2)
        end
        billboard:Destroy()
    end)
end

local function toggleAmmoESP()
    espEnabled = not espEnabled

    if espEnabled then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end

        workspace.DescendantAdded:Connect(function(obj)
            if espEnabled and (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end)
    else
        for _, gui in pairs(espObjects) do
            if gui and gui.Parent then
                gui:Destroy()
            end
        end
        espObjects = {}
    end
end

-- Nút bật/tắt
AddButton(Tab3o, {
    Name = "ESP Ammo",
    Callback = function()
        toggleAmmoESP()
    end
})





local espEnabled = false
local espObjects = {}

-- Tên vật phẩm muốn hiện ESP
local allowedNames = {
    ["Bond"] = true,
    ["GoldenEgg"] = true
}

local function createESP(target)
    local adornee = target:IsA("Model") and target:FindFirstChildWhichIsA("BasePart") or target
    if not adornee then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = adornee
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0, 255, 255) -- Màu xanh lơ
    label.TextStrokeTransparency = 0.2
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextSize = 18
    label.Font = Enum.Font.SourceSansBold
    label.Text = target.Name

    billboard.Parent = game.CoreGui
    table.insert(espObjects, billboard)

    spawn(function()
        while espEnabled and adornee and adornee.Parent do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local dist = (char.HumanoidRootPart.Position - adornee.Position).Magnitude
                label.Text = string.format("%s | %dm", target.Name, math.floor(dist))
            end
            wait(0.2)
        end
        billboard:Destroy()
    end)
end

local function toggleBondESP()
    espEnabled = not espEnabled

    if espEnabled then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end

        workspace.DescendantAdded:Connect(function(obj)
            if espEnabled and (obj:IsA("BasePart") or obj:IsA("Model")) and allowedNames[obj.Name] then
                createESP(obj)
            end
        end)
    else
        for _, gui in pairs(espObjects) do
            if gui and gui.Parent then
                gui:Destroy()
            end
        end
        espObjects = {}
    end
end

-- Nút bật/tắt trong GUI
AddButton(Tab3o, {
    Name = "ESP Bond & Egg",
    Callback = function()
        toggleBondESP()
    end
})















   Section = AddSection(Tab4o, {"Teleport"})



AddButton(Tab4o, {
    Name = "TP to End",
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local TeleportService = game:GetService("TeleportService")
        local targetPosition = Vector3.new(-424.44, 20.52, -49040.60)

        local function method4()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local hrp = char.HumanoidRootPart

            local oldPrimary = char.PrimaryPart
            char.PrimaryPart = hrp
            char:SetPrimaryPartCFrame(CFrame.new(targetPosition))
            char.PrimaryPart = oldPrimary

            print("[M4] Teleport thành công.")
        end

        local function method5()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local hrp = char.HumanoidRootPart

            if hrp.SetNetworkOwner then
                pcall(function()
                    hrp:SetNetworkOwner(LocalPlayer)
                end)
                hrp.CFrame = CFrame.new(targetPosition)
                print("[M5] Teleport thành công.")
            else
                print("[M5] Lỗi: Không thể đặt Network Owner.")
            end
        end

        local function method6()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local hrp = char.HumanoidRootPart

            if hookfunction then
                hookfunction(TeleportService.Teleport, function(...)
                    print("[M6] Hook Teleport: Đã teleport.")
                end)
            end

            hrp.CFrame = CFrame.new(targetPosition)
            print("[M6] Teleport thành công.")
        end

        local function method7()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local hrp = char.HumanoidRootPart

            if hookfunction then
                hookfunction(TeleportService.TeleportAsync, function(...)
                    print("[M7] Hook TeleportAsync: Đã teleport.")
                end)
            end

            hrp.CFrame = CFrame.new(targetPosition)
            print("[M7] TeleportAsync thành công.")
        end

        for i = 1, 10 do
            task.wait(0.1)
            method4()
            task.wait(0.1)
            method5()
            task.wait(0.1)
            method6()
            task.wait(0.1)
            method7()
        end

        print("Tất cả phương pháp đã chạy xong 3 lần.")
    end
})

         




AddButton(Tab4o, {
    Name = "TP to End v2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/0.1%25loading.txt"))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TP to End",
            Text = "Script by YanghoVN",
            Duration = 3
        })
    end
})





AddButton(Tab4o, {
    Name = "TP to You Train",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/TPtotrain.txt"))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TP to Train",
            Text = "Script by YanghoVN",
            Duration = 3
        })
    end
})





AddButton(Tab4o, {
    Name = "TP to Tesla Lab",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/Tptotesla.lua.txt"))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TP to Tesla Lab",
            Text = "Script by YanghoVN",
            Duration = 3
        })
    end
})





AddButton(Tab4o, {
    Name = "TP to Fastcastle",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/FASTCASTLE.txt"))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TP to Fastcastle",
            Text = "Script by YanghoVN",
            Duration = 3
        })
    end
})




AddButton(Tab4o, {
    Name = "TP to Fort",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/Tpfort.lua.txt"))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TP to Fort",
            Text = "Script by YanghoVN",
            Duration = 3
        })
    end
})



AddButton(Tab4o, {
    Name = "TP to Sterling",
    Callback = function()
        -- Chạy script từ link
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/TPsterling.txt"))()

        -- Hook SetCore để chặn thông báo khác
        local originalSetCore = game:GetService("StarterGui").SetCore
        local blocked = {"SendNotification"}

        hookfunction(originalSetCore, function(self, method, ...)
            if table.find(blocked, method) then
                return -- chặn không cho hiển thị
            end
            return originalSetCore(self, method, ...)
        end)
    end
})




AddButton(Tab4o, {
    Name = "TP to Farm",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/tptofarm.lua.txt"))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TP to Farm",
            Text = "Script by YanghoVN",
            Duration = 3
        })
    end
})




AddButton(Tab4o, {
    Name = "TP to Bank",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/Banktp.txt"))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TP to Bank",
            Text = "Script by YanghoVN",
            Duration = 3
        })
    end
})




   AddButton(Tab4o, {
    Name = "TP to Unicorn",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/KJ/refs/heads/main/Test.lua.txt"))()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TP to Unicorn",
            Text = "Script by YanghoVN",
            Duration = 3
        })
    end
})





   Section = AddSection(Tab5o, {"Chức Năng Script "})
   Section = AddSection(Tab5o, {"• Bypass Anti-Cheat"})
   Section = AddSection(Tab5o, {"• Anti-Banned"})
   Section = AddSection(Tab5o, {"• Bypass All Script"})
   Section = AddSection(Tab5o, {"• Fix Bug Script"})