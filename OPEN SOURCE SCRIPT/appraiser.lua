local space = Tabs.Appraise:AddSection("Appraiser")

local FishData = {["Emperor Jellyfish"] = 8000, ["Angelfish"] = 20, ["Oyster"] = 5, ["Sand Dollar"] = 2, ["White Perch"] = 12, ["Smallmouth Bass"] = 17, ["Great Hammerhead Shark"] = 5000, ["Seaweed"] = 3, ["Napoleonfish"] = 350, ["Sea Bass"] = 60, ["Midnight Axolotl"] = 30, ["Trout"] = 50, ["Rabbitfish"] = 60, ["Swamp Bass"] = 60, ["Captain's Goldfish"] = 25, ["Largemouth Bass"] = 45, ["Walleye"] = 40, ["Brine Phantom"] = 6500, ["Rock"] = 210, ["Glacier Pike"] = 35, ["Arctic Char"] = 60, ["Manta Ray"] = 10000, ["Lobster"] = 28, ["Blackfish"] = 20, ["Brine Shrimp"] = 3, ["Globe Jellyfish"] = 240, ["Pollock"] = 50, ["Chinfish"] = 40, ["Bowfin"] = 60, ["Cod"] = 100, ["Sea Turtle"] = 1500, ["Driftwood"] = 6, ["Pumpkinseed"] = 5, ["Cockatoo Squid"] = 20, ["Arapaima"] = 2000, ["Nessie"] = 40000, ["Pyrogrub"] = 600, ["Lurkerfish"] = 20, ["Stalactite"] = 130, ["Bone"] = 25, ["Mahi Mahi"] = 150, ["Axolotl"] = 15, ["Grey Carp"] = 70, ["Goldfish"] = 7, ["Sunfish"] = 10000, ["Zombiefish"] = 30, ["Phantom Ray"] = 60, ["Voidfin Mahi"] = 155, ["Umbral Shark"] = 1550, ["Buccaneer Barracuda"] = 250, ["Boot"] = 12, ["Eel"] = 45, ["Spiderfish"] = 10, ["Bluefin Tuna"] = 2200, ["Eyefestation"] = 6500, ["Carbon Crate"] = 160, ["Corsair Grouper"] = 200, ["Mackerel"] = 40, ["Night Shrimp"] = 2, ["Stingray"] = 300, ["Isonade"] = 13000, ["Ribbon Eel"] = 150, ["Minnow"] = 6, ["Crown Bass"] = 60, ["Alligator"] = 3000, ["Quality Bait Crate"] = 120, ["Enchant Relic"] = 210, ["Olm"] = 4, ["Shipwreck Barracuda"] = 300, ["Spectral Serpent"] = 130000, ["Rockstar Hermit Crab"] = 12, ["Banditfish"] = 200, ["Swamp Scallop"] = 14, ["Longtail Bass"] = 40, ["Bluefish"] = 9, ["Prawn"] = 5, ["Ringle"] = 4, ["Horseshoe Crab"] = 90, ["Scallop"] = 5, ["Nurse Shark"] = 1500, ["Bream"] = 27, ["Abyssacuda"] = 110, ["Scurvy Sailfish"] = 700, ["Snook"] = 70, ["Wiifish"] = 400, ["Crab"] = 14, ["Whiptail Catfish"] = 30, ["Oarfish"] = 2500, ["Common Crate"] = 80, ["Haddock"] = 40, ["Slate Tuna"] = 600, ["Porgy"] = 30, ["Shrimp"] = 2, ["Bait Crate"] = 80, ["Skipjack Tuna"] = 160, ["Bull Shark"] = 1300, ["Ember Snapper"] = 120, ["Anchovy"] = 3, ["Log"] = 75, ["White Bass"] = 25, ["Coelacanth"] = 100, ["Barbed Shark"] = 9500, ["Twilight Eel"] = 200, ["Fish Barrel"] = 150, ["Shortfin Mako Shark"] = 1000, ["Lingcod"] = 140, ["Sturgeon"] = 800, ["Anglerfish"] = 20, ["Gazerfish"] = 140, ["Red Snapper"] = 70, ["Whale Shark"] = 100000, ["Obsidian Salmon"] = 180, ["Tire"] = 110, ["Fangborn Gar"] = 380, ["Obsidian Swordfish"] = 2500, ["Swordfish"] = 2500, ["Mullet"] = 20, ["Salmon"] = 100, ["Sailfish"] = 600, ["Ember Perch"] = 15, ["Cutlass Fish"] = 250, ["Galleon Goliath"] = 200, ["Sardine"] = 3, ["Pike"] = 35, ["Pond Emperor"] = 2500, ["Pufferfish"] = 20, ["Cookiecutter Shark"] = 15, ["Voltfish"] = 16, ["Redeye Bass"] = 15, ["Golden Seahorse"] = 8, ["Sockeye Salmon"] = 70, ["Basalt"] = 210, ["Magma Tang"] = 30, ["Skelefish"] = 10, ["Carp"] = 50, ["Suckermouth Catfish"] = 170, ["Squid"] = 25, ["Halibut"] = 2000, ["Ghoulfish"] = 120, ["Glassfish"] = 4, ["Dolphin"] = 2000, ["Sawfish"] = 6000, ["Sea Pickle"] = 10, ["Great White Shark"] = 12000, ["Clownfish"] = 6, ["Dweller Catfish"] = 160, ["Perch"] = 12, ["Chub"] = 30, ["Sea Urchin"] = 9, ["Cursed Eel"] = 250, ["Fungal Cluster"] = 9, ["Herring"] = 11, ["Grayling"] = 20, ["Blue Tang"] = 15, ["Flounder"] = 55, ["Butterflyfish"] = 15, ["Yellow Boxfish"] = 20, ["Dumbo Octopus"] = 40, ["Mythic Fish"] = 14, ["Catfish"] = 150, ["Sweetfish"] = 5, ["Lapisjack"] = 400, ["Sea Mine"] = 3250, ["Red Tang"] = 15, ["Gudgeon"] = 3, ["Whisker Bill"] = 1000, ["Burbot"] = 35, ["Ice"] = 60, ["Colossal Squid"] = 12000, ["Reefrunner Snapper"] = 250, ["Handfish"] = 60, ["Flying Fish"] = 50, ["Bluegill"] = 6, ["Red Drum"] = 25, ["Coral Geode"] = 180, ["Amberjack"] = 400, ["Trumpetfish"] = 20, ["Mussel"] = 2, ["Glacierfish"] = 600, ["Alligator Gar"] = 450, ["Moonfish"] = 5000, ["Yellowfin Tuna"] = 1360, ["Candy Fish"] = 10, ["Volcanic Geode"] = 200, ["Barracuda"] = 110, ["Rubber Ducky"] = 7, ["Marsh Gar"] = 380, ["King Oyster"] = 10, ["Keepers Guardian"] = 400, ["Mushgrove Crab"] = 14, ["Pale Tang"] = 15, ["Chinook Salmon"] = 400, ["Golden Smallmouth Bass"] = 45}
local statFolder,Filtered
local WeightVal,DelayVal = 100, 0.8
local fishDone = {}
local MutList = {"Any", "Albino", "Darkened", "Electric", "Frozen", "Ghastly", "Glossy", "Midas", "Mosaic", "Mythical", "Negative", "Silver", "Sinister", "Translucent", "Hexed", "Sunken", "Abyssal"}

