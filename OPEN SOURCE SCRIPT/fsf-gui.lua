if not game:IsLoaded() then game.Loaded:Wait() end

if not writefile then print("You cannot change configs because your executor does not support files!") end

print("[FSF-G] Loading GUI")

getgenv().SecureMode = true
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local data = loadstring(game:HttpGet("https://raw.githubusercontent.com/P3nguinMinecraft/FischScripts/main/fsf-data.lua"))()

if not isfile("FischServerFinder/config.json") and writefile then
    if not isfolder("FischServerFinder") then
        makefolder("FischServerFinder")
    end
    writefile("FischServerFinder/config.json", game:GetService("HttpService"):JSONEncode(data.defaultConfig))
end
local config
if isfile("FischServerFinder/config.json") then
    config = game:GetService("HttpService"):JSONDecode(readfile("FischServerFinder/config.json"))
else
    config = data.defaultConfig
end

local function saveConfig()
    if not writefile then return end
    local encode = game:GetService("HttpService"):JSONEncode(config)
    writefile("FischServerFinder/config.json", encode)
end

local function updateTable(default, previous)
    local updated = {}
    for key, value in pairs(default) do
        if type(value) == "table" and type(previous[key]) == "table" then
            updated[key] = updateTable(value, previous[key])
        elseif previous[key] ~= nil then
            updated[key] = previous[key]
        else
            updated[key] = value
        end
    end

    return updated
end

local function mergeConfig(default, conf)
    conf = updateTable(default, conf)
    conf.version = data.version
    conf.versid = data.versid
    return conf
end

local function dropdownconvert(conf, listName, options)
    local list = conf[listName]
    for name, _ in pairs(list) do
        list[name] = false
        for _, optionName in ipairs(options) do
            if optionName == name then
                list[name] = true
                break
            end
        end
    end
end

local function dropdownsetup(conf, listName, dropdown)
    local allThing = {}
    local selectedThing = {}
    local list = conf[listName]
    local order = data.ordered[listName]

    for _, name in ipairs(order) do
        local enabled = list[name]
        table.insert(allThing, name)
        if enabled then
            table.insert(selectedThing, name)
        end
    end

    dropdown:Refresh(allThing)
    dropdown:Set(selectedThing)
end

local af_mod = loadstring(game:HttpGet("https://raw.githubusercontent.com/P3nguinMinecraft/FischScripts/main/obfusc/fsf-af.lua"))()

local fishConfig
if isfile("FischServerFinder/fishconfig.json") then
    fishConfig = game:GetService("HttpService"):JSONDecode(readfile("FischServerFinder/fishconfig.json"))
else
    fishConfig = data.defaultFishConfig
end

local function saveFishConfig()
    writefile("FischServerFinder/fishconfig.json", game:GetService("HttpService"):JSONEncode(fishConfig))
    af_mod.init()
end

local guiConfig
if isfile("FischServerFinder/guiconfig.json") then
    guiConfig = game:GetService("HttpService"):JSONDecode(readfile("FischServerFinder/guiconfig.json"))
else
    guiConfig = data.defaultGuiConfig
end

local function saveGuiConfig()
    writefile("FischServerFinder/guiconfig.json", game:GetService("HttpService"):JSONEncode(guiConfig))
end

local Window = Rayfield:CreateWindow({
    Name = "FischServerFinder - Penguin " .. data.version,
    Icon = 0,
    LoadingTitle = "FischServerFinder GUI",
    LoadingSubtitle = "by Penguin",
    Theme = "Default",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
       Enabled = false,
       FolderName = "FischServerFinder",
       FileName = "rf_config"
    },

    Discord = {
       Enabled = true,
       Invite = "fWncS2vFx",
       RememberJoins = true,
    },

    KeySystem = false,
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = {"Hello"}
    }
})

local HomeTab = Window:CreateTab("Home", nil)

local HomeLabel1 = HomeTab:CreateLabel("GUI for FischServerFinder")

local HomeLabel2 = HomeTab:CreateLabel("Explore the various Tabs to change configs!")

if not writefile then HomeLabel2:Set("You cannot change configs because your executor does not support files!") end

local HomeButton1 = HomeTab:CreateButton({
    Name = "Close GUI (Destroy)",
    Callback = function()
        Rayfield:Destroy()
    end,
})

local HomeButton2 = HomeTab:CreateButton({
    Name = "Load Main Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/P3nguinMinecraft/FischScripts/main/fischserverfinder.lua"))()
    end,
})

