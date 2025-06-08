if getgenv().already_executed then
    warn("Allux: Already executed!")
    return
end
getgenv().already_executed = true
if not game:IsLoaded() then
    game.Loaded:Wait()
end
local vim = game:GetService("VirtualInputManager")
local re = game:GetService("ReplicatedStorage")
local vr = game:GetService("VirtualUser")
local lp = game.Players.LocalPlayer
getgenv().config = {
    auto_equip_rod = nil,
    auto_thorown_rod = nil,
    auto_shake = nil,
    auto_reel = nil,
    auto_reel_perfect_catch = nil,
    auto_sell_all = nil,
    auto_sell_in_hand = nil,
    disable_oxygen = nil,
    walk_on_water = nil,
    auto_trade_all_items = nil,
    auto_accept_trade = nil,
    anti_afk = nil,
    remove_fog = nil,
    auto_fail_catch = nil
}
if not isfolder("Allux/Config") then
    makefolder("Allux/Config")
end
local function save_config()
    local config_name = "Allux/Config/fisch_cfg.json"
    local json_config = game:GetService("HttpService"):JSONEncode(getgenv().config)
    writefile(config_name, json_config)
end
local function load_config()
    local config_name = "Allux/Config/fisch_cfg.json"
    if isfile(config_name) then
        local json_config = readfile(config_name)
        getgenv().config = game:GetService("HttpService"):JSONDecode(json_config)
    end
