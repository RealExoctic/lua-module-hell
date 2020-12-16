local ReplicatedStorage = game.ReplicatedStorage
local HTTPService = game:GetService("HttpService")

local URL = "https://discordapp.com/api/webhooks/753903098501791825/51rViznhGEysMJyTUsZYZIlxIMDdmLbtYeHiRDR7mSwqsglfFC76u8nwDkVE4JpHSy70"

ReplicatedStorage.Shared.Events.AntiHTTP.OnServerEvent:Connect(function(Player)
	print("Poop")
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local Data = {
		["content"] = "",
		["embeds"] = {
			["title"] = "Rexon Studios Anti-Exploit",
			["description"] = Player.Name.. " has triggered the anti-exploit!",
			["color"] = tonumber(0x00FF00),
			["fields"] = {
				{
					["name"] = "User Walkspeed:",
					["value"] = Character.Humanoid.WalkSpeed,
					["inline"] = true
				},
				["name"] = "User JumpHeight",
				["value"] = Character.Humanoid.JumpHeight,
				["inline"] = true,
			}
		}
	}
	print("Sent")
	Data = HTTPService:JSONEncode(Data)
	HTTPService:PostAsync(URL,Data)
end)