local HomeButton3 = HomeTab:CreateButton({
    Name = "Reset Config",
    Callback = function()
        config = data.defaultConfig
        saveConfig()
        Rayfield:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/P3nguinMinecraft/FischScripts/main/fsf-gui.lua"))()
    end,
})

HomeTab:CreateDivider()

local zonecd = -1

local HomeButton4 = HomeTab:CreateButton({
    Name = "Send Zones",
    Callback = function()
        if tick() - zonecd > 60 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/isMoons/loader/refs/heads/main/sendzone.lua"))()
        else
            Rayfield:Notify({
                Title = "Send Zones",
                Content = "You can send again in " .. tostring(math.floor(tick() - zonecd)) .. " seconds!",
                Duration = 5,
                Image = nil,
            })
        end
    end,
})

local ToolsTab = Window:CreateTab("Tools", nil)

local ToolsButton1 = ToolsTab:CreateButton({
    Name = "Redeem Codes",
    Callback = function()
        for _, code in data.codes do
            game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("runcode"):FireServer(code)
        end
    end,
})

local ToolsSection1 = ToolsTab:CreateSection("Rendering")

local ToolsButton2 = ToolsTab:CreateButton({
    Name = "Remove Fog (Permanent)",
    Callback = function()
        local Sky = game:GetService("Lighting"):FindFirstChild("Sky")
        if Sky then Sky:Destroy() end
    end,
})

local disablewater
local function disablewaterfunc()
    local blur = game:GetService("Lighting"):FindFirstChild("underwaterbl")
    local constrast =  game:GetService("Lighting"):FindFirstChild("underwatercc")
    blur.Enabled = false
    constrast.Enabled = false
end

ToolsTab:CreateDivider()

local ToolsToggle1 = ToolsTab:CreateToggle({
    Name = "Disable Water Fog",
    CurrentValue = false,
    Flag = "ToolsToggle1",
    Callback = function(Value)
        guiConfig.ToolsToggle1 = Value
        saveGuiConfig()
        if Value then
            disablewater = game:GetService("RunService").RenderStepped:Connect(disablewaterfunc)
        else
            disablewater:Disconnect()
            disablewater = nil
        end
    end,
})

ToolsToggle1:Set(guiConfig.ToolsToggle1)

ToolsTab:CreateDivider()

local fullbright

local function fullbrightfunc()
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.location.Brightness = 0
end

local ToolsToggle2 = ToolsTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Flag = "ToolsToggle2",
    Callback = function(Value)
        guiConfig.ToolsToggle2 = Value
        saveGuiConfig()
        if Value then
            fullbright = game:GetService("RunService").RenderStepped:Connect(fullbrightfunc)
        else
            fullbright:Disconnect()
            fullbright = nil
        end
    end
})

ToolsToggle2:Set(guiConfig.ToolsToggle2)

ToolsTab:CreateDivider()

local antigp

local ToolsToggle3 = ToolsTab:CreateToggle({
    Name = "Anti Game Paused",
    CurrentValue = false,
    Flag = "ToolsToggle3",
    Callback = function(Value)
        guiConfig.ToolsToggle3 = Value
        saveGuiConfig()
        if Value then
            antigp = game:GetService("RunService").RenderStepped:Connect(function()
                game:GetService("Players").LocalPlayer.GameplayPaused = false
            end)
        else
            antigp:Disconnect()
            antigp = nil
        end
    end,
})

ToolsToggle3:Set(guiConfig.ToolsToggle3)

local instantinteract

local ToolsToggle4 = ToolsTab:CreateToggle({
    Name = "Instant Interaction",
    CurrentValue = false,
    Flag = "ToolsToggle4",
    Callback = function(Value)
        guiConfig.ToolsToggle3 = Value
        saveGuiConfig()
        if Value then
            if fireproximityprompt then
                instantinteract = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
                    pcall(function()
                        fireproximityprompt(prompt)
                    end)
                end)
            else
                Rayfield:Notify({
                    Title = "Instant Interaction",
                    Content = "Your executor does not support fireproximityprompt!",
                    Duration = 5,
                    Image = nil,
                })
            end
        else
            instantinteract:Disconnect()
            instantinteract = nil
        end
    end,
})

ToolsToggle4:Set(guiConfig.ToolsToggle4)

local FishTab = Window:CreateTab("AutoFish", nil)

local FishSection1 = FishTab:CreateSection("Cast")

