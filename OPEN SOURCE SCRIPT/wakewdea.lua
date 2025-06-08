local EnchantSection = Automatically:AddSection({Title = "Enchants"})
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

-- List of enchant names for dropdown
local EnchantNames = {}
for name in pairs(Enchants) do
    table.insert(EnchantNames, name)
end
table.sort(EnchantNames)

-- Variables
getgenv().SelectedEnchant = nil
getgenv().AutoEnchantEnabled = false
getgenv().IsHoldingExalted = false

-- Function to update relic status
local function UpdateRelicStatus()
    if LocalPlayer.Character then
        getgenv().IsHoldingExalted = LocalPlayer.Character:FindFirstChild("Exalted Relic") ~= nil
    else
        getgenv().IsHoldingExalted = false
    end
end

-- Dropdown for Enchant Selection (similar to CheckValues in your example)
local EnchantDropdown = EnchantSection:AddDropdown("EnchantDropdown", {
    Title = "Select Enchant",
    Values = EnchantNames,
    Multi = false,
    Default = nil,
    Callback = function(value)
        if not value or value == "" then
            StellarLibrary:Notify({
                Title = "Error",
                Content = "No enchant selected!",
                Duration = 5
            })
            return
        end
        
        getgenv().SelectedEnchant = value
        local enchantData = Enchants[value]
        StellarLibrary:Notify({
            Title = enchantData.IsExalted and "Exalted Enchant" or "Enchant Selected",
            Content = enchantData.IsExalted and 
                (value .. " requires an Exalted Relic!") or 
                ("Selected: " .. value),
            Duration = 5
        })
    end
})

-- Toggle for Auto Enchant
local AutoEnchantToggle = EnchantSection:AddToggle("AutoEnchantToggle", {
    Title = "Auto Enchant",
    Default = false,
    Callback = function(state)
        getgenv().AutoEnchantEnabled = state
        
        if state then
            if not getgenv().SelectedEnchant or not Enchants[getgenv().SelectedEnchant] then
                StellarLibrary:Notify({
                    Title = "Error",
                    Content = "Please select a valid enchant!",
                    Duration = 5
                })
                getgenv().AutoEnchantEnabled = false
                AutoEnchantToggle:Set(false) -- Visually toggle off
                return
            end
            
            local selectedData = Enchants[getgenv().SelectedEnchant]
            local requiredRelic = selectedData.IsExalted and "Exalted Relic" or "Enchant Relic"
            UpdateRelicStatus()
            
            if not LocalPlayer.Character or 
               (selectedData.IsExalted and not getgenv().IsHoldingExalted) or 
               (not selectedData.IsExalted and not LocalPlayer.Character:FindFirstChild("Enchant Relic")) then
                StellarLibrary:Notify({
                    Title = "Error",
                    Content = "Please hold a " .. requiredRelic .. "!",
                    Duration = 5
                })
                getgenv().AutoEnchantEnabled = false
                AutoEnchantToggle:Set(false)
                return
            end
            
            spawn(function()
                while getgenv().AutoEnchantEnabled and LocalPlayer.Character do
                    UpdateRelicStatus()
                    
                    if (selectedData.IsExalted and not getgenv().IsHoldingExalted) or 
                       (not selectedData.IsExalted and not LocalPlayer.Character:FindFirstChild("Enchant Relic")) then
                        StellarLibrary:Notify({
                            Title = "Error",
                            Content = "Please hold a " .. requiredRelic .. "!",
                            Duration = 5
                        })
                        getgenv().AutoEnchantEnabled = false
                        AutoEnchantToggle:Set(false)
                        break
                    end
                    
                    if ReplicatedStorage.world.cycle.Value ~= "Night" then
                        StellarLibrary:Notify({
                            Title = "Error",
                            Content = "Can only enchant at night!",
                            Duration = 5
                        })
                        getgenv().AutoEnchantEnabled = false
                        AutoEnchantToggle:Set(false)
                        break
                    end
                    
                    if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1310, -799, -82)
                    else
                        StellarLibrary:Notify({
                            Title = "Error",
                            Content = "Character root part not found!",
                            Duration = 5
                        })
                        getgenv().AutoEnchantEnabled = false
                        AutoEnchantToggle:Set(false)
                        break
                    end
                    
                    local altar = workspace.world.interactables:FindFirstChild("Enchant Altar")
                    if altar and altar:FindFirstChild("ProximityPrompt") then
                        fireproximityprompt(altar.ProximityPrompt)
                        
                        task.wait(0.5)
                        local confirm = LocalPlayer.PlayerGui:FindFirstChild("over") and 
                            LocalPlayer.PlayerGui.over:FindFirstChild("prompt") and 
                            LocalPlayer.PlayerGui.over.prompt:FindFirstChild("confirm")
                        if confirm then
                            firesignal(confirm.MouseButton1Click)
                        end
                        
                        task.wait(1)
                        local rod = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        if rod and rod:FindFirstChild("Enchantment") then
                            if rod.Enchantment.Value == getgenv().SelectedEnchant then
                                Fluent:Notify({
                                    Title = "Success",
                                    Content = "Successfully applied " .. getgenv().SelectedEnchant .. "!",
                                    Duration = 5
                                })
                                getgenv().AutoEnchantEnabled = false
                                AutoEnchantToggle:Set(false)
                                break
                            end
                        end
                    else
                        StellarLibrary:Notify({
                            Title = "Error",
                            Content = "Enchant Altar not found!",
                            Duration = 5
                        })
                        getgenv().AutoEnchantEnabled = false
                        AutoEnchantToggle:Set(false)
                        break
                    end
                    
                    task.wait(1)
                end
            end)
        else
            StellarLibrary:Notify({
                Title = "Auto Enchant",
                Content = "Auto Enchant toggled OFF",
                Duration = 5
            })
        end
    end
})
