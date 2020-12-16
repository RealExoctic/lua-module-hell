local module = {}

local Players = game.Players
local DS2 = require(1936396537)

DS2.Combine("HLRDeathMatchSave","Kills","Level")

local DefaultLevel = 1
local DefaultKills = 0 

local KillsNeededToUpLevel = function(Level)
	return 20 + Level * 1
end

Players.PlayerAdded:Connect(function(player)
	local Stats = Instance.new("Folder",player)
	Stats.Name = "leaderstats"
	
	local LevelStat = Instance.new("NumberValue",Stats)
	LevelStat.Name = "Level"
	local KillStat = Instance.new("NumberValue",Stats)
	KillStat.Name = "Kills"
	
	local LevelStore = DS2("Level",player)
	local KillStore = DS2("Kills",player)
	
	
	local function updateLevel(Level)
		player.leaderstats.Level.Value = Level
	end
	
	local function updateKills(Kills)
		if Kills >= KillsNeededToUpLevel(KillStore:Get(DefaultKills)) then 
			LevelStore:Increment(1)
		else
			player.leaderstats.Kills.Value = Kills
		end
	end
	
	updateLevel(LevelStore:Get(DefaultLevel))
	updateKills(KillStore:Get(DefaultKills))
	
	LevelStore:OnUpdate(updateLevel)
	KillStore:OnUpdate(updateKills)
end)



return module
