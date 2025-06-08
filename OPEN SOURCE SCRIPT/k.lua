    --     -- Initial Setup
    UpdatePlayerList()
    local section = Tabs.Forge:AddSection("Forge Feature")
    local FishData = loadstring(game:HttpGet("https://raw.githubusercontent.com/isMoons/loader/refs/heads/main/Fishdata.lua"))()
    local __t = {}
    local CheckValues = Tabs.Forge:AddDropdown("CheckValues", { 
        Title = "Check Values Fish", 
        Values = __t,
        Multi = false,
        Default = nil,
        Callback = function(v)
            if not v or v == "" then return end
    
            local data = game.ReplicatedStorage.playerstats:FindFirstChild(v)
            if not data then return end
            data = data.Inventory:GetChildren()
    
            local curValue = 0
    
            for _, item in pairs(data) do
                -- GIVE ME CREDIT [{Naaellx}] - THIS FEATURE DOESNT WORKING IF YOU NOT GIVE ME CREDIT HAHAHAHAHA CUS I REMOVE ONE CODE ON HERE [BE SMART] 
                   -- GIVE ME CREDIT [{Naaellx}] - THIS FEATURE DOESNT WORKING IF YOU NOT GIVE ME CREDIT HAHAHAHAHA CUS I REMOVE ONE CODE ON HERE [BE SMART] 
                    -- GIVE ME CREDIT [{Naaellx}] - THIS FEATURE DOESNT WORKING IF YOU NOT GIVE ME CREDIT HAHAHAHAHA CUS I REMOVE ONE CODE ON HERE [BE SMART] 
                        -- GIVE ME CREDIT [{Naaellx}] - THIS FEATURE DOESNT WORKING IF YOU NOT GIVE ME CREDIT HAHAHAHAHA CUS I REMOVE ONE CODE ON HERE [BE SMART] 
                    -- GIVE ME CREDIT [{Naaellx}] - THIS FEATURE DOESNT WORKING IF YOU NOT GIVE ME CREDIT HAHAHAHAHA CUS I REMOVE ONE CODE ON HERE [BE SMART] 
                    curValue = curValue + itemPrice
                end
            end
    
            Fluent:Notify({
                Title = "Account Value",
                Content = v .. "Account is worth : " .. curValue .. " C$",
                Duration = 5
            })
        end
    })
    
    game.ReplicatedStorage.playerstats.ChildAdded:Connect(function(c)
        table.insert(__t, c.Name)
        CheckValues:SetValues(__t)
    end)
    
    game.ReplicatedStorage.playerstats.ChildRemoved:Connect(function(c)
        local index = table.find(__t, c.Name)
        if index then
            table.remove(__t, index)
            CheckValues:SetValues(__t)
        end
    end)
    
    for _, v in pairs(game.ReplicatedStorage.playerstats:GetChildren()) do
        table.insert(__t, v.Name)
    end
    CheckValues:SetValues(__t)