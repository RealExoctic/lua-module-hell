local Module = {}

Module.Key = Enum.KeyCode.Tab

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Main = Player:WaitForChild("PlayerGui"):WaitForChild("Main")

local CurrentCamera = workspace.CurrentCamera

local Shared = game.ReplicatedStorage.Shared
local API = require(Shared.GlobalModules.API)

local MenuOpened = false
local OldWalkSpeed

function Module.Input(name,state,input)
    if (state == Enum.UserInputState.Begin) then

        if not MenuOpened then
            OldWalkSpeed = Character.Humanoid.WalkSpeed
            Character.Humanoid.UseJumpPower = false
            Character.HumanoidRootPart.Anchored = true
            Character.Humanoid.WalkSpeed = 0
            CurrentCamera.CameraType = Enum.CameraType.Scriptable

            API:PauseEveryAudio(workspace)
            API:PauseEveryAudio(game.SoundService)

            API:DisableMouseIcon(true)
            MenuOpened = true
            Main.PausedMenu.Visible = true
        else
            CurrentCamera.CameraType = Enum.CameraType.Custom
            Character.Humanoid.UseJumpPower = true
            Character.HumanoidRootPart.Anchored = false
            Character.Humanoid.WalkSpeed = OldWalkSpeed

            API:ResumeEveryAudio(workspace)
            API:ResumeEveryAudio(game.SoundService)

            API:DisableMouseIcon(false)
            MenuOpened = false
            Main.PausedMenu.Visible = false
        end
    end
end


return Module