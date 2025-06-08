local HttpService = game:GetService("HttpService")

-- URL Firebase (Ganti dengan URL Database Firebase kamu)
local firebaseUrl = "https://execution-b3f68-default-rtdb.firebaseio.com/executionCount.json"

-- URL Webhook Discord (Ganti dengan webhook kamu)
local discordWebhookUrl = "https://discord.com/api/webhooks/1354541576646430890/6ORZLO1QklH4mk0jh6WelPc_FgGteM77GhA4qnYuGY04ykbWDUk2PH3LY-HfYJ5W1VwU"

-- Ambil data dari Firebase
local function getExecutionCount()
    local response = request({
        Url = firebaseUrl,
        Method = "GET"
    })

    if response and response.Body then
        local data = tonumber(response.Body) or 0
        return data
    else
        warn("Gagal mengambil data dari Firebase!")
        return 0
    end
end

-- Update execution count ke Firebase dan Discord
local function updateExecutionCount()
    local currentCount = getExecutionCount()
    local newCount = currentCount + 1

    -- Simpan ke Firebase
    request({
        Url = firebaseUrl,
        Method = "PUT",
        Headers = { ["Content-Type"] = "application/json" },
        Body = tostring(newCount)
    })

    -- Kirim ke Discord Webhook
    local messageData = {
        ["username"] = "Execution Tracker",
        ["avatar_url"] = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg?ex=67c93a3a&is=67c7e8ba&hm=a345e419c89c574e0f32f5ec36919cb1800eae29aa213afa5d64524a1a37287f&=&format=webp",
        ["embeds"] = {
            {
                ["title"] = "Script Execution Tracker",
                ["description"] = "**Total Executions:** `" .. tostring(newCount) .. "`",
                ["color"] = tonumber(0x00FF00), -- Warna hijau
                ["footer"] = { ["text"] = "Execution Webhook | Made by ThanHub" },
                ["timestamp"] = DateTime.now():ToIsoDate()
            }
        }
    }

    local messageJson = HttpService:JSONEncode(messageData)

    request({
        Url = discordWebhookUrl,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = messageJson
    })

    print("Execution count diperbarui: " .. newCount)
end

-- Jalankan update execution
updateExecutionCount()

