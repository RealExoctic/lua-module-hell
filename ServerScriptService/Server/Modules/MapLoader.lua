local module = {}

--[[ SERVICES ]]--
local ReplicatedStorage = game.ReplicatedStorage
local ReplicatedFirst = game.ReplicatedFirst
local API = require(game.ReplicatedStorage.Shared.GlobalModules.API)

local Players = game.Players
local Lighting = game.Lighting
local Terrain = workspace.Terrain

--[[ VARIBALES ]]--
local WorkspaceFolder = workspace.World
local DestinationFolder = WorkspaceFolder.LoadedMap

local CurrentLoadedMap
local Count = 0




function module:LoadMap(map,Seamless)
	if map:IsA("Model") or map:IsA("Folder") then
		_G.Map = nil
		--[[ Map Info Stuff, very messy! ]]--
		--[[ UPDATE 8/23/2020: I found a way to make the map loading faster!!!]]
		local MapInfo = map:FindFirstChild("Mapinfo")
		
		for _,category in pairs(MapInfo:GetDescendants()) do
			if game:FindFirstChild(category.Name) then
				local Service = game:GetService(category.Name)
				
				local function writeVariable(Name,Value)
					Service[Name] = Value
				end
				
				if Service then 
					for _,property in pairs(Service:GetChildren()) do
						local CanWrite,Cant = pcall(function()
							writeVariable(Service.Name,property.Value)
						end)
						if CanWrite then 
							writeVariable(Service.Name,property.Value)
						end
						if Cant then
							warn("Can't write! "..Cant)
						end
					end
				end
			end
		end
		
		warn("Server >> Loading ".. MapInfo.LevelInfo.LevelName.Value)
		
		API:CheckForTriggers(map)
		
		--[[ Map Loading ]]--
		local GhostFolder = Instance.new("Folder",DestinationFolder.Parent)
		GhostFolder.Name = "GhostFolder"
		
		
		for i,child in ipairs(map:GetChildren()) do
			local cClone = child:Clone()
			cClone.Parent = GhostFolder
			Count = (Count + 1)%10
			if Count == 0 then
				wait()
			end
		end
		
		--[[ Final Touches ]]--
		DestinationFolder:ClearAllChildren()
		DestinationFolder:Destroy()	
		GhostFolder.Name = "LoadedMap"
		
		
		for _,v in pairs(GhostFolder:GetDescendants()) do
			if v.Name == "WaterBrick" and v:IsA("Part") then 
				Terrain:FillBlock(v.CFrame,v.Size,Enum.Material.Water)
				v:Destroy()
			end
		end
		GhostFolder = nil		
		if MapInfo.Transitions.PreviousMap == nil or not Seamless then
			API:CheckForSpawn(map)
		end
		require(MapInfo.Function)["Function"]( )
		
		repeat _G.Map = CurrentLoadedMap wait() until _G.Map == CurrentLoadedMap
	end
end
--[[ END ]]--
return module
