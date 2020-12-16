local h = require(1936396537)

while true do
	wait(1)
	for k, player in pairs(game.Players:GetPlayers()) do
		local killsStore = h("Kills",player)
		local Levels = h("Level",player)
		
		print(killsStore)
		killsStore:Increment(696)
		Levels:Increment(696)
	end
end