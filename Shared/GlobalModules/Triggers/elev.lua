local Module = {}

local Map = workspace.World.LoadedMap

local LeftDoor = Map.LeftDoor
local RightDoor = Map.RightDoor
local API = require(game.ReplicatedStorage.Shared.GlobalModules.API)

API:TweenModel(LeftDoor, Map.LeftDoorOpen:GetPrimaryPartCFrame(),TweenInfo.new(1,Enum.EasingStyle.Linear))
API:TweenModel(RightDoor, Map.RightDoorOpen:GetPrimaryPartCFrame(),TweenInfo.new(1,Enum.EasingStyle.Linear))
API:PlayAudio(5048077804,false,1,LeftDoor.PrimaryPart)
API:PlayAudio(5048077804,false,1,RightDoor.PrimaryPart)

return Module 