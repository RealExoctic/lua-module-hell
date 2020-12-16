local MenuModule = {}

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local API = require(game.ReplicatedStorage.Shared.GlobalModules.API)

local Ui = Player.PlayerGui:WaitForChild("Main")
local Menu = Ui.Menu.ButtonHolder

for _,v in pairs(Menu:GetChildren()) do 
    if v:IsA("TextButton") or v:IsA("TextLabel") then 
        v.MouseEnter:Connect(function()
            v.TextColor3 = Color3.fromRGB(255, 255, 255)
            API:PlayAudio(4896396749,false,.5,1)
        end)
        v.MouseLeave:Connect(function()
            v.TextColor3 = Color3.fromRGB(175, 175, 175) 
        end)
    end
end


return MenuModule