-- NPCBrain.lua 
--[[ Written by RealExoctic on 8/25/2020 on 8:03 PM ]]

--[[ MADE FOR HALF-LIFE: ROBLOX! DO NOT SHARE UNLESS OPEN-SOURCED! ]]

local Module = {}

--[[ SERVICES ]]
local PathFindingService = game:GetService("PathfindingService")
local TweenService = game:GetService("TweenService")

function Module:NPCMove(model,position)
	assert(model:IsA("Model"),"Model argument must be a Model")
	assert(typeof(position) == "Vector3","Position argument must be a Vector3")
	assert(model:FindFirstChild("Humanoid"),"Given model's Humanoid is nil")
	assert(model:FindFirstChild("HumanoidRootPart"),"Given model's HumanoidRootPart is nil")
	
	local NPCPath = PathFindingService:CreatePath()
	local ComputePath = NPCPath:ComputeAsync(model.HumanoidRootPart.Position,position)
	local Waypoints = NPCPath:GetWaypoints()
	
	for _,point in pairs(Waypoints) do 
		model.Humanoid:MoveTo(point.Position)
		
		if point.Action == Enum.PathWaypointAction.Jump then 
			print("Jump!")
			model.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end		
		model.Humanoid.MoveToFinished:Wait()
	end	
end

function Module:NPCLookAt(npc,part)
	assert(npc:IsA("Model"),"NPC argument must be a model")
	assert(part:IsA("Part"),"Part argument must be a part")
	
	local LookAtTween = TweenService:Create(npc.Head,TweenInfo.new(.5),{CFrame = CFrame.lookAt(npc.Head.Position,part.Position)})
	
	LookAtTween:Play()
end
return Module