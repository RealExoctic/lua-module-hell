local Module = {}

Module.Key = Enum.KeyCode.F
Module.MobileButtonEnabled = false

local Player  = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Mouse = Player:GetMouse()

local Sounds = Player.PlayerScripts.Client:WaitForChild("Sounds")
local Values = Player.PlayerScripts.Client:WaitForChild("Values")
local RunService = game:GetService("RunService")

local FlashLightEnabled = false

local GhostPart 

function Module.Input(name,state,input)
    if (state == Enum.UserInputState.Begin) and (Values.HEV.Equipped.Value) then

        if not FlashLightEnabled then 
            FlashLightEnabled = true 
            Sounds.HEV.FlashlightNoise:Play()
            if not CurrentCamera:FindFirstChild("GhostPart") then
                GhostPart = Instance.new("Part",CurrentCamera)
                GhostPart.Name = "GhostPart"
                GhostPart.Transparency = 1
                GhostPart.CanCollide = false
                GhostPart.Anchored = true 
                
                local SpotLight = Instance.new("SpotLight",GhostPart)
                SpotLight.Name = "SpotLight"
                SpotLight.Shadows = true
                SpotLight.Range = 54
                SpotLight.Brightness = 2
                
                SpotLight.Enabled = true 
                RunService.Stepped:Connect(function()
                    if GhostPart ~= nil then 
                        GhostPart.CFrame = CurrentCamera.CFrame
                    end
                end)
            end
        elseif FlashLightEnabled then 
            FlashLightEnabled = false 
            Sounds.HEV.FlashlightNoise:Play()
            if GhostPart ~= nil then 
                GhostPart:Destroy()
                GhostPart = nil
            end
        end
    end
end


return Module
