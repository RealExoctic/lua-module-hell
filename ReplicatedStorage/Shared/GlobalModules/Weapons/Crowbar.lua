local Weapon = {}

local ReplicatedStorage = game.ReplicatedStorage
local ViewAnimationService = require(ReplicatedStorage.Shared.GlobalModules.ViewAnimationService)

local Player = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

local CurrentHitAnimaation = 1 
local CurrentMissAnimation = 1

local HitAnimations = {
	[1] = 5647627831,
	[2] = 5647732552
}
local MissAnimations = {
	[1] = 5647627831,
	[2] = 5647732552,
	[3] = 5645089154,
}



function cloneAndPlay(sound,parent)
	local soundClone = sound:Clone()
	soundClone.Parent = parent
	soundClone.Name = "CLONE_"..soundClone.Name
	soundClone:Play()
	
	
	soundClone.Ended:Connect(function()
		soundClone:Destroy()
		soundClone = nil 
	end)
end


function Weapon:Hit(Mouse,Weapon)
	local DistanceFromHit = Player:DistanceFromCharacter(Mouse.Hit.Position)
	local Animation = CurrentCamera.ViewModel:FindFirstChildOfClass("Animation")
	
	if not CurrentCamera.ViewModel:FindFirstChildOfClass("Animation") then 
		local Animation = Instance.new("Animation")
	end
	
	if DistanceFromHit < Weapon.Values.Range.Value then 
		
		
		ViewAnimationService:ViewModelAnimation(CurrentCamera.ViewModel,Animation,HitAnimations[CurrentHitAnimaation])
		CurrentHitAnimaation = CurrentHitAnimaation + 1
		
		if CurrentHitAnimaation > #HitAnimations then 
			CurrentHitAnimaation = 1
		end
		cloneAndPlay(Weapon.Sounds.Hit,Weapon)
		local Hit = Instance.new("Part",workspace)
		Hit.Name = "Crowbar_HIT_TEST"
		Hit.Transparency = 0.5 
		Hit.CanCollide = false 
		Hit.Anchored = true 
		
		Hit.Size = Vector3.new(1,1,1)
		Hit.CFrame = Mouse.Hit
	else
		ViewAnimationService:ViewModelAnimation(CurrentCamera.ViewModel,Animation,MissAnimations[CurrentMissAnimation])
		CurrentMissAnimation = CurrentMissAnimation + 1
		
		if CurrentMissAnimation > #MissAnimations then 
			CurrentMissAnimation = 1
		end
		cloneAndPlay(Weapon.Sounds.Swing,Weapon)
		wait(2)
	end
end





return Weapon