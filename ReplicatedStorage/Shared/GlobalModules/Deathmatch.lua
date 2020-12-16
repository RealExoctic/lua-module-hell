local Button = {}

local Players = game.Players
local Player = Players.LocalPlayer

local UI = Player.PlayerGui:WaitForChild("Main")
local API = require(game.ReplicatedStorage.Shared.GlobalModules.API)

local BannedUsers = {
	500634351
}

function Button.Press()
	if not table.find(BannedUsers,Player.UserId) then 
		print("Normal user!")
		API:TeleportPlayerToPlace(Player,5623948346)
	else
		print("Exploiter!")
		API:TeleportPlayerToPlace(Player,5623949315)
	end
end

return Button