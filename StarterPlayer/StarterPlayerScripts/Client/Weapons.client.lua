local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local PhysicsService = game:GetService("PhysicsService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local ViewAnimationService = require(ReplicatedStorage.Shared.GlobalModules.ViewAnimationService)

local API = require(ReplicatedStorage.Shared.GlobalModules.API)

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local Character = Player.Character or Player.CharacterAdded:Wait()
local Camera = workspace.CurrentCamera

local currentAnimationId 

local CurrentWeapon 
local ViewModel 
local Anim 

local Weapons = {
	["Zero"] = nil,
	["One"] = ReplicatedStorage.Shared.Weapons.Crowbar,
	["Two"] = ReplicatedStorage.Shared.Weapons.Revolver,
}

local function RecursiveSetCollsionGroup(Children, Group)
	for _,part in pairs(Children) do
		if part:IsA("Part") or part:IsA("MeshPart") then 
			PhysicsService:SetPartCollisionGroup(part, Group)
		end
	end
end

local function Shoot(actionName, inputState, inputObject)
	if (inputState == Enum.UserInputState.Begin and not Player.PlayerScripts.Client.Values.WeaponsDisabled.Value) then
		if ViewModel and CurrentWeapon ~= nil then 
			if Weapons[CurrentWeapon] then 
				local GunModule = require(ReplicatedStorage.Shared.GlobalModules.Weapons[Weapons[CurrentWeapon].Name]) 
				
				GunModule:Hit(Mouse,Weapons[CurrentWeapon])
			end
		end
	end
end

local function changeWeapon(Weapon)
	if Weapons[Weapon] and not Player.PlayerScripts.Client.Values.WeaponsDisabled.Value then 
		CurrentWeapon = Weapon 
		if Camera:FindFirstChild("ViewModel") then
			Camera.ViewModel:Destroy()
		end
		ViewModel = Weapons[Weapon].ViewModel:Clone()
		RecursiveSetCollsionGroup(ViewModel:GetChildren(), "ViewModel")
		ViewModel.Parent = Camera
		ViewModel.HumanoidRootPart.CFrame = Camera.CFrame
		if Anim == nil then
			Anim = Instance.new("Animation")
			Anim.Parent = ViewModel
		end
		ViewAnimationService:ViewModelAnimation(ViewModel,Anim,Weapons[Weapon].Animations.Equip.Value)	
		wait(.4)
		ViewAnimationService:ViewModelAnimation(ViewModel,Anim,Weapons[Weapon].Animations.Idle.Value)	
	end
	if Weapons[Weapon] == "Zero" and Camera:FindFirstChild("ViewModel") then 
		ViewModel:Destroy()
		ViewModel = nil 
	end
end

UserInputService.InputBegan:Connect(function(key)
	if key.UserInputType == Enum.UserInputType.Touch and UserInputService.TouchEnabled then 
		Shoot("MobileButton",Enum.UserInputState.Begin,Enum.UserInputType.Touch)
	end
	
	if Character.Humanoid.Health > 0 and not Player.PlayerScripts.Client.Values.WeaponsDisabled.Value then
		for number,weapon in pairs(Weapons) do
			if key.KeyCode == Enum.KeyCode[number] then
				CurrentWeapon = number 
				changeWeapon(number)
			end
		end
	end
end)

for number,TextButton in pairs(Player.PlayerGui:WaitForChild("Main").MobileWeaponSelector:GetChildren()) do 
	if TextButton:IsA("TextButton") then 
		TextButton.MouseButton1Click:Connect(function()
			if Weapons[TextButton.Name] and not Player.PlayerScripts.Client.Values.WeaponsDisabled.Value then 
				CurrentWeapon = number 
				changeWeapon(TextButton.Name)
			end
		end)
	end
end



ContextActionService:BindAction("Shoot",Shoot,false,Enum.UserInputType.MouseButton1)

RunService.RenderStepped:Connect(function(DeltaTime)
	if ViewModel ~= nil then 
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		UserInputService.MouseIconEnabled = false
		if ViewModel:FindFirstChild("HumanoidRootPart") then 
			ViewModel.HumanoidRootPart.CFrame = Camera.CFrame
		end
	end
end)