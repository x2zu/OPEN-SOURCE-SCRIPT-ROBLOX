repeat
    wait()
until game:IsLoaded()

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local VIM = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local WorldFolder = workspace:FindFirstChild("world")
local ActiveFolder = workspace:FindFirstChild('active')
local ZoneFolder = workspace:FindFirstChild('zones')
local LocalPlayerPawn = Players.LocalPlayer

local Hint = Instance.new("Hint", game.CoreGui)
Hint.Text = "Vixie | Waiting for game to load..."


LocalPlayerPawn.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

if WorldFolder == nil then
    LocalPlayerPawn:Kick("[VIXIE] Sorry but couldn't find world folder, Did Fisch have an update?")
    return
end

if ActiveFolder == nil then
    LocalPlayerPawn:Kick("[VIXIE] Sorry but couldn't find active folder, Did Fisch have an update?")
    return
end

if ZoneFolder == nil then
    LocalPlayerPawn:Kick("[VIXIE] Sorry but couldn't find zone folder, Did Fisch have an update?")
    return
end

local TpFolder = WorldFolder:WaitForChild("spawns"):WaitForChild("TpSpots") 
local NpcFolder = WorldFolder:WaitForChild("npcs")
local tp_locations = loadstring(game:HttpGet("https://raw.githubusercontent.com/ProjektEta/Vixie.lua/refs/heads/main/Tools/Fisch/TeleportAreas.lua"))()
local worldevents =loadstring(game:HttpGet("https://raw.githubusercontent.com/ProjektEta/Vixie.lua/refs/heads/main/Tools/Fisch/WorldEvents.lua"))()
local roddata = loadstring(game:HttpGet("https://raw.githubusercontent.com/ProjektEta/Vixie.lua/refs/heads/main/Tools/Fisch/RodData.lua"))()
local baitdata = loadstring(game:HttpGet("https://raw.githubusercontent.com/ProjektEta/Vixie.lua/refs/heads/main/Tools/Fisch/BaitData.lua"))()
local AppraisialData = loadstring(game:HttpGet("https://raw.githubusercontent.com/ProjektEta/Vixie.lua/refs/heads/main/Tools/Fisch/AppraisalData.lua"))()
local FishData = loadstring(game:HttpGet("https://raw.githubusercontent.com/ProjektEta/Vixie.lua/refs/heads/main/Tools/Fisch/FishData.lua"))()

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ProjektEta/Vixie.lua/refs/heads/main/Tools/Universal/UI.lua"))()
local Window = lib:Window({
    Name = "Vixie.lua",
    Version = "<font color=\"#FFC0CB\">version: </font> keyless | v1.1"
})
local pointers = Window.Flags 

