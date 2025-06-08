Information = Window:AddTab({ Title = "Information", Icon = "book" }), 
local Information = Tabs.Information:AddSection("Social Media - Ancestral")
Tabs.Information:AddButton({
    Title = "Copy Discord link",
    Description = "Join our discord to see next update!",
    Callback = function()
        setclipboard("https://discord.gg/dJmUxnAfbq")
    end
})
Tabs.Information:AddButton({
    Title = "Copy Youtube Link",
    Description = "Support me with subscribe! :D",
    Callback = function()
        setclipboard("https://youtube.com/@ismoonss?si=Zb_BaENYI-P_ozM8?sub_confirmation=1")
    end
})
Tabs.Information:AddButton({
    Title = "Copy Tiktok Link",
    Description = "Support me with follow tiktok! :D",
    Callback = function()
        setclipboard("https://www.tiktok.com/@ismoonss_")
    end
})