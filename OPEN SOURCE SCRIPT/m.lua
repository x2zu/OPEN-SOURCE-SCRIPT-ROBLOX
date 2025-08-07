@@ -8,7 +8,7 @@ local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

--- Aldytoi add new feature and variable 
--- Aldytoi add new feature and variable 
local replicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
if not player or not replicatedStorage then return end
@@ -18,16 +18,16 @@ local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Siri

-- Window
local Window = Rayfield:CreateWindow({
    Name = "Fish It Script - Bsnl_18",
    LoadingTitle = "Fish It - by Bsnl_18",
    LoadingSubtitle = "by @Bsnl_18",
    Theme = "Amethyst",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "bsnl",
        FileName = "FishIt"
    },
    KeySystem = false
    Name = "Fish It Script - Bsnl_18",
    LoadingTitle = "Fish It - by Bsnl_18",
    LoadingSubtitle = "by @Bsnl_18",
    Theme = "Amethyst",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "bsnl",
        FileName = "FishIt"
    },
    KeySystem = false
})

-- Tabs
@@ -62,7 +62,7 @@ local autoRecastDelay = 1.6
local enchantPos = Vector3.new(3231, -1303, 1402)

local featureState = {
    AutoSell = false,
    AutoSell = false,
}

local function NotifySuccess(title, message)
@@ -75,8 +75,8 @@ end

-- Developer Info
DevTab:CreateParagraph({
    Title = "Bsnl_18 Lua",
    Content = "Jangan Lupa Follow Ya Bre\nDeveloper:\n- Instagram: @Bsnl_18\n- GitHub: github.com/Bsnl_18\n\n"
    Title = "Bsnl_18 Lua",
    Content = "Jangan Lupa Follow Ya Bre\nDeveloper:\n- Instagram: @Bsnl_18\n- GitHub: github.com/Bsnl_18\n\n"
})
DevTab:CreateButton({ Name = "Saweria", Callback = function() setclipboard("https://saweria.co/aldytoi") NotifySuccess("Link Saweria", "Copied to clipboard!") end })

