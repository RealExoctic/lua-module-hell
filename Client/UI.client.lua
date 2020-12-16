local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local UI = PlayerGui:WaitForChild("Main")

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Shared = game.ReplicatedStorage.Shared

local Settings = require(Shared.GlobalModules.Settings)
local API = require(Shared.GlobalModules.API)


pcall(function()
    StarterGui:SetCore("TopbarEnabled", false)
    StarterGui:SetCore("ResetButtonCallback", false)
end)

if RunService:IsStudio() then
     UI.StudioModeSimple.Visible = Settings.StudioModeUiSimple
end



Humanoid.HealthChanged:Connect(function(health)
    if Player.PlayerScripts.Client.Values.HEV.Equipped.Value then
        UI.HUD.Health.Text = health

        if health <= 20 then
            print("Red")
            UI.HUD.Health.TextColor3 = Color3.fromRGB(255,29,15)
            UI.HUD.Icon1.ImageColor3 = Color3.fromRGB(255,29,15 )
        else
            print("Yellow")
            UI.HUD.Health.TextColor3 = Color3.fromRGB(255,160,0)
            UI.HUD.Icon1.ImageColor3 = Color3.fromRGB(255,160,0)
        end
    end
end)

API:DisableMouseIcon(false)