function getAllOwnedFish()
    local OwnedList = {}
    for _, fish in ipairs(player.Backpack:GetChildren()) do
        if fish:FindFirstChild("fishscript") then
            OwnedList[fish.Name] = true -- Use dictionary for uniqueness
        end
    end

    -- Convert dictionary keys to array
    local resultList = {}
    for fishName in pairs(OwnedList) do
        table.insert(resultList, fishName)
    end
    return resultList
end

local allOwnedFish = getAllOwnedFish()

local MutationListed = {}

-- Dropdown to select mutations
local MutationList = Tabs.Appraise:AddDropdown("MutationListDropdown", {
    Title = "Mutation Target",
    Description = "Select Mutation Target",
    Values = MutList,
    Multi = true,  
    Default = {},  
})

MutationList:OnChanged(function(Value)
    local Values = {}
    for mutation, state in next, Value do
        if state then
            table.insert(Values, mutation)  
        end
    end
    MutationListed = Values  
end)


-- Fish Selection Dropdown
local FishSelection = Tabs.Appraise:AddDropdown("FishSelection", {
    Title = "Selected Fish",
    Description = "Select Fish Target",
    Values = allOwnedFish,
    Multi = true,
    Default = {},
})

FishSelection:OnChanged(function(Value)
    -- Equip the selected fish automatically
    if #Value > 0 then
        local selectedFish = Value[1] -- Take the first selected fish from the dropdown
        local player = game.Players.LocalPlayer -- Ensure 'player' refers to the local player
        for _, fish in ipairs(player.Backpack:GetChildren()) do
            if fish.Name == selectedFish then
                -- Equip the fish if it's found in the backpack
                player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(fish)
                break
            end
        end
    end
end)

