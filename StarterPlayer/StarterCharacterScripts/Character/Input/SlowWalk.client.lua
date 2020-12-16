local Player = game.Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")

local ContextActionService = game:GetService("ContextActionService")

local ESpeed = 6 
local LeftShiftSpeed = 8

local EHold = false 
local ShiftHold = false 

local OldSpeed = game.StarterPlayer.CharacterWalkSpeed

local function EWalk(name,state,input)
	if not EHold and not Humanoid.WalkSpeed == ESpeed then 
		print("bro")
		EHold = true 
		
		Humanoid.WalkSpeed = ESpeed
	else
		EHold = false 
		if Humanoid.WalkSpeed == ESpeed then 
			Humanoid.WalkSpeed = OldSpeed
		end
	end
end


local function ShiftWalk(name,state,input)
	if not ShiftHold then 
		ShiftHold = true 
		
		Humanoid.WalkSpeed = LeftShiftSpeed
	else
		ShiftHold = false 
		if Humanoid.WalkSpeed == LeftShiftSpeed then 
			Humanoid.WalkSpeed = OldSpeed
		end
	end
end

ContextActionService:BindAction("EWalk",EWalk,false,Enum.UserInputType.MouseButton2)
ContextActionService:BindAction("ShiftWalk",ShiftWalk,false,Enum.KeyCode.LeftShift)