@@ -85,50 +85,50 @@ DevTab:CreateButton({ Name = "GitHub", Callback = function() setclipboard("https

-- MainTab (Auto Fish)
MainTab:CreateParagraph({
    Title = "🎣 Auto Fish Settings",
    Content = "Setup Fishing Options"
    Title = "🎣 Auto Fish Settings",
    Content = "Setup Fishing Options"
})

-- Section: Standard Boats
Spawn_Boat:CreateParagraph({
    Title = "List Available Boats",
    Content = "All boats available for spawning. Click to spawn a boat."
    Title = "List Available Boats",
    Content = "All boats available for spawning. Click to spawn a boat."
})

local boatArray = {
    { Name = "Small Boat", ID = 1 },
    { Name = "Kayak", ID = 2},
    { Name = "Jetski", ID = 3 },
    { Name = "Highfield Boat", ID = 4},
    { Name = "Speed Boat", ID = 5 },
    { Name = "Fishing Boat", ID = 6  },
    { Name = "Mini Yacht", ID = 14 },
    { Name = "Hyper Boat", ID = 7 },
    { Name = "Frozen Boat", ID = 11  },
    { Name = "Cruiser Boat", ID = 13 },
    { Name = "Alpha Floaty", ID = 8 },
    { Name = "Evil Duck", ID = 9 },
    { Name = "Festive Duck", ID = 10 },
    { Name = "Santa Sleigh", ID = 12 }
    { Name = "Small Boat", ID = 1 },
    { Name = "Kayak", ID = 2},
    { Name = "Jetski", ID = 3 },
    { Name = "Highfield Boat", ID = 4},
    { Name = "Speed Boat", ID = 5 },
    { Name = "Fishing Boat", ID = 6  },
    { Name = "Mini Yacht", ID = 14 },
    { Name = "Hyper Boat", ID = 7 },
    { Name = "Frozen Boat", ID = 11  },
    { Name = "Cruiser Boat", ID = 13 },
    { Name = "Alpha Floaty", ID = 8 },
    { Name = "Evil Duck", ID = 9 },
    { Name = "Festive Duck", ID = 10 },
    { Name = "Santa Sleigh", ID = 12 }
}

for _, boat in ipairs(boatArray) do
    Spawn_Boat:CreateButton({
        Name = "🛥️ " .. boat.Name,
        Callback = function()
            pcall(function()
                replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/DespawnBoat"]:InvokeServer()
                task.wait(3)
                replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/SpawnBoat"]:InvokeServer(boat.ID)
                Rayfield:Notify({
                    Title = "🚤 Spawning Boat",
    Spawn_Boat:CreateButton({
        Name = "🛥️ " .. boat.Name,
        Callback = function()
            pcall(function()
                replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/DespawnBoat"]:InvokeServer()
                task.wait(3)
                replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/SpawnBoat"]:InvokeServer(boat.ID)
                Rayfield:Notify({
                    Title = "🚤 Spawning Boat",
Content = "Spawning " .. boat.Name,
                    Duration = 1,
                    Image = 4483362458
                })
            end)
        end
    })
                    Duration = 1,
                    Image = 4483362458
                })
            end)
        end
    })
end

local itemsFolder = replicatedStorage:WaitForChild("Items")
@@ -137,758 +137,465 @@ local rods = {}

-- Fungsi untuk format angka jadi readable string
local function formatPrice(num)
    if not num or type(num) ~= "number" then return "???" end
    if num >= 1e6 then
        return string.format("%.1fM Coins", num / 1e6)
    elseif num >= 1e3 then
        return string.format("%.1fk Coins", num / 1e3)
    else
        return tostring(num) .. " Coins"
    end
    if not num or type(num) ~= "number" then return "???" end
    if num >= 1e6 then
        return string.format("%.1fM Coins", num / 1e6)
    elseif num >= 1e3 then
        return string.format("%.1fk Coins", num / 1e3)
    else
        return tostring(num) .. " Coins"
    end
end

-- Loop semua module di Items
for _, module in ipairs(itemsFolder:GetChildren()) do
    if module:IsA("ModuleScript") then
        local success, data = pcall(require, module)
        if success and typeof(data) == "table" then
            local rodData = data.Data
            if rodData and rodData.Type == "Fishing Rods" then
                local id = rodData.Id or "?"
                local name = rodData.Name or module.Name
                local desc = rodData.Description or "-"
                local price = "???"

                -- Gunakan data Price jika ada
                if data.Price then
                    price = formatPrice(data.Price)
                else
                    -- fallback ke priceMap jika tidak ada Price
                    local priceMap = {
                        ["Gold Rod"] = "VIP Only",
                        ["Lucky Rod"] = "15k Coins",
                        ["Midnight Rod"] = "50k Coins",
                        ["Chrome Rod"] = "437k Coins",
                    }
                    price = priceMap[name] or "???"
                end

                table.insert(rods, {
                    ID = id,
                    Name = name,
                    Dex = desc,
                    Harga = price
                })
            end
        end
    end
    if module:IsA("ModuleScript") then
        local success, data = pcall(require, module)
        if success and typeof(data) == "table" then
            local rodData = data.Data
            if rodData and rodData.Type == "Fishing Rods" then
                local id = rodData.Id or "?"
                local name = rodData.Name or module.Name
                local desc = rodData.Description or "-"
                local price = "???"

                -- Gunakan data Price jika ada
                if data.Price then
                    price = formatPrice(data.Price)
                else
                    -- fallback ke priceMap jika tidak ada Price
                    local priceMap = {
                        ["Gold Rod"] = "VIP Only",
                        ["Lucky Rod"] = "15k Coins",
                        ["Midnight Rod"] = "50k Coins",
                        ["Chrome Rod"] = "437k Coins",
                    }
                    price = priceMap[name] or "???"
                end

                table.insert(rods, {
                    ID = id,
                    Name = name,
                    Dex = desc,
                    Harga = price
                })
            end
        end
    end
end
Buy_Rod:CreateParagraph({
    Title = "Purchase Rods",
    Content = "Some Rods can't be purchased because they are VIP only or doesn't have a price map."
    Title = "Purchase Rods",
    Content = "Some Rods can't be purchased because they are VIP only or doesn't have a price map."
})
-- Buat tombol beli untuk setiap rod
for _, rod in ipairs(rods) do
    Buy_Rod:CreateButton({
        Name = string.format("%s (%s)", rod.Name, rod.Harga),
        Callback = function()
            local success, result = pcall(function()
                return replicatedStorage
                    .Packages._Index["sleitnick_net@0.2.0"]
                    .net["RF/PurchaseFishingRod"]
                    :InvokeServer(rod.ID)
            end)

            Rayfield:Notify({
                Title = "Purchase Rod",
                Content = success and ("Buying " .. rod.Name) or ("Failed to buy " .. rod.Name),
                Duration = 1
            })

            if not success then
                warn("[Buy Rod Error]:", result)
            end
        end
    })
    Buy_Rod:CreateButton({
        Name = string.format("%s (%s)", rod.Name, rod.Harga),
        Callback = function()
            local success, result = pcall(function()
                return replicatedStorage
                    .Packages._Index["sleitnick_net@0.2.0"]
                    .net["RF/PurchaseFishingRod"]
                    :InvokeServer(rod.ID)
            end)

            Rayfield:Notify({
                Title = "Purchase Rod",
                Content = success and ("Buying " .. rod.Name) or ("Failed to buy " .. rod.Name),
                Duration = 1
            })

            if not success then
                warn("[Buy Rod Error]:", result)
            end
        end
    })
end
-- Max Rod & Bait Modifier
MainTab:CreateToggle({
    Name = "⚙️ Max Rod & Bait Modifier",
    CurrentValue = false,
    Flag = "MaxRodBaitToggle",
    Callback = function(state)
        if state then
            local ReplicatedStorage = game:GetService("ReplicatedStorage")

            -- === Modify Rods ===
            local itemsFolder = ReplicatedStorage:WaitForChild("Items")

            for _, module in ipairs(itemsFolder:GetChildren()) do
                if module:IsA("ModuleScript") then
                    local success, rodData = pcall(require, module)
                    if success and type(rodData) == "table" then
                        rodData.ClickPower =9999
                        rodData.Resilience = 9999
                        rodData.Speed = 9999
                        rodData.MaxWeight = 9999
                    end
                    if success and type(rodData) == "table" and rodData.RollData then
                      
                            rodData.RollData.BaseLuck = 9999 
                            rodData.RollData.Frequency.Golden = 100
                            rodData.RollData.Frequency.Rainbow = 100

                        print("Rod:", module.Name, "-> BaseLuck:", rodData.RollData.BaseLuck)
                    end
                end
            end

            -- === Modify Baits ===
            local baitsFolder = ReplicatedStorage:WaitForChild("Baits")

            local targetBait = baitsFolder:FindFirstChild("Corrupt Bait")
            if not targetBait then
                warn("Corrupt Bait tidak ditemukan!")
                return
            end

            local targetModule = require(targetBait)

            for _, bait in pairs(baitsFolder:GetChildren()) do
                if bait:IsA("ModuleScript") then
                    local success, baitModule = pcall(require, bait)
                    if success and baitModule and baitModule.Modifiers then
                        baitModule.Price = targetModule.Price
                        baitModule.Modifiers.BaseLuck = 99999

                        if baitModule.Modifiers.ShinyMultiplier == nil then
                            baitModule.Modifiers.ShinyMultiplier = 99999
                        end
                        if baitModule.Modifiers.MutationMultiplier == nil then
                            baitModule.Modifiers.MutationMultiplier = 99999
                        end

                        print("Bait updated:", bait.Name)
                    else
                        warn("Gagal load bait:", bait.Name)
                    end
                end
            end

            Rayfield:Notify({
                Title = "Sukses!",
                Content = "Rod dan bait telah dimodifikasi.",
                Duration = 1,
                Image = 4483362458
            })
        end
    end
    Name = "⚙️ Max Rod & Bait Modifier",
    CurrentValue = false,
    Flag = "MaxRodBaitToggle",
    Callback = function(state)
        if state then
            local ReplicatedStorage = game:GetService("ReplicatedStorage")

            -- === Modify Rods ===
            local itemsFolder = ReplicatedStorage:WaitForChild("Items")

            for _, module in ipairs(itemsFolder:GetChildren()) do
                if module:IsA("ModuleScript") then
                    local success, rodData = pcall(require, module)
                    if success and type(rodData) == "table" then
                        rodData.ClickPower =9999
                        rodData.Resilience = 9999
                        rodData.Speed = 9999
                        rodData.MaxWeight = 9999
                    end
                    if success and type(rodData) == "table" and rodData.RollData then
                      
                            rodData.RollData.BaseLuck = 9999 
                            rodData.RollData.Frequency.Golden = 100
                            rodData.RollData.Frequency.Rainbow = 100

                        print("Rod:", module.Name, "-> BaseLuck:", rodData.RollData.BaseLuck)
                    end
                end
            end

            -- === Modify Baits ===
            local baitsFolder = ReplicatedStorage:WaitForChild("Baits")

            local targetBait = baitsFolder:FindFirstChild("Corrupt Bait")
            if not targetBait then
                warn("Corrupt Bait tidak ditemukan!")
                return
            end

            local targetModule = require(targetBait)

            for _, bait in pairs(baitsFolder:GetChildren()) do
                if bait:IsA("ModuleScript") then
                    local success, baitModule = pcall(require, bait)
                    if success and baitModule and baitModule.Modifiers then
                        baitModule.Price = targetModule.Price
                        baitModule.Modifiers.BaseLuck = 99999

                        if baitModule.Modifiers.ShinyMultiplier == nil then
                            baitModule.Modifiers.ShinyMultiplier = 99999
                        end
                        if baitModule.Modifiers.MutationMultiplier == nil then
                            baitModule.Modifiers.MutationMultiplier = 99999
                        end

                        print("Bait updated:", bait.Name)
                    else
                        warn("Gagal load bait:", bait.Name)
                    end
                end
            end

            Rayfield:Notify({
                Title = "Sukses!",
                Content = "Rod dan bait telah dimodifikasi.",
                Duration = 1,
                Image = 4483362458
            })
        end
    end
})
MainTab:CreateToggle({
    Name = "🎣 Auto Fishing",
    CurrentValue = false,
    Callback = function(val)
        autofish = val
        if val then
            task.spawn(function()
                while autofish do
                    pcall(function()
                        equipRemote:FireServer(1)
                        task.wait(0.1)

                        local timestamp = perfectCast and 9999999999 or (tick() + math.random())
                        rodRemote:InvokeServer(timestamp)
                        task.wait(0.1)

                        local x = perfectCast and -1.238 or (math.random(-1000, 1000) / 1000)
                        local y = perfectCast and 0.969 or (math.random(0, 1000) / 1000)

                        miniGameRemote:InvokeServer(x, y)
                        task.wait(1.3)
                        finishRemote:FireServer()
                        getCurrentFishCount()
                    end)
                    task.wait(autoRecastDelay)
                end
            end)
         else
            unequipRemote:FireServer(1)
            task.wait(1.3)
             finishRemote:FireServer()
            Rayfield:Notify({
                Title = "Auto Fishing Stopped",
                Content = "Deactivated Auto Fishing",
                Duration = 1
            })
    
        end
    end
    Name = "🎣 Auto Fishing",
    CurrentValue = false,
    Callback = function(val)
        autofish = val
        if val then
            task.spawn(function()
                while autofish do
                    pcall(function()
                        equipRemote:FireServer(1)
                        task.wait(0.1)

                        local timestamp = perfectCast and 9999999999 or (tick() + math.random())
                        rodRemote:InvokeServer(timestamp)
                        task.wait(0.1)

                        local x = perfectCast and -1.238 or (math.random(-1000, 1000) / 1000)
                        local y = perfectCast and 0.969 or (math.random(0, 1000) / 1000)

                        miniGameRemote:InvokeServer(x, y)
                        task.wait(1.3)
                        finishRemote:FireServer()
                    end)
                    task.wait(autoRecastDelay)
                end
            end)
         else
            unequipRemote:FireServer(1)
            task.wait(1.3)
             finishRemote:FireServer()
            Rayfield:Notify({
                Title = "Auto Fishing Stopped",
                Content = "Deactivated Auto Fishing",
                Duration = 1
            })
    
        end
    end
})

MainTab:CreateToggle({
    Name = "✨ Perfect Cast",
    CurrentValue = true,
    Callback = function(val)
        perfectCast = val
    end
    Name = "✨ Perfect Cast",
    CurrentValue = true,
    Callback = function(val)
        perfectCast = val
    end
})

MainTab:CreateSlider({
    Name = "⏱️ Auto Fishing Delay (seconds)",
    Range = {0.5, 5},
    Increment = 0.1,
    CurrentValue = autoRecastDelay,
    Callback = function(val)
        autoRecastDelay = val
    end
}) 
 
    Name = "⏱️ Auto Fishing Delay (seconds)",
    Range = {0.5, 5},
    Increment = 0.1,
    CurrentValue = autoRecastDelay,
    Callback = function(val)
        autoRecastDelay = val
    end
}) 
 
-- Buy Weather
Buy_Weather:CreateParagraph({
    Title = "🌤️ Purchase Weather Events",
    Content = "Select a weather event to trigger."
    Title = "🌤️ Purchase Weather Events",
    Content = "Select a weather event to trigger."
})
local autoBuyWeather = false
 local eventsFolder = ReplicatedStorage:WaitForChild("Events")
 local eventsFolder = ReplicatedStorage:WaitForChild("Events")

local weathers = {}
local weathersNoShark = {}

-- Ambil semua event dari folder Events
for _, eventModule in ipairs(eventsFolder:GetChildren()) do
    if eventModule:IsA("ModuleScript") then
        local success, eventData = pcall(require, eventModule)
        if success and eventData and type(eventData) == "table" then
            local weatherInfo = {
                Name = eventData.Name or eventModule.Name,
                Price = eventData.WeatherMachinePrice or 0,
                Desc = eventData.Description or "No description",
            }

            table.insert(weathers, weatherInfo)

            if not string.lower(weatherInfo.Name):find("shark") then
                table.insert(weathersNoShark, weatherInfo)
            end
        end
    end
    if eventModule:IsA("ModuleScript") then
        local success, eventData = pcall(require, eventModule)
        if success and eventData and type(eventData) == "table" then
            local weatherInfo = {
                Name = eventData.Name or eventModule.Name,
                Price = eventData.WeatherMachinePrice or 0,
                Desc = eventData.Description or "No description",
            }

            table.insert(weathers, weatherInfo)

            if not string.lower(weatherInfo.Name):find("shark") then
                table.insert(weathersNoShark, weatherInfo)
            end
        end
    end
end

-- 🔁 Auto Buy (Tanpa Shark)
Buy_Weather:CreateToggle({
    Name = "🌀 Auto Buy All Weather (No Shark)",
    CurrentValue = false,
    Flag = "AutoBuyWeatherToggle",
    Callback = function(Value)
        autoBuyWeather = Value
        if Value then
            Rayfield:Notify({
                Title = "Auto Weather",
                Content = "Started Auto Buying Weather",
                Duration = 1
            })

            task.spawn(function()
                while autoBuyWeather do
                    for _, w in ipairs(weathersNoShark) do
                        pcall(function()
                            replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseWeatherEvent"]:InvokeServer(w.Name)
                        end)
                        task.wait(0.1)
                    end
                    task.wait(0.1)
                end
            end)
        else
            Rayfield:Notify({
                Title = "Auto Weather",
                Content = "Stop Auto Buying",
                Duration = 1
            })
        end
    end
    Name = "🌀 Auto Buy All Weather (No Shark)",
    CurrentValue = false,
    Flag = "AutoBuyWeatherToggle",
    Callback = function(Value)
        autoBuyWeather = Value
        if Value then
            Rayfield:Notify({
                Title = "Auto Weather",
                Content = "Started Auto Buying Weather",
                Duration = 1
            })

            task.spawn(function()
                while autoBuyWeather do
                    for _, w in ipairs(weathersNoShark) do
                        pcall(function()
                            replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseWeatherEvent"]:InvokeServer(w.Name)
                        end)
                        task.wait(0.1)
                    end
                    task.wait(0.1)
                end
            end)
        else
            Rayfield:Notify({
                Title = "Auto Weather",
                Content = "Stop Auto Buying",
                Duration = 1
            })
        end
    end
})

-- 📦 Buat tombol untuk semua event
for _, w in ipairs(weathers) do
    Buy_Weather:CreateButton({
        Name = w.Name .. " Spawn",
        Callback = function()
            pcall(function()
                replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseWeatherEvent"]:InvokeServer(w.Name)
                Rayfield:Notify({
                    Title = "⛅ Weather Event",
                    Content = "Spawned " .. w.Name,
                    Duration = 1
                })
            end)
        end
    })
    Buy_Weather:CreateButton({
        Name = w.Name .. " Spawn",
        Callback = function()
            pcall(function()
                replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseWeatherEvent"]:InvokeServer(w.Name)
                Rayfield:Notify({
                    Title = "⛅ Weather Event",
                    Content = "Spawned " .. w.Name,
                    Duration = 1
                })
            end)
        end
    })
end
-- Buy Bait
Buy_Baits:CreateParagraph({
    Title = "Buy Baits",
    Content = "Buy Baits Everywhere"
    Title = "Buy Baits",
    Content = "Buy Baits Everywhere"
})
 local baitsFolder = ReplicatedStorage:WaitForChild("Baits")
 local baitsFolder = ReplicatedStorage:WaitForChild("Baits")

for _, baitModule in ipairs(baitsFolder:GetChildren()) do
    if baitModule:IsA("ModuleScript") then
        local success, baitData = pcall(require, baitModule)
        if success and baitData and baitData.Data then
            local id = baitData.Data.Id or 0
            local name = baitData.Data.Name or "Unknown"
            local desc = baitData.Data.Description or "-"
            local priceText = baitData.Price and baitData.Price .. " Coins" or "No Price"

            Buy_Baits:CreateButton({
                Name = name .. " (" .. priceText .. ")",
                Callback = function()
                    pcall(function()
                        replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseBait"]:InvokeServer(id)
                        Rayfield:Notify({
                            Title = "Bait Purchase",
                            Content = "Buying " .. name,
                            Duration = 3
                        })
                    end)
                end
            })
        else
            warn("Gagal membaca bait module:", baitModule.Name)
        end
    end
    if baitModule:IsA("ModuleScript") then
        local success, baitData = pcall(require, baitModule)
        if success and baitData and baitData.Data then
            local id = baitData.Data.Id or 0
            local name = baitData.Data.Name or "Unknown"
            local desc = baitData.Data.Description or "-"
            local priceText = baitData.Price and baitData.Price .. " Coins" or "No Price"

            Buy_Baits:CreateButton({
                Name = name .. " (" .. priceText .. ")",
                Callback = function()
                    pcall(function()
                        replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseBait"]:InvokeServer(id)
                        Rayfield:Notify({
                            Title = "Bait Purchase",
                            Content = "Buying " .. name,
                            Duration = 3
                        })
                    end)
                end
            })
        else
            warn("Gagal membaca bait module:", baitModule.Name)
        end
    end
end
local threshold = 30 -- Default threshold

MainTab:CreateInput({
    Name = "🎯 Auto Sell Threshold",
    PlaceholderText = "Default: 30",
    RemoveTextAfterFocusLost = false,
    Callback = function(input)
        local num = tonumber(input)
        if num then
            threshold = num
            Rayfield:Notify({
                Title = "Threshold Diperbarui",
                Content = "Ikan akan dijual otomatis saat jumlah mencapai " .. threshold,
                Duration = 1
            })
        else
            Rayfield:Notify({
                Title = "Input Tidak Valid",
                Content = "Masukkan angka, bukan teks.",
                Duration = 1
            })
        end
    end
    Name = "🎯 Auto Sell Threshold",
    PlaceholderText = "Default: 30",
    RemoveTextAfterFocusLost = false,
    Callback = function(input)
        local num = tonumber(input)
        if num then
            threshold = num
            Rayfield:Notify({
                Title = "Threshold Diperbarui",
                Content = "Ikan akan dijual otomatis saat jumlah mencapai " .. threshold,
                Duration = 1
            })
        else
            Rayfield:Notify({
                Title = "Input Tidak Valid",
                Content = "Masukkan angka, bukan teks.",
                Duration = 1
            })
        end
    end
})
 -- Toggle Auto Sell berdasarkan threshold ikan
 -- Toggle Auto Sell berdasarkan threshold ikan
local AutoSellToggle = MainTab:CreateToggle({
    Name = "🛒 Auto Sell",
    CurrentValue = false,
    Flag = "AutoSell",
    Callback = function(value)
        featureState.AutoSell = value
        if value then
            task.spawn(function()
                while featureState.AutoSell and player do
                    pcall(function()
                        local fishCount = getCurrentFishCount()
                        if fishCount < threshold then return end

                         print("Fish Count:",  fishCount, "Threshold:", threshold)

                        if not (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then return end

                        local npcContainer = replicatedStorage:FindFirstChild("NPC")
                        local alexNpc = npcContainer and npcContainer:FindFirstChild("Alex")

                        if not alexNpc then
                            featureState.AutoSell = false
                            AutoSellToggle:Set(false)
                            return
                        end

                        local originalCFrame = player.Character.HumanoidRootPart.CFrame
                        local npcPosition = alexNpc.WorldPivot.Position

                        player.Character.HumanoidRootPart.CFrame = CFrame.new(npcPosition)
                        task.wait(1)

                        replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/SellAllItems"]:InvokeServer()
                        task.wait(1)

                        player.Character.HumanoidRootPart.CFrame = originalCFrame

                        Rayfield:Notify({
                            Title = "Auto Sell",
                            Content = "Ikan dijual (jumlah ≥ " .. threshold .. ")",
                            Duration = 1
                        })
                    end)
                    task.wait(1) -- Delay pendek hanya untuk loop, bukan threshold
                end
            end)
        end
    end
    Name = "🛒 Auto Sell",
    CurrentValue = false,
    Flag = "AutoSell",
    Callback = function(value)
        featureState.AutoSell = value
        if value then
            task.spawn(function()
                while featureState.AutoSell and player do
                    pcall(function()
                        local fishCount = getCurrentFishCount()
                        if fishCount < threshold then return end

                         print("Fish Count:",  fishCount, "Threshold:", threshold)

                        if not (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then return end

                        local npcContainer = replicatedStorage:FindFirstChild("NPC")
                        local alexNpc = npcContainer and npcContainer:FindFirstChild("Alex")

                        if not alexNpc then
                            featureState.AutoSell = false
                            AutoSellToggle:Set(false)
                            return
                        end

                        local originalCFrame = player.Character.HumanoidRootPart.CFrame
                        local npcPosition = alexNpc.WorldPivot.Position

                        player.Character.HumanoidRootPart.CFrame = CFrame.new(npcPosition)
                        task.wait(1)

                        replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/SellAllItems"]:InvokeServer()
                        task.wait(1)

                        player.Character.HumanoidRootPart.CFrame = originalCFrame

                        Rayfield:Notify({
                            Title = "Auto Sell",
                            Content = "Ikan dijual (jumlah ≥ " .. threshold .. ")",
                            Duration = 1
                        })
                    end)
                    task.wait(1) -- Delay pendek hanya untuk loop, bukan threshold
                end
            end)
        end
    end
})

-- Toggle logic
local blockUpdateOxygen = false

PlayerTab:CreateToggle({
    Name = "Unlimited Oxygen",
    CurrentValue = false,
    Flag = "BlockUpdateOxygen",
    Callback = function(value)
        blockUpdateOxygen = value
        Rayfield:Notify({
            Title = "Update Oxygen Block",
            Content = value and "Remote blocked!" or "Remote allowed!",
            Duration = 3,
        })
    end,
    Name = "Unlimited Oxygen",
    CurrentValue = false,
    Flag = "BlockUpdateOxygen",
    Callback = function(value)
        blockUpdateOxygen = value
        Rayfield:Notify({
            Title = "Update Oxygen Block",
            Content = value and "Remote blocked!" or "Remote allowed!",
            Duration = 3,
        })
    end,
})

-- Hook FireServer
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" and tostring(self) == "URE/UpdateOxygen" and blockUpdateOxygen then
        warn("Tahan Napas Bang")
        return nil -- prevent call
    end
    if method == "FireServer" and tostring(self) == "URE/UpdateOxygen" and blockUpdateOxygen then
        warn("Tahan Napas Bang")
        return nil -- prevent call
    end

    return oldNamecall(self, unpack(args))
    return oldNamecall(self, unpack(args))
end))

-- Player Tab
PlayerTab:CreateToggle({
    Name = "Infinity Jump",
    CurrentValue = false,
    Callback = function(val)
        ijump = val
    end
    Name = "Infinity Jump",
    CurrentValue = false,
    Callback = function(val)
        ijump = val
    end
})



UserInputService.JumpRequest:Connect(function()
    if ijump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
    if ijump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

do
    PlayerTab:CreateParagraph({
        Title = "🛒 Teleport to Shops",
        Content = "Click a button to teleport to the nearest NPC."
    })
    local shop_npcs = {
        { Name = "Boats Shop", Path = "Boat Expert" },
        { Name = "Rod Shop", Path = "Joe" },
        { Name = "Bobber Shop", Path = "Seth" }
    }

    for _, npc_data in ipairs(shop_npcs) do
        PlayerTab:CreateButton({
            Name = npc_data.Name,
            Callback = function()
                local npc = game:GetService("ReplicatedStorage"):FindFirstChild("NPC"):FindFirstChild(npc_data.Path)
                local char = game:GetService("Players").LocalPlayer.Character
                if npc and char and char:FindFirstChild("HumanoidRootPart") then
                    char:PivotTo(npc:GetPivot())
                    Rayfield:Notify({
                        Title = "Teleported",
                        Content = "To " .. npc_data.Name,
                        Duration = 1,
                        Image = 4483362458
                    })
                else
                    Rayfield:Notify({
                        Title = "Error",
                        Content = "NPC or Character not found in workspace or props.",
                        Duration = 1,
                        Image = 4483362458
                    })
                end
            end,
        })
    end

    PlayerTab:CreateButton({
        Name = "Weather Machine",
        Callback = function()
            local weather = workspace:FindFirstChild("!!!! ISLAND LOCATIONS !!!!"):FindFirstChild("Weather Machine")
            local char = game:GetService("Players").LocalPlayer.Character
            if weather and char and char:FindFirstChild("HumanoidRootPart") then
                char:PivotTo(CFrame.new(weather.Position))
                Rayfield:Notify({
                    Title = "Teleported",
                    Content = "To Weather Machine",
                    Duration = 3,
                    Image = 4483362458
                })
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Weather Machine not found workspace or props.",
                    Duration = 1,
                    Image = 4483362458
                })
            end
        end,
    })