getgenv().VIXIE_GLOBALS = {
    getBait = function()
        local best, bvalue = nil, -math.huge

        for _,v in pairs(game.ReplicatedStorage.playerstats[LocalPlayerPawn.Name].Stats.bait:GetChildren()) do
            if v.Value == 0 then continue end
            if pointers['autobait_type'] == "Quantity" then

                local cvalue = v.Value

                if pointers["autobait_filtertype"] == "Worst" then
                    if cvalue < bvalue or bvalue == -math.huge then
                        bvalue = cvalue
                        best = v.Name
                    end
                else
                    if cvalue > bvalue then
                        bvalue = cvalue
                        best = v.Name
                    end
                end
            
            elseif pointers['autobait_type'] == "Universal Luck" then
                local cvalue = baitdata[string.split(v.Name, "_")[2]]
                if not cvalue then continue end
                if pointers['autobait_filtertype'] == "Worst" then
                    if cvalue == nil then continue end

                    if tonumber(cvalue.Luck) < bvalue or bvalue == -math.huge then
                        bvalue = tonumber(cvalue.Luck)
                        best = v.Name
                    end
                else
                    if tonumber(cvalue.Luck) > bvalue then
                        bvalue = tonumber(cvalue.Luck)
                        best = v.Name
                    end
                end

            elseif pointers['autobait_type'] == "Luck" then
                local cvalue = baitdata[string.split(v.Name, "_")[2]]
                if not cvalue then continue end
                if pointers['autobait_filtertype'] == "Worst" then
                    if cvalue == nil then continue end

                    if tonumber(cvalue.Luck) < bvalue or bvalue == -math.huge then
                        bvalue = tonumber(cvalue.Luck)
                        best = v.Name
                    end
                else
                    if tonumber(cvalue.Luck) > bvalue then
                        bvalue = tonumber(cvalue.Luck)
                        best = v.Name
                    end
                end
            
            elseif pointers['autobait_type'] == "Lure Speed" then
                local cvalue = baitdata[string.split(v.Name, "_")[2]]
                if not cvalue then continue end
                if pointers['autobait_filtertype'] == "Worst" then
                    if cvalue == nil then continue end

                    if tonumber(cvalue.LureSpeed) < bvalue or bvalue == -math.huge then
                        bvalue = tonumber(cvalue.LureSpeed)
                        best = v.Name
                    end
                else
                    if tonumber(cvalue.LureSpeed) > bvalue then
                        bvalue = tonumber(cvalue.LureSpeed)
                        best = v.Name
                    end
                end

            elseif pointers['autobait_type'] == "Resilience" then
                local cvalue = baitdata[string.split(v.Name, "_")[2]]
                if not cvalue then continue end
                    if pointers['autobait_filtertype'] == "Worst" then
                        if cvalue == nil then continue end
    
                        if tonumber(cvalue.Resilience) < bvalue or bvalue == -math.huge then
                            bvalue = tonumber(cvalue.Resilience)
                            best = v.Name
                        end
                    else
                        if tonumber(cvalue.Resilience) > bvalue then
                            bvalue = tonumber(cvalue.Resilience)
                            best = v.Name
                        end
                    end

            elseif pointers['autobait_type'] == "Resilience" then
                local cvalue = baitdata[string.split(v.Name, "_")[2]]
                if not cvalue then continue end
                    if pointers['autobait_filtertype'] == "Worst" then
                        if cvalue == nil then continue end
    
                        if tonumber(cvalue.Resilience) < bvalue or bvalue == -math.huge then
                            bvalue = tonumber(cvalue.Resilience)
                            best = v.Name
                        end
                    else
                        if tonumber(cvalue.Resilience) > bvalue then
                            bvalue = tonumber(cvalue.Resilience)
                            best = v.Name
                        end
                    end
            
            elseif pointers['autobait_type'] == "Rarity" then
                
                local rarValue = {
                    ["Common"] = 1,
                    ["Uncommon"] = 1.5,
                    ["Unusual"] = 2,
                    ["Rare"] = 3,
                    ["Legendary"] = 4,
                    ["Mythical"] = 5,
                }
                local cvalue = baitdata[string.split(v.Name, "_")[2]]
                if not cvalue then continue end
                        if pointers['autobait_filtertype'] == "Worst" then
                            if cvalue == nil then continue end
        
                            if rarValue[cvalue.Rarity] < bvalue or bvalue == -math.huge then
                                bvalue = rarValue[cvalue.Rarity]
                                best = v.Name
                            end
                        else
                            if rarValue[cvalue.Rarity] > bvalue then
                                bvalue = rarValue[cvalue.Rarity]
                                best = v.Name
                            end
                        end

            end
        end

        if best then
            if LocalPlayerPawn.PlayerGui:FindFirstChild("reel") then
                repeat
                    task.wait()
                until not LocalPlayerPawn.PlayerGui:FindFirstChild("reel")
            end

            local __equippedItem = LocalPlayerPawn.Character:FindFirstChildWhichIsA("Tool")
            LocalPlayerPawn.Character.Humanoid:UnequipTools()
            task.wait(.1)
            LocalPlayerPawn.Backpack['Equipment Bag'].Parent = LocalPlayerPawn.Character
            task.wait(.1)
            warn(best)
            game.ReplicatedStorage.packages.Net['RE/Bait/Equip']:FireServer(string.split(best, "_")[2])
            task.wait(.1)
            LocalPlayerPawn.Character.Humanoid:UnequipTools()
            task.wait(.5)
            if __equippedItem then
                __equippedItem.Parent = LocalPlayerPawn.Character
            end

            return
        end
    end
}

local AutomationPage = Window:Page({
    Name = "Automation"
})

local ClientPage = Window:Page({
    Name = "Client"
})

local WorldPage = Window:Page({
    Name = "World"
})

local MiscPage = Window:Page({
    Name = "Misc"
})

