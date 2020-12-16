local Module = {}

Module.Key = Enum.KeyCode.Tab
Module.MobileButtonEnabled = false

local Player = game.Players.LocalPlayer
local Character = Player.Character

local UserInputService = game:GetService("UserInputService")
local Main = Player:WaitForChild("PlayerGui"):WaitForChild("Main")
local CurrentCamera = workspace.CurrentCamera

local Shared = game.ReplicatedStorage.Shared
local API = require(Shared.GlobalModules.API)

local WalkSpeed = game.StarterPlayer.CharacterWalkSpeed
local JumpHeight = game.StarterPlayer.CharacterJumpHeight
local MenuOpened = Player.PlayerScripts.Client.Values.MenuOpened

function Module.Input(name,state,input)
	if (state == Enum.UserInputState.Begin)then
		if not MenuOpened.Value then
			print(Player.Name .. " has paused")
			Player.PlayerScripts.Client.Values.Paused.Value = true
			Player.PlayerScripts.Client.Values.WeaponsDisabled.Value = true
			Shared.GlobalModules.Input.Crouch.Disabled.Value = true 
			Character.Character.Input.SlowWalk.Disabled = true 
			
			Character.Humanoid.WalkSpeed = 0
			Character.Humanoid.JumpHeight = 0
			
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			
            API:DisableMouseIcon(true)
			MenuOpened.Value = true
            Main.PausedMenu.Visible = true
		elseif MenuOpened.Value then
			Player.PlayerScripts.Client.Values.Paused.Value = false
			Player.PlayerScripts.Client.Values.WeaponsDisabled.Value = false
			Character.Humanoid.WalkSpeed = WalkSpeed
			Character.Humanoid.JumpHeight = JumpHeight

			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

			API:DisableMouseIcon(false)
			MenuOpened.Value = false
			Main.PausedMenu.Visible = false
		end
    end
end


return Module