end



PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {15, 500},
    Increment = 5,
    CurrentValue = 15,
    Callback = function(val)
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
})
 
local islandCoords = {
    ["01"] = { name = "Weather Machine", position = Vector3.new(-1451, 7, 1949) },
    ["02"] = { name = "Esoteric Depths", position = Vector3.new(3177, -1293, 1459) },
    ["03"] = { name = "Tropical Grove", position = Vector3.new(-2018, 13, 3670) },
    ["04"] = { name = "Stingray Shores", position = Vector3.new(-12, 14, 2793) },
    ["05"] = { name = "Kohana Volcano", position = Vector3.new(-499, 34, 209) },
    ["06"] = { name = "Coral Reefs", position = Vector3.new(-3075, 11, 2197) },
    ["07"] = { name = "Crater Island", position = Vector3.new(988, 11, 4874) },
    ["08"] = { name = "Kohana", position = Vector3.new(-638, 13, 739) },
    ["09"] = { name = "Winter Fest", position = Vector3.new(1631, 14, 3300) },
    ["10"] = { name = "Isoteric Island", position = Vector3.new(2007, 14, 1420) },
    ["11"] = { name = "Lost Isle", position = Vector3.new(-3650.3, -103, -1108.06) },
    ["12"] = { name = "Lost Isle [Lost Shore]", position = Vector3.new(-3677, 107, -912) },
    ["13"] = { name = "Lost Isle [Sisyphus]", position = Vector3.new(-3699.85, -103, -938.63) },
    ["14"] = { name = "Lost Isle [Treasure Hall]", position = Vector3.new(-3632, -288.25, -1449) },
    ["15"] = { name = "Lost Isle [Treasure Room]", position = Vector3.new(-3632, -273.5, -1631.5) }
}