end
local MainFrame = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local TextButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local wdujwjwswxwdi = Instance.new("ScreenGui")
wdujwjwswxwdi.Name = "wdujwjwswxwdi"
wdujwjwswxwdi.Parent = game.CoreGui
wdujwjwswxwdi.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainFrame.Name = "MainFrame"
MainFrame.Parent = wdujwjwswxwdi
MainFrame.AnchorPoint = Vector2.new(1, 0)
MainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
MainFrame.BackgroundTransparency = 1
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(1, -60, 0, 10)
MainFrame.Size = UDim2.new(0, 45, 0, 45)
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame
ImageLabel.Parent = MainFrame
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0, 45, 0, 45)
ImageLabel.Image = "rbxassetid://"
TextButton.Parent = MainFrame
TextButton.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton.BackgroundTransparency = 1
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.5, 0, 0.5, 5)
TextButton.Size = UDim2.new(0, 45, 0, 45)
TextButton.AutoButtonColor = false
TextButton.Font = Enum.Font.SourceSansBold
TextButton.Text = "ð¸"
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.TextSize = 20
TextButton.MouseButton1Click:Connect(
    function()
        vim:SendKeyEvent(true, "Insert", false, game)
        vim:SendKeyEvent(false, "Insert", false, game)
    end
)
load_config()
local Fluent =
    loadstring(
    game:HttpGet(
        "https://gist.githubusercontent.com/x6mani/43b5184edbc3ce8b79e945a287d71bd4/raw/566d61566aae7f0984247c155d20ef5c9116d597/Allux.lua"
    )
)()
local Window =
    Fluent:CreateWindow(
    {
        Title = "Fisch",
        SubTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name ..
            " | (https://discord.gg/9PXfpUMG)",
        TabWidth = 160,
        Size = UDim2.fromOffset(550, 410),
        Acrylic = false,
        Theme = "Midnight",
        MinimizeKey = Enum.KeyCode.Insert
    }
)
local general_tab = {general = Window:AddTab({Title = "Main", Icon = "home"})}
local farm_sec = general_tab.general:AddSection("Fishing")
farm_sec:AddToggle(
    "Toggle",
    {
        Title = "Auto Equip Rod",
        Default = getgenv().config.auto_equip_rod or false,
        Callback = function(Value)
            getgenv().config.auto_equip_rod = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_equip_rod do
                        task.wait()
                        local rod_name = re.playerstats[lp.Name].Stats.rod.Value
                        local equipped_rod = lp.Character:FindFirstChild(rod_name)
                        local back_pack = lp:WaitForChild("Backpack")
                        if back_pack:FindFirstChild(rod_name) and not equipped_rod then
                            task.wait(0.2)
                            lp.Character.Humanoid:EquipTool(back_pack:FindFirstChild(rod_name))
                        end
                    end
                end
            )
        end
    }
)
farm_sec:AddToggle(
    "Toggle",
    {
        Title = "Auto Throw Rod",
        Default = getgenv().config.auto_throw_rod or false,
        Callback = function(Value)
            getgenv().config.auto_thorown_rod = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_thorown_rod do
                        task.wait()
                        local rod_name = re.playerstats[lp.Name].Stats.rod.Value
                        local equipped_rod = lp.Character:FindFirstChild(rod_name)
                        if equipped_rod then
                            equipped_rod.events.cast:FireServer(100)
                        end
                    end
                end
            )
        end
    }
)
farm_sec:AddToggle(
    "Toggle",
    {
        Title = "Auto Shake",
        Default = getgenv().config.auto_shake or false,
        Callback = function(Value)
            getgenv().config.auto_shake = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_shake do
                        task.wait()
                        local shake_button =
                            lp:WaitForChild("PlayerGui"):FindFirstChild("shakeui") and
                            lp:WaitForChild("PlayerGui").shakeui:FindFirstChild("safezone"):FindFirstChild("button")
                        if shake_button then
                            shake_button.Size = UDim2.new(1001, 0, 1001, 0)
                            vr:Button1Down(Vector2.new(1, 1))
                            vr:Button1Up(Vector2.new(1, 1))
                        end
                    end
                end
            )
        end
    }
)
farm_sec:AddToggle(
    "Toggle",
    {
        Title = "Auto Reel",
        Default = getgenv().config.auto_reel or false,
        Callback = function(Value)
            getgenv().config.auto_reel = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_reel do
                        task.wait()
                        if not getgenv().config.auto_reel_perfect_catch then
                            if not getgenv().config.auto_fail_catch then
                                if lp:WaitForChild("PlayerGui"):FindFirstChild("reel") then
                                    task.wait(1)
                                    re.events.reelfinished:FireServer(100, false)
                                end
                            end
                        end
                    end
                end
            )
        end
    }
)
farm_sec:AddToggle(
    "Toggle",
    {
        Title = "Perfect Catch",
        Default = getgenv().config.auto_reel_perfect_catch or false,
        Callback = function(Value)
            getgenv().config.auto_reel_perfect_catch = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_reel_perfect_catch do
                        task.wait()
                        if not getgenv().config.auto_fail_catch then
                            if lp:WaitForChild("PlayerGui"):FindFirstChild("reel") then
                                task.wait(1)
                                re.events.reelfinished:FireServer(100, true)
                            end
                        end
                    end
                end
            )
        end
    }
)
local save_pos = general_tab.general:AddSection("Position")
save_pos:AddButton(
    {Title = "Save Position", Description = "", Callback = function()
            getgenv().position = lp.Character.HumanoidRootPart.CFrame
        end}
)
save_pos:AddButton(
    {Title = "Teleport to Position", Description = "", Callback = function()
            if getgenv().position then
                lp.Character.HumanoidRootPart.CFrame = getgenv().position
            end
        end}
)
save_pos:AddButton(
    {Title = "Reset Position", Description = "", Callback = function()
            getgenv().position = nil
        end}
)
local teleport_tab = {teleport = Window:AddTab({Title = "Teleport", Icon = "repeat"})}
local island_sec = teleport_tab.teleport:AddSection("Island")
local island_list = {}
local function get_island_list()
    island_list = {}
    for _, island in pairs(workspace.world.spawns.TpSpots:GetChildren()) do
        if island:IsA("BasePart") then
            table.insert(island_list, island.Name)
        end
    end
end
get_island_list()
local select_island_d =
    island_sec:AddDropdown(
    "select_island_d",
    {Title = "Select Island", Values = island_list, Multi = false, Default = "", Callback = function(Value)
            getgenv().select_island = Value
        end}
)
select_island_d:OnChanged(
    function(Value)
        getgenv().select_island = Value
    end
)
local teleport_island =
    island_sec:AddButton(
    {Title = "Teleport To Island", Description = "", Callback = function()
            local selected_island = getgenv().select_island
            if selected_island then
                for _, teleport_island in pairs(workspace.world.spawns.TpSpots:GetChildren()) do
                    if teleport_island.Name == selected_island and teleport_island:IsA("BasePart") then
                        lp.Character.HumanoidRootPart.CFrame = teleport_island.CFrame
                        return
                    end
                end
            end
        end}
)
local event_sec = teleport_tab.teleport:AddSection("Event")
local event_list = {}
local function get_event_list()
    event_list = {}
    for i, v in pairs(workspace.zones.fishing:GetDescendants()) do
        if v:FindFirstChild("POIHeader") then
            table.insert(event_list, tostring(v.Name))
        end
    end
