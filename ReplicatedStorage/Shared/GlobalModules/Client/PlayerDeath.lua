local Death = {}

local Player = game.Players.LocalPlayer
local Char = Player.Character

local ReplicatedStorage = game.ReplicatedStorage.Shared
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local CurrentCamera = workspace.CurrentCamera

local UserDead = Player.PlayerScripts.Client.Values.UserDead

Char:WaitForChild("Humanoid").Died:Connect(function()
	UserDead.Value = true 
	if CurrentCamera:FindFirstChild("ViewModel") then 
		CurrentCamera.ViewModel:Destroy()
	end
	Char:SetPrimaryPartCFrame(Char.PrimaryPart.CFrame * CFrame.Angles(0,0,math.rad(-90.15)))
	Player.PlayerGui.Main.HUD.Visible = false
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	Player.PlayerScripts.Client.Sounds.Death:Play()
	
	local cf = RunService.Heartbeat:Connect(function()
		CurrentCamera.CFrame = Char.Head.CFrame
	end)
	
	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Gamepad1 then 
			if UserDead.Value then
				cf:Disconnect()
				print("User is dead.")
				print(UserDead.Value)
				UserDead.Value = false
				Player.PlayerGui.Main.HUD.Visible = false
				Player.PlayerScripts.Client.Values.HEV.Equipped.Value = false
				
				local Original = Player.PlayerScripts.Client:FindFirstChild("Weapons")
				
				if Original == nil then warn("Original weapons script is nil") return end
				ReplicatedStorage.Events.LoadCharacter:FireServer()
				local Clone = Original:Clone()
				
				CurrentCamera.CameraType = Enum.CameraType.Custom
				wait(.2)
				Clone.Parent = Player.PlayerScripts.Client
				Clone = nil
				Original:Destroy()
				Original = nil
				print("DANGER: Self-destruction initiated. This script will now destroy itself in T-1 second.")
				
				local ScriptClone = script:Clone()
				ScriptClone.Parent = script.Parent
				
				require(ScriptClone)
				script:Destroy()
			end
		end
	end)
end)


return Death