for _, data in pairs(islandCoords) do
    IslandsTab:CreateButton({
        Name = data.name,
        Callback = function()
            local char = Workspace.Characters:FindFirstChild(LocalPlayer.Name)
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(data.position + Vector3.new(0, 5, 0))
                NotifySuccess("Teleported!", "" .. data.name)
            else
                NotifyError("Teleport Failed", "Character or HRP not found!")
            end
        end
    })
end 
-- NPC Tab
local npcFolder = ReplicatedStorage:WaitForChild("NPC")
for _, npc in ipairs(npcFolder:GetChildren()) do
	NPCTab:CreateButton({
		Name = "Teleport to NPC: " .. npc.Name,
		Callback = function()
			local npcCandidates = Workspace:GetDescendants()
			for _, descendant in ipairs(npcCandidates) do
				if descendant.Name == npc.Name and descendant:FindFirstChild("HumanoidRootPart") then
					local myChar = LocalPlayer.Character
					local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
					if myHRP then
						myHRP.CFrame = descendant.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
						NotifySuccess("Teleport Success", "You teleported to NPC: " .. npc.Name)
						return
					end
				end
			end
			NotifyError("Teleport Failed", "NPC not found in Workspace!")
		end
	})
end

-- Settings Tab
SettingsTab:CreateButton({ Name = "Rejoin Server", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end })
SettingsTab:CreateButton({ Name = "Server Hop (New Server)", Callback = function()
    local placeId = game.PlaceId
    local servers, cursor = {}, ""
    repeat
        local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100" .. (cursor ~= "" and "&cursor=" .. cursor or "")
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)
        if success and result and result.data then
            for _, server in pairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(servers, server.id)
                end
            end
            cursor = result.nextPageCursor or ""
        else
            break
        end
    until not cursor or #servers > 0

    if #servers > 0 then
        local targetServer = servers[math.random(1, #servers)]
        TeleportService:TeleportToPlaceInstance(placeId, targetServer, LocalPlayer)
    else
        NotifyError("Server Hop Failed", "No available servers found!")
    end
end })
SettingsTab:CreateButton({ Name = "Unload Script", Callback = function()
    Rayfield:Notify({ Title = "Script Unloaded", Content = "The script will now unload.", Duration = 3, Image = "circle-check" })
    wait(3)
    game:GetService("CoreGui").Rayfield:Destroy()
end })

-- 🔄 Ambil semua anak dari workspace.Props dan filter hanya yang berupa Model atau BasePart

local function createEventButtons()
    EventTab.Flags = {} -- Bersihkan flags lama agar tidak dobel
    local props = Workspace:FindFirstChild("Props")
    if props then
        for _, child in pairs(props:GetChildren()) do
            if child:IsA("Model") or child:IsA("BasePart") then
                local eventName = child.Name

                EventTab:CreateButton({
                    Name = "Teleport to: " .. eventName,
                    Callback = function()
                        local character = Workspace.Characters:FindFirstChild(LocalPlayer.Name)
                        local hrp = character and character:FindFirstChild("HumanoidRootPart")
                        local pos = nil

                        if child:IsA("Model") then
                            if child.PrimaryPart then
                                pos = child.PrimaryPart.Position
                            else
                                local part = child:FindFirstChildWhichIsA("BasePart")
                                if part then
                                    pos = part.Position
                                end
                            end
                        elseif child:IsA("BasePart") then
                            pos = child.Position
                        end

                        if pos and hrp then
                            hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0)) -- Naik dikit biar gak stuck
                           
                        else
                            Rayfield:Notify({
                                Title = "❌ Teleport Failed",
                                Content = "Failed to locate valid part for: " .. eventName,
                                Duration = 1
                            })
                        end
                    end
                })
            end
        end
    end