local FishToggle1 = FishTab:CreateToggle({
    Name = "Auto Cast",
    CurrentValue = fishConfig.autocast,
    Flag = "FishToggle1",
    Callback = function(Value)
        fishConfig.autocast = Value
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local FishToggle2 = FishTab:CreateToggle({
    Name = "Drop Bobber",
    CurrentValue = fishConfig.dropbobber,
    Flag = "FishToggle2",
    Callback = function(Value)
        fishConfig.dropbobber = Value
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local FishSlider1 = FishTab:CreateSlider({
    Name = "Cast Power",
    Range = {0, 100},
    Increment = 1,
    Suffix = "%",
    CurrentValue = fishConfig.castpower,
    Flag = "FishSlider1",
    Callback = function(Value)
        fishConfig.castpower = Value
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local FishSection2 = FishTab:CreateSection("Shake")

local FishToggle3 = FishTab:CreateToggle({
    Name = "Auto Shake",
    CurrentValue = fishConfig.autoshake,
    Flag = "FishToggle3",
    Callback = function(Value)
        fishConfig.autoshake = Value
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local shakeTable = {}
if fishConfig.shakenav then
    shakeTable = {"Navigation"}
else
    shakeTable = {"Click"}
end

local FishDropdown1 = FishTab:CreateDropdown({
    Name = "Shake Method",
    Options = {"Navigation", "Click"},
    CurrentOption = shakeTable,
    MultipleOptions = false,
    Flag = "FishDropdown1",
    Callback = function(Option)
        if Option[1] == "Navigation" then
            fishConfig.shakenav = true
        else
            fishConfig.shakenav = false
        end
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local FishSection3 = FishTab:CreateSection("Reel")

local FishToggle4 = FishTab:CreateToggle({
    Name = "Auto Reel",
    CurrentValue = fishConfig.autoreel,
    Flag = "FishToggle4",
    Callback = function(Value)
        fishConfig.autoreel = Value
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local FishToggle5 = FishTab:CreateToggle({
    Name = "Instant Reel",
    CurrentValue = fishConfig.instantreel,
    Flag = "FishToggle5",
    Callback = function(Value)
        fishConfig.instantreel = Value
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local FishToggle6 = FishTab:CreateToggle({
    Name = "Perfect Catch",
    CurrentValue = fishConfig.perfectCatch,
    Flag = "FishToggle6",
    Callback = function(Value)
        fishConfig.perfectCatch = Value
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local FishDropdown2 = FishTab:CreateDropdown({
    Name = "Reel Select",
    Options = {"None", "Whitelist", "Blacklist"},
    CurrentOption = {fishConfig.reelSelect},
    MultipleOptions = false,
    Flag = "FishDropdown2",
    Callback = function(Option)
        fishConfig.reelSelect = Option[1]
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local FishLabel1 = FishTab:CreateLabel("Comma-separated list, NOT case-sensitive")

local FishInput1 = FishTab:CreateInput({
    Name = "Whitelist",
    CurrentValue = "",
    PlaceholderText = "Ex: 'Phantom Megalodon, The Kraken'",
    RemoveTextAfterFocusLost = false,
    Flag = "FishInput1",
    Callback = function(Text)
        fishConfig.reelWhitelistStr = Text
        saveFishConfig()
    end,
})

FishTab:CreateDivider()

local FishInput2 = FishTab:CreateInput({
    Name = "Blacklist",
    CurrentValue = fishConfig.reelBlacklistStr,
    PlaceholderText = "Ex: 'Common Crate, Sardine'",
    RemoveTextAfterFocusLost = false,
    Flag = "FishInput2",
    Callback = function(Text)
        fishConfig.reelBlacklistStr = Text
        saveFishConfig()
    end,
})

local prevLocation
local zonefreeze
local function zonefreezefunc()
    local fishing = game:GetService("Workspace"):WaitForChild("zones"):WaitForChild("fishing")
    local zone, coords

    for i = #data.ordered.eventzones, 1, -1 do
        if zone or not guiConfig.eventzonetoggle then break end
        local name = data.ordered.events[i]
        if guiConfig.eventzones[name] then
            zone = fishing:FindFirstChild(name)
            if zone then
                coords = data.zoneData.eventzones[name]
                if not coords then coords = {x = 0, y = 0, z = 0} end
                break
            end
        end
    end

    for i = #data.ordered.zones, 1, -1 do
        if zone or not guiConfig.zonetoggle then break end
        local name = data.ordered.events[i]
        if guiConfig.zones[name] then
            zone = fishing:FindFirstChild(name)
            if zone then
                coords = data.zoneData.zones[name]
                if not coords then coords = {x = 0, y = 0, z = 0} end
                break
            end
        end
    end

    if not zone or not coords then return end

    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(zone.Position + Vector3.new(coords.x, coords.y, coords.z))
end

local AreaTab = Window:CreateTab("Areas", nil)

local AreaSection1 = AreaTab:CreateSection("Zone Freeze")

local AreaToggle1 = AreaTab:CreateToggle({
    Name = "Zone Freeze",
    CurrentValue = false,
    Flag = "AreaToggle1",
    Callback = function(Value)
        guiConfig.zonetoggle = Value
        if zonefreeze then
            zonefreeze:Disconnect()
            zonefreeze = nil
        end
        if guiConfig.zonetoggle or guiConfig.eventzonetoggle then
            zonefreeze = game:GetService("RunService").RenderStepped:Connect(zonefreezefunc)
            if not prevLocation then
                prevLocation = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        else
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = prevLocation
            prevLocation = nil
        end
    end,
})

local AreaToggle2 = AreaTab:CreateToggle({
    Name = "Event Zone Fishing",
    CurrentValue = false,
    Flag = "AreaToggle2",
    Callback = function(Value)
        guiConfig.eventzonetoggle = Value
        guiConfig.zonetoggle = Value
        if zonefreeze then
            zonefreeze:Disconnect()
            zonefreeze = nil
        end
        if guiConfig.zonetoggle or guiConfig.eventzonetoggle then
            zonefreeze = game:GetService("RunService").RenderStepped:Connect(zonefreezefunc)
            if not prevLocation then
                prevLocation = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        else
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = prevLocation
            prevLocation = nil
        end
    end,
})

local AreaDropdown1 = AreaTab:CreateDropdown({
    Name = "Zones",
    Options = {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "AreaDropdown1",
    Callback = function(Options)
        dropdownconvert(guiConfig, "zones", Options)
        saveGuiConfig()
    end,
})

dropdownsetup(guiConfig, "zones", AreaDropdown1)

local AreaDropdown2 = AreaTab:CreateDropdown({
    Name = "Event Zones",
    Options = {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "AreaDropdown2",
    Callback = function(Options)
        dropdownconvert(guiConfig, "eventzones", Options)
    end,
})

dropdownsetup(guiConfig, "eventzones", AreaDropdown2)

local ScriptTab = Window:CreateTab("Script Config", nil)

local ScriptParagraph1 = ScriptTab:CreateParagraph({Title = "Auto Scan", Content = "Automatically scans the server for desired features on join"})

local ScriptToggle1 = ScriptTab:CreateToggle({
    Name = "Auto Scan",
    CurrentValue = config.autoscan,
    Flag = "ScriptToggle1",
    Callback = function(Value)
        config.autoscan = Value
        saveConfig()
    end,
})

ScriptTab:CreateDivider()

local ScriptParagraph2 = ScriptTab:CreateParagraph({Title = "Auto Hop", Content = "Automatically serverhops if the current server has nothing desirable"})

local ScriptToggle2 = ScriptTab:CreateToggle({
    Name = "Auto Hop",
    CurrentValue = config.autohop,
    Flag = "ScriptToggle2",
    Callback = function(Value)
        config.autohop = Value
        saveConfig()
    end,
})

ScriptTab:CreateDivider()

local ScriptParagraph3 = ScriptTab:CreateParagraph({Title = "Auto Webhook", Content = "Automatically sends a webhook to the URL below with all features on join"})

local ScriptToggle3 = ScriptTab:CreateToggle({
    Name = "Auto Webhook",
    CurrentValue = config.autowebhook,
    Flag = "ScriptToggle3",
    Callback = function(Value)
        config.autowebhook = Value
        saveConfig()
    end,
})

local ScriptInput1 = ScriptTab:CreateInput({
    Name = "Webhook Url",
    CurrentValue = config.webhookUrl,
    PlaceholderText = "discord.com/api/webhooks/#/#",
    RemoveTextAfterFocusLost = false,
    Flag = "ScriptInput1",
    Callback = function(Text)
        config.webhookUrl = Text
        saveConfig()
    end,
})

ScriptTab:CreateDivider()

local ScriptSection1 = ScriptTab:CreateSection("Auto Display")

local ScriptParagraph5 = ScriptTab:CreateParagraph({Title = "Auto Uptime", Content = "Automatically displays the server's uptime when you scan"})

local ScriptToggle4 = ScriptTab:CreateToggle({
    Name = "Auto Uptime",
    CurrentValue = config.infoList.autouptime,
    Flag = "ScriptToggle4",
    Callback = function(Value)
        config.infoList.autouptime = Value
        saveConfig()
    end,
})

ScriptTab:CreateDivider()

local ScriptParagraph6 = ScriptTab:CreateParagraph({Title = "Auto Webhook", Content = "Automatically displays the server's ingame Fisch version when you scan"})

local ScriptToggle5 = ScriptTab:CreateToggle({
    Name = "Auto Version",
    CurrentValue = config.infoList.autoversion,
    Flag = "ScriptToggle5",
    Callback = function(Value)
        config.infoList.autoversion = Value
        saveConfig()
    end,
})

ScriptTab:CreateDivider()

local ScriptParagraph7 = ScriptTab:CreateParagraph({Title = "Auto PlaceVersion", Content = "Automatically displays the server's Roblox PlaceVersion when you scan"})

local ScriptToggle6 = ScriptTab:CreateToggle({
    Name = "Auto PlaceVersion",
    CurrentValue = config.infoList.autoplaceversion,
    Flag = "ScriptToggle6",
    Callback = function(Value)
        config.infoList.autoplaceversion = Value
        saveConfig()
    end,
})

local ServerTab = Window:CreateTab("Server Config", nil)

local ServerParagraph1 = ServerTab:CreateParagraph({Title = "Weather", Content = "Select weathers that are desirable"})

local ServerDropdown1 = ServerTab:CreateDropdown({
    Name = "Weather",
    Options = {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "ServerDropdown1",
    Callback = function(Options)
        dropdownconvert(config, "weatherList", Options)
        saveConfig()
    end,
})

dropdownsetup(config, "weatherList", ServerDropdown1)

local ServerDivider1 = ServerTab:CreateDivider()

local ServerParagraph2 = ServerTab:CreateParagraph({Title = "Events", Content = "Select events that are desirable"})

local ServerDropdown2 = ServerTab:CreateDropdown({
    Name = "Events",
    Options = {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "ServerDropdown2",
    Callback = function(Options)
        dropdownconvert(config, "eventList", Options)
        saveConfig()
    end,
})

dropdownsetup(config, "eventList", ServerDropdown2)

ServerTab:CreateDivider()

local ServerParagraph3 = ServerTab:CreateParagraph({Title = "Seasons", Content = "Select seasons that are desirable"})

local ServerDropdown3 = ServerTab:CreateDropdown({
    Name = "Season",
    Options = {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "ServerDropdown3",
    Callback = function(Options)
        dropdownconvert(config, "seasonList", Options)
        saveConfig()
    end,
})

dropdownsetup(config, "seasonList", ServerDropdown3)

local ServerDivider3 = ServerTab:CreateDivider()

local ServerParagraph4 = ServerTab:CreateParagraph({Title = "Daytime Cycle", Content = "Select daytime cycles that are desirable"})

local ServerDropdown4 = ServerTab:CreateDropdown({
    Name = "Daytime Cycle",
    Options = {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "ServerDropdown4",
    Callback = function(Options)
        dropdownconvert(config, "cycleList", Options)
        saveConfig()
    end,
})

dropdownsetup(config, "cycleList", ServerDropdown4)

ServerTab:CreateDivider()

local ServerParagraph5 = ServerTab:CreateParagraph({Title = "Server Luck", Content = "Toggle and select minimum amount of server luck desired (Robux Luck Multiplier)"})

local ServerToggle1 = ServerTab:CreateToggle({
    Name = "Luck Toggle",
    CurrentValue = config.luckList.enabled,
    Flag = "ServerToggle1",
    Callback = function(Value)
        config.luckList.enabled = Value
        saveConfig()
    end,
})

local resetLuckMin

local ServerInput1 = ServerTab:CreateInput({
    Name = "Minimum Multiplier",
    CurrentValue = config.luckList.min,
    PlaceholderText = "",
    RemoveTextAfterFocusLost = false,
    Flag = "ServerInput1",
    Callback = function(Text)
        if tonumber(Text) and tonumber(Text) > 0 then
            config.filename = tonumber(Text)
            saveConfig()
        else
            Rayfield:Notify({
                Title = "Minimum Multiplier",
                Content = "The input has to be a positive integer!",
                Duration = 5,
                Image = nil,
            })
            resetLuckMin()
        end
    end,
})

resetLuckMin = function()
    ServerInput1:Set(config.luckList.min)
end

ServerTab:CreateDivider()

local ServerParagraph6 = ServerTab:CreateParagraph({Title = "Server Version", Content = "Toggle and select the desired ingame Fisch version in the form x.x.x"})

local ServerToggle2 = ServerTab:CreateToggle({
    Name = "Version Toggle",
    CurrentValue = config.versionList.enabled,
    Flag = "ServerToggle2",
    Callback = function(Value)
        config.luckList.enabled = Value
        saveConfig()
    end,
})

local ServerInput2 = ServerTab:CreateInput({
    Name = "Version",
    CurrentValue = config.versionList.version,
    PlaceholderText = "x.x.x",
    RemoveTextAfterFocusLost = false,
    Flag = "ServerInput2",
    Callback = function(Text)
        config.versionList.version = Text
    end,
})

ServerTab:CreateDivider()

local ServerParagraph7 = ServerTab:CreateParagraph({Title = "PlaceVersion", Content = "Toggle and select the desired Roblox PlaceVersion (game.PlaceVersion)"})

local ServerToggle3 = ServerTab:CreateToggle({
    Name = "PlaceVersion Toggle",
    CurrentValue = config.placeVersionList.enabled,
    Flag = "ServerToggle3",
    Callback = function(Value)
        config.placeVersionList.enabled = Value
        saveConfig()
    end,
})

local resetPlaceVersion

local ServerInput3 = ServerTab:CreateInput({
    Name = "PlaceVersion",
    CurrentValue = config.placeVersionList.version,
    PlaceholderText = "1234",
    RemoveTextAfterFocusLost = false,
    Flag = "ServerInput3",
    Callback = function(Text)
        if tonumber(Text) and tonumber(Text) > 0 then
            config.placeVersionList.version = tonumber(Text)
            saveConfig()
        else
            Rayfield:Notify({
                Title = "PlaceVersion",
                Content = "The input has to be a positive integer!",
                Duration = 5,
                Image = nil,
            })
            resetPlaceVersion()
        end
    end,
})

resetPlaceVersion = function()
    ServerInput3:Set(config.placeVersionList.version)
end

ServerTab:CreateDivider()

local ServerSection1 = ServerTab:CreateSection("Uptime Search")

local ServerParagraph8 = ServerTab:CreateParagraph({Title = "Before Time", Content = "Desirable server if the uptime is less than the amount below (summed)"})

local ServerToggle4 = ServerTab:CreateToggle({
    Name = "Before Time - Toggle",
    CurrentValue = config.uptimeList.beforeTime.enabled,
    Flag = "ServerToggle4",
    Callback = function(Value)
        config.uptimeList.beforeTime.enabled = Value
        saveConfig()
    end,
})

local resetBHour

local ServerInput4 = ServerTab:CreateInput({
    Name = "Before Time - Hour",
    CurrentValue = config.uptimeList.beforeTime.hour,
    PlaceholderText = "x hours",
    RemoveTextAfterFocusLost = false,
    Flag = "ServerInput4",
    Callback = function(Text)
        if tonumber(Text) and tonumber(Text) >= 0 then
            config.uptimeList.beforeTime.hour = tonumber(Text)
            saveConfig()
        else
            Rayfield:Notify({
                Title = "Before Time - Hour",
                Content = "The input has to be a valid integer!",
                Duration = 5,
                Image = nil,
            })
            resetBHour()
        end
    end,
})

resetBHour = function()
    ServerInput4:Set(config.uptimeList.beforeTime.hour)
end

local resetBMin

local ServerInput5 = ServerTab:CreateInput({
    Name = "Before Time - Min",
    CurrentValue = config.uptimeList.beforeTime.min,
    PlaceholderText = "x mins",
    RemoveTextAfterFocusLost = false,
    Flag = "ServerInput5",
    Callback = function(Text)
        if tonumber(Text) and tonumber(Text) >= 0 then
            config.uptimeList.beforeTime.min = tonumber(Text)
            saveConfig()
        else
            Rayfield:Notify({
                Title = "Before Time - Min",
                Content = "The input has to be a valid integer!",
                Duration = 5,
                Image = nil,
            })
            resetBMin()
        end
    end,
})

resetBMin = function()
    ServerInput5:Set(config.uptimeList.beforeTime.min)
end

ServerTab:CreateDivider()

local ServerParagraph9 = ServerTab:CreateParagraph({Title = "After Time", Content = "Desirable server if the uptime is more than the amount below (summed)"})

local ServerToggle5 = ServerTab:CreateToggle({
    Name = "After Time - Toggle",
    CurrentValue = config.uptimeList.afterTime.enabled,
    Flag = "ServerToggle5",
    Callback = function(Value)
        config.uptimeList.afterTime.enabled = Value
        saveConfig()
    end,
})

local resetAHour

local ServerInput6 = ServerTab:CreateInput({
    Name = "After Time - Hour",
    CurrentValue = config.uptimeList.afterTime.hour,
    PlaceholderText = "x hours",
    RemoveTextAfterFocusLost = false,
    Flag = "ServerInput6",
    Callback = function(Text)
        if tonumber(Text) and tonumber(Text) >= 0 then
            config.uptimeList.afterTime.hour = tonumber(Text)
            saveConfig()
        else
            Rayfield:Notify({
                Title = "After Time - Hour",
                Content = "The input has to be a valid integer!",
                Duration = 5,
                Image = nil,
            })
            resetAHour()
        end
    end,
})

resetAHour = function()
    ServerInput6:Set(config.uptimeList.afterTime.hour)
end

local resetAMin

local ServerInput7 = ServerTab:CreateInput({
    Name = "After Time - Min",
    CurrentValue = config.uptimeList.afterTime.min,
    PlaceholderText = "x mins",
    RemoveTextAfterFocusLost = false,
    Flag = "ServerInput7",
    Callback = function(Text)
        if tonumber(Text) and tonumber(Text) >= 0 then
            config.uptimeList.afterTime.min = tonumber(Text)
            saveConfig()
        else
            Rayfield:Notify({
                Title = "After Time - Min",
                Content = "The input has to be a valid integer!",
                Duration = 5,
                Image = nil,
            })
            resetAMin()
        end
    end,
})

resetAMin = function()
    ServerInput7:Set(config.uptimeList.afterTime.min)
end

ServerTab:CreateDivider()

local ServerParagraph10 = ServerTab:CreateParagraph({Title = "Or Logic", Content = "If Or Logic is on, server is desired if EITHER Before or After is satisfied. If Or Logic is off, BOTH Before and After must be satisfied (used if you need between 2 uptimes)"})

local ServerToggle6 = ServerTab:CreateToggle({
    Name = "Or Logic",
    CurrentValue = config.uptimeList.orLogic,
    Flag = "ServerToggle6",
    Callback = function(Value)
        config.uptimeList.orLogic = Value
        saveConfig()
    end,
})

ServerTab:CreateDivider()

local EventsTab = Window:CreateTab("Events Config", nil)

local EventsParagraph1 = EventsTab:CreateParagraph({Title = "Fishing Zones", Content = "Select the Fishing/Event Zones that are desired"})

local EventsDropdown1 = EventsTab:CreateDropdown({
    Name = "Zones",
    Options = {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "EventsDropdown1",
    Callback = function(Options)
        dropdownconvert(config, "zoneList", Options)
        saveConfig()
    end,
})

dropdownsetup(config, "zoneList", EventsDropdown1)

local EventsParagraph2 = EventsTab:CreateParagraph({Title = "Meteor Items", Content = "Select the Meteor Items that are desired"})

local EventsDropdown2 = EventsTab:CreateDropdown({
    Name = "Meteor Items",
    Options = {},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "EventsDropdown2",
    Callback = function(Options)
        dropdownconvert(config, "meteorList", Options)
        saveConfig()
    end,
})

dropdownsetup(config, "meteorList", EventsDropdown2)

local sunkenSet

local EventsSection1 = EventsTab:CreateSection("Sunken Chests")

local EventsParagraph3 = EventsTab:CreateParagraph({Title = "Sunken Chest Toggle", Content = "Global toggle for all Sunken Chest features"})

local EventsToggle1 = EventsTab:CreateToggle({
    Name = "Sunken Chest Toggle",
    CurrentValue = config.sunkenchestList.enabled,
    Flag = "EventsToggle1",
    Callback = function(Value)
        if not Value then
            sunkenSet(2, false)
            sunkenSet(3, false)
            sunkenSet(4, false)
            sunkenSet(5, false)
        end
        config.sunkenchestList.enabled = Value
        saveConfig()
    end,
})

local EventsParagraph4 = EventsTab:CreateParagraph({Title = "Buffer Before", Content = "A server will be desirable x minutes before chests spawn"})

local EventsSlider1 = EventsTab:CreateSlider({
    Name = "Buffer Before",
    Range = {0, 20},
    Increment = 1,
    Suffix = "mins",
    CurrentValue = config.sunkenchestList.bufferbefore,
    Flag = "EventsSlider1",
    Callback = function(Value)
        config.sunkenchestList.bufferbefore = Value
        saveConfig()
    end,
})

local EventsParagraph5 = EventsTab:CreateParagraph({Title = "Alert on Load", Content = "Alerts you when sunken chests are loaded. Required for Auto Farm (Recommended)"})

local EventsToggle2 = EventsTab:CreateToggle({
    Name = "Alert on Load",
    CurrentValue = config.sunkenchestList.alertonload,
    Flag = "EventsToggle2",
    Callback = function(Value)
        if not Value and config.sunkenchestList.autofarm then
            Rayfield:Notify({
                Title = "Alert on Load",
                Content = "Alert on Load is required for Auto Farm!",
                Duration = 5,
                Image = nil,
            })
        elseif Value and not config.sunkenchestList.enabled then
            Rayfield:Notify({
                Title = "Alert on Load",
                Content = "Sunken Chest Toggle is off!",
                Duration = 5,
                Image = nil,
            })
        else
            config.sunkenchestList.alertonload = Value
            saveConfig()
        end
    end,
})

local EventsParagraph6 = EventsTab:CreateParagraph({Title = "Sunken Chest Hop After Claim", Content = "Automatically server hops after you claim the sunken chest"})

local EventsToggle3 = EventsTab:CreateToggle({
    Name = "Hop After Claim",
    CurrentValue = config.sunkenchestList.hopafterclaim,
    Flag = "EventsToggle3",
    Callback = function(Value)
        if Value and not config.sunkenchestList.enabled then
            Rayfield:Notify({
                Title = "Hop After Claim",
                Content = "Sunken Chest Toggle is off!",
                Duration = 5,
                Image = nil,
            })
        else
            config.sunkenchestList.hopafterclaim = Value
            saveConfig()
        end
    end,
})

local EventsParagraph7 = EventsTab:CreateParagraph({Title = "Sunken Chest Auto Farm", Content = "Automatically searches for and opens sunken chests when you join a server (Auto Hop is recommended)"})

local EventsToggle4 = EventsTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = config.sunkenchestList.autofarm,
    Flag = "EventsToggle4",
    Callback = function(Value)
        if Value and not config.sunkenchestList.enabled then
            Rayfield:Notify({
                Title = "Auto Farm",
                Content = "Sunken Chest Toggle is off!",
                Duration = 5,
                Image = nil,
            })
        else
            if Value then
                sunkenSet(2, true)
            else
                sunkenSet(5, false)
            end
            config.sunkenchestList.autofarm = Value
            saveConfig()
        end
    end,
})

local EventsParagraph8 = EventsTab:CreateParagraph({Title = "Sunken Chest Force Hop", Content = "Server hops even if there are other desired features, requires Auto Farm and Auto Hop!"})

local EventsToggle5 = EventsTab:CreateToggle({
    Name = "Force Hop",
    CurrentValue = config.sunkenchestList.forcehop,
    Flag = "EventsToggle4",
    Callback = function(Value)
        if Value and not config.sunkenchestList.autofarm then
            Rayfield:Notify({
                Title = "Force Hop",
                Content = "Auto Farm is off!",
                Duration = 5,
                Image = nil,
            })
        elseif Value and not config.autohop then
            Rayfield:Notify({
                Title = "Force Hop",
                Content = "Auto Hop is off!",
                Duration = 5,
                Image = nil,
            })
        else
            config.sunkenchestList.forcehop = Value
            saveConfig()
        end
    end,
})

sunkenSet = function(thing, value)
    local object
    if thing == 0 then
        object = EventsToggle1
    elseif thing == 1 then
        object = EventsSlider1
    elseif thing == 2 then
        object = EventsToggle2
    elseif thing == 3 then
        object = EventsToggle3
    elseif thing == 4 then
        object = EventsToggle4
    elseif thing == 5 then
        object = EventsToggle5
    end

    object:Set(value)
end

mergeConfig(data.defaultConfig, config)
saveConfig()
mergeConfig(data.defaultFishConfig, fishConfig)
saveFishConfig()
mergeConfig(data.defaultGuiConfig, guiConfig)
saveGuiConfig()

print("[FSF-G] Loaded!")