local Button = {}

local Players = game.Players
local Player = Players.LocalPlayer

local UI = Player:WaitForChild("PlayerGui").Main

local Window = require(script.Parent.Window)
local API = require(game.ReplicatedStorage.Shared.GlobalModules.API)


function Button.Press()
	local function Confirm()
		API:TeleportPlayerToPlace(Player,5623948346)
		API:DisplayMessage("Waiting for TeleportService...",8)
		API:DisableMouseIcon(false)
	end
	
	Window.OpenWindow("Deathmatch","Are you sure you want to be teleported to Deathmatch? This will teleport you to a seperate place!","Yes","No",Confirm)
end

return Button