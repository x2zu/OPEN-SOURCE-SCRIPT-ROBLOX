        local AutoEnchant = Tabs.Automatically:AddSection("Auto Enchant")
        local Enchants = {
            ["Sea King"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Lucky"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Clever"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Sea Overlord"] = { IsExalted = true, IsSongOfTheDeep = false },
            ["Scrapper"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Steady"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Divine"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Long"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Swift"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Mystical"] = { IsExalted = true, IsSongOfTheDeep = false },
            ["Blessed Song"] = { IsExalted = false, IsSongOfTheDeep = true },
            ["Immortal"] = { IsExalted = true, IsSongOfTheDeep = false },
            ["Herculean"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Noir"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Controlled"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Abyssal"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Invincible"] = { IsExalted = true, IsSongOfTheDeep = false },
            ["Wormhole"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Breezed"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Quantum"] = { IsExalted = true, IsSongOfTheDeep = false },
            ["Blessed"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Resilient"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Unbreakable"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Insight"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Hasty"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Quality"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Piercing"] = { IsExalted = true, IsSongOfTheDeep = false },
            ["Mutated"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Storming"] = { IsExalted = false, IsSongOfTheDeep = false },
            ["Anomalous"] = { IsExalted = true, IsSongOfTheDeep = false },
            ["Ghastly"] = { IsExalted = false, IsSongOfTheDeep = false },
        }
        
        local EnchantNames = {}
        for enchantName, _ in pairs(Enchants) do
            table.insert(EnchantNames, enchantName)
        end
        
        Tabs.Automatically:AddDropdown("EnchantSelectDropDown", {
            Title = "Selected Enchant",
            Description = "",
            Values = EnchantNames,
            Default = "",
            PlaceHolder = "Select Enchant",
            Multiple = false,
            Callback = function(selectedEnchant)
                getgenv().SelectedEnchant = selectedEnchant
                print("Enchant Selected:", selectedEnchant)
            end,
        })
        
        local AutoEnchantToggle = Tabs.Automatically:AddToggle("AutoEnchantToggle", {
            Title = "Auto Enchant",
            Default = false,
            Description = "",
            Callback = function(isEnabled)
                genv.AutoEnchant = isEnabled
        
                if not genv.SelectedEnchant then
                    Fluent:Notify("Auto Enchant", "Please select an enchant.", 5)
                    AutoEnchantToggle:Set(false)
                    return
                end
        
                if genv.AutoEnchant then
                    local selectedData = data.Enchants[genv.SelectedEnchant]
                    if not selectedData then
                        Fluent:Notify("Auto Enchant", "Invalid enchant selected.", 5)
                        AutoEnchantToggle:Set(false)
                        return
                    end
        
                    local playerRelic = workspace[LocalPlayer.Name]:FindFirstChild(
                        selectedData.IsExalted and "Exalted Relic" or "Enchant Relic"
                    )
                    if not playerRelic then
                        Fluent:Notify("Auto Enchant", "Please hold the correct relic.", 5)
                        AutoEnchantToggle:Set(false)
                        return
                    end
        
                    if ReplicatedStorage.world.cycle.Value ~= "Night" then
                        Fluent:Notify("Auto Enchant", "It needs to be night time.", 5)
                        AutoEnchantToggle:Set(false)
                        return
                    end
        
                    if ReplicatedStorage.playerstats[LocalPlayer.Name].Rods[getEquippedRod()].Value == genv.SelectedEnchant then
                        Fluent:Notify("Auto Enchant", "You already have this enchant.", 5)
                        AutoEnchantToggle:Set(false)
                        return
                    end
        
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1310, -799, -82)
                end
        
                task.wait(1)
        
                while genv.AutoEnchant do
                    task.wait(0.1)
                    local enchantAltar = workspace.world.interactables:FindFirstChild("Enchant Altar")
        
                    if enchantAltar and enchantAltar:FindFirstChild("ProximityPrompt") and enchantAltar.ProximityPrompt.Enabled then
                        local selectedData = data.Enchants[genv.SelectedEnchant]
                        local requiredRelic = selectedData.IsExalted and "Exalted Relic" or "Enchant Relic"
        
                        if not workspace[LocalPlayer.Name]:FindFirstChild(requiredRelic) then
                            Fluent:Notify("Auto Enchant", "Please hold the correct relic.", 5)
                            AutoEnchantToggle:Set(false)
                            return
                        end
        
                        enchantAltar.ProximityPrompt.Parent = LocalPlayer.Character
                        for _, obj in ipairs(LocalPlayer.Character:GetChildren()) do
                            if obj:IsA("ProximityPrompt") then
                                obj.HoldDuration = 0
                                obj:InputHoldBegin()
                                task.wait(0.01)
                                obj:InputHoldEnd()
                                obj.Parent = enchantAltar
                            end
                        end
        
                        task.wait(0.5)
        
                        if LocalPlayer.PlayerGui.over:FindFirstChild("prompt") then
                            local confirmButton = LocalPlayer.PlayerGui.over.prompt.confirm
                            if getconnections then
                                for _, v in pairs(getconnections(confirmButton.MouseButton1Click)) do
                                    v.Function()
                                end
                            else
                                firesignal(confirmButton.MouseButton1Click)
                            end
                        end
                    end
        
                    if ReplicatedStorage.playerstats[LocalPlayer.Name].Rods[getEquippedRod()].Value == genv.SelectedEnchant then
                        AutoEnchantToggle:Set(false)
                    end
                end
            end,
        })
               