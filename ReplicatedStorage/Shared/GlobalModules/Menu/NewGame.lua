local Button = {}

local Players = game.Players
local Player = Players.LocalPlayer
local Character = Player.Character
local CurrentCamera = workspace.CurrentCamera

local UI = Player.PlayerGui:WaitForChild("Main")
local Shared = game.ReplicatedStorage.Shared

local API = require(game.ReplicatedStorage.Shared.GlobalModules.API)
local Window = require(script.Parent.Window)


function Button.Press()
	local function CallBack()
		Player.PlayerScripts.Client.Values.WeaponsDisabled.Value = false
		Shared.GlobalModules.Input.PauseMenu.Disabled.Value = false
		Shared.GlobalModules.Input.Crouch.Disabled.Value = false 
		Character.Character.Input.SlowWalk.Disabled = false 
		
		
		Character.Humanoid.WalkSpeed = game.StarterPlayer.CharacterWalkSpeed
		Character.Humanoid.JumpHeight = game.StarterPlayer.CharacterJumpHeight
		
		UI.Menu.Visible = false 
		UI["New Game"]:Destroy()
			
		API:DisableMouseIcon(false)
		
		CurrentCamera.CameraType = Enum.CameraType.Custom
		CurrentCamera.FieldOfView = 54 
		CurrentCamera.CFrame = workspace.World.Menu.Camera.CFrame
	end
	Window.OpenWindow("New Game","The new game window is still in development! for now you'll have this window.","Start","Cancel",CallBack)
end

return Button