do -- AutomationPage

    local AutomationSec = AutomationPage:Section({
        Name = "Automation",
        LeftTitle = "Options",
        RightTitle = "Settings"
    })

    local AutoAppraise = AutomationPage:Section({
        Name = "Auto Appraise",
        LeftTitle = "Options",
        RightTitle = "Settings"
    })

    AutoAppraise:Toggle({
        State = false,
        Flag = "autopraise_enabled",
        Side = "Left",
        Name = "Auto Appraise",
        Callback = function(v)
            if v == true and not pointers['autofish_enabled'] then
                
                local heldFish = LocalPlayerPawn.Character:FindFirstChildWhichIsA("Tool")
                local v = nil
                if heldFish and heldFish:FindFirstChild("link") then
                    v = heldFish.link.Value
                else
                    return
                end

                if not v then return end

                local _oldCF = LocalPlayerPawn.Character.HumanoidRootPart.CFrame
                LocalPlayerPawn.Character.HumanoidRootPart.CFrame = CFrame.new(448.253815, 150.538727, 206.717392, 0.0551895462, -4.95227894e-08, -0.998475909, 3.75087801e-08, 1, -4.75251305e-08, 0.998475909, -3.4828723e-08, 0.0551895462)

                local hasMutation = false

                repeat
                    local WantedMutation = pointers['autoAppraiseType']
                    local curMutation = "NULL"

                    if heldFish and heldFish:FindFirstChild("link") then
                        v = heldFish.link.Value
                    else
                        break
                    end
    
                    if not v then break end

                    task.wait(.1)
                    workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Appraiser"):WaitForChild("appraiser"):WaitForChild("appraise"):InvokeServer()

                    if v:FindFirstChild("Mutation") == nil then
                        curMutation = "NULL"
                    else
                        curMutation = v.Mutation.Value
                    end

                    if curMutation == WantedMutation then
                        hasMutation = true
                    end

                    task.wait(.3)
                    heldFish.Parent = LocalPlayerPawn.Character

                    if game.ReplicatedStorage.playerstats[LocalPlayerPawn.Name].Stats.coins.Value <= 250 then
                        break
                    end
                until hasMutation or pointers['autopraise_enabled'] == false
                LocalPlayerPawn.Character.HumanoidRootPart.CFrame = _oldCF
            end
        end
    })

    AutoAppraise:List({
        Options = AppraisialData,
        Max = #AppraisialData,
        State = "",
        Flag = "autoAppraiseType",
        Side = "Right",
        Name = "Auto Appraise",
    })
    
    AutomationSec:Toggle({
        State = false,
        Flag = "autofish_enabled",
        Side = "Left",
        Name = "Autofish",
    })

    AutomationSec:Toggle({
        State = false,
        Flag = "autosell_enabled",
        Side = "Left",
        Name = "Auto Sell",
    })

    AutomationSec:Toggle({
        State = false,
        Flag = "autobait_enabled",
        Side = "Left",
        Name = "Auto Bait",
    })

    AutomationSec:List({
        Options = {
            "GuiService",
        },
        Max = 1,
        State = "GuiService",
        Flag = "autoshake_type",
        Side = "Left",
        Name = "Auto Shake Type",
    })

    AutomationSec:List({
        Options = {
            "Always Perfect",
            "Legit",
            "Instant",
            "Legit Instant"
        },
        Max = 4,
        State = "Instant",
        Flag = "autoreel_type",
        Side = "Left",
        Name = "Auto Reel Type",
    })

    AutomationSec:List({
        Options = {
            "Quantity",
            "Universal Luck",
            "Lure Speed",
            "Luck",
            "Resilience",
            "Rarity"
        },
        Max = 6,
        State = "Quantity",
        Flag = "autobait_type",
        Side = "Right",
        Name = "Auto bait Filter",
    })

    
    AutomationSec:List({
        Options = {
            "Worst",
            "Best"
        },
        Max = 2,
        State = "Best",
        Flag = "autobait_filtertype",
        Side = "Right",
        Name = "Auto bait Filter Type",
    })

    AutomationSec:Slider({
        Name = "Cast Delay",
        Min = 1,
        State = 2,
        Max = 5,
        Suffix = "s",
        Side = "Right",
        Decimals = .1,
        Flag = "autocast_delay"
    })

    AutomationSec:Slider({
        Name = "Shake Delay",
        Min = 0,
        State = 0,
        Max = 500,
        Suffix = "ms",
        Side = "Right",
        Decimals = 5,
        Flag = "autoshake_delay"
    })

    AutomationSec:Slider({
        Name = "Instant Reel Delay",
        Min = 1,
        State = 2,
        Max = 5,
        Suffix = "s",
        Side = "Right",
        Decimals = .1,
        Flag = "autoreel_delay"
    })

    AutomationSec:Slider({
        Name = "Instant Perfect Chance",
        Min = 0,
        State = 50,
        Max = 100,
        Suffix = "%",
        Side = "Right",
        Decimals = 1,
        Flag = "autoreel_pchance"
    })




