
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()


local ReplicatedStorage = game.ReplicatedStorage.Shared
local UserInputService = game:GetService("UserInputService")

local StarterGui = game:GetService("StarterGui")

local CurrentCamera = workspace.CurrentCamera
local Mouse = Player:GetMouse()

for _,ClientModule in pairs(ReplicatedStorage.GlobalModules.Client:GetDescendants()) do
	if ClientModule:IsA("ModuleScript") and ClientModule.Parent ~= "IgnoreOnStartup" then 
		local Loaded,Failure = pcall(function()
			require(ClientModule)
		end)
	end
end