end

-- Tombol untuk refresh list event
EventTab:CreateButton({
    Name = "🔄 Refresh Event List",
    Callback = function()
        createEventButtons()
        Rayfield:Notify({
            Title = "✅ Refreshed",
            Content = "Event list has been refreshed.",
            Duration = 3
        })
    end
})

-- Panggil pertama kali saat tab dibuka
createEventButtons() 
 local function getCurrentFishCount()
    local gui = player:FindFirstChild("PlayerGui")
    if not gui then warn("PlayerGui not found") return 0 end

    local inventory = gui:FindFirstChild("Inventory")
    if not inventory then warn("Inventory not found") return 0 end

    local main = inventory:FindFirstChild("Main")
    if not main then warn("Main not found") return 0 end

    local top = main:FindFirstChild("Top")
    if not top then warn("Top not found") return 0 end

    local options = top:FindFirstChild("Options")
    if not options then warn("Options not found") return 0 end

    local fish = options:FindFirstChild("Fish")
    if not fish then warn("Fish not found") return 0 end

    local label = fish:FindFirstChild("Label")
    if not label then warn("Label not found") return 0 end

    local bagLabel = label:FindFirstChild("BagSize")
    if not bagLabel then warn("BagSize not found") return 0 end

    if not bagLabel:IsA("TextLabel") then
        warn("BagSize is not a TextLabel")
        return 0
    end

    local text = bagLabel.Text
    local currentCount = tonumber(text:match("^(%d+)%s*/")) or 0
    print("Current Fish Count:", currentCount, "| Threshold:", threshold)

    -- ✅ Check AutoSell and trigger if needed
    if featureState.AutoSell and currentCount >= threshold then
        print("AutoSell Triggered via Fish Count Check")

        if not (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then
            warn("Player or HumanoidRootPart not found")
            return currentCount
        end

        local npcContainer = replicatedStorage:FindFirstChild("NPC")
        local alexNpc = npcContainer and npcContainer:FindFirstChild("Alex")
        if not alexNpc then
            warn("Alex NPC not found")
            featureState.AutoSell = false
            AutoSellToggle:Set(false)
            return currentCount
        end

        local originalCFrame = player.Character.HumanoidRootPart.CFrame
        local npcPosition = alexNpc.WorldPivot.Position

        player.Character.HumanoidRootPart.CFrame = CFrame.new(npcPosition)
        task.wait(1)

        local success, err = pcall(function()
            replicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/SellAllItems"]:InvokeServer()
        end)
        if not success then
            warn("Auto Sell failed:", err)
        else
            print("Auto Sell Success!")
        end

        task.wait(1)
        player.Character.HumanoidRootPart.CFrame = originalCFrame

        Rayfield:Notify({
            Title = "Auto Sell",
            Content = "Ikan dijual otomatis (jumlah ≥ " .. threshold .. ")",
            Duration = 2
        })
    end

    return currentCount
end

local current = getCurrentFishCount()
print("Fish Count via direct call:", current)