end

do -- client section

    local ClientSec = ClientPage:Section({
        Name = "Client",
        LeftTitle = "Local Character",
        RightTitle = "Interactions"
    })

    local UISec = ClientPage:Section({
        Name = "UI",
        LeftTitle = "UI",
        RightTitle = ""
    })

    local uiDeathConn = false
    UISec:Toggle({
        State = false,
        Flag = "ui_death_toggle",
        Side = "Left",
        Name = "Anti-Death UI",
        Callback = function(v)        
            
            if v == true then
                uiDeathConn = LocalPlayerPawn.PlayerGui:WaitForChild("death")
                uiDeathConn = uiDeathConn:GetPropertyChangedSignal("Enabled"):Connect(function(v)
                    if v == true then LocalPlayerPawn.PlayerGui.death.Enabled = false end
                end)
            elseif uiDeathConn then
                uiDeathConn:Disconnect()
            end

        end
    })

    UISec:Button({
        Side = "Left",
        Name = "Spoof Player Name",
        Callback = function()  
            LocalPlayerPawn.Character.HumanoidRootPart.user.level.Text = "BEST FREE SCRIPT"
            LocalPlayerPawn.Character.HumanoidRootPart.user.user.Text = "VIXIE USER"
            LocalPlayerPawn.Character.HumanoidRootPart.user.streak.Text = "VIXIE.LUA FREE"
            LocalPlayerPawn.Character.HumanoidRootPart.user.title.Text = "BEST FREE SCRIPT"
            LocalPlayerPawn.Character.HumanoidRootPart.user.fish:Destroy()
            LocalPlayerPawn.Character.HumanoidRootPart.user.fire:Destroy()  
        end 
    })

    local __freezeCFrame = CFrame.new(0,0,0)
    local freezeCon = nil
    ClientSec:Toggle({
        State = false,
        Flag = "freezechar_enabled",
        Side = "Left",
        Name = "Freeze Character",
        Callback = function(v)        
            __freezeCFrame = LocalPlayerPawn.Character.HumanoidRootPart.CFrame

            if v == true then
                freezeCon = game:GetService("RunService").RenderStepped:Connect(function()
                    LocalPlayerPawn.Character.HumanoidRootPart.CFrame = __freezeCFrame
                end)
            else
                if freezeCon then
                    freezeCon:Disconnect()
                end
            end
        end
    })

    local CharAntiDrownCon = nil
    ClientSec:Toggle({
        State = false,
        Flag = "infoxygen_enabled",
        Side = "Left",
        Name = "No Drowning",
        Callback = function(v)
            local s,e = pcall(function()
                if v == true then
                    LocalPlayerPawn.Character.Resources.oxygen.Enabled = false	
                    LocalPlayerPawn.Character.Resources["oxygen(peaks)"].Enabled = false
                    CharAntiDrownCon = LocalPlayerPawn.Character.CharacterAdded:Connect(function()	
                        LocalPlayerPawn.Character.Resources.oxygen.Enabled = false	
                        LocalPlayerPawn.Character.Resources["oxygen(peaks)"].Enabled = false
                    end)
                else	
                    LocalPlayerPawn.Character.Resources.oxygen.Enabled = true	
                    LocalPlayerPawn.Character.Resources["oxygen(peaks)"].Enabled = true
        
                    if CharAntiDrownCon then
                        CharAntiDrownCon:Disconnect()
                    end
                end 
            end)
        end
    })

    local AntiTempCharConn = nil
    ClientSec:Toggle({
        State = false,
        Flag = "inftemp_enabled",
        Side = "Left",
        Name = "No Freezing",
        Callback = function(v)
            local s,e = pcall(function()
                if v == true then
                    LocalPlayerPawn.Character.Resources.temperature.Enabled = false	
                    LocalPlayerPawn.Character.Resources["temperature(heat)"].Enabled = false	
                    AntiTempCharConn = LocalPlayerPawn.Character.CharacterAdded:Connect(function()	
                        LocalPlayerPawn.Character.Resources.temperature.Enabled = false	
                        LocalPlayerPawn.Character.Resources["temperature(heat)"].Enabled = false
                    end)
                else	
                    LocalPlayerPawn.Character.Resources.temperature.Enabled = true	
                    LocalPlayerPawn.Character.Resources["temperature(heat)"].Enabled = true
        
                    if AntiTempCharConn then
                        AntiTempCharConn:Disconnect()
                    end
                end 
            end)
        end
    })

    ClientSec:Button({
        Side = "Right",
        Name = "Sell Held Fish",
        Callback = function(v)
            game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("Sell"):InvokeServer()
        end
    })

    ClientSec:Button({
        Side = "Right",
        Name = "Sell All Fish",
        Callback = function(v)
            game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("SellAll"):InvokeServer()
        end
    })

    ClientSec:Button({
        Side = "Right",
        Name = "Appraise Held Fish (450)",
        Callback = function(v)
            local _oldCF = LocalPlayerPawn.Character.HumanoidRootPart.CFrame
            task.wait()
            LocalPlayerPawn.Character.HumanoidRootPart.CFrame = CFrame.new(448.253815, 150.538727, 206.717392, 0.0551895462, -4.95227894e-08, -0.998475909, 3.75087801e-08, 1, -4.75251305e-08, 0.998475909, -3.4828723e-08, 0.0551895462)
            workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Appraiser"):WaitForChild("appraiser"):WaitForChild("appraise"):InvokeServer()
            task.wait()
            LocalPlayerPawn.Character.HumanoidRootPart.CFrame = _oldCF
        end
    })

    ClientSec:Button({
        Side = "Right",
        Name = "Fix Held Map (250)",
        Callback = function(v)
            local _oldCF = LocalPlayerPawn.Character.HumanoidRootPart.CFrame
            task.wait()
            LocalPlayerPawn.Character.HumanoidRootPart.CFrame = CFrame.new(-2823.90112, 214.34288, 1515.54041, -0.20666413, -3.82791967e-08, 0.978411973, 5.99187189e-08, 1, 5.17800807e-08, -0.978411973, 6.93262763e-08, -0.20666413)
            workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Jack Marrow"):WaitForChild("treasure"):WaitForChild("repairmap"):InvokeServer()
            task.wait()
            LocalPlayerPawn.Character.HumanoidRootPart.CFrame = _oldCF
        end
    })

    local listA = {}
    local listB = {}

    local pvr = ClientSec:List({
        Options = {},
        Max = 0,
        State = "",
        Flag = "purcahseValidRods",
        Side = "Right",
        Name = "Purchase Rod",
        Callback = function(v)
            if v == nil or v == "" then return end

            local rodName = listB[v][1]
            local rodPrice = listB[v][2]

            if tonumber(rodPrice) > game.ReplicatedStorage.playerstats[LocalPlayerPawn.Name].Stats.coins.Value then
                return
            end

            game.ReplicatedStorage.events.purchase:FireServer(rodName, "Rod", rodPrice, 1)

            table.remove(listA, table.find(listA, v))
        end
    })

    for rodName, rodData in pairs(roddata) do
        if rodData.Price ~= "inf" and rodData.Price ~= "No Price" then

            if game.ReplicatedStorage.playerstats[LocalPlayerPawn.Name].Rods:FindFirstChild(rodName) then
                continue
            end

            table.insert(listA, rodName.." ($"..rodData.Price..")")
            listB[rodName.." ($"..rodData.Price..")"] = {rodName, rodData.Price}
        end
    end
    task.spawn(function()
        while task.wait(5) do pvr:Refresh(listA) end
    end)

