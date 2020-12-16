local module = {}

local RunService = game:GetService("RunService")
local UI = game.Players.LocalPlayer.PlayerGui.Main

local Settings = require(game.ReplicatedStorage.Shared.GlobalModules.Settings)

function module.Init()
	UI.StudioModeSimple.Visible = Settings.StudioModeUiSimple
end



return module
