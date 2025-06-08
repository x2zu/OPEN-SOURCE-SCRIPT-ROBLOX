local CoreGui = game:GetService("CoreGui");
local loadTime = os.clock()
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

local InfLoadGui = {}
-- StarterGui.Infernium
InfLoadGui["1"] = Instance.new("ScreenGui", CoreGui or game:GetService("Players").LocalPlayer.PlayerGui);
InfLoadGui["1"]["Name"] = [[InferniumLoad]];
InfLoadGui["1"]["IgnoreGuiInset"] = true;
InfLoadGui["1"]["ResetOnSpawn"] = false;

-------------------------------------------------
-- StarterGui.Infernium.PhoneButton
InfLoadGui["2"] = Instance.new("Frame", InfLoadGui["1"]);
InfLoadGui["2"]["Visible"] = false;
InfLoadGui["2"]["BorderSizePixel"] = 0;
InfLoadGui["2"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
InfLoadGui["2"]["Size"] = UDim2.new(0.03773, 0, 0.07624, 0);
InfLoadGui["2"]["Position"] = UDim2.new(0.45881, 0, 0.41418, 0);
InfLoadGui["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
InfLoadGui["2"]["Name"] = [[PhoneButton]];
InfLoadGui["2"]["BackgroundTransparency"] = 0.34;


-- StarterGui.Infernium.PhoneButton.UIGradient
InfLoadGui["3"] = Instance.new("UIGradient", InfLoadGui["2"]);
InfLoadGui["3"]["Rotation"] = 45;
InfLoadGui["3"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.249, Color3.fromRGB(229, 218, 255)),ColorSequenceKeypoint.new(0.505, Color3.fromRGB(199, 176, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(188, 161, 255))};


-- StarterGui.Infernium.PhoneButton.UICorner
InfLoadGui["4"] = Instance.new("UICorner", InfLoadGui["2"]);
InfLoadGui["4"]["CornerRadius"] = UDim.new(0.26, 0);


-- StarterGui.Infernium.PhoneButton.UIStroke
InfLoadGui["5"] = Instance.new("UIStroke", InfLoadGui["2"]);
InfLoadGui["5"]["Thickness"] = 4;
InfLoadGui["5"]["Color"] = Color3.fromRGB(79, 0, 98);


-- StarterGui.Infernium.PhoneButton.Icon
InfLoadGui["6"] = Instance.new("ImageLabel", InfLoadGui["2"]);
InfLoadGui["6"]["BorderSizePixel"] = 0;
InfLoadGui["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
InfLoadGui["6"]["Image"] = [[http://www.roblox.com/asset/?id=80049658671101]];
InfLoadGui["6"]["Size"] = UDim2.new(0.84244, 0, 0.76453, 0);
InfLoadGui["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
InfLoadGui["6"]["BackgroundTransparency"] = 1;
InfLoadGui["6"]["Name"] = [[Icon]];
InfLoadGui["6"]["Position"] = UDim2.new(0.07641, 0, 0.11024, 0);


-- StarterGui.Infernium.PhoneButton.UIAspectRatioConstraint
InfLoadGui["7"] = Instance.new("UIAspectRatioConstraint", InfLoadGui["2"]);
InfLoadGui["7"]["AspectRatio"] = 1.00454;


-- StarterGui.Infernium.PhoneButton.ImageButton
InfLoadGui["8"] = Instance.new("ImageButton", InfLoadGui["2"]);
InfLoadGui["8"]["BorderSizePixel"] = 0;
InfLoadGui["8"]["AutoButtonColor"] = false;
InfLoadGui["8"]["ImageTransparency"] = 1;
InfLoadGui["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
InfLoadGui["8"]["Image"] = [[rbxassetid://4841508676]];
InfLoadGui["8"]["Size"] = UDim2.new(1, 0, 1, 0);
InfLoadGui["8"]["BackgroundTransparency"] = 1;
InfLoadGui["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);

--------------------------------------
-- StarterGui.Infernium.LoadingScreen
InfLoadGui["9"] = Instance.new("Frame", InfLoadGui["1"]);
InfLoadGui["9"]["BorderSizePixel"] = 0;
InfLoadGui["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
InfLoadGui["9"]["Size"] = UDim2.new(0.05988, 0, 0.12438, 0);
InfLoadGui["9"]["Position"] = UDim2.new(0.47006, 0, 0.43781, 0);
InfLoadGui["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
InfLoadGui["9"]["Name"] = [[LoadingScreen]];
InfLoadGui["9"]["BackgroundTransparency"] = 1;
InfLoadGui["9"]["Visible"] = true;


-- StarterGui.Infernium.LoadingScreen.Icon
InfLoadGui["a"] = Instance.new("ImageLabel", InfLoadGui["9"]);
InfLoadGui["a"]["BorderSizePixel"] = 0;
InfLoadGui["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
InfLoadGui["a"]["Image"] = [[http://www.roblox.com/asset/?id=80049658671101]];
InfLoadGui["a"]["Size"] = UDim2.new(1.20497, 0, 1.09353, 0);
InfLoadGui["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
InfLoadGui["a"]["BackgroundTransparency"] = 1;
InfLoadGui["a"]["ImageTransparency"] = 1;
InfLoadGui["a"]["Name"] = [[Icon]];
InfLoadGui["a"]["Position"] = UDim2.new(-0.098, 0, -0.329, 0);


-- StarterGui.Infernium.LoadingScreen.LoadLabel
InfLoadGui["b"] = Instance.new("TextLabel", InfLoadGui["9"]);
InfLoadGui["b"]["TextWrapped"] = true;
InfLoadGui["b"]["BorderSizePixel"] = 0;
InfLoadGui["b"]["TextSize"] = 14;
InfLoadGui["b"]["TextScaled"] = true;
InfLoadGui["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
InfLoadGui["b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Montserrat.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
InfLoadGui["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
InfLoadGui["b"]["BackgroundTransparency"] = 1;
InfLoadGui["b"]["Size"] = UDim2.new(9.21092, 0, 0.20244, 0);
InfLoadGui["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
InfLoadGui["b"]["Text"] = [[Loading module..]];
InfLoadGui["b"]["Name"] = [[LoadLabel]];
InfLoadGui["b"]["Position"] = UDim2.new(-4.08, 0, 0.75977, 0);


-- StarterGui.Infernium.LoadingScreen.LoadLabel.UIStroke
InfLoadGui["c"] = Instance.new("UIStroke", InfLoadGui["b"]);
InfLoadGui["c"]["Thickness"] = 0.8;
InfLoadGui["c"]["Color"] = Color3.fromRGB(32, 9, 59);


-- StarterGui.Infernium.LoadingScreen.UIAspectRatioConstraint
InfLoadGui["d"] = Instance.new("UIAspectRatioConstraint", InfLoadGui["9"]);

_G.Passed = true
local _loaded = false
local _canShow = false
local _LoadingText = {
    "Checking Modules",
    "Initializing Assets",
    "Loading Core Components",
    "Verifying Files",
    "Preparing System",
    "Syncing Resources",
    "Configuring Settings",
    "Loading Data",
    "Establishing Connection",
    "Starting Engine",
    "Optimizing Performance",
    "Checking Dependencies",
    "Finalizing Setup",
    "Compiling Resources",
    "Launching Interface",
    "Encrypting Files",
    "Loading Framework",
    "Validating Modules",
    "Setting Up Network",
    "Checking Integrity",
    "Creating Database",
    "Starting Services",
    "Preloading Scripts",
    "Loading Libraries",
    "Activating Security",
    "Optimizing Code",
    "Initializing System",
    "Decrypting Files",
    "Verifying Connections",
    "Establishing Protocols",
    "Synchronizing Data",
    "Loading Features",
    "Configuring Engine",
    "Loading Assets",
    "Updating Files",
    "Checking Resources",
    "Preparing Data",
    "Activating Modules",
    "System Check Complete",
    "Setting Up UI",
    "Verifying Authentication",
    "Running Security Check",
    "Activating Functions",
    "Preloading Resources"
}

local random = Random.new()
task.spawn(function()
    while _canShow == false do
        for i = 1, 3 do
            InfLoadGui["b"]["Text"] = string.gsub(InfLoadGui["b"]["Text"], "%.+", "")
            InfLoadGui["b"]["Text"] = InfLoadGui["b"]["Text"] .. string.rep(".", i)
            task.wait(0.5)
        end
    end
end)

local upTime = 1.8
local downTime = 0.7
task.spawn(function()
    ts:Create(InfLoadGui["a"], TweenInfo.new(upTime, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {ImageTransparency = 0}):Play()
    ts:Create(InfLoadGui["b"], TweenInfo.new(upTime, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency = 0}):Play()

    while _loaded == false do
        if _G.Passed == false then
            InfLoadGui["b"]["Text"] = "Verifying"
            while _G.Passed == false do
                task.wait(0.5)
            end
        end

        local randomText = _LoadingText[math.random(1, #_LoadingText)]
        InfLoadGui["b"]["Text"] = randomText
        task.wait(random:NextNumber(1.3, 3.5))
    end

    ts:Create(InfLoadGui["a"], TweenInfo.new(downTime, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
    ts:Create(InfLoadGui["b"], TweenInfo.new(downTime, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
    task.wait(downTime)
    InfLoadGui["1"]:Destroy()
    _canShow = true
end)