end

do -- World

    local WorldSection = WorldPage:Section({
        Name = "World",
        LeftTitle = "Teleports",
        RightTitle = "Ocean"
    })

    local MiscSection = WorldPage:Section({
        Name = "Misc",
        LeftTitle = "Account Values",
        RightTitle = ""
    })

    local __t = {}
    local accV = MiscSection:List({
        Options = __t,
        Max = #__t,
        State = "",
        Flag = "accountValuechecker",
        Side = "Left",
        Name = "Check Account Value",
        Callback = function(v)
            if v == nil or v == "" then return end

            local data = game.ReplicatedStorage.playerstats:FindFirstChild(v)
            if not data then return end
            data = data.Inventory:GetChildren()

            local curValue = 0

            for _,v in pairs(data) do
                if FishData.Fish[v.Value] then
                    if v:FindFirstChild("Mutation") then
                        local fV = tonumber(FishData.Fish[v.Value].Price) * v.Stack.Value
                        if FishData.Mutations[v.Mutation.Value] then
                            fV *= tonumber(FishData.Mutations[v.Mutation.Value].PriceMultiply)
                        end

                        curValue += fV
                    else
                        curValue += tonumber(FishData.Fish[v.Value].Price) * v.Stack.Value
                    end
                end
            end

            Hint.Text = "Vixie | "..v.."'s Account is worth~: "..curValue.." C$"
            print("Vixie | "..v.."'s Account is worth~: "..curValue.." C$")

        end
    })

    game.ReplicatedStorage.playerstats.ChildAdded:Connect(function(c)
        table.insert(__t, c.Name)
        accV:Refresh(__t)
    end)

    game.ReplicatedStorage.playerstats.ChildRemoved:Connect(function(c)
        table.remove(__t, table.find(__t, c))
        accV:Refresh(__t)
    end)

    for _,v in pairs(game.ReplicatedStorage.playerstats:GetChildren()) do
        table.insert(__t, v.Name)
    end
    accV:Refresh(__t)

    WorldSection:Toggle({
        State = false,
        Flag = "walkOnWater",
        Side = "Right",
        Name = "Walk on Water",
        Callback = function(v)
            for _,v in pairs(ZoneFolder:WaitForChild("fishing"):GetChildren()) do
                if v:IsA("Part") then
                    v.CanCollide = v
                end
            end
        end
    })

    WorldSection:Button({
        Side = "Left",
        Name = "Teleport to treasure map",
        Callback = function()
            local getTool = LocalPlayerPawn.Character:FindFirstChild("Treasure Map")

            if getTool == nil and  getTool.link.Value.Repaired.Value == false then
                return
            end

            LocalPlayerPawn.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(getTool.link.Value.x.Value, getTool.link.Value.y.Value, getTool.link.Value.z.Value))
        end
    })

    local _tps = {}

    for i,v in pairs(tp_locations) do
        table.insert(_tps, i)
    end

    WorldSection:List({
        Options = _tps,
        Max = #_tps,
        State = "",
        Flag = "teleport_lcoation",
        Side = "Left",
        Name = "Teleports",
        Callback = function(v)
            if v == nil then
                return
            end
            LocalPlayerPawn.Character.HumanoidRootPart.CFrame = TpFolder[tp_locations[v]].CFrame + Vector3.new(0,4,0)
        end
    })

    local ___tFolder1 = {}
    local ___tFolder2 = {}

    local WorldEvents = WorldSection:List({
        Options = {},
        Max = 0,
        State = "",
        Flag = "worldevent_tp",
        Side = "Left",
        Name = "World Events TP",
        Callback = function(v)
            if v == nil then
                return
            end
            LocalPlayerPawn.Character.HumanoidRootPart.CFrame = ___tFolder1[v].CFrame + Vector3.new(0,4,0)
        end
    })
    ZoneFolder.fishing.ChildAdded:Connect(function(child)
        if worldevents[child.Name] then
            ___tFolder1[worldevents[child.Name]] = child
            table.insert(___tFolder2, worldevents[child.Name])     
            
            WorldEvents:Refresh(___tFolder2)
        end
    end)

    ZoneFolder.fishing.ChildRemoved:Connect(function(child)
        if table.find(___tFolder1, child) then
            local i = table.find(___tFolder1, child)
            ___tFolder1[i] = nil
            table.remove(___tFolder2, table.find(___tFolder2, i))

            WorldEvents:Refresh(___tFolder2)
        end
    end)

    for _,child in pairs(ZoneFolder.fishing:GetChildren()) do
        if worldevents[child.Name] then
            ___tFolder1[worldevents[child.Name]] = child
            table.insert(___tFolder2, worldevents[child.Name])     
            WorldEvents:Refresh(___tFolder2)       
        end
    end
