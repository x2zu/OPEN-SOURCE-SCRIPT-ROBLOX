local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LocalPlayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create Window
local Window = Fluent:CreateWindow({
    Title = "Auto Enchant",
    SubTitle = "by Monkeys",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Create Tab
local Tabs = {
    Enchant = Window:AddTab({ Title = "Auto Enchant", Icon = "wand-magic-sparkles" })
}

-- Enchant Data
local Enchants = {
    ["Blessed Song"] = { IsExalted = false, IsSongOfTheDeep = true },
    ["Sea King"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Swift"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Long"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Ghastly"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Lucky"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Divine"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Mutated"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Unbreakable"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Herculean"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Steady"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Blessed"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Wormhole"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Resilient"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Controlled"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Storming"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Scrapper"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Breezed"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Insight"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Clever"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Noir"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Hasty"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Quality"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Abyssal"] = { IsExalted = false, IsSongOfTheDeep = false },
    ["Mystical"] = { IsExalted = true, IsSongOfTheDeep = false },
    ["Quantum"] = { IsExalted = true, IsSongOfTheDeep = false },
    ["Invincible"] = { IsExalted = true, IsSongOfTheDeep = false },
    ["Piercing"] = { IsExalted = true, IsSongOfTheDeep = false },
    ["Anomalous"] = { IsExalted = true, IsSongOfTheDeep = false },
    ["Sea Overlord"] = { IsExalted = true, IsSongOfTheDeep = false },
    ["Immortal"] = { IsExalted = true, IsSongOfTheDeep = false }
}

-- List of Enchant Names
local EnchantNames = {}
for name in pairs(Enchants) do
    table.insert(EnchantNames, name)
end
table.sort(EnchantNames)

-- Variables
getgenv().SelectedEnchant = nil
getgenv().AutoEnchantEnabled = false
getgenv().IsHoldingExalted = false

-- Function cari altar
local function FindEnchantAltar()
    local tpSpots = workspace:FindFirstChild("world") and workspace.world:FindFirstChild("spawns") and workspace.world.spawns:FindFirstChild("TpSpots")
    if not tpSpots then return nil end
    local altar = tpSpots:FindFirstChild("enchantaltar") or tpSpots:FindFirstChild("altar")
    return altar
end

-- Function update relic status
local function UpdateRelicStatus()
    if LocalPlayer.Character then
        getgenv().IsHoldingExalted = LocalPlayer.Character:FindFirstChild("Exalted Relic") ~= nil
    else
        getgenv().IsHoldingExalted = false
    end
end

-- Dropdown pilih enchant
local EnchantDropdown = Tabs.Enchant:AddDropdown("EnchantDropdown", {
    Title = "Select Enchant",
    Values = EnchantNames,
    Multi = false,
    Default = nil,
    Callback = function(value)
        if not value or value == "" then
            Fluent:Notify({ Title = "Error", Content = "No enchant selected!", Duration = 5 })
            return
        end
        getgenv().SelectedEnchant = value
        local enchantData = Enchants[value]
        Fluent:Notify({
            Title = enchantData.IsExalted and "Exalted Enchant" or "Enchant Selected",
            Content = enchantData.IsExalted and (value .. " requires an Exalted Relic!") or ("Selected: " .. value),
            Duration = 5
        })
    end
})

-- Toggle auto enchant
local AutoEnchantToggle = Tabs.Enchant:AddToggle("AutoEnchantToggle", {
    Title = "Auto Enchant",
    Default = false,
    Callback = function(state)
        getgenv().AutoEnchantEnabled = state

        if state then
            if not getgenv().SelectedEnchant or not Enchants[getgenv().SelectedEnchant] then
                Fluent:Notify({ Title = "Error", Content = "Please select a valid enchant!", Duration = 5 })
                getgenv().AutoEnchantEnabled = false
                AutoEnchantToggle:Set(false)
                return
            end

            local selectedData = Enchants[getgenv().SelectedEnchant]
            local requiredRelic = selectedData.IsExalted and "Exalted Relic" or "Enchant Relic"
            UpdateRelicStatus()

            if not LocalPlayer.Character or 
               (selectedData.IsExalted and not getgenv().IsHoldingExalted) or 
               (not selectedData.IsExalted and not LocalPlayer.Character:FindFirstChild("Enchant Relic")) then
                Fluent:Notify({ Title = "Error", Content = "Please hold a " .. requiredRelic .. "!", Duration = 5 })
                getgenv().AutoEnchantEnabled = false
                AutoEnchantToggle:Set(false)
                return
            end

            spawn(function()
                while getgenv().AutoEnchantEnabled and LocalPlayer.Character do
                    UpdateRelicStatus()

                    if (selectedData.IsExalted and not getgenv().IsHoldingExalted) or 
                       (not selectedData.IsExalted and not LocalPlayer.Character:FindFirstChild("Enchant Relic")) then
                        Fluent:Notify({ Title = "Error", Content = "Relic not found!", Duration = 5 })
                        getgenv().AutoEnchantEnabled = false
                        AutoEnchantToggle:Set(false)
                        break
                    end

                    if ReplicatedStorage:FindFirstChild("world") and ReplicatedStorage.world:FindFirstChild("cycle") and ReplicatedStorage.world.cycle.Value ~= "Night" then
                        Fluent:Notify({ Title = "Error", Content = "Can only enchant at night!", Duration = 5 })
                        getgenv().AutoEnchantEnabled = false
                        AutoEnchantToggle:Set(false)
                        break
                    end

                    local altar = FindEnchantAltar()
if altar and altar:IsA("BasePart") then
    -- Teleport ke posisi fix
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1310, -799, -82)

    task.wait(0.5)

    local prompt = altar:FindFirstChildOfClass("ProximityPrompt")
    if prompt then
        fireproximityprompt(prompt)

        task.wait(0.5)

        local gui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("over")
        if gui and gui:FindFirstChild("prompt") and gui.prompt:FindFirstChild("confirm") then
            firesignal(gui.prompt.confirm.MouseButton1Click)
        end

        task.wait(1)

        local rod = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if rod and rod:FindFirstChild("Enchantment") and rod.Enchantment.Value == getgenv().SelectedEnchant then
            Fluent:Notify({ Title = "Success", Content = "Enchant Successful!", Duration = 5 })
            getgenv().AutoEnchantEnabled = false
            AutoEnchantToggle:Set(false)
            break
        end
    else
        Fluent:Notify({ Title = "Error", Content = "No ProximityPrompt found!", Duration = 5 })
        getgenv().AutoEnchantEnabled = false
        AutoEnchantToggle:Set(false)
        break
    end
else
    Fluent:Notify({ Title = "Error", Content = "Enchant Altar not found!", Duration = 5 })
    getgenv().AutoEnchantEnabled = false
    AutoEnchantToggle:Set(false)
    break
end


                    task.wait(1)
                end
            end)
        else
            Fluent:Notify({ Title = "Auto Enchant", Content = "Auto Enchant OFF", Duration = 5 })
        end
    end
})

-- Start UI
Window:SelectTab(1)
Fluent:Notify({
    Title = "Auto Enchant Loaded",
    Content = "Select enchant and toggle ON! Exalted requires Exalted Relic.",
    Duration = 5
})
