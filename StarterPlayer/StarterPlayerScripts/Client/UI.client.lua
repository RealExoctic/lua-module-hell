local Player = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

local StarterGui = game:GetService("StarterGui")
local Shared = game.ReplicatedStorage.Shared

delay(.5,function()
	StarterGui:SetCore("TopbarEnabled", false) --// Disable the Topbar, since it's not needed in Singleplayer
end)

wait(.2)
CurrentCamera.CameraType = Enum.CameraType.Scriptable
CurrentCamera.FieldOfView = 25
CurrentCamera.CFrame = workspace.World.Menu:WaitForChild("Camera").CFrame

for _,module in pairs(Shared.GlobalModules.UI:GetChildren()) do
	if module:IsA("ModuleScript") then 
		local ModuleCloneRequire = require(module:Clone())
		ModuleCloneRequire.Init()
		print("Client Debug >> "..module.Name)
	end
end













