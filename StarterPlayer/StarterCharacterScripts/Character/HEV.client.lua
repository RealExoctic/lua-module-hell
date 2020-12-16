local Player = game.Players.LocalPlayer
local MainGui = Player:WaitForChild("PlayerGui"):WaitForChild("Main")
local Character = Player.Character

local Humanoid = Character:WaitForChild("Humanoid")

local Sounds = Player.PlayerScripts.Client.Sounds
local Values = Player.PlayerScripts.Client.Values
local FindHEV

local CurrentCharge 

--// I hate having to do this 
Player.CharacterAdded:Connect(function(newCharacter)
	Character = newCharacter
	Humanoid = Character:WaitForChild("Humanoid")
	Values.HEV.Equipped.Value = false
end)

	
Humanoid.Touched:Connect(function(hit)
	if hit.Parent ~= nil then 
		FindHEV = string.find(hit.Parent.Name,"HEV")
	end

	if not Values.HEV.Equipped.Value then
		if FindHEV then
            Values.HEV.Equipped.Value = true
			Sounds.HEV.Welcome:Play()
			MainGui.HUD.Health.Text = Player.Character.Humanoid.Health
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

Humanoid.HealthChanged:Connect(function(health)
	MainGui.HUD.Health.Text = health
	if health <= 20 then
		--// This is terrible, but it works
		--// Remind me to never make UI code ever again
		MainGui.HUD.Health.TextColor3 = Color3.fromRGB(255,29,15)
		MainGui.HUD.Icon1.ImageColor3 = Color3.fromRGB(255,29,15)
	else
		MainGui.HUD.Health.TextColor3 = Color3.fromRGB(255,160,0)
		MainGui.HUD.Icon1.ImageColor3 = Color3.fromRGB(255,160,0)
	end
end)

Values.HEV.Charge.Changed:Connect(function()
	MainGui.HUD.Suit.Text = Values.HEV.Charge.Value
end)
