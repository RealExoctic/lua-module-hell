local Player = game.Players.LocalPlayer
local MainGui = Player:WaitForChild("PlayerGui"):WaitForChild("Main")
local Character = Player.Character or Player.CharacterAdded:Wait()

local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local Sounds = script.Parent:WaitForChild("Sounds")
local Values = script.Parent:WaitForChild("Values")


HumanoidRootPart.Touched:Connect(function(hit)
    local FindHEV = string.find(hit.Parent.Name,"HEV")

    if not Values.HEV.Equipped.Value then
        if FindHEV then
            Values.HEV.Equipped.Value = true
            Sounds.HEV.Welcome:Play()
            MainGui.HUD.Visible = true

            if not hit.Parent:FindFirstChild("MusicDisabled") then
                Sounds.HEV.Music:Play()
            end

            hit.Parent:Destroy()
            hit.Parent = nil

            hit:Destroy()
            hit = nil
        end
    end
end)