-- Auto Appraise Toggle
local AutoToggle = Tabs.Appraise:AddToggle("AutoToggle", {Title = "Auto Appraise", Default = false})
AutoToggle:OnChanged(function(Value)
    
end)
Options.AutoToggle:SetValue(false)

-- Appraise All Toggle
local AppraiseAll = Tabs.Appraise:AddToggle("AppraiseAll", {Title = "Appraise All Selected Fish", Default = false})
AppraiseAll:OnChanged(function(Value)
   
end)
Options.AppraiseAll:SetValue(false)

-- Weight Target Dropdown
local WeightTarget = Tabs.Appraise:AddDropdown("WeightTarget", {
    Title = "Weight Target",
    Description = "Select Weight Target",
    Values = {"Big", "Giant"},
    Multi = true,
    Default = {}, 
})

local WeightListed = {}

WeightTarget:OnChanged(function(Value)
    WeightListed = {} 
    for Weight, State in next, Value do
        if State then  
            table.insert(WeightListed, Weight)
        end
    end

end)

-- Weight Filter Toggle
local WeightToggle = Tabs.Appraise:AddToggle("WeightToggle", {Title = "Weight Filter Toggle", Default = false})
WeightToggle:OnChanged(function(Value)
   
end)
Options.WeightToggle:SetValue(false)

-- Mutation Toggle
local MutationToggle = Tabs.Appraise:AddToggle("MutationToggle", {Title = "Mutation Toggle", Default = false})
MutationToggle:OnChanged(function(Value)

end)
Options.MutationToggle:SetValue(false)

-- Require Sparkling Toggle
local SparklingToggle = Tabs.Appraise:AddToggle("SparklingToggle", {Title = "Require Sparkling", Default = false})
SparklingToggle:OnChanged(function(Value)
    fishDone = {} -- Reset appraised list when Sparkling requirement changes
end)
Options.SparklingToggle:SetValue(false)

-- Require Shiny Toggle
local ShinyToggle = Tabs.Appraise:AddToggle("ShinyToggle", {Title = "Require Shiny", Default = false})
ShinyToggle:OnChanged(function(Value)
    fishDone = {} -- Reset appraised list when Shiny requirement changes
end)
Options.ShinyToggle:SetValue(false)
-- Function to get the currently held fish tool
function getHeldFish()
    -- Iterate through the player's character to find a fish tool
    for _, tool in ipairs(player.Character:GetChildren()) do
        if tool:IsA("Tool") then
            return tool  -- Return the fish tool
        end
    end
    return nil  -- Return nil if no fish tool is held
end

