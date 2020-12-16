local Module = {}

Module.Key = Enum.KeyCode.E


local Player  = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Sounds = Player.PlayerScripts.Client:WaitForChild("Sounds")
local Values = Player.PlayerScripts.Client:WaitForChild("Values")

local Buttons = game.ReplicatedStorage.Shared.GlobalModules.Buttons

function Module.Input(name,state,input)
    if (state == Enum.UserInputState.Begin) then
        if Mouse.Target ~= nil and Mouse.Target:IsA("Part") and Player:DistanceFromCharacter(Mouse.Target.Position) <= 5 then
            local stillnevergonnagiveyouup = string.gsub(Mouse.Target.Name,"Button","")
            if Buttons:FindFirstChild(stillnevergonnagiveyouup) then
                print("Client >> Button"..stillnevergonnagiveyouup.." has been pressed!" )
                Sounds.select:Play()
                require(Buttons[stillnevergonnagiveyouup]:Clone())
            end
        else
            Sounds.denyselect:Play()
        end
    end
end


return Module
