local module = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage.Shared.Events

local Players = game.Players

Events.WeaponRayDamage.OnServerEvent:Connect(function(Player,FP,TP,Weapon)
	local RayCast = Ray.new(FP,(TP-FP).unit*100)
	local Part,Position = workspace:FindPartOnRay(RayCast,Player.Character,false,true)						
	
	if Part then 
		print(true)
		local Humanoid = Part.Parent:FindFirstChildOfClass("Humanoid")
		
		if Humanoid then
			print("Damage")
			print(Weapon)
			Humanoid.Health = Humanoid.Health - Weapon.Values.Damage.Value
		end
	end	
	return Part,Position
end)

return module