end
get_event_list()
local select_event_d =
    event_sec:AddDropdown(
    "select_event_d",
    {Title = "Select Event", Values = event_list, Multi = false, Default = "", Callback = function(Value)
            getgenv().select_event = Value
        end}
)
local TeleportEvent =
    event_sec:AddButton(
    {Title = "Teleport To Event", Description = "", Callback = function()
            if getgenv().select_event and getgenv().select_event ~= "" then
                for i, v in pairs(workspace.zones.fishing:GetDescendants()) do
                    if v:FindFirstChild("POIHeader") and v.Name == getgenv().select_event then
                        local heightAboveWater = 40
                        lp.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, heightAboveWater, 0)
                        return
                    end
                end
            end
        end}
)
local RefreshEvent =
    event_sec:AddButton(
    {Title = "Refresh Event", Description = "", Callback = function()
            local current_selection = select_event_d.Value
            get_event_list()
            select_event_d:SetValues(event_list)
            if table.find(event_list, current_selection) then
                select_event_d:SetValue(current_selection)
            else
                select_event_d:SetValue(event_list[#event_list])
            end
        end}
)
local npc_sec = teleport_tab.teleport:AddSection("NPC")
local Npclist = {}
local function RefreshNPCList()
    Npclist = {}
    for _, npc in pairs(game:GetService("Workspace").world.npcs:GetChildren()) do
        table.insert(Npclist, npc.Name)
    end
end
RefreshNPCList()
local SelectNPC =
    npc_sec:AddDropdown(
    "SelectNPC",
    {Title = "Select NPC", Values = Npclist, Multi = false, Default = "", Callback = function(Value)
            getgenv().TPNPC = Value
        end}
)
npc_sec:AddButton(
    {Title = "Teleport To NPC", Description = "", Callback = function()
            local selectedNPC = getgenv().TPNPC
            if selectedNPC then
                for _, npc in pairs(game:GetService("Workspace").world.npcs:GetChildren()) do
                    if npc.Name == selectedNPC and npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                        return
                    end
                end
            end
        end}
)
npc_sec:AddButton(
    {Title = "Refresh NPC List", Description = "", Callback = function()
            RefreshNPCList()
            SelectNPC:SetValues(Npclist)
        end}
)
local shop_tab = {shop = Window:AddTab({Title = "Shop", Icon = "shopping-bag"})}
local seller_sec = shop_tab.shop:AddSection("Seller")
seller_sec:AddButton(
    {Title = "Sell All", Description = "", Callback = function()
            workspace.world.npcs:FindFirstChild("Marc Merchant").merchant.sellall:InvokeServer()
        end}
)
seller_sec:AddButton(
    {Title = "Sell In Hand", Description = "", Callback = function()
            workspace.world.npcs:FindFirstChild("Marc Merchant").merchant.sell:InvokeServer()
        end}
)
seller_sec:AddToggle(
    "Toggle",
    {Title = "Auto Sell All", Default = getgenv().config.auto_sell_all or false, Callback = function(Value)
            getgenv().config.auto_sell_all = Value
            while getgenv().config.auto_sell_all do
                task.wait()
                workspace.world.npcs:FindFirstChild("Marc Merchant").merchant.sellall:InvokeServer()
            end
        end}
)
seller_sec:AddToggle(
    "Toggle",
    {Title = "Auto Sell In Hand", Default = getgenv().config.auto_sell_in_hand or false, Callback = function(Value)
            getgenv().config.auto_sell_in_hand = Value
            while getgenv().config.auto_sell_in_hand do
                task.wait()
                workspace.world.npcs:FindFirstChild("Marc Merchant").merchant.sell:InvokeServer()
            end
        end}
)
local totem_sec = shop_tab.shop:AddSection("Totem")
local select_item_d =
    totem_sec:AddDropdown(
    "select_item_d",
    {
        Title = "Select Totem",
        Values = {
            "Aurora Totem",
            "Sundial Totem",
            "Eclipse Totem",
            "Meteor Totem",
            "Tempest Totem",
            "Windset Totem",
            "Smokescreen"
        },
        Multi = false,
        Default = 1
    }
)
select_item_d:OnChanged(
    function(Value)
        getgenv().selected_totem = Value
    end
)
local item_ammount_d =
    totem_sec:AddInput(
    "ammount_item",
    {
        Title = "Ammount",
        Default = 1,
        Placeholder = "Input Ammount...",
        Numeric = true,
        Finished = false,
        Callback = function(Value)
            getgenv().totem_ammount = Value
        end
    }
)
totem_sec:AddButton(
    {Title = "Buy Totem", Description = "", Callback = function()
            re.events.purchase:FireServer(getgenv().selected_totem, "Item", nil, getgenv().totem_ammount)
        end}
)
local user_tab = {user = Window:AddTab({Title = "User", Icon = "user"})}
local user_sec = user_tab.user:AddSection("User")
user_sec:AddToggle(
    "Toggle",
    {Title = "Disable Oxygen", Default = getgenv().config.disable_oxygen or false, Callback = function(Value)
            getgenv().config.disable_oxygen = Value
            if getgenv().config.disable_oxygen then
                lp.Character.client.oxygen.Disabled = true
            else
                lp.Character.client.oxygen.Disabled = false
            end
        end}
)
user_sec:AddToggle(
    "Toggle",
    {Title = "Walk On Water", Default = getgenv().config.walk_on_water or false, Callback = function(Value)
            getgenv().config.walk_on_water = Value
            for i, v in pairs(workspace.zones.fishing:GetChildren()) do
                if v.Name == "Ocean" then
                    v.CanCollide = Value
                end
            end
        end}
)
local identify_sec = user_tab.user:AddSection("Stream")
identify_sec:AddButton(
    {
        Title = "Protect Identify",
        Description = "",
        Callback = function()
            if not getgenv().Config then
                getgenv().Config = {
                    Headless = false,
                    FakeDisplayName = "PROTECTED",
                    FakeName = "PROTECTED",
                    FakeId = 666666666
                }
            end
            local players = game:GetService("Players")
            local localPlayer = players.LocalPlayer
            local lastShadow = nil
            local function disguisechar(char, id)
                task.spawn(
                    function()
                        if not char then
                            return
                        end
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        char:WaitForChild("Head")
                        local desc
                        local success
                        repeat
                            success =
                                pcall(
                                function()
                                    desc = players:GetHumanoidDescriptionFromUserId(id)
                                end
                            )
                            task.wait(1)
                        until success
                        if hum and desc then
                            desc.HeightScale = hum:WaitForChild("HumanoidDescription").HeightScale
                            char.Archivable = true
                            local disguiseclone = char:Clone()
                            disguiseclone.Name = "disguisechar"
                            disguiseclone.Parent = workspace
                            for _, v in pairs(disguiseclone:GetChildren()) do
                                if v:IsA("Accessory") or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") then
                                    v:Destroy()
                                end
                            end
                            disguiseclone.Humanoid:ApplyDescriptionClientServer(desc)
                            for _, v in pairs(char:GetChildren()) do
                                if
                                    (v:IsA("Accessory") and v:GetAttribute("InvItem") == nil and
                                        v:GetAttribute("ArmorSlot") == nil) or
                                        v:IsA("ShirtGraphic") or
                                        v:IsA("Shirt") or
                                        v:IsA("Pants") or
                                        v:IsA("BodyColors")
                                 then
                                    v.Parent = game
                                end
                            end
                            char.ChildAdded:Connect(
                                function(v)
                                    if
                                        ((v:IsA("Accessory") and v:GetAttribute("InvItem") == nil and
                                            v:GetAttribute("ArmorSlot") == nil) or
                                            v:IsA("ShirtGraphic") or
                                            v:IsA("Shirt") or
                                            v:IsA("Pants") or
                                            v:IsA("BodyColors")) and
                                            v:GetAttribute("Disguise") == nil
                                     then
                                        repeat
                                            task.wait()
                                            v.Parent = game
                                        until v.Parent == game
                                    end
                                end
                            )
                            for _, v in pairs(disguiseclone:WaitForChild("Animate"):GetChildren()) do
                                v:SetAttribute("Disguise", true)
                                local real = char.Animate:FindFirstChild(v.Name)
                                if v:IsA("StringValue") and real then
                                    real.Parent = game
                                    v.Parent = char.Animate
                                end
                            end
                            for _, v in pairs(disguiseclone:GetChildren()) do
                                v:SetAttribute("Disguise", true)
                                if v:IsA("Accessory") then
                                    for _, v2 in pairs(v:GetDescendants()) do
                                        if v2:IsA("Weld") and v2.Part1 then
                                            v2.Part1 = char[v2.Part1.Name]
                                        end
                                    end
                                    v.Parent = char
                                elseif v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
                                    v.Parent = char
                                elseif v.Name == "Head" and v:FindFirstChildOfClass("SpecialMesh") then
                                    char.Head:FindFirstChildOfClass("SpecialMesh").MeshId =
                                        v:FindFirstChildOfClass("SpecialMesh").MeshId
                                end
                            end
                            local localface = char:FindFirstChild("face", true)
                            local cloneface = disguiseclone:FindFirstChild("face", true)
                            if localface and cloneface then
                                localface.Parent = game
                                cloneface.Parent = char.Head
                            end
                            char.Humanoid.HumanoidDescription:SetEmotes(desc:GetEmotes())
                            char.Humanoid.HumanoidDescription:SetEquippedEmotes(desc:GetEquippedEmotes())
                            disguiseclone:Destroy()
                            local function applyShadowDisguise()
                                local shadow = workspace:FindFirstChild("Shadows")
                                if shadow then
                                    local playerShadow = shadow:FindFirstChild(localPlayer.Name)
                                    if playerShadow and playerShadow ~= lastShadow then
                                        for _, part in pairs(playerShadow:GetChildren()) do
                                            if
                                                part:IsA("Accessory") or part:IsA("ShirtGraphic") or part:IsA("Shirt") or
                                                    part:IsA("Pants")
                                             then
                                                part:Destroy()
                                            end
                                        end
                                        local bodyColors = playerShadow:FindFirstChildOfClass("BodyColors")
                                        if bodyColors then
                                            bodyColors.HeadColor = BrickColor.Random()
                                            bodyColors.LeftLegColor = BrickColor.Random()
                                            bodyColors.RightLegColor = BrickColor.Random()
                                            bodyColors.LeftArmColor = BrickColor.Random()
                                            bodyColors.RightArmColor = BrickColor.Random()
                                            bodyColors.TorsoColor = BrickColor.Random()
                                        end
                                        lastShadow = playerShadow
                                    end
                                end
                            end
                            task.spawn(
                                function()
                                    while true do
                                        if
                                            not workspace:FindFirstChild("Shadows") or
                                                not workspace.Shadows:FindFirstChild(localPlayer.Name)
                                         then
                                            lastShadow = nil
                                        end
                                        applyShadowDisguise()
                                        task.wait(1)
                                    end
                                end
                            )
                        end
                    end
                )
            end
            local oldUserId = tostring(localPlayer.UserId)
            local oldName = localPlayer.Name
            local oldDisplayName = localPlayer.DisplayName
            local function processtext(text)
                if string.gsub(text, oldName, getgenv().Config.FakeName) ~= text then
                    return string.gsub(text, oldName, getgenv().Config.FakeName)
                elseif string.gsub(text, oldUserId, getgenv().Config.FakeId) ~= text then
                    return string.gsub(text, oldUserId, getgenv().Config.FakeId)
                elseif string.gsub(text, oldDisplayName, getgenv().Config.FakeDisplayName) ~= text then
                    return string.gsub(text, oldDisplayName, getgenv().Config.FakeDisplayName)
                end
                return text or ""
            end
            for _, v in next, game:GetDescendants() do
                if v:IsA("TextBox") or v:IsA("TextLabel") or v:IsA("TextButton") then
                    v.Text = processtext(v.Text)
                    v.Name = processtext(v.Name)
                    v.Changed:Connect(
                        function()
                            v.Text = processtext(v.Text)
                            v.Name = processtext(v.Name)
                        end
                    )
                end
            end
            game.DescendantAdded:Connect(
                function(descendant)
                    if descendant:IsA("TextBox") or descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
                        descendant.Text = processtext(descendant.Text)
                        descendant.Name = processtext(descendant.Name)
                        descendant.Changed:Connect(
                            function()
                                descendant.Text = processtext(descendant.Text)
                                descendant.Name = processtext(descendant.Name)
                            end
                        )
                    end
                end
            )
            localPlayer.CharacterAppearanceId = getgenv().Config.FakeId
            if getgenv().Config.Headless == true then
                task.spawn(
                    function()
                        while true do
                            local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                            if char and char:FindFirstChild("Head") then
                                char.Head.Transparency = 1
                                local decal = char.Head:FindFirstChildOfClass("Decal")
                                if decal then
                                    decal:Destroy()
                                end
                            end
                            task.wait(0.5)
                        end
                    end
                )
            end
            pcall(
                function()
                    disguisechar(localPlayer.Character, getgenv().Config.FakeId)
                end
            )
            localPlayer.CharacterAdded:Connect(
                function(character)
                    disguisechar(character, getgenv().Config.FakeId)
                end
            )
        end
    }
)
local trade_tab = {trade = Window:AddTab({Title = "Trade", Icon = "gift"})}
local trade_sec = trade_tab.trade:AddSection("Trading")
local player_list = {}
local function get_player_list()
    player_list = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= lp then
            table.insert(player_list, player.Name)
        end
    end
end
get_player_list()
local select_player =
    trade_sec:AddDropdown(
    "select_player",
    {Title = "Select Player", Values = player_list, Multi = false, Default = "", Callback = function(Value)
            getgenv().select_player = Value
        end}
)
trade_sec:AddButton(
    {Title = "Refresh Player List", Description = "", Callback = function()
            get_player_list()
            select_player:SetValues(player_list)
        end}
)
trade_sec:AddToggle(
    "Toggle",
    {
        Title = "Auto Send All Items",
        Default = getgenv().config.auto_trade_all_items or false,
        Callback = function(Value)
            getgenv().config.auto_trade_all_items = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_trade_all_items do
                        task.wait()
                        for _, item in ipairs(lp.Backpack:GetChildren()) do
                            if item:IsA("Tool") then
                                item.Parent = lp.Character
                                local offer_event = item:FindFirstChild("offer")
                                if offer_event then
                                    local args = {[1] = getgenv().select_player}
                                    pcall(
                                        function()
                                            offer_event:FireServer(unpack(args))
                                        end
                                    )
                                end
                                item.Parent = lp.Backpack
                            end
                        end
                    end
                end
            )
        end
    }
)
trade_sec:AddButton(
    {
        Title = "Send All Items",
        Description = "",
        Callback = function()
            for _, item in ipairs(lp.Backpack:GetChildren()) do
                if item:IsA("Tool") then
                    if item:IsA("Tool") then
                        item.Parent = lp.Character
                        local offer_event = item:FindFirstChild("offer")
                        if offer_event then
                            local args = {[1] = getgenv().select_player}
                            pcall(
                                function()
                                    offer_event:FireServer(unpack(args))
                                end
                            )
                        end
                        item.Parent = lp.Backpack
                    end
                end
            end
        end
    }
)
trade_sec:AddButton(
    {Title = "Send Equipped Item", Description = "", Callback = function()
            local target_player = game.Players:FindFirstChild(getgenv().select_player)
            if target_player then
                local equipped_tool = lp.Character:FindFirstChildWhichIsA("Tool")
                if equipped_tool and equipped_tool:FindFirstChild("offer") then
                    equipped_tool.offer:FireServer(target_player)
                end
            end
        end}
)
trade_sec:AddToggle(
    "Toggle",
    {
        Title = "Auto Accept Trade",
        Default = getgenv().config.auto_accept_trade or false,
        Callback = function(Value)
            getgenv().config.auto_accept_trade = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_accept_trade do
                        task.wait()
                        local hud = lp.PlayerGui:FindFirstChild("hud")
                        if hud then
                            local safezone = hud:FindFirstChild("safezone")
                            if safezone then
                                local bodyAnnouncements = safezone:FindFirstChild("bodyannouncements")
                                if bodyAnnouncements then
                                    local offerFrame = bodyAnnouncements:FindFirstChild("offer")
                                    if offerFrame and offerFrame:FindFirstChild("confirm") then
                                        firesignal(offerFrame.confirm.MouseButton1Click)
                                    end
                                end
                            end
                        end
                    end
                end
            )
        end
    }
)
local server_tab = {server = Window:AddTab({Title = "Server", Icon = "wifi"})}
local server_sec = server_tab.server:AddSection("Server")
server_sec:AddButton(
    {Title = "Copy JobId", Description = "", Callback = function()
            setclipboard(game.JobId)
        end}
)
local jobid =
    server_sec:AddInput(
    "Input",
    {
        Title = "Job Id",
        Default = "",
        Placeholder = "Input JobId",
        Numeric = false,
        Finished = false,
        Callback = function(Value)
        end
    }
)
server_sec:AddButton(
    {Title = "Join JobId", Description = "", Callback = function(Value)
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobid.Value, lp)
        end}
)
server_sec:AddButton(
    {Title = "Rejoin", Description = "", Callback = function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
        end}
)
server_sec:AddButton(
    {Title = "Server Hop", Description = "", Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, lp)
        end}
)
local miscellaneous_tab = {miscellaneous = Window:AddTab({Title = "Miscellaneous", Icon = "align-justify"})}
local misc_sec = miscellaneous_tab.miscellaneous:AddSection("Misc")
misc_sec:AddToggle(
    "Toggle",
    {
        Title = "Anti AFK",
        Default = getgenv().config.anti_afk or false,
        Callback = function(Value)
            getgenv().config.anti_afk = Value
            spawn(
                function()
                    if getgenv().config.anti_afk then
                        task.spawn(
                            function()
                                lp.Idled:connect(
                                    function()
                                        pcall(
                                            function()
                                                vr:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                                                task.wait()
                                                vr:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                                            end
                                        )
                                    end
                                )
                            end
                        )
                    end
                end
            )
        end
    }
)
misc_sec:AddButton(
    {Title = "Less Lag", Description = "", Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/v5cvqQ7r"))()
        end}
)
misc_sec:AddToggle(
    "Toggle",
    {Title = "Remove Fog", Default = getgenv().config.remove_fog or false, Callback = function(Value)
            getgenv().config.remove_fog = Value
            if getgenv().config.remove_fog then
                if game:GetService("Lighting"):FindFirstChild("Sky") then
                    game:GetService("Lighting"):FindFirstChild("Sky").Parent = game:GetService("Lighting").bloom
                end
            else
                if game:GetService("Lighting").bloom:FindFirstChild("Sky") then
                    game:GetService("Lighting").bloom:FindFirstChild("Sky").Parent = game:GetService("Lighting")
                end
            end
        end}
)
local rod_multiplier = miscellaneous_tab.miscellaneous:AddSection("Rod Multiplier")
local rods_equip_amount =
    rod_multiplier:AddInput(
    "rods_equip_amount",
    {
        Title = "Rods Multiplier Amount",
        Default = "",
        Placeholder = "Input Amount...",
        Numeric = true,
        Finished = false,
        Callback = function(Value)
            getgenv().rods_equip_amount = tonumber(Value)
        end
    }
)
rod_multiplier:AddButton(
    {Title = "Rod Multiplier", Description = "", Callback = function()
            for i = 1, getgenv().rods_equip_amount do
                local rod_of_the_depths = {[1] = "Rod Of The Eternal King"}
                re.events.equiprod:FireServer(unpack(rod_of_the_depths))
                local rod_of_the_forgotten_fang = {[1] = "Rod Of The Depths"}
                re.events.equiprod:FireServer(unpack(rod_of_the_forgotten_fang))
            end
            local equipped_rods = {}
            for _, tool in ipairs(lp.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(equipped_rods, tool.Name)
                end
            end
            if not table.find(equipped_rods, "Rod Of The Eternal King") then
                local rod_of_eternal_king = {[1] = "Rod Of The Eternal King"}
                re.events.equiprod:FireServer(unpack(rod_of_eternal_king))
            end
        end}
)
rod_multiplier:AddToggle(
    "Toggle",
    {
        Title = "Auto Fail Catch",
        Default = getgenv().config.auto_fail_catch or false,
        Callback = function(Value)
            getgenv().config.auto_fail_catch = Value
            save_config()
            spawn(
                function()
                    while getgenv().config.auto_fail_catch do
                        task.wait()
                        if lp:WaitForChild("PlayerGui"):FindFirstChild("reel") then
                            task.wait()
                            re.events.reelfinished:FireServer(0)
                        end
                    end
                end
            )
        end
    }
)
Window:SelectTab(1)
Fluent:Notify({Title = "Fisch:", Content = "Executed!", Duration = 5})
