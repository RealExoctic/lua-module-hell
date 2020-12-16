--[[ PLAYER ]]
local Player  = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local CurrentCamera = workspace.CurrentCamera
local Mouse = Player:GetMouse()

--[[ SERVICDES ]]
local RunService = game:GetService("RunService")
local Shared = game:GetService("ReplicatedStorage").Shared
local ContextActionService = game:GetService("ContextActionService")

--[[ VARIABLES ]]
local Buttons = game.ReplicatedStorage.Shared.GlobalModules.Buttons


for _,v in pairs(Shared.GlobalModules.Input:GetDescendants()) do 
    if v:IsA("ModuleScript") then 
        local Clone = require(v:Clone())
        print(v)
        ContextActionService:BindAction(v.Name,Clone.Input,true,Clone.Key)
    end
end