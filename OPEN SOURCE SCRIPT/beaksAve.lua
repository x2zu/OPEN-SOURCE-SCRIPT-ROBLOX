local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
do
	local _with_0 = ThemeManager
	_with_0:SetLibrary(Library)
	_with_0:SetFolder("pudding")
end
do
	local _with_0 = SaveManager
	SaveManager:SetLibrary(Library)
	SaveManager:IgnoreThemeSettings()
	SaveManager:SetIgnoreIndexes({
		"MenuKeybind"
	})
	SaveManager:SetFolder("pudding/beaks")
end
do
	local Window = Library:CreateWindow({
		Title = "Beaks",
		Footer = "Beaks by Ave | discord.gg/RVED6GzEyG"
	})
	do
		local Gun = Window:AddTab("Main")
		do
			local SilentAim = Gun:AddLeftGroupbox("Gun")
			SilentAim:AddToggle("SilentAim_Enabled", {
				Text = "Silent Aim"
			})
			SilentAim:AddLabel("_", {
				Text = "For those who want to play more legit",
				DoesWrap = true
			})
		end
		local AutoFarm = Gun:AddRightGroupbox("Auto Farm")
		AutoFarm:AddToggle("AutoFarm_KillAll", {
			Text = "Kill All"
		})
		AutoFarm:AddLabel("_", {
			Text = "Make sure to have your weapon out to use this.",
			DoesWrap = true
		})
		AutoFarm:AddSlider("AutoFarm_ShootDelay", {
			Text = "Shoot Delay",
			Default = 0.1,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Compact = false,
			Suffix = "s"
		})
		AutoFarm:AddToggle("AutoFarm_AutoSell", {
			Text = "Auto Sell"
		})
	end
	local Settings = Window:AddTab("Settings")
	do
		local UI = Settings:AddRightGroupbox("UI")
		local BindLabel = UI:AddLabel("Menu Keybind")
		BindLabel:AddKeyPicker("MenuKeybind", {
			Default = "RightShift",
			NoUI = true,
			Text = "Menu Keybind"
		})
		Library.ToggleKeybind = Library.Options.MenuKeybind
	end
	SaveManager:BuildConfigSection(Settings)
	ThemeManager:ApplyToTab(Settings)
end
local Aether = require(game.ReplicatedStorage.Packages.Aether)
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local GetMouseLocation
do
	local _base_0 = UserInputService
	local _fn_0 = _base_0.GetMouseLocation
	GetMouseLocation = _fn_0 and function(...)
		return _fn_0(_base_0, ...)
	end
end
local WorldToScreenPoint
do
	local _base_0 = Camera
	local _fn_0 = _base_0.WorldToScreenPoint
	WorldToScreenPoint = _fn_0 and function(...)
		return _fn_0(_base_0, ...)
	end
end
local GetChildren = game.GetChildren
local GetClosestBird
GetClosestBird = function()
	local ClosestBird = nil
	local ClosestDistance = math.huge
	local ScreenPosition = nil
	local _list_0 = workspace.Regions:GetChildren()
	for _index_0 = 1, #_list_0 do
		local Region = _list_0[_index_0]
		local MouseLocation = GetMouseLocation()
		MouseLocation = Vector2.new(MouseLocation.X, MouseLocation.Y)
		local _list_1 = GetChildren(Region.ClientBirds)
		for _index_1 = 1, #_list_1 do
			local Bird = _list_1[_index_1]
			local Health = Bird:GetAttribute("Health")
			local Visible = Bird:GetAttribute("CurrentlyVisible")
			if not Visible then
continue
			end
			if not Health or Health == 0 then
continue
			end
			local BirdPos, OnScreen = WorldToScreenPoint(Bird.PrimaryPart.Position)
			local BirdScreenPos = Vector2.new(BirdPos.X, BirdPos.Y)
			if not OnScreen then
continue
			end
			local Distance = (MouseLocation - BirdScreenPos).Magnitude
			if Distance <= ClosestDistance then
				ClosestBird = Bird
				ClosestDistance = Distance
				ScreenPosition = BirdScreenPos
			end
		end
	end
	return ClosestBird, ClosestDistance, ScreenPosition
end
-- Silent aim with instant hit
local FastCastRedux = require(Aether.GetUtil("FastCastRedux"))
do
	local OldFire = FastCastRedux.Fire
	FastCastRedux.Fire = function(Self, ShootFrom, ShootDirection, Distance, Params)
		local ClosestBird = GetClosestBird()
		local PrimaryPart
		if ClosestBird ~= nil then
			PrimaryPart = ClosestBird.PrimaryPart
		end
		if PrimaryPart and Library.Toggles.SilentAim_Enabled.Value then
			ShootFrom = PrimaryPart.Position + Vector3.new(0, 1, 0)
			ShootDirection = Vector3.new(0, -1, 0)
		end
		return OldFire(Self, ShootFrom, ShootDirection, Distance, Params)
	end
end
-- Auto Farm
local Net = require(Aether.GetUtil("Net"))
local GunShootEvent = Net:RemoteEvent("GunShootEvent")
local SellInventory = Net:RemoteFunction("SellInventory")
local LocalPlayer = game.Players.LocalPlayer
local GunList = require(game.ReplicatedStorage.Configuration.Guns)
while true do
	task.wait()
	local Weapon
	do
		local _obj_0 = LocalPlayer.Character
		if _obj_0 ~= nil then
			Weapon = _obj_0:FindFirstChildWhichIsA("Tool")
		end
	end
	if not GunList[(function()
		if Weapon ~= nil then
			return Weapon.Name
		end
		return nil
	end)()] then
continue
	end
	local HandlePart = Weapon:FindFirstChild("HandlePart", true)
	if not HandlePart then
continue
	end
	local _list_0 = workspace.Regions:GetChildren()
	for _index_0 = 1, #_list_0 do
		local Region = _list_0[_index_0]
		local _list_1 = Region.ClientBirds:GetChildren()
		for _index_1 = 1, #_list_1 do
			local Bird = _list_1[_index_1]
			local Health = Bird:GetAttribute("Health")
			local Visible = Bird:GetAttribute("CurrentlyVisible")
			if not Visible then
continue
			end
			if not Health or Health == 0 then
continue
			end
			if Library.Toggles.AutoFarm_KillAll.Value then
				local HandlePos = HandlePart.Position
				local BirdPos = Bird.PrimaryPart.Position
				GunShootEvent:FireServer("BulletFired", Weapon, HandlePart.Position, "Dart")
				GunShootEvent:FireServer("BirdHit", Weapon, Bird.PrimaryPart.Position, (Bird:GetAttribute("Id")), "Dart")
			end
		end
	end
	if Library.Toggles.AutoFarm_AutoSell.Value then
		SellInventory:InvokeServer("All")
	end
	task.wait(Library.Options.AutoFarm_ShootDelay.Value)
end