end

do

    local MiscSection = MiscPage:Section({
        Name = "Misc",
        LeftTitle = "Options",
        RightTitle = "UI"
    })

    MiscSection:Button({
        Side = "Left",
        Name = "Join Our Discord",
        Callback = function(v)
            local s,e = pcall(function()
                request({
                    Url = "http://127.0.0.1:6463/rpc?v=1",
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["Origin"] = "https://discord.com"
                    },
                    Body = game:GetService("HttpService"):JSONEncode({
                        cmd = "INVITE_BROWSER",
                        args = {
                            code = "x4RfPQZvs2"
                        },
                        nonce = game:GetService("HttpService"):GenerateGUID(false)
                    }),
                })
            end)
        
            setclipboard("https://discord.gg/x4RfPQZvs2")
        end
    })

    MiscSection:Toggle({
        State = false,
        Flag = "useWebhook",
        Side = "Left",
        Name = "Use Webhook",
    })

    MiscSection:Textbox({
        State = "",
        Flag = "discord_webhook",
        Side = "Left",
        Name = "Webhook URL",
        holder = "",
        Callback = function(v)
            print(v)
        end
    })
    
    MiscSection:Keybind({
        State = Enum.KeyCode.End,
        Mode = "Toggle",
        Side = "Right",
        Flag = "UI_Config_Toggle",
        Name = "Menu Toggle",
        Callback = function()
            Window:SetOpen(not Window.Open)
        end
    })

