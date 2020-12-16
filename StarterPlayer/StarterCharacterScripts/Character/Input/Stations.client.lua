local Player = game.Players.LocalPlayer

local Character = Player.Character
local Humanoid = Character.Humanoid

local Mouse = Player:GetMouse()

local Client = Player.PlayerScripts.Client
local UserInputService = game:GetService("UserInputService")

local StationDistanceLimit = 7 


UserInputService.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.E then 
		print(Mouse.Target)
		local Target = Mouse.Target
		local HEVCharge = Client.Values.HEV.Charge
		
		
		if Target ~= nil then 
			local Distance = Player:DistanceFromCharacter(Target.Position) 
			--// HEV Charger
			if Target.Name == "SuitCharger" and Client.Values.HEV.Equipped.Value and Distance <= StationDistanceLimit and not Player.PlayerScripts.Client.Values.HEV.Charging.Value and not Player.PlayerScripts.Client.Values.Paused.Value then
				Player.PlayerScripts.Client.Values.HEV.Charging.Value = true 
				local ChargerCharge = Target.Charge
				
				for i = ChargerCharge.Value,0,-1 do 
					HEVCharge.Value +=1
					ChargerCharge.Value -=1
					
					wait(.2)
					if ChargerCharge.Value < 0 or HEVCharge.Value >= 100 and Distance >StationDistanceLimit or Mouse.Target.Name ~= "SuitCharger" or Player.Character.Humanoid.Health <= 0 or Player.PlayerScripts.Client.Values.Paused.Value then
						
						if HEVCharge.Value > 100 then 
							HEVCharge.Value = 100
						end
						Player.PlayerScripts.Client.Values.HEV.Charging.Value = false
						break
					end
				end
			end
			
			--// Medical Station
			if Target.Name == "MedStation" then 
				local ChargerCharge = Target.Charge
				
				if ChargerCharge.Value < 0 then 
					
				end
			end
		end
	end
end)



