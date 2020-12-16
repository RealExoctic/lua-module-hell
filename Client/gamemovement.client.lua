local UIS,RS = game:GetService("UserInputService"), game:GetService("RunService")

local Spring = require(game.ReplicatedStorage.Shared.GlobalModules:WaitForChild("Spring"))
wait(.2) -- roblox why do you take so long to load??, so fucking slow that even Character is nil at startup! 
-- making devs use  CharacterAdded:Wait() just for their code to work! Optimize your code roblox!
local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")


local v3 = Vector3.new

local Direction = Spring.new(v3())
	Direction.Speed = 8

local Front,Side = v3(0,0,1),v3(1,0,0)
local LastJump,JUMP_COOLDOWN = 0,1.4

UIS.InputBegan:Connect(function(Input,GP)
	if not GP and Input.UserInputType == Enum.UserInputType.Keyboard then
		--Handle movement
		if Input.KeyCode == Enum.KeyCode.W then
			Direction.Target = Direction.Target - Front
			
		elseif Input.KeyCode == Enum.KeyCode.S then
			Direction.Target = Direction.Target + Front
			
		elseif Input.KeyCode == Enum.KeyCode.A then
			Direction.Target = Direction.Target - Side
			
		elseif Input.KeyCode == Enum.KeyCode.D then
			Direction.Target = Direction.Target + Side
			
		--Handle jumping
		elseif Input.KeyCode == Enum.KeyCode.Space then
			if tick()-LastJump>= JUMP_COOLDOWN then
				Humanoid.Jump = true
				LastJump = tick()
			end
		end
	end
end)
