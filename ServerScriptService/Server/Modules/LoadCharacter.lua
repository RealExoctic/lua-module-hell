local Load = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage.Shared.Events

local Players = game.Players

Events.LoadCharacter.OnServerEvent:Connect(function(player)
	if player.Character == nil or player.Character.Humanoid.Health == 0 then
		player:LoadCharacter()
		print("Server >> LoadCharacter on ".. player.Name )

	end
end)


return Load
