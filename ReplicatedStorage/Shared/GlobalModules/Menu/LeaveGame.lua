local Button = {}

local Players = game.Players
local Player = Players.LocalPlayer
local Character = Player.Character 

local UI = Player.PlayerGui:WaitForChild("Main")
local Shared = game.ReplicatedStorage.Shared
local API = require(Shared.GlobalModules.API)

local MenuOpened = Player.PlayerScripts.Client.Values.MenuOpened
	
function Button.Press()
	API:SendToMenu()
	
	Shared.GlobalModules.Input.Crouch.Disabled.Value = true 
	Character.Character.Input.SlowWalk.Disabled = false 
	Player.PlayerScripts.Client.Values.WeaponsDisabled.Value = false
	
	Character.Humanoid.WalkSpeed = 0
	Character.Humanoid.JumpHeight = 0
	
	
	
	API:DisableMouseIcon(true)
	UI.PausedMenu.Visible = false
end

return Button