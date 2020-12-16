local Module = {}

Module.Key = Enum.KeyCode.E
Module.MobileButtonEnabled = false


local Player  = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Sounds = Player.PlayerScripts.Client:WaitForChild("Sounds")
local Values = Player.PlayerScripts.Client:WaitForChild("Values")

local Buttons = game.ReplicatedStorage.Shared.GlobalModules.Buttons

function Module.Input(name,state,input)
	if (state == Enum.UserInputState.Begin) then
		if Mouse.Target ~= nil and Mouse.Target:IsA("Part") and Player:DistanceFromCharacter(Mouse.Target.Position) <= 7 then
			local stillnevergonnagiveyouup = string.gsub(Mouse.Target.Name,"Button","")

			for _,module in pairs(Buttons:GetDescendants()) do
				if module.Name == stillnevergonnagiveyouup then 
					Sounds.select:Play()
					require(module:Clone()).OnPress()
				end
			end
		else
			Sounds.denyselect:Play()
        end
    end
end


return Module