function switchFish()
    -- Iterate through all fish in the player's backpack
    for _, fish in ipairs(player.Backpack:GetChildren()) do
        -- Check if the fish is in the selection list and hasn't been appraised
        if table.find(FishSelection.Value, fish.Name) and not table.find(fishDone, fish) then
            -- Equip the fish
            print("Equipping:", fish.Name)  -- Debugging print
            player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(fish)
            return
        end
    end
end

-- Function to categorize fish by weight
function getWeightCategory(fish)
    local fishName = fish.Name
    local statFolder = fish.link.Value
    local weight = statFolder.Weight.Value
    local Big = FishData[fishName] / 10
    local Giant = (FishData[fishName] / 10) * 1.99
    if weight > Giant then
        return "Giant"
    elseif weight > Big then
        return "Big"
    else
        return "Regular"
    end
end

LocalPlayer.Backpack.ChildAdded:Connect(function(instance)
	if instance:isA("Tool") and not instance:FindFirstChild("link") then
		repeat task.wait() until instance:FindFirstChild("link")
		local oldtools = getHeldFish()
		if oldtools then oldtools.Parent = player.Backpack end
		if AutoToggle.Value then
			player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(instance)
		end
	end
end)

function applyFilter(fish)
    local statFolder = fish.link.Value  -- Assuming fish.link.Value is the folder containing stats

    -- Weight Filter Check
    if WeightToggle.Value and next(WeightListed) ~= nil then
        -- Check if the fish's weight category is in the selected weight targets
        if not table.find(WeightListed, getWeightCategory(fish)) then
            return false  -- Filter out fish that do not match the weight target
        end
    end

    -- Sparkling Filter Check
    if SparklingToggle.Value then
        if not statFolder:FindFirstChild("Sparkling") then
            return false  -- Filter out fish that are not sparkling
        end
    end

    -- Shiny Filter Check
    if ShinyToggle.Value then
        if not statFolder:FindFirstChild("Shiny") then
            return false  -- Filter out fish that are not shiny
        end
    end

    -- Mutation Filter Check
    if MutationToggle.Value and next(MutationListed) ~= nil then
        -- Try to find Mutation in different places (statFolder, linked folder, etc.)
        local Mutation = nil
        
        -- Check if there's a "Mutation" directly in the statFolder or the fish object
        if statFolder then
            Mutation = statFolder:FindFirstChild("Mutation") 
        else
            print("Stat Folder Mutaion not Found") -- Look in the stat folder
        end

        local Any = table.find(MutationListed, "Any")

        -- If no mutation exists, and "Any" is not selected, return false
        if not Mutation then
            if not Any then
                return false  -- No mutation found, and "Any" is not selected, so filter out
            else
                return true  -- Pass if 'Any' is selected
            end
        else
            -- If "Any" mutation is selected, accept all mutations
            if Any then
                return true
            end

            -- Check if the fish's mutation matches any of the selected mutations
            for _, selectedMutation in ipairs(MutationListed) do
                -- If we find a match, return true immediately
                if selectedMutation == Mutation.Value then
                    return true  -- Accept fish with the correct mutation
                end
            end

            -- If no mutation matches any in the list, return false
            return false  -- Filter out fish that do not match any of the selected mutations
        end
    end

    -- If all filters are passed
    return true
end


-- Auto appraise function to handle appraising the fish
function AutoAppraise()
    if not AutoToggle.Value then return end
    local fish = getHeldFish()  -- Get the currently held fish
    if fish then
        local isFiltered = applyFilter(fish)
        if isFiltered then 
            -- If AppraiseAll is enabled and the fish hasn't been appraised yet
            if AppraiseAll.Value and not table.find(fishDone, fish) then
                table.insert(fishDone, fish)  -- Mark fish as appraised
                switchFish()  -- Switch to next fish
            end
            return
        end

        -- Appraise the current fish if it passes the filter
        local success, errorMsg = pcall(function()
            workspace.world.npcs.Appraiser.appraiser.appraise:InvokeServer()
        end)
        if not success then
        end
        task.wait(tonumber(DelayVal))  -- Delay before trying again
    elseif not fish and AppraiseAll.Value then
        switchFish()
    end
end