local id = game.PlaceId
if id == 16732694052 then
Fisch = true;
else
game:Shutdown()
end;
if game.Workspace.zones.fishing:FindFirstChild("Megalodon Default") then
    if Fisch then
 
    for i, v in pairs(game.Players:GetPlayers()) do
        PlayersMin = i
    end
 
    if game.Workspace.zones.fishing:FindFirstChild("Megalodon Default") then
        MegalodonMessage = '```Megalodon is spawing : 🟢```'
    else
        MegalodonMessage = '```Megalodon isn\'t spawn : :x:```'
    end
    JoinServer = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,' ..
        '\'' .. tostring(game.JobId) .. '\'' .. ')'
 
 
    local url = "https://discord.com/api/webhooks/1350822212613050449/3H1V_pNIViRxF19sANHfBEIqGGfjSqFDJXeIlvf7zh8-l_QyIovNZL1-ALNISwgDWiti"                                                                                                                
    local data = {
        ["username"] = 'Fisch Finder || Thanhub',                                                                                                                                                                                                           
        ['content'] = '',--'<@&1178668706461646953>',                                                                                                                                                                                            
        ["avatar_url"] = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg?ex=67c93a3a&is=67c7e8ba&hm=a345e419c89c574e0f32f5ec36919cb1800eae29aa213afa5d64524a1a37287f&=&format=webp", 
        ["embeds"] = {
            {
                ["description"] = "# **Megalodon Webhook**",
                ["color"] = tonumber(0x0000FF), -- color id        #
                ["type"] = "rich",
                ["fields"] = {
                    {
                        ["name"] = "[🦈] Megalodon Check",
                        ["value"] = MegalodonMessage,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "[📃] JobID",
                        ["value"] = '```' .. tostring(game.JobId) .. '```'
                    },
                    {
                        ["name"] = "[📁] Join Server",
                        ["value"] = '```' .. JoinServer .. '```',
                    },
                    {
                        ["name"] = "[👥] Players Active",
                        ["value"] = '```' .. tostring(PlayersMin) .. '/15```'
                    }
                },
                ["footer"] = {
                    ["text"] = "Webhook Created By ThanHub WEBHOOK", 
                },
                ["timestamp"] = DateTime.now():ToIsoDate(),
            }
        },
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request
    local abcdef = { Url = url, Body = newdata, Method = "POST", Headers = headers }
    request(abcdef)
    end
    end

local id = game.PlaceId
if id == 16732694052 then
Fisch = true;
else
game:Shutdown()
end;
if game.Workspace.zones.fishing:FindFirstChild("Isonade") then
    if Fisch then
 
    for i, v in pairs(game.Players:GetPlayers()) do
        PlayersMin = i
    end
 
    if game.Workspace.zones.fishing:FindFirstChild("Isonade") then
        IsonadeMessage = '```Strange Pool is spawing : 🟢```'
    else
        IsonadeMessage = '```Strange Pool isn\'t spawn : :x:```'
    end
    JoinServer = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,' ..
        '\'' .. tostring(game.JobId) .. '\'' .. ')'
 
 
    local url = "https://discord.com/api/webhooks/1350822357677113414/nh0JBkVhDEZDwVah1GcJb8moGFrmthqRUj25S8ZfiZbwiwut-EXVmhjoHpkQGp05NetV"                                                                                                                
    local data = {
        ["username"] = 'Fisch Finder || Thanhub',                                                                                                                                                                                                           
        ['content'] = '',--'<@&1178668706461646953>',                                                                                                                                                                                            
        ["avatar_url"] = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg?ex=67c93a3a&is=67c7e8ba&hm=a345e419c89c574e0f32f5ec36919cb1800eae29aa213afa5d64524a1a37287f&=&format=webp", 
        ["embeds"] = {
            {
                ["description"] = "# **Strange Pool ( Isonade ) Webhook**",
                ["color"] = tonumber(0x0000FF), -- color id        #
                ["type"] = "rich",
                ["fields"] = {
                    {
                        ["name"] = "Strange Pool Check",
                        ["value"] = IsonadeMessage,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "[📃] JobID",
                        ["value"] = '```' .. tostring(game.JobId) .. '```'
                    },
                    {
                        ["name"] = "[📁] Join Server",
                        ["value"] = '```' .. JoinServer .. '```',
                    },
                    {
                        ["name"] = "[👥] Players Active",
                        ["value"] = '```' .. tostring(PlayersMin) .. '/15```'
                    }
                },
                ["footer"] = {
                    ["text"] = "Webhook Created By ThanHub WEBHOOK", 
                },
                ["timestamp"] = DateTime.now():ToIsoDate(),
            }
        },
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request
    local abcdef = { Url = url, Body = newdata, Method = "POST", Headers = headers }
    request(abcdef)
    end
    end

local id = game.PlaceId
if id == 16732694052 then
Fisch = true;
else
game:Shutdown()
end;
if game.Workspace.zones.fishing:FindFirstChild("Orcas Pool") then
    if Fisch then
 
    for i, v in pairs(game.Players:GetPlayers()) do
        PlayersMin = i
    end
 
    if game.Workspace.zones.fishing:FindFirstChild("Orcas Pool") then
        OrcasMessage = '```Orcas Pool is spawing : 🟢```'
    else
	OrcasMessage = '```Orcas Pool is spawing : :x:```'
    end
    JoinServer = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,' ..
        '\'' .. tostring(game.JobId) .. '\'' .. ')'
 
    local url = "https://discord.com/api/webhooks/1351348313730842704/NYv-_bM5YMAYRHvkNLSd83QCyWJ2dHq15MjKRvtbUlZdBhiMId739Ih3AXXJ8BT5ndQO"                                                                                                                
    local data = {
        ["username"] = 'Fisch Finder || Thanhub',                                                                                                                                                                                                           
        ['content'] = '',--'<@&1178668706461646953>',                                                                                                                                                                                            
        ["avatar_url"] = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg?ex=67c93a3a&is=67c7e8ba&hm=a345e419c89c574e0f32f5ec36919cb1800eae29aa213afa5d64524a1a37287f&=&format=webp", 
        ["embeds"] = {
            {
                ["description"] = "# **Orcas Pool Webhook**",
                ["color"] = tonumber(0x0000FF), -- color id        #
                ["type"] = "rich",
                ["fields"] = {
                    {
                        ["name"] = "Orcas Pool Check",
                        ["value"] = OrcasMessage,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "[📃] JobID",
                        ["value"] = '```' .. tostring(game.JobId) .. '```'
                    },
                    {
                        ["name"] = "[📁] Join Server",
                        ["value"] = '```' .. JoinServer .. '```',
                    },
                    {
                        ["name"] = "[👥] Players Active",
                        ["value"] = '```' .. tostring(PlayersMin) .. '/15```'
                    }
                },
                ["footer"] = {
                    ["text"] = "Webhook Created By ThanHub WEBHOOK", 
                },
                ["timestamp"] = DateTime.now():ToIsoDate(),
            }
        },
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request
    local abcdef = { Url = url, Body = newdata, Method = "POST", Headers = headers }
    request(abcdef)
    end
    end

local id = game.PlaceId
if id == 16732694052 then
    Fisch = true
else
    game:Shutdown()
end

if Fisch then
    for i, v in pairs(game.Players:GetPlayers()) do
        PlayersMin = i
    end

-- Cek apakah ReplicatedStorage > world > uptime ada
local UpTimeMessage = "Unknown"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if ReplicatedStorage:FindFirstChild("world") and ReplicatedStorage.world:FindFirstChild("uptime") then
    local elapsedTime = ReplicatedStorage.world.uptime.Value
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = math.floor(elapsedTime % 60)
    UpTimeMessage = string.format("```%02d:%02d:%02d```", hours, minutes, seconds)
end

    -- Total Players di Server
    local TotalPlayers = #game.Players:GetPlayers()

-- Game Version dari playerstats
local GameVersion = "Unknown"
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if Workspace:FindFirstChild("PlayerStats") then
    local playerStats = Workspace.PlayerStats:FindFirstChild(game.Players.LocalPlayer.Name)
    if playerStats and playerStats:FindFirstChild("T") then
        local playerFolder = playerStats:FindFirstChild("T"):FindFirstChild(game.Players.LocalPlayer.Name)
        if playerFolder and playerFolder:FindFirstChild("Stats") then
            local stats = playerFolder.Stats
            if stats:FindFirstChild("lastversion") then
                GameVersion = stats.lastversion.Value
            end
        end
    end
end
    -- Ambil Cycle dari ReplicatedStorage
    local CycleStatus = "Unknown" -- Default jika tidak ditemukan
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    if ReplicatedStorage:FindFirstChild("world") and ReplicatedStorage.world:FindFirstChild("cycle") then
        CycleStatus = ReplicatedStorage.world.cycle.Value -- Ambil nilai dari cycle
    end

    -- Generate Join Server Script
    local JoinServer = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,' ..
        '\'' .. tostring(game.JobId) .. '\'' .. ')'

    local url = "https://discord.com/api/webhooks/1351356594843156480/qQAwdr-zE2j6kUJjYjUzBdja3SWKHGMYX_bO7ja0hwMViOey6J79gsW0Q9_w3jd-_0C1"
    local data = {
        ["username"] = 'Server Info || Thanhub',
        ['content'] = '',
        ["avatar_url"] = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg?ex=67c93a3a&is=67c7e8ba&hm=a345e419c89c574e0f32f5ec36919cb1800eae29aa213afa5d64524a1a37287f&=&format=webp",
        ["embeds"] = {
            {
                ["description"] = "# **Server Information**",
                ["color"] = tonumber(0x0000FF), -- Warna embed (biru)
                ["type"] = "rich",
                ["fields"] = {
                    {
                        ["name"] = "[⏳] Server UpTime",
                        ["value"] = UpTimeMessage
                    },
                    {
                        ["name"] = "[👥] Total Players",
                        ["value"] = '```' .. tostring(TotalPlayers) .. '/15```',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "[🔖] Game Version",
                        ["value"] = '```' .. tostring(GameVersion) .. '```',
                        ["inline"] = true
                    },
                    {
                        ["name"] = "[🌍] Server Cycle",
                        ["value"] = '```' .. CycleStatus .. '```',
                        ["inline"] = true
                    },
		    {
                        ["name"] = "[📃] JobID",
                        ["value"] = '```' .. tostring(game.JobId) .. '```'
                    },
                    {
                        ["name"] = "[📁] Join Server",
                        ["value"] = '```' .. JoinServer .. '```',
                    }
                },
                ["footer"] = {
                    ["text"] = "Webhook Created By ThanHub WEBHOOK",
                },
                ["timestamp"] = DateTime.now():ToIsoDate(),
            }
        },
    }

    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request
    local abcdef = { Url = url, Body = newdata, Method = "POST", Headers = headers }
    request(abcdef)
end

local id = game.PlaceId
if id == 16732694052 then
Fisch = true;
else
game:Shutdown()
end;
if game.Workspace.zones.fishing:FindFirstChild("Forsaken Veil - Scylla") then
    if Fisch then
 
    for i, v in pairs(game.Players:GetPlayers()) do
        PlayersMin = i
    end
 
    if game.Workspace.zones.fishing:FindFirstChild("Forsaken Veil - Scylla") then
        ScyllaMessage = '```Forsaken Veil - Scylla is spawing : 🟢```'
    else
	ScyllaMessage = '```Forsaken Veil - Scylla is spawing : :x:```'
    end
    JoinServer = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,' ..
        '\'' .. tostring(game.JobId) .. '\'' .. ')'
 
    local url = "https://discord.com/api/webhooks/1351363551440408656/eiPDdUL3ZRZ9rUZrCiRI4L7BR3fGOiz2wA04OEzxULxJprY7OCGfp-1f1HEYL0IWzLh1"                                                                                                                
    local data = {
        ["username"] = 'Fisch Finder || Thanhub',                                                                                                                                                                                                           
        ['content'] = '',--'<@&1178668706461646953>',                                                                                                                                                                                            
        ["avatar_url"] = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg?ex=67c93a3a&is=67c7e8ba&hm=a345e419c89c574e0f32f5ec36919cb1800eae29aa213afa5d64524a1a37287f&=&format=webp", 
        ["embeds"] = {
            {
                ["description"] = "# **Forsaken Veil - Scylla Webhook**",
                ["color"] = tonumber(0x0000FF), -- color id        #
                ["type"] = "rich",
                ["fields"] = {
                    {
                        ["name"] = "🐉 Forsaken Veil - Scylla Check",
                        ["value"] = ScyllaMessage,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "[📃] JobID",
                        ["value"] = '```' .. tostring(game.JobId) .. '```'
                    },
                    {
                        ["name"] = "[📁] Join Server",
                        ["value"] = '```' .. JoinServer .. '```',
                    },
                    {
                        ["name"] = "[👥] Players Active",
                        ["value"] = '```' .. tostring(PlayersMin) .. '/15```'
                    }
                },
                ["footer"] = {
                    ["text"] = "Webhook Created By ThanHub WEBHOOK", 
                },
                ["timestamp"] = DateTime.now():ToIsoDate(),
            }
        },
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request
    local abcdef = { Url = url, Body = newdata, Method = "POST", Headers = headers }
    request(abcdef)
    end
    end

local id = game.PlaceId
if id == 16732694052 then
Fisch = true;
else
game:Shutdown()
end;
if game.Workspace.zones.fishing:FindFirstChild("Whales Pool") then
    if Fisch then
 
    for i, v in pairs(game.Players:GetPlayers()) do
        PlayersMin = i
    end
 
    if game.Workspace.zones.fishing:FindFirstChild("Whales Pool") then
        WhaleMessage = '```Whales Pool is spawing : 🟢```'
    else
	WhaleMessage = '```Whales Pool is spawing : :x:```'
    end
    JoinServer = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,' ..
        '\'' .. tostring(game.JobId) .. '\'' .. ')'
 
    local url = "https://discord.com/api/webhooks/1352576551337857065/Q_ikSs3cEcxMs6sIgWEWYxtL3Z704TBLf8EXzywqZaZgXinwM3g4PW5BENLzAW4wjX_I"                                                                                                                
    local data = {
        ["username"] = 'Fisch Finder || Thanhub',                                                                                                                                                                                                           
        ['content'] = '',--'<@&1178668706461646953>',                                                                                                                                                                                            
        ["avatar_url"] = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg?ex=67c93a3a&is=67c7e8ba&hm=a345e419c89c574e0f32f5ec36919cb1800eae29aa213afa5d64524a1a37287f&=&format=webp", 
        ["embeds"] = {
            {
                ["description"] = "# **Whales Pool Webhook**",
                ["color"] = tonumber(0x0000FF), -- color id        #
                ["type"] = "rich",
                ["fields"] = {
                    {
                        ["name"] = "🐳 Whales Pool Check",
                        ["value"] = WhaleMessage,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "[📃] JobID",
                        ["value"] = '```' .. tostring(game.JobId) .. '```'
                    },
                    {
                        ["name"] = "[📁] Join Server",
                        ["value"] = '```' .. JoinServer .. '```',
                    },
                    {
                        ["name"] = "[👥] Players Active",
                        ["value"] = '```' .. tostring(PlayersMin) .. '/15```'
                    }
                },
                ["footer"] = {
                    ["text"] = "Webhook Created By ThanHub WEBHOOK", 
                },
                ["timestamp"] = DateTime.now():ToIsoDate(),
            }
        },
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request
    local abcdef = { Url = url, Body = newdata, Method = "POST", Headers = headers }
    request(abcdef)
    end
    end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Pastikan hanya berjalan di tempat yang benar
if game.PlaceId ~= 16732694052 then
    game:Shutdown()
    return
end

-- Cek apakah Aurora Borealis ada
local AuroraExists = Workspace:FindFirstChild("active") 
    and Workspace.active:FindFirstChild("constant") 
    and Workspace.active.constant:FindFirstChild("Aurora Borealis")

if not AuroraExists then return end -- Jika tidak ada Aurora, tidak mengirim webhook

-- Data untuk webhook
local PlayersCount = #Players:GetPlayers()
local AuroraMessage = "🌀 **Aurora Borealis is Active!**"
local JoinServer = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, \'' .. tostring(game.JobId) .. '\')'

local WebhookURL = "https://discord.com/api/webhooks/1353985665997738005/vRlJRVyGMwpxbwiK77ywmWSwJ4oPVAxCbK1Du71rJqB4-CPsz2Qu77U7hYEDny3lTCly"

local WebhookData = {
    ["username"] = "Sky Finder || ThanHub",
    ["avatar_url"] = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg",
    ["embeds"] = {{
        ["title"] = "**ThanHub (Fisch Webhook)**",
        ["color"] = tonumber(0x0000FF),
        ["fields"] = {
            {
                ["name"] = "👋 Players In Server :",
                ["value"] = "```" .. PlayersCount .. "/15```",
                ["inline"] = true
            },
            {
                ["name"] = "🌞 Time Of Day :",
                ["value"] = "```" .. os.date("%X") .. "```",
                ["inline"] = true
            },
            {
                ["name"] = "📌 Information:",
                ["value"] = "```🌌 Aurora Borealis```",
                ["inline"] = false
            },
            {
                ["name"] = "🆔 JobID:",
                ["value"] = "```" .. tostring(game.JobId) .. "```",
                ["inline"] = false
            },
                    {
                        ["name"] = "[📁] Join Server",
                        ["value"] = '```' .. JoinServer .. '```',
                    }
        },
        ["footer"] = {
            ["text"] = "Webhook Created By ThanHub",
        },
        ["timestamp"] = DateTime.now():ToIsoDate(),
    }}
}

-- Kirim data ke webhook
local EncodedData = HttpService:JSONEncode(WebhookData)
local Headers = { ["content-type"] = "application/json" }

local RequestFunction = syn and syn.request or request or HttpPost or http_request
if RequestFunction then
    RequestFunction({ Url = WebhookURL, Body = EncodedData, Method = "POST", Headers = Headers })
end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Pastikan hanya berjalan di tempat yang benar
if game.PlaceId ~= 16732694052 then
    game:Shutdown()
    return
end

-- Cek apakah folder season ada dan ambil musim saat ini
local SeasonExists = ReplicatedStorage:FindFirstChild("world") 
    and ReplicatedStorage.world:FindFirstChild("season")

local CurrentSeason = SeasonExists and ReplicatedStorage.world.season.Value or "Unknown"

-- Jika season tidak ditemukan, jangan kirim webhook
if CurrentSeason == "Unknown" then return end 

-- Warna dan emoji sesuai dengan musim
local SeasonColors = {
    ["Spring"] = 0x00FF00, -- Hijau
    ["Summer"] = 0xFFFF00, -- Kuning
    ["Autumn"] = 0xFFA500, -- Orange
    ["Winter"] = 0xADD8E6  -- Biru Muda
}

local SeasonEmojis = {
    ["Spring"] = "🌸",
    ["Summer"] = "☀️",
    ["Autumn"] = "🍂",
    ["Winter"] = "❄️"
}

local SeasonColor = SeasonColors[CurrentSeason] or 0xFFFFFF -- Default putih jika tidak ada
local SeasonEmoji = SeasonEmojis[CurrentSeason] or "📅"

-- Format pesan dengan ```code block```
local SeasonMessage = '```' .. SeasonEmoji .. " " .. CurrentSeason .. " Season is Active!```"
local JoinServer = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, \'' .. tostring(game.JobId) .. '\')'

local WebhookURL = "https://discord.com/api/webhooks/1353995124392329310/ouvzZDtejkGX52F_ATdH3Xzp2nZbwfp6BYaOLa4DxXQoiKppCJugrZ8a5kuXTHRELvGb"

local WebhookData = {
    ["username"] = "Season Finder || ThanHub",
    ["avatar_url"] = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg",
    ["embeds"] = {{
        ["title"] = "**ThanHub (Fisch Webhook)**",
        ["color"] = tonumber(SeasonColor),
        ["fields"] = {
            {
                ["name"] = "👋 Players In Server :",
                ["value"] = "```" .. #Players:GetPlayers() .. "/15```",
                ["inline"] = true
            },
            {
                ["name"] = "🌞 Time Of Day :",
                ["value"] = "```" .. os.date("%X") .. "```",
                ["inline"] = true
            },
            {
                ["name"] = "📌 Information:",
                ["value"] = SeasonMessage,
                ["inline"] = false
            },
            {
                ["name"] = "🆔 JobID:",
                ["value"] = "```" .. tostring(game.JobId) .. "```",
                ["inline"] = false
            },
                    {
                        ["name"] = "[📁] Join Server",
                        ["value"] = '```' .. JoinServer .. '```',
                    }
        },
        ["footer"] = {
            ["text"] = "Webhook Created By ThanHub",
        },
        ["timestamp"] = DateTime.now():ToIsoDate(),
    }}
}

-- Kirim data ke webhook
local EncodedData = HttpService:JSONEncode(WebhookData)
local Headers = { ["content-type"] = "application/json" }

local RequestFunction = syn and syn.request or request or HttpPost or http_request
if RequestFunction then
    RequestFunction({ Url = WebhookURL, Body = EncodedData, Method = "POST", Headers = Headers })
end