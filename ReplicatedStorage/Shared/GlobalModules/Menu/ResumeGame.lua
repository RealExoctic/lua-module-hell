local Button = {}

local Players = game.Players
local Player = Players.LocalPlayer
local Character = Player.Character

local CurrentCamera = workspace.CurrentCamera

local UI = Player.PlayerGui:WaitForChild("Main")
local Shared = game.ReplicatedStorage.Shared
local API = require(Shared.GlobalModules.API)

local MenuOpened = Player.PlayerScripts.Client.Values.MenuOpened

--// I hate having to do this 
Player.CharacterAdded:Connect(function(newCharacter)
	Character = newCharacter
end)

function Button.Press()
	CurrentCamera.CameraType = Enum.CameraType.Custom
	Character.HumanoidRootPart.Anchored = false
	Player.PlayerScripts.Client.Values.Paused.Value = false
	Player.PlayerScripts.Client.Values.WeaponsDisabled.Value = false
	
	API:ResumeEveryAudio(workspace)
	API:ResumeEveryAudio(game.SoundService)
	
	API:DisableMouseIcon(false)
	UI.PausedMenu.Visible = false
	UI.Menu.Visible = false
end

return Button