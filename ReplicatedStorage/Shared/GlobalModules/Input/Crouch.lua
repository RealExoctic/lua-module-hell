local Module = {}

Module.Key = Enum.KeyCode.LeftControl
Module.MobileButtonEnabled = false

local Player  = game.Players.LocalPlayer
local Character = Player.Character
local CurrentCamera = workspace.CurrentCamera
local Mouse = Player:GetMouse()

local TweenService = game:GetService("TweenService")
local Settings = require(game.ReplicatedStorage.Shared.GlobalModules.Settings)
local RunService = game:GetService("RunService")

local Crouching = false
local CameraUp = Vector3.new(0,0,0)
local CameraDown = Vector3.new(0,-1.8,0)
local OldSpeed = game.StarterPlayer.CharacterWalkSpeed

local Animation 
local AnimationTrack

function Module.Input(name,state,input)
	if not Crouching then 
		Crouching = true
		print("starting")
		Animation = Instance.new("Animation")
		Animation.AnimationId = Settings.CrouchAnimation
		
		AnimationTrack = Character.Humanoid:LoadAnimation(Animation)
		
		Character.Humanoid.WalkSpeed = 10
		
		TweenService:Create(Character.Humanoid,TweenInfo.new(.3),{CameraOffset = CameraDown}):Play()
		AnimationTrack.Looped = true 
		
		AnimationTrack:Play()
	else
		print("stopping")
		Crouching = false
		AnimationTrack.Looped = false
		AnimationTrack:Stop()
		
		Character.Humanoid.WalkSpeed = OldSpeed
		
		TweenService:Create(Character.Humanoid,TweenInfo.new(.3),{CameraOffset = CameraUp}):Play()
		Animation:Destroy()
		
		Animation = nil
		AnimationTrack = nil
	end
end


return Module
