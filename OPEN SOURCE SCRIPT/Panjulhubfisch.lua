local StellarLibrary = loadstring(game:HttpGet("https://pastebin.com/raw/X9xMVqEZ"))()

local Window = StellarLibrary:CreateWindow({Title = "TEST"})

local Fishing = Window:AddTab({ Title = "Fishing", Icon = "anchor" })
  local GuiService = game:GetService("GuiService")
  local VirtualInputManager = game:GetService("VirtualInputManager")
  local RepliStorage = game:GetService("ReplicatedStorage")
      local HttpService = game:GetService("HttpService")
      local Players = game:GetService("Players")
      local RunService = game:GetService("RunService")
  --	local ReplicatedStorage = game:GetService("ReplicatedStorage")
      local TweenService = game:GetService("TweenService")
      local VirtualInputManager = Instance.new("VirtualInputManager") -- fak u
      local VirtualUser = game:GetService("VirtualUser")
      local StarterGui = game:GetService("StarterGui")
      local CoreGui = game:GetService("CoreGui")
  --	local GuiService = game:GetService("GuiService")
      local CollectionService = game:GetService("CollectionService")
      local UserInputService = game:GetService("UserInputService")
      local Lighting = game:GetService("Lighting")
      local CorePackages = game:GetService("CorePackages")
      local VeryImportantPart = Instance.new("Part") -- fake zone for tricking temperature/oxygen scripts
  
  local LocalPlayer = Players.LocalPlayer
  local Utils = {}
  --local CurrentTool: Tool? 

  --Variable
  local AutoCasting = false
  local AutoReeling = false
  local InstantBob = false
  local AutoSelling = false

  local MainLeft = Fishing:AddSection({Title = "Fishing"})
  local InstantBob = false
  local InstantBobConnection
  
  MainLeft:AddToggle("InstantBobber", {
      Title = "Instant Bobber",
      Default = false,
      Description = "Instan pivot bobber ke permukaan air di bawah",
      Callback = function(Value)
          InstantBob = Value
  
          if InstantBob then
              InstantBobConnection = RunService.RenderStepped:Connect(function()
                  local success, err = pcall(function()
                      local Character = LocalPlayer.Character
                      if not Character then return end
  
                      local Tool = Character:FindFirstChildOfClass("Tool")
                      if not Tool then return end
  
                      local Bobber = Tool:FindFirstChild("bobber")
                      if not Bobber then return end
  
                      local Params = RaycastParams.new()
                      Params.FilterType = Enum.RaycastFilterType.Include
                      Params.FilterDescendantsInstances = { workspace.Terrain }
  
                      local RayResult = workspace:Raycast(Bobber.Position, Vector3.new(0, -10, 0), Params)
                      if RayResult and RayResult.Instance and RayResult.Instance:IsA("Terrain") then
                          Bobber:PivotTo(CFrame.new(RayResult.Position))
                      end
                  end)
                  
                  if not success then
                      warn("[InstantBobber Error]:", err)
                  end
              end)
          elseif InstantBobConnection then
              InstantBobConnection:Disconnect()
              InstantBobConnection = nil
          end
      end
  })
  