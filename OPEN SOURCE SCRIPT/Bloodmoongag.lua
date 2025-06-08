local SkyboxManager_upvr = require(game.ReplicatedStorage.Modules.SkyboxManager)
local Sky_upvr = script.Sky
SkyboxManager_upvr.AddSkybox(Sky_upvr)

local clone_upvr = script.Ambience:Clone()
local var4_upvw = false

local function CreateEvent_upvr()
    if var4_upvw == true then return end
    var4_upvw = true
    
    game.Lighting.ClockTime = 16
    game.TweenService:Create(game.Lighting, TweenInfo.new(0.1), { Ambient = Color3.fromRGB(138, 107, 107); ExposureCompensation = 1; Brightness = 0.6; OutdoorAmbient = Color3.fromRGB(62, 16, 16); }):Play()
    game.TweenService:Create(game.Lighting.NightColor, TweenInfo.new(0.1), { Brightness = 0.05; TintColor = Color3.fromRGB(255, 226, 226); Contrast = 0.1; }):Play()
    game.TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.1), { Density = 0.357; Offset = 0.721; }):Play()
    game.TweenService:Create(game.Workspace.Terrain.Clouds, TweenInfo.new(0.1), { Cover = 0.657; Density = 1; Color = Color3.fromRGB(45, 1, 1); }):Play()
    game.Lighting.SunRays.Intensity = 0.028
    SkyboxManager_upvr.UpdateSkybox(Sky_upvr, 4)
    clone_upvr.Parent = workspace
    clone_upvr:Play()
    clone_upvr.Volume = 0.1
end

local function ResetEvent_upvr()
    -- Não fazer nada, pois o evento é permanente
end

workspace:SetAttribute("BloodMoonEvent", true)

CreateEvent_upvr()

-- Manter o evento ativo
while true do
    wait(1)
    if not workspace:GetAttribute("BloodMoonEvent") then
        workspace:SetAttribute("BloodMoonEvent", true)
    end
end