end

local function mainLoop()
    
    game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("afk"):FireServer(false)
    
    if pointers["autofish_enabled"] == false then return end

    if pointers["autosell_enabled"] == true then
        game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("SellAll"):InvokeServer()
    end

    if pointers["autobait_enabled"] then
        getgenv().VIXIE_GLOBALS.getBait()
    end

    task.wait(1)

    local s,e = pcall(function()
        
        local event;

        for _,v in pairs(LocalPlayerPawn.Character:GetChildren()) do
            if v:IsA("Tool") then event = v end
        end
    
        event.events.cast:FireServer(100, 1)
    end)
    if e then
        warn(e)
        return
    end

    local __db = 0

    local ui = LocalPlayerPawn.PlayerGui:FindFirstChild("shakeui")
    repeat
        ui = LocalPlayerPawn.PlayerGui:FindFirstChild("shakeui")
        task.wait(.1)
        __db += 1

        if (__db > 20) then
            return
        end
    until ui

    repeat
        if ui:FindFirstChild("safezone") then
            if ui.safezone:FindFirstChild("button") then
                pcall(function()
                    if pointers["autoshake_type"] == "GuiService" then
                        GuiService.SelectedObject = ui.safezone:FindFirstChild("button")
                        if GuiService.SelectedObject == ui.safezone:FindFirstChild("button") then
                            VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                            VIM:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                        end
                    end
                end)
            end
        end
        task.wait(pointers["autoshake_delay"] / 1000)
        ui = LocalPlayerPawn.PlayerGui:FindFirstChild("shakeui")
        if not (ui) then ui = false end
    until not ui
    print("Shake ui disappeared")

    local bounceBack = 0
    
    ui = LocalPlayerPawn.PlayerGui:FindFirstChild("reel")
    repeat
       task.wait(.1)
       ui = LocalPlayerPawn.PlayerGui:FindFirstChild("reel") 
       bounceBack += 1
       if bounceBack >= 20 then
            print("protection")
            return;
       end
       
    until ui
    print("Found Reel UI")

    if pointers["autoreel_type"] == "Always Perfect" then
        repeat
            task.wait()
            if ui:FindFirstChild("bar") then
                local b = ui:FindFirstChild("bar")
                if b:FindFirstChild("fish") and b:FindFirstChild("playerbar") then
                    b:FindFirstChild("playerbar").Position = b:FindFirstChild("fish").Position
                end
            end
        
            ui = LocalPlayerPawn.PlayerGui:FindFirstChild("reel") 
            if not (ui) then ui = false end
        until not ui
        
        print("Finished!")
    elseif pointers["autoreel_type"]  == "Legit" then

        repeat
            task.wait()
            if ui:FindFirstChild("bar") then
                local b = ui:FindFirstChild("bar")
                if b:FindFirstChild("fish") and b:FindFirstChild("playerbar") then
                    b:FindFirstChild("playerbar").Position = b:FindFirstChild("fish").Position
                    local x = TweenService:Create(b:FindFirstChild("playerbar"),
                                TweenInfo.new(1, Enum.EasingStyle.Elastic), {Position = b:FindFirstChild("fish").Position})
                    x:Play()
                    x.Completed:Wait()
                end
            end
        
            ui = LocalPlayerPawn.PlayerGui:FindFirstChild("reel") 
            if not (ui) then ui = false end
        until not ui
        
        print("Finished!")

    elseif pointers["autoreel_type"]  == "Instant" then
        task.wait(pointers["autoreel_delay"])
        repeat
            task.wait()
            if ui:FindFirstChild("bar") then
                local b = ui:FindFirstChild("bar")
                if b:FindFirstChild("fish") and b:FindFirstChild("playerbar") then
                    b:FindFirstChild("playerbar").Position = b:FindFirstChild("fish").Position
                end

                local isPerfect = math.random(1, 100) < pointers["autoreel_pchance"]
                game.ReplicatedStorage.events["reelfinished "]:FireServer(100, isPerfect)
            end
            ui = LocalPlayerPawn.PlayerGui:FindFirstChild("reel") 
            if not (ui) then ui = false end
        until not ui 

    elseif pointers["autoreel_type"]  == "Legit Instant" then
        task.wait(pointers["autoreel_delay"])
        repeat
            task.wait()
            if ui:FindFirstChild("bar") then
                local b = ui:FindFirstChild("bar")
                if b:FindFirstChild("fish") and b:FindFirstChild("playerbar") then
                    b:FindFirstChild("playerbar").Position = b:FindFirstChild("fish").Position
                end
    
                if b:FindFirstChild("progress") then
                    if b:FindFirstChild("progress").bar.Size.X.Scale > .5 then
                        local isPerfect = math.random(1, 100) < pointers["autoreel_pchance"]
                        game.ReplicatedStorage.events["reelfinished "]:FireServer(100, isPerfect)
                    end
                end
            end
            ui = LocalPlayerPawn.PlayerGui:FindFirstChild("reel") 
            if not (ui) then ui = false end
        until not ui 
    end

    return;

end

local CpH = 0
local XpH = 0
local FpH = 0
local lXpH = 0
local lCpH = 0

local lastWebhook = os.time()


game.ReplicatedStorage.playerstats:FindFirstChild(LocalPlayerPawn.Name).Stats.coins.Changed:Connect(function(v)
    CpH += v - lCpH
end)

game.ReplicatedStorage.playerstats:FindFirstChild(LocalPlayerPawn.Name).Stats.xp.Changed:Connect(function(v)
    XpH += v - lXpH
end)

game.ReplicatedStorage.playerstats:FindFirstChild(LocalPlayerPawn.Name).Inventory.ChildAdded:Connect(function(newItem)
    FpH += 1

    if (pointers["usewebhooks"]) then
        local s,e = pcall(function()

            local _multi = 3600 / (os.time() - lastWebhook)

            CpH *= _multi
            XpH *= _multi
            FpH *= _multi

            lastWebhook = os.time()

            local Mutation = newItem:FindFirstChild("Mutation")
            if Mutation == nil then Mutation = "NULL" else Mutation = Mutation.Value end
            request({
                Url = pointers["webhookURL"],
                Method = "Post",
                Headers = {
                    ['content-type'] = "application/json",
                },
                Body = game:GetService("HttpService"):JSONEncode({
                    ['embeds'] = {{
                        ['title'] = "__**VIXIE AUTO FISHER**__",
                        ['description'] = "You have caught a fish...",
                        ['type'] = "rich",
                        ['color'] = tonumber(0xffffff),
                        ['fields'] = {
                            {
                                ["name"] = "You caught a "..newItem.Value,
                                ["value"] = "Wighet: "..newItem:WaitForChild("Weight").Value.."KG \nMutation: "..Mutation
                            },
                            {
                                ["name"] = LocalPlayerPawn.Name.." Stats",
                                ["value"] = "C$: "..LocalPlayerPawn.leaderstats['C$'].Value.."\nLevel: "..LocalPlayerPawn.leaderstats['Level'].Value
                            },
                            {
                                ["name"] = LocalPlayerPawn.Name.." Performance",
                                ["value"] = "C$/h: "..CpH.."\nXP/h: "..XpH.."\nLevels/h: "..(XpH / 10000).."\nFishes/h: "..FpH
                            },
                            {
                                ["name"] = "**ADVERTISEMENT**",
                                ["value"] = "JOIN FEMSENSE NOW! https://discord.gg/x4RfPQZvs2"
                            },
                        },
                        ['footer'] = {
                            ['text'] = "Eta is best femboy ^^"
                        }
                    }}
                })
            })

            lXpH = XpH / _multi
            lCpH = CpH / _multi

            CpH = 0
            XpH = 0
            FpH = 0
        end)
        if e then
            warn(e)
        end
    end
end)


while task.wait(pointers["autocast_delay"]) do
    local s,e = pcall(function()
        mainLoop()
    end)
    if e then
        warn(e)
    end
end