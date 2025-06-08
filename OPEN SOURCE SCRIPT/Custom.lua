local plrs = cloneref(game:GetService("Players")) or game:GetService("Players")
local player = plrs.LocalPlayer
local Characterr = Window:AddTab('Custom')
local Chams = Characterr:AddLeftGroupbox('Custom Character')

getgenv().ChamShit = {
    CharacterChams = false,
    RodChams = false,
    RainbowCharacterChams = false,
    RainbowRodChams = false,
    CharacterColor = Color3.fromRGB(255, 255, 255),
    RodColor = Color3.fromRGB(255, 255, 255),
    OriginalProperties = {}
}

local function SaveOriginalProperties()
    if not player.Character then return end
    for _, v in ipairs(player.Character:GetDescendants()) do
        if v:IsA("BasePart") and not ChamShit.OriginalProperties[v] then
            ChamShit.OriginalProperties[v] = {
                Color = v.Color,
                Material = v.Material
            }
        end
    end
end

local function RestoreOriginalProperties()
    for v, props in pairs(ChamShit.OriginalProperties) do
        if v and v:IsA("BasePart") then
            v.Color = props.Color
            v.Material = props.Material
        end
    end
end

local function UpdateChams()
    if not player.Character then return end
    
    for _, v in ipairs(player.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            if ChamShit.RainbowCharacterChams then
                task.spawn(function()
                    while ChamShit.RainbowCharacterChams do
                        for hue = 0, 255, 4 do
                            if not ChamShit.RainbowCharacterChams then break end
                            v.Color = Color3.fromHSV(hue / 256, 1, 1)
                            v.Material = Enum.Material.ForceField
                            task.wait()
                        end
                    end
                end)
            elseif ChamShit.RainbowRodChams then
                task.spawn(function()
                    while ChamShit.RainbowRodChams do
                        for hue = 0, 255, 4 do
                            if not ChamShit.RainbowRodChams then break end
                            v.Color = Color3.fromHSV(hue / 256, 1, 1)
                            v.Material = Enum.Material.Neon
                            task.wait()
                        end
                    end
                end)
            elseif ChamShit.CharacterChams then
                v.Material = Enum.Material.ForceField
                v.Color = ChamShit.CharacterColor
            elseif ChamShit.RodChams then
                v.Material = Enum.Material.Neon
                v.Color = ChamShit.RodColor
            else
                RestoreOriginalProperties()
            end
        end
    end
end

SaveOriginalProperties()

Chams:AddLabel('Select Character Color'):AddColorPicker('CharacterColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Character Color', 
    Transparency = 0, 
    Callback = function(Value)
        ChamShit.CharacterColor = Value
        if ChamShit.CharacterChams then UpdateChams() end
    end
})

Chams:AddLabel('Select Rod Color'):AddColorPicker('RodColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Rod Color', 
    Transparency = 0, 
    Callback = function(Value)
        ChamShit.RodColor = Value
        if ChamShit.RodChams then UpdateChams() end
    end
})

Chams:AddToggle('Enable Character', {
    Text = 'Enable Character',
    Default = false,
    Callback = function(Value)
        ChamShit.CharacterChams = Value
        if not Value and not ChamShit.RodChams and not ChamShit.RainbowCharacterChams and not ChamShit.RainbowRodChams then
            RestoreOriginalProperties()
        else
            UpdateChams()
        end
    end
})

Chams:AddToggle('Enable Rod', {
    Text = 'Enable Rod',
    Default = false,
    Callback = function(Value)
        ChamShit.RodChams = Value
        if not Value and not ChamShit.CharacterChams and not ChamShit.RainbowCharacterChams and not ChamShit.RainbowRodChams then
            RestoreOriginalProperties()
        else
            UpdateChams()
        end
    end
})

Chams:AddToggle('Enable Rainbow Character', {
    Text = 'Enable Rainbow Character',
    Default = false,
    Callback = function(Value)
        ChamShit.RainbowCharacterChams = Value
        if not Value then
            RestoreOriginalProperties()
        else
            UpdateChams()
        end
    end
})

Chams:AddToggle('Enable Rainbow Rod', {
    Text = 'Enable Rainbow Rod',
    Default = false,
    Callback = function(Value)
        ChamShit.RainbowRodChams = Value
        if not Value then
            RestoreOriginalProperties()
        else
            UpdateChams()
        end
    end
})
