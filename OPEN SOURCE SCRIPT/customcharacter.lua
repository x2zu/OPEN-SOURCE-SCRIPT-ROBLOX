local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/refs/heads/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/refs/heads/main/addons/SaveManager.lua"))()
local repo = 'https://txtbin.net/raw/k8gsj1ab76'

local Library = loadstring(game:HttpGet(repo))()

local Window = Library:CreateWindow({
    Title = "Ancestral-Universal",
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local plrs = cloneref(game:GetService("Players")) or game:GetService("Players")
local player = plrs.LocalPlayer
local Characterr = Window:AddTab('Custom')
local Chams = Characterr:AddLeftGroupbox('Custom Character')

getgenv().ChamShit = {
    PlayerChams = false,
    RainbowChams = false,
    PlayerChamColor = Color3.fromRGB(255, 255, 255),
    Material = "ForceField",
}

Chams:AddDropdown('Select Custom', {

    Values = {"ForceField", "Neon"},
    Default = 1,
    Multi = false,
    Text = 'Select Options',
    Callback = function(Value)
        ChamShit.Material = Value
    end
})

Chams:AddLabel('Select Color'):AddColorPicker('Color', {
    Default = Color3.new(255, 255, 255),
    Title = 'Select Color', 
    Transparency = 0, 

    Callback = function(Value)
        ChamShit.PlayerChamColor = Value
    end
})


Chams:AddToggle('Enable Toggle', {
    Text = 'Enable Toggle',
    Default = false,
    Tooltip = nil, 
    Callback = function(Value)
        ChamShit.PlayerChams = Value
        if ChamShit.RainbowChams then 
            while ChamShit.PlayerChams and task.wait() do 
                for hue = 0, 255, 4 do
                    task.spawn(function()
                        for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do 
                            if v:IsA("BasePart") then 
                                v.Material = Enum.Material[ChamShit.Material]
                                v.Color = Color3.fromHSV(hue / 256, 1, 1)
                            end
                            end
                    end)
                    task.wait()
                end
                end
        else
            while ChamShit.PlayerChams and task.wait() do 
                for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do 
                    if v:IsA("BasePart") then 
                        v.Color = ChamShit.PlayerChamColor
                        v.Material = Enum.Material[ChamShit.Material]
                    end
                end
                task.wait()
            end
        end
    end
})
