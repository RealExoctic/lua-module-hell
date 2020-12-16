local Players = game.Players
local Player = Players.LocalPlayer

local Shared = game.ReplicatedStorage.Shared

local Character = Player.Character or Player.CharacterAdded:Wait()
local TriggerModules = Shared.GlobalModules.Triggers

local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Values = Shared:WaitForChild("Values")

local function ShowTriggers(bool)
    local SetTransparency = 1
    if bool then
        SetTransparency = 0.6
    else
        SetTransparency = 1
    end

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Part") and string.find(v.Name,"Trigger") then
            for _,texture in pairs(v:GetChildren()) do
                if texture:IsA("Texture") then
                    texture.Transparency = SetTransparency
                end
            end
        end
    end
end




HumanoidRootPart.Touched:Connect(function(hit)
        local nevergonnasayalieandhurtyou = string.gsub(hit.Name,"Trigger","")

        if TriggerModules:FindFirstChild(nevergonnasayalieandhurtyou) then
            print("Client >> Trigger ".. TriggerModules[nevergonnasayalieandhurtyou].Name .. " has been triggered!")
            require(TriggerModules[nevergonnasayalieandhurtyou]:Clone())
            if hit:FindFirstChild("TriggerOnce") then
                if hit.TriggerOnce.Value then
                    hit:Destroy()
                    hit = nil
            end
        end
    end
end)

Values.ShowTriggers.Changed:Connect(ShowTriggers)
ShowTriggers(false)