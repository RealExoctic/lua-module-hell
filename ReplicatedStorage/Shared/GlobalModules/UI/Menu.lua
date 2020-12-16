local module = {}

local ReplicatedStorage = game.ReplicatedStorage

local MenuUi = game.Players.LocalPlayer.PlayerGui:WaitForChild("Main").Menu.ButtonHolder
local PauseUi = game.Players.LocalPlayer.PlayerGui.Main.PausedMenu.ButtonHolder

local Shared = ReplicatedStorage.Shared
local API = require(Shared.GlobalModules.API)

function gobrrr(ui)
	for _,button in pairs(ui:GetChildren()) do
		if button:IsA("TextButton") then
			button.MouseButton1Down:Connect(function()
				API:PlaySound(4896397321,false,.5)
				local FindModule = ReplicatedStorage.Shared.GlobalModules.Menu:FindFirstChild(button.Name)
				
				if FindModule then
					FindModule = require(FindModule)
					FindModule.Press()
				end
			end)
			button.MouseEnter:Connect(function()
				API:PlaySound(4896396749,false,.5)
			end)
		end
	end
end


function module.Init()
	gobrrr(MenuUi)
	gobrrr(PauseUi)
end

return module
