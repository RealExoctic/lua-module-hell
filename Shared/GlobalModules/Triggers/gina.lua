local gina = {}

local Map = workspace.World.LoadedMap

local API = require(game.ReplicatedStorage.Shared.GlobalModules.API)
local TweenService = game:GetService("TweenService")

API:PlayAudio(5048077804,false,1,Map.StartGina)
wait(5)

TweenService:Create(Map.HEVDoor,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Position = Vector3.new(Map.HEVDoor.Position.X,Map.HEVDoor.Position.Y+20,Map.HEVDoor.Position.Z)